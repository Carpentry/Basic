//
//  UIFont+TRTag.h
//  BasicW
//
//  Created by 小李 on 2019/11/27.
//  Copyright © 2019 lyl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIFont (TRTag)
+ (UIFont *)tagCreateFont ;
+ (UIFont *)tagWaitFont ;
+ (UIFont *)tagSelectedFont;
@end

NS_ASSUME_NONNULL_END
