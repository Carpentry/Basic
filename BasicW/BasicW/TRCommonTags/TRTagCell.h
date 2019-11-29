//
//  TRTagCell.h
//  BasicW
//
//  Created by 小李 on 2019/11/26.
//  Copyright © 2019 lyl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TRTagModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, TRTagCellType) {
    TRTagCellTypeCreate,    //新建
    TRTagCellTypeWait,      //待选状态
    TRTagCellTypeSelected,  //选中
};

@interface TRTagCell : UICollectionViewCell
@property (nonatomic, strong) TRTagModel *tagModel;
@property (nonatomic, assign) TRTagCellType type;
@property (nonatomic, strong) UILabel *textLabel;

+ (NSString *)cellReuseIdentifier;
@end

NS_ASSUME_NONNULL_END
