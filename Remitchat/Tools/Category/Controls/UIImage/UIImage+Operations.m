//
//  UIImage+Operations.m
//  Remitchat
//
// Copyright (c) 2015 CC ( http://www.ccskill.com )
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

#import "UIImage+Operations.h"
#import <Accelerate/Accelerate.h>

static int16_t gaussianblur_kernel[25] = {
    1, 4, 6, 4, 1,
    4, 16, 24, 16, 4,
    6, 24, 36, 24, 6,
    4, 16, 24, 16, 4,
    1, 4, 6, 4, 1
};

static int16_t edgedetect_kernel[9] = {
    -1, -1, -1,
    -1, 8, -1,
    -1, -1, -1
};

static int16_t emboss_kernel[9] = {
    -2, 0, 0,
    0, 1, 0,
    0, 0, 2
};

static int16_t sharpen_kernel[9] = {
    -1, -1, -1,
    -1, 9, -1,
    -1, -1, -1
};

static int16_t unsharpen_kernel[9] = {
    -1, -1, -1,
    -1, 17, -1,
    -1, -1, -1
};

static uint8_t backgroundColorBlack[4] = {0,0,0,0};

static unsigned char morphological_kernel[9] = {
    1, 1, 1,
    1, 1, 1,
    1, 1, 1,
};

//static unsigned char morphological_kernel[25] = {
//    0, 1, 1, 1, 0,
//    1, 1, 1, 1, 1,
//    1, 1, 1, 1, 1,
//    1, 1, 1, 1, 1,
//    0, 1, 1, 1, 0,
//};

@implementation UIImage (Operations)

- (UIImage *)gaussianBlur
{
    const size_t width = self.size.width;
    const size_t height = self.size.height;
    const size_t bytesPerRow = width * 4;

    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    CGContextRef bmContext = CGBitmapContextCreate(NULL, width, height, 8, bytesPerRow, space, kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedFirst);
    CGColorSpaceRelease(space);
    if (!bmContext)
        return nil;

    CGContextDrawImage(bmContext, (CGRect){.origin.x = 0.0f, .origin.y = 0.0f, .size.width = width, .size.height = height}, self.CGImage);

    UInt8* data = (UInt8*)CGBitmapContextGetData(bmContext);
    if (!data)
    {
        CGContextRelease(bmContext);
        return nil;
    }

    const size_t n = sizeof(UInt8) * width * height * 4;
    void* outt = malloc(n);
    vImage_Buffer src = {data, height, width, bytesPerRow};
    vImage_Buffer dest = {outt, height, width, bytesPerRow};

    vImageConvolve_ARGB8888(&src, &dest, NULL, 0, 0, gaussianblur_kernel, 5, 5, 256, NULL, kvImageCopyInPlace);

    memcpy(data, outt, n);
    free(outt);

    CGImageRef blurredImageRef = CGBitmapContextCreateImage(bmContext);
    UIImage* blurred = [UIImage imageWithCGImage:blurredImageRef];

    CGImageRelease(blurredImageRef);
    CGContextRelease(bmContext);

    return blurred;
}

- (UIImage *)edgeDetection
{
    const size_t width = self.size.width;
    const size_t height = self.size.height;
    const size_t bytesPerRow = width * 4;

    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    CGContextRef bmContext = CGBitmapContextCreate(NULL, width, height, 8, bytesPerRow, space, kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedFirst);
    CGColorSpaceRelease(space);
    if (!bmContext)
        return nil;

    CGContextDrawImage(bmContext, (CGRect){.origin.x = 0.0f, .origin.y = 0.0f, .size.width = width, .size.height = height}, self.CGImage);

    UInt8* data = (UInt8*)CGBitmapContextGetData(bmContext);
    if (!data)
    {
        CGContextRelease(bmContext);
        return nil;
    }

    const size_t n = sizeof(UInt8) * width * height * 4;
    void* outt = malloc(n);
    vImage_Buffer src = {data, height, width, bytesPerRow};
    vImage_Buffer dest = {outt, height, width, bytesPerRow};

    vImageConvolve_ARGB8888(&src, &dest, NULL, 0, 0, edgedetect_kernel, 3, 3, 1, backgroundColorBlack, kvImageCopyInPlace);

    memcpy(data, outt, n);
    CGImageRef edgedImageRef = CGBitmapContextCreateImage(bmContext);
    UIImage* edged = [UIImage imageWithCGImage:edgedImageRef];

    CGImageRelease(edgedImageRef);
    free(outt);
    CGContextRelease(bmContext);

    return edged;
}

