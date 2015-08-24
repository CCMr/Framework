//
//  BaseTableViewHeaderFooterView.m
//  CC
//
//  Created by kairunyun on 15/3/6.
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

#import "BaseTableViewHeaderFooterView.h"
#import "FriendGroup.h"

@interface BaseTableViewHeaderFooterView(){
    FriendGroup *friendGroup;
}

@end

@implementation BaseTableViewHeaderFooterView

-(id)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        lineBgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,winsize.width, 50)];
        lineBgImageView.image = [UIImage imageNamed:@"chat_bottom_bg"];
        [self addSubview:lineBgImageView];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if (![self.delegate respondsToSelector:@selector(didClickHeadView:Index:)])
        return;
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:touch.view];
    CGRect frame = CGRectMake(0, 0, winsize.width, 50);
    if (CGRectContainsPoint(frame, point)) {
        friendGroup.opened = !friendGroup.opened;
        if ([self.delegate respondsToSelector:@selector(didClickHeadView:Index:)])
            [self.delegate didClickHeadView:self Index:(int)self.tag];
    }
}

-(void)setDatas:(NSObject *)obj{
    friendGroup = (FriendGroup *)obj;
}

-(void)setDatas:(NSObject *)objDatas didSelectedBlock:(didSelectedHeaderFooterView)seletedBlock{
    self.didSelected = seletedBlock;
    friendGroup = (FriendGroup *)objDatas;
}

@end
