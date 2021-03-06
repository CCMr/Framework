//
//  BaseEntity.m
//  CC
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

#import "BaseEntity.h"
#import <objc/runtime.h>

@interface BaseEntity()

/**
 *  @author CC, 2015-08-01
 *
 *  @brief  对象数组属性
 *
 *  @since 1.0
 */
@property (nonatomic, strong) NSMutableArray *propertArray;

@end

@implementation BaseEntity

//must override
+ (id)dataWithJavaJsonDictonary:(NSDictionary *)jsonDic error:(NSError **)error
{
    if ([NSStringFromClass(self.class) isEqualToString:@"BaseEntity"]) {
        assert(0);
    }
    return [self.class new];
}

+(id)BaseEntityWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

- (id)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self populateObject:self fromDictionary:dict exclude:nil];
    }
    return self;
}


- (void)setDic:(NSDictionary *)dic{
    [self populateObject:self fromDictionary:dic exclude:nil];
}


-(NSDictionary *)ChangedDictionary{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    unsigned int propsCount;
    objc_property_t *props = class_copyPropertyList([self class], &propsCount);//获得属性列表
    
    for(int i = 0;i < propsCount; i++){
        objc_property_t prop = props[i];
        NSString *propName = [NSString stringWithUTF8String:property_getName(prop)];//获得属性的名称
        
        const char *propType = getPropertyType(prop);
        NSString *propertyType = [NSString stringWithUTF8String:propType]; //获得属性类型
        
        id value = [self valueForKey:propName];//kvc读值
        if(!value){
            if ([propertyType isEqualToString:@"NSString"])
                value = @"";
            else if ([propertyType isEqualToString:@"int"])
                value = 0;
            else if ([propertyType isEqualToString:@"NSManagedObjectID"])
                value = [NSManagedObjectID new];
            else if ([propertyType isEqualToString:@"NSMutableArray"] || [propertyType isEqualToString:@"NSArray"])
                value = [NSMutableArray array];
            else
                value = nil;
        }else
            value = [self ObjectInternal:value];
        if(value)
            [dic setObject:value forKey:propName];
    }
    return dic;
}


-(id)ObjectInternal:(id)obj{
    if([obj isKindOfClass:[NSString class]] || [obj isKindOfClass:[NSNumber class]] || [obj isKindOfClass:[NSNull class]] || [obj isKindOfClass:[NSManagedObjectID class]] || [obj isKindOfClass:[UIImage class]] )
        return obj;
    
    if([obj isKindOfClass:[NSArray class]]){
        NSArray *objarr = obj;
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:objarr.count];
        [objarr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [arr setObject:[self ObjectInternal:obj] atIndexedSubscript:idx];
        }];
        return arr;
    }else if([obj isKindOfClass:[NSDictionary class]]){
        NSDictionary *objdic = obj;
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:[objdic count]];
        for(NSString *key in objdic.allKeys)
            [dic setObject:[self ObjectInternal:[objdic objectForKey:key]] forKey:key];
        return dic;
    }
    return [self ObjectInternal:obj];
}