- (UIImage *)emboss
{
    const size_t width = self.size.width;
    const size_t height = self.size.height;
    const size_t bytesPerRow = width * 4;

    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    CGContextRef bmContext = CGBitmapContextCreate(NULL, width, height, 8, bytesPerRow, space, kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedFirst);
    CGColorSpaceRelease(space);
    if (!bmContext)
        return nil;

    CGContextDrawImage(bmContext, (CGRect){.origin.x = 0.0f, .origin.y = 0.0f, .size.width = width, .size.height = height}, self.CGImage);

    UInt8* data = (UInt8*)CGBitmapContextGetData(bmContext);
    if (!data)
    {
        CGContextRelease(bmContext);
        return nil;
    }

    const size_t n = sizeof(UInt8) * width * height * 4;
    void* outt = malloc(n);
    vImage_Buffer src = {data, height, width, bytesPerRow};
    vImage_Buffer dest = {outt, height, width, bytesPerRow};

    vImageConvolve_ARGB8888(&src, &dest, NULL, 0, 0, emboss_kernel, 3, 3, 1, NULL, kvImageCopyInPlace);

    memcpy(data, outt, n);

    free(outt);

    CGImageRef embossImageRef = CGBitmapContextCreateImage(bmContext);
    UIImage* emboss = [UIImage imageWithCGImage:embossImageRef];

    CGImageRelease(embossImageRef);
    CGContextRelease(bmContext);

    return emboss;
}

- (UIImage *)sharpen
{
    const size_t width = self.size.width;
    const size_t height = self.size.height;
    const size_t bytesPerRow = width * 4;

    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    CGContextRef bmContext = CGBitmapContextCreate(NULL, width, height, 8, bytesPerRow, space, kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedFirst);
    CGColorSpaceRelease(space);
    if (!bmContext)
        return nil;

    CGContextDrawImage(bmContext, (CGRect){.origin.x = 0.0f, .origin.y = 0.0f, .size.width = width, .size.height = height}, self.CGImage);

    UInt8* data = (UInt8*)CGBitmapContextGetData(bmContext);
    if (!data)
    {
        CGContextRelease(bmContext);
        return nil;
    }

    const size_t n = sizeof(UInt8) * width * height * 4;
    void* outt = malloc(n);
    vImage_Buffer src = {data, height, width, bytesPerRow};
    vImage_Buffer dest = {outt, height, width, bytesPerRow};
    vImageConvolve_ARGB8888(&src, &dest, NULL, 0, 0, sharpen_kernel, 3, 3, 1, NULL, kvImageCopyInPlace);

    memcpy(data, outt, n);

    free(outt);

    CGImageRef sharpenedImageRef = CGBitmapContextCreateImage(bmContext);
    UIImage* sharpened = [UIImage imageWithCGImage:sharpenedImageRef];

    CGImageRelease(sharpenedImageRef);
    CGContextRelease(bmContext);

    return sharpened;
}

- (UIImage *)unsharpen
{
    const size_t width = self.size.width;
    const size_t height = self.size.height;
    const size_t bytesPerRow = width * 4;

    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    CGContextRef bmContext = CGBitmapContextCreate(NULL, width, height, 8, bytesPerRow, space, kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedFirst);
    CGColorSpaceRelease(space);
    if (!bmContext)
        return nil;

    CGContextDrawImage(bmContext, (CGRect){.origin.x = 0.0f, .origin.y = 0.0f, .size.width = width, .size.height = height}, self.CGImage);

    UInt8* data = (UInt8*)CGBitmapContextGetData(bmContext);
    if (!data)
    {
        CGContextRelease(bmContext);
        return nil;
    }

    const size_t n = sizeof(UInt8) * width * height * 4;
    void* outt = malloc(n);
    vImage_Buffer src = {data, height, width, bytesPerRow};
    vImage_Buffer dest = {outt, height, width, bytesPerRow};
    vImageConvolve_ARGB8888(&src, &dest, NULL, 0, 0, unsharpen_kernel, 3, 3, 9, NULL, kvImageCopyInPlace);

    memcpy(data, outt, n);

    free(outt);

    CGImageRef unsharpenedImageRef = CGBitmapContextCreateImage(bmContext);
    UIImage* unsharpened = [UIImage imageWithCGImage:unsharpenedImageRef];

    CGImageRelease(unsharpenedImageRef);
    CGContextRelease(bmContext);

    return unsharpened;
}

