//
//  UIFont+TRTag.m
//  BasicW
//
//  Created by 小李 on 2019/11/27.
//  Copyright © 2019 lyl. All rights reserved.
//

#import "UIFont+TRTag.h"

@implementation UIFont (TRTag)
+ (UIFont *)tagCreateFont {
    return [self tagFontWithName:@"PingFangSC-Regular" sizie:17];
}

+ (UIFont *)tagWaitFont {
    return [self tagFontWithName:@"PingFangSC-Regular" sizie:15];
}

+ (UIFont *)tagSelectedFont{
    return [self tagFontWithName:@"PingFangSC-Regular" sizie:15];

}

+ (UIFont *)tagFontWithName:(NSString *)name sizie:(CGFloat)size {
    return [self fontWithName:name size:size] == nil ? [self systemFontOfSize:size] : [self fontWithName:name size:size];

}
@end
