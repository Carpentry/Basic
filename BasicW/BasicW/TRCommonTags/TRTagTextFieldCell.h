//
//  TRTagTextFieldCell.h
//  BasicW
//
//  Created by 小李 on 2019/11/26.
//  Copyright © 2019 lyl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TRTagModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol TRTagTextFieldCellDelegate <NSObject>
- (void)addTag:(TRTagModel *)model;
- (void)removeLastTag;

@end

@interface TRTagTextFieldCell : UICollectionViewCell
@property (nonatomic, weak) id<TRTagTextFieldCellDelegate> delegate;
+ (NSString *)cellReuseIdentifier;
@end

NS_ASSUME_NONNULL_END
