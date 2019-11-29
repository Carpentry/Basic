//
//  UIColor+TRTag.h
//  BasicW
//
//  Created by 小李 on 2019/11/26.
//  Copyright © 2019 lyl. All rights reserved.
//
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (TRTag)
+ (UIColor *)tagCreateBgColor; //创建时背景色
+ (UIColor *)tagWaitBgColor; //待选背景色
+ (UIColor *)tagSelectedBgColor; //选中背景色
+ (UIColor *)tagCreateFontColor;//创建时字体色
+ (UIColor *)tagWaitFontColor; //待选字体色
+ (UIColor *)tagSelectedFontColor; //选中字体色
+ (UIColor *)tagCreateBorderColor; //创建时边框色
+ (UIColor *)tagWaitBorderColor; //待选边框色
+ (UIColor *)tagSelectedBorderColor;//选中边框色


@end

NS_ASSUME_NONNULL_END