#pragma mark - Get properties for a class
-(id)populateObject:(id)obj fromDictionary:(NSDictionary *)dict exclude:(NSArray *)excludeArray {
    if (obj == nil)
        return nil;
    
    Class cls = [obj class];
    NSDictionary* properties = [self propertiesForClass:cls];
    // Since key of object is a string, we need to check the dict contains
    // string as key. If it contains non-string key, the key will be skipped.
    // If key is not inside the object properties, it's skipped too.
    // Otherwise assign value of key from dict to obj
    for (id key in dict) {
        // Skip for non-string key   NSLog(@"TDUtils: key must be NSString. Received key %@", key);
        if ([key isKindOfClass:[NSString class]] == NO)
            continue;
        
        // If key is not inside the object properties, skip it    NSLog(@"TDUtils: key %@ is not existed in class %@", key, NSStringFromClass(cls));
        if (![properties objectForKey:key])
            continue;
        
        // If key inside excludeArray, skip it    NSLog(@"TDUtils: key %@ is skipped", key);
        if (excludeArray && [excludeArray indexOfObject:key] != NSNotFound)
            continue;
        
        // For string-key
        id value = [dict objectForKey:key];
        
        // If the property type is NSString and the value is array,
        // join them with ","
        NSString *propertyType = [properties objectForKey:key];
        
        //对应属性对象与对应对象实体名称
        __block NSString *propertKey, *classKey;
        if ([propertyType isEqualToString:@"NSArray"] || [propertyType isEqualToString:@"NSMutableArray"]) {
            
            if (!_propertArray) {
                //获取对象属性中是数组的属性
                _propertArray = [NSMutableArray array];
                [properties.allKeys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    id type = [properties objectForKey:obj];
                    
                    if ([type isEqualToString:@"NSArray"] || [type isEqualToString:@"NSMutableArray"]) {
                        [_propertArray addObject:obj];
                    }
                }];
            }
            
            //匹配当前属性
            [_propertArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                NSArray *keyAry = [obj componentsSeparatedByString:@"_"];
                if (keyAry.count > 1) {
                    //子对象名
                    NSString *className = keyAry.lastObject;
                    //解析判断字段名
                    NSString *isKey = [obj stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"_%@",className] withString:@""];
                    
                    if ([key isEqualToString:isKey]){
                        propertKey = obj;
                        classKey = className;
                    }
                }
            }];
        }
        
        if ([propertyType isEqualToString:@"NSString"] && [value isKindOfClass:[NSArray class]]) {
            NSArray* arr = (NSArray*) value;
            NSString* arrString = [arr componentsJoinedByString:@","];
            [obj setValue:arrString forKey:key];
        }else if (![propertyType isEqualToString:@"NSString"] && ![propertyType isEqualToString:@"NSDictionary"] && [value isKindOfClass:[NSDictionary class]]) { // If the property type is a custom class (not NSDictionary), and the value is a dictionary,convert the dictionary to object of that class
            
            // Init a child attribute with respective class
            Class objCls = NSClassFromString(propertyType);
            id childObj = [[objCls alloc] init];
            
            // Populate data from the value
            [self populateObject:childObj fromDictionary:value exclude:nil];
            
            [obj setValue:childObj forKey:key];
        }else if (propertKey && classKey){// 子对象的解析
            //子对象类名
            Class objCls = NSClassFromString(classKey);
            
            NSMutableArray *chilArray = [NSMutableArray array];
            [value enumerateObjectsUsingBlock:^(id valueObj, NSUInteger idx, BOOL *stop) {
                //创建子对象
                //递归解析对象
                id childObj = [[objCls alloc] init];
                [self populateObject:childObj fromDictionary:valueObj exclude:nil];
                [chilArray addObject:childObj];
            }];
            
            [obj setValue:chilArray forKey:propertKey];
        }else {// Else, set value for key
            [obj setValue:value forKey:key];
        }
    }
    
    return obj;
}

-(NSDictionary *)propertiesForClass:(Class)cls{
    if (cls == NULL)
        return nil;
    
    NSMutableDictionary *results = [[NSMutableDictionary alloc] init];
    
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList(cls, &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        const char *propName = property_getName(property);
        if(propName) {
            const char *propType = getPropertyType(property);
            NSString *propertyName = [NSString stringWithUTF8String:propName];
            NSString *propertyType = [NSString stringWithUTF8String:propType];
            [results setObject:propertyType forKey:propertyName];
        }
    }
    
    free(properties);
    // returning a copy here to make sure the dictionary is immutable
    return [NSDictionary dictionaryWithDictionary:results];
}

static const char *getPropertyType(objc_property_t property) {
    const char *attributes = property_getAttributes(property);
    char buffer[1 + strlen(attributes)];
    strcpy(buffer, attributes);
    char *state = buffer, *attribute;
    while ((attribute = strsep(&state, ",")) != NULL) {
        if (attribute[0] == 'T' && attribute[1] != '@') {
            // it's a C primitive type:
            /*
             if you want a list of what will be returned for these primitives, search online for
             "objective-c" "Property Attribute Description Examples"
             apple docs list plenty of examples of what you get for int "i", long "l", unsigned "I", struct, etc.
             */
            NSString *name = [[NSString alloc] initWithBytes:attribute + 1 length:strlen(attribute) - 1 encoding:NSASCIIStringEncoding];
            return (const char *)[name cStringUsingEncoding:NSASCIIStringEncoding];
        }else if (attribute[0] == 'T' && attribute[1] == '@' && strlen(attribute) == 2) {
            // it's an ObjC id type:
            return "id";
        }else if (attribute[0] == 'T' && attribute[1] == '@') {
            // it's another ObjC object type:
            NSString *name = [[NSString alloc] initWithBytes:attribute + 3 length:strlen(attribute) - 4 encoding:NSASCIIStringEncoding];
            return (const char *)[name cStringUsingEncoding:NSASCIIStringEncoding];
        }
    }
    return "";
}

@end


@implementation BaseEntityList

- (id)init
{
    if (self = [super init]) {
        self.dataList = [NSMutableArray new];
    }
    
    return self;
}

//must override
+ (id)dataWithJavaJsonDictonary:(NSDictionary *)jsonDic error:(NSError **)error
{
    if ([NSStringFromClass(self.class) isEqualToString:@"BaseEntityList"]) {
        assert(0);
    }
    return [self.class new];
}

@end