- (UIImage *)rotateInRadians:(float)radians
{
    if (!(&vImageRotate_ARGB8888))
        return nil;

    const size_t width = self.size.width;
    const size_t height = self.size.height;
    const size_t bytesPerRow = width * 4;

    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    CGContextRef bmContext = CGBitmapContextCreate(NULL, width, height, 8, bytesPerRow, space, kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedFirst);
    CGColorSpaceRelease(space);
    if (!bmContext)
        return nil;

    CGContextDrawImage(bmContext, (CGRect){.origin.x = 0.0f, .origin.y = 0.0f, .size.width = width, .size.height = height}, self.CGImage);

    UInt8* data = (UInt8*)CGBitmapContextGetData(bmContext);
    if (!data)
    {
        CGContextRelease(bmContext);
        return nil;
    }

    vImage_Buffer src = {data, height, width, bytesPerRow};
    vImage_Buffer dest = {data, height, width, bytesPerRow};
    Pixel_8888 bgColor = {0, 0, 0, 0};
    vImageRotate_ARGB8888(&src, &dest, NULL, radians, bgColor, kvImageBackgroundColorFill);

    CGImageRef rotatedImageRef = CGBitmapContextCreateImage(bmContext);
    UIImage* rotated = [UIImage imageWithCGImage:rotatedImageRef];

    CGImageRelease(rotatedImageRef);
    CGContextRelease(bmContext);

    return rotated;
}

- (UIImage *)dilate
{
    const size_t width = self.size.width;
    const size_t height = self.size.height;
    const size_t bytesPerRow = width * 4;

    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    CGContextRef bmContext = CGBitmapContextCreate(NULL, width, height, 8, bytesPerRow, space, kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedFirst);
    CGColorSpaceRelease(space);
    if (!bmContext)
        return nil;

    CGContextDrawImage(bmContext, (CGRect){.origin.x = 0.0f, .origin.y = 0.0f, .size.width = width, .size.height = height}, self.CGImage);

    UInt8* data = (UInt8*)CGBitmapContextGetData(bmContext);
    if (!data)
    {
        CGContextRelease(bmContext);
        return nil;
    }

    const size_t n = sizeof(UInt8) * width * height * 4;
    void* outt = malloc(n);
    vImage_Buffer src = {data, height, width, bytesPerRow};
    vImage_Buffer dest = {outt, height, width, bytesPerRow};
    vImageDilate_ARGB8888(&src, &dest, 0, 0, morphological_kernel, 3, 3, kvImageCopyInPlace);

    memcpy(data, outt, n);

    free(outt);

    CGImageRef dilatedImageRef = CGBitmapContextCreateImage(bmContext);
    UIImage* dilated = [UIImage imageWithCGImage:dilatedImageRef];

    CGImageRelease(dilatedImageRef);
    CGContextRelease(bmContext);

    return dilated;
}

