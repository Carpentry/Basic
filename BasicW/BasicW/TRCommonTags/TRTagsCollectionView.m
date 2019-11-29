//
//  TRTagsCollectionView.m
//  BasicW
//
//  Created by 小李 on 2019/11/26.
//  Copyright © 2019 lyl. All rights reserved.
//

#import "TRTagsCollectionView.h"
#import "TRTagCell.h"
#import "TRCollectionViewLeftAlignedLayout.h"
@interface TRTagsCollectionView()<TRCollectionViewDelegateLeftAlignedLayout, UICollectionViewDataSource>
{
    NSIndexPath *_lastChoose;
    NSInteger _chooseNumber;
}
@end

@implementation TRTagsCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    if (!layout) {
        TRCollectionViewLeftAlignedLayout *flowLayout = [[TRCollectionViewLeftAlignedLayout alloc] init];
        layout = flowLayout;
    }
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.scrollEnabled = YES;
        self.showsVerticalScrollIndicator = NO;
        self.allowsMultipleSelection = YES;
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = [UIColor clearColor];
        self.maxTagCount = NSIntegerMax;
        _chooseNumber = 0;
        [self registerClass:[TRTagCell class] forCellWithReuseIdentifier:[TRTagCell cellReuseIdentifier]];
        
    }
    return self;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _tagArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TRTagCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[TRTagCell cellReuseIdentifier] forIndexPath:indexPath];
    cell.type = TRTagCellTypeWait;
    cell.tagModel = _tagArray[indexPath.row];
    if (cell.tagModel.isChoose) {
        _lastChoose = indexPath;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    TRTagCell *cell = (TRTagCell *)[collectionView cellForItemAtIndexPath:indexPath];
    TRTagModel *tagModel = _tagArray[indexPath.row];
    if (tagModel.isChoose) {
        [self collectionView:collectionView didDeselectItemAtIndexPath:indexPath];
    }
    if (_chooseNumber < _maxTagCount) {
        _chooseNumber++;
        tagModel.isChoose = YES;
        cell.tagModel = tagModel;
        cell.type = TRTagCellTypeSelected;
        [self.chooseDelegate chooseTag:tagModel];
    } else {
        
    }
    
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    TRTagCell *cell = (TRTagCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.type = TRTagCellTypeWait;
    TRTagModel *tagModel = _tagArray[indexPath.row];
    if (tagModel.isChoose) {
        tagModel.isChoose = NO;
        _chooseNumber--;
        cell.tagModel = tagModel;
        [self.chooseDelegate disChooseTag:tagModel];
    } else {
        
    }
}

#pragma mark - TRCollectionViewDelegateLeftAlignedLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    TRTagModel *model = _tagArray[indexPath.row];
    CGSize size = [model.name sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]}];;
    return CGSizeMake(100,30);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 12;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 12;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(12, 12, 12, 12);
}

#pragma mark - lazy
- (void)setTagArray:(NSArray *)tagArray {
    _tagArray = tagArray;
    _chooseNumber = 0;
    [tagArray enumerateObjectsUsingBlock:^(TRTagModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
        if (model.isChoose) {
            _chooseNumber++;
        }
    }];

}


@end
