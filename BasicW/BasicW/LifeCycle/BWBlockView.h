//
//  BWBlockView.h
//  BasicW
//
//  Created by 小李 on 2019/11/12.
//  Copyright © 2019 lyl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^ClickedBlock)(void);

@interface BWBlockView : UIView
@property (nonatomic, copy) ClickedBlock clickBlock;

- (void)doSth;
@end

NS_ASSUME_NONNULL_END