- (UIImage *)erode
{
    const size_t width = self.size.width;
    const size_t height = self.size.height;
    const size_t bytesPerRow = width * 4;

    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    CGContextRef bmContext = CGBitmapContextCreate(NULL, width, height, 8, bytesPerRow, space, kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedFirst);
    CGColorSpaceRelease(space);
    if (!bmContext)
        return nil;

    CGContextDrawImage(bmContext, (CGRect){.origin.x = 0.0f, .origin.y = 0.0f, .size.width = width, .size.height = height}, self.CGImage);

    UInt8* data = (UInt8*)CGBitmapContextGetData(bmContext);
    if (!data)
    {
        CGContextRelease(bmContext);
        return nil;
    }

    const size_t n = sizeof(UInt8) * width * height * 4;
    void* outt = malloc(n);
    vImage_Buffer src = {data, height, width, bytesPerRow};
    vImage_Buffer dest = {outt, height, width, bytesPerRow};

    vImageErode_ARGB8888(&src, &dest, 0, 0, morphological_kernel, 3, 3, kvImageCopyInPlace);

    memcpy(data, outt, n);

    free(outt);

    CGImageRef erodedImageRef = CGBitmapContextCreateImage(bmContext);
    UIImage* eroded = [UIImage imageWithCGImage:erodedImageRef];

    CGImageRelease(erodedImageRef);
    CGContextRelease(bmContext);

    return eroded;
}

- (UIImage *)dilateWithIterations:(int)iterations {

    UIImage *dstImage = self;
    for (int i=0; i<iterations; i++) {
        dstImage = [dstImage dilate];
    }
    return dstImage;
}

- (UIImage *)erodeWithIterations:(int)iterations {

    UIImage *dstImage = self;
    for (int i=0; i<iterations; i++) {
        dstImage = [dstImage erode];
    }
    return dstImage;
}

- (UIImage *)gradientWithIterations:(int)iterations {

    UIImage *dilated = [self dilateWithIterations:iterations];
    UIImage *eroded = [self erodeWithIterations:iterations];

    UIImage *dstImage = [dilated imageBlendedWithImage:eroded blendMode:kCGBlendModeDifference alpha:1.0];

    return dstImage;
}

- (UIImage *)tophatWithIterations:(int)iterations {

    UIImage *dilated = [self dilateWithIterations:iterations];

    UIImage *dstImage = [self imageBlendedWithImage:dilated blendMode:kCGBlendModeDifference alpha:1.0];

    return dstImage;
}

- (UIImage *)blackhatWithIterations:(int)iterations {

    UIImage *eroded = [self erodeWithIterations:iterations];

    UIImage *dstImage = [eroded imageBlendedWithImage:self blendMode:kCGBlendModeDifference alpha:1.0];

    return dstImage;
}

- (UIImage *)equalization
{
    const size_t width = self.size.width;
    const size_t height = self.size.height;
    const size_t bytesPerRow = width * 4;

    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    CGContextRef bmContext = CGBitmapContextCreate(NULL, width, height, 8, bytesPerRow, space, kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedFirst);
    CGColorSpaceRelease(space);
    if (!bmContext)
        return nil;

    CGContextDrawImage(bmContext, (CGRect){.origin.x = 0.0f, .origin.y = 0.0f, .size.width = width, .size.height = height}, self.CGImage);

    UInt8* data = (UInt8*)CGBitmapContextGetData(bmContext);
    if (!data)
    {
        CGContextRelease(bmContext);
        return nil;
    }

    vImage_Buffer src = {data, height, width, bytesPerRow};
    vImage_Buffer dest = {data, height, width, bytesPerRow};

    vImageEqualization_ARGB8888(&src, &dest, kvImageNoFlags);

    CGImageRef destImageRef = CGBitmapContextCreateImage(bmContext);
    UIImage* destImage = [UIImage imageWithCGImage:destImageRef];

    CGImageRelease(destImageRef);
    CGContextRelease(bmContext);

    return destImage;
}

/**
 *  @author CC, 15-09-02
 *
 *  @brief  混合图片
 *
 *  @param overlayImage <#overlayImage description#>
 *  @param blendMode    <#blendMode description#>
 *  @param alpha        <#alpha description#>
 *
 *  @return <#return value description#>
 *
 *  @since <#1.0#>
 */
- (UIImage *)imageBlendedWithImage: (UIImage *)overlayImage
                         blendMode: (CGBlendMode)blendMode
                             alpha: (CGFloat)alpha
{

    UIGraphicsBeginImageContext(self.size);

    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    [self drawInRect:rect];

    [overlayImage drawAtPoint:CGPointMake(0, 0) blendMode:blendMode alpha:alpha];

    UIImage *blendedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return blendedImage;
}

@end
