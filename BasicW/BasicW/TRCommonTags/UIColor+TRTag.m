//
//  UIColor+TRTag.m
//  BasicW
//
//  Created by 小李 on 2019/11/26.
//  Copyright © 2019 lyl. All rights reserved.
//

#import "UIColor+TRTag.h"


@implementation UIColor (TRTag)

+ (UIColor *)tagCreateBgColor { //创建时背景色
    return [self tagColorWithRed:255.0 green:255.0 blue:255.0];
}

+ (UIColor *)tagWaitBgColor { //待选背景色
    return [self tagColorWithRed:245.0 green:246.0 blue:248.0];

}

+ (UIColor *)tagSelectedBgColor { //选中背景色
    return [self tagColorWithRed:255.0 green:123.0 blue:17.0];
}

+ (UIColor *)tagCreateFontColor { //创建时字体色
    return [self tagColorWithRed:0 green:0 blue:0];
}

+ (UIColor *)tagWaitFontColor { //待选字体色
    return [self tagColorWithRed:144.0 green:143.0 blue:157.0];
}

+ (UIColor *)tagSelectedFontColor { //选中字体色
    return [self tagColorWithRed:0 green:0 blue:0];
}

+ (UIColor *)tagCreateBorderColor { //创建时边框色
    return [self tagColorWithRed:207.0 green:209.0 blue:221.0];
}

+ (UIColor *)tagWaitBorderColor { //待选边框色
    return [self tagColorWithRed:245.0 green:246.0 blue:248.0];
}

+ (UIColor *)tagSelectedBorderColor { //选中边框色
    return [self tagColorWithRed:255.0 green:123.0 blue:17.0];
}

+ (UIColor *)tagColorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue {
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];
}
@end
