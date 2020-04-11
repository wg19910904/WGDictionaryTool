
//  Copyright © 2019 WG. All rights reserved.

#import "NSDictionary+Tool.h"
#import <objc/runtime.h>
@implementation NSDictionary (Tool)
+(void)load{
    [super load];
    //防止插入nil导致crash
    Method oldCreateObjc = class_getClassMethod(self, @selector(dictionaryWithObjects:forKeys:count:));
    Method newCreateObjc = class_getClassMethod(self, @selector(WGdictionaryWithObjects:forKeys:count:));
    method_exchangeImplementations(oldCreateObjc, newCreateObjc);
}

+ (instancetype)WGdictionaryWithObjects:(const id  [])objects forKeys:(const id [])keys count:(NSUInteger)cnt{
    NSMutableArray *objArr = @[].mutableCopy;
    NSMutableArray *keyArr = @[].mutableCopy;
    for (int i = 0; i < cnt; i++ ) {
        NSString *addr = [NSString stringWithFormat:@"%p",objects[i]];
        if ([addr length] > 5) {
            [objArr addObject:objects[i]];
            [keyArr addObject:keys[i]];
        }
    }
    return [NSDictionary dictionaryWithObjects:objArr forKeys:keyArr];
}

@end
