//
//  TRTagsCollectionView.h
//  BasicW
//
//  Created by 小李 on 2019/11/26.
//  Copyright © 2019 lyl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TRTagModel.h"


@protocol TRChooseDelegate <NSObject>
- (void)chooseTag:(TRTagModel *)tagModel;
- (void)disChooseTag:(TRTagModel *)tagModel;

@end

@interface TRTagsCollectionView : UICollectionView
@property (nonatomic, weak) id<TRChooseDelegate> chooseDelegate;
@property (nonatomic, strong) NSArray *tagArray;
@property (nonatomic, assign) NSInteger maxTagCount;

@end

