//
//  TRCommonTagsViewController.m
//  BasicW
//
//  Created by 小李 on 2019/11/26.
//  Copyright © 2019 lyl. All rights reserved.
//

#import "TRCommonTagsViewController.h"
#import "TRCollectionViewLeftAlignedLayout.h"
#import "TRTagCell.h"
#import "TRTagsCollectionView.h"
#import "TRTagTextFieldCell.h"
#import <Masonry/Masonry.h>
#import "NSMutableArray+TRTag.h"

@interface TRCommonTagsViewController ()<UICollectionViewDataSource,TRCollectionViewDelegateLeftAlignedLayout,TRChooseDelegate,TRTagTextFieldCellDelegate> {
    UICollectionView *_selectedCollectionView;
    UIView *_backgroundView;
    UIMenuController *_menuController;
    TRTagsCollectionView *_tagCollectionView;
    
    NSMutableArray *_tagArray;
    NSMutableArray *_selectedArray;
    UILongPressGestureRecognizer *_longPress;
    TRTagModel *_delModel;
    
    NSInteger _selectedCollectionViewH;
    NSInteger _tagCollectionViewH;
    NSInteger _maxSelectedNum;
    NSInteger _tagCollectionMaxH;
    NSInteger _selectedCollectionViewMaxH;
    NSInteger _selectedCollectionContentSizeH;
}
@end

@implementation TRCommonTagsViewController

#pragma mark - Cycle
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)loadView {
    [super loadView];
    [self loadData];
    self.view.layer.masksToBounds = YES;
    _backgroundView = [[UIView alloc] init];
    _backgroundView.layer.masksToBounds = YES;
    _backgroundView.layer.borderWidth = 1;
    _backgroundView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_backgroundView];
    
    TRCollectionViewLeftAlignedLayout *layout = [[TRCollectionViewLeftAlignedLayout alloc] init];
    _selectedCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _selectedCollectionView.dataSource = self;
    _selectedCollectionView.delegate = self;
    _selectedCollectionView.backgroundColor = [UIColor clearColor];
    [_selectedCollectionView registerClass:[TRTagCell class] forCellWithReuseIdentifier:[TRTagCell cellReuseIdentifier]];
    [_selectedCollectionView registerClass:[TRTagTextFieldCell class] forCellWithReuseIdentifier:[TRTagTextFieldCell cellReuseIdentifier]];
    [self.view addSubview:_selectedCollectionView];
    
    _longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(profileTagLongPress:)];
    [_selectedCollectionView addGestureRecognizer:_longPress];
    
    _tagCollectionView = [[TRTagsCollectionView alloc] init];
    _tagCollectionView.chooseDelegate = self;
    _tagCollectionView.tagArray = _tagArray;
    [self.view addSubview:_tagCollectionView];

    [self.view updateConstraintsIfNeeded];
    [self.view layoutIfNeeded];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置标签";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
    if (_selectedCollectionViewH == 0) {
        _selectedCollectionViewH = _selectedCollectionView.contentSize.height;
    }
    
    if (_tagCollectionViewH == 0 && _selectedCollectionViewH != 0) {
        _tagCollectionMaxH = self.view.frame.size.height - _selectedCollectionViewH - 12 - 80;
        _tagCollectionViewH = _tagCollectionMaxH < _tagCollectionView.contentSize.height ? _tagCollectionMaxH : _tagCollectionView.contentSize.height;
    }
    
    [_selectedCollectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(12);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(_selectedCollectionViewH);
    }];
    [_backgroundView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(_selectedCollectionView);
        make.left.mas_equalTo(_selectedCollectionView).offset(-5);
        make.right.mas_equalTo(_selectedCollectionView).offset(5);
    }];
    [_tagCollectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_backgroundView.mas_bottom);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(_tagCollectionViewH);
    }];
}

#pragma mark - Private

- (void)loadData {
    _selectedArray = [NSMutableArray array];
    TRTagModel *model = [[TRTagModel alloc] init];
    model.name = @"123";
    model.isChoose = NO;
    [_selectedArray addObject:model];
    
    _tagArray = [NSMutableArray array];
    for (NSInteger i = 0; i < 40; i++) {
        TRTagModel *model = [[TRTagModel alloc] init];
        model.name = [NSString stringWithFormat:@"tag-%ld",i+1];
        model.isChoose = NO;
        [_tagArray addObject:model];
    }
    
    _maxSelectedNum = 12;
    _selectedCollectionViewH = 0;
    _selectedCollectionViewMaxH = 250;
}

- (void)showMenuController:(UIView *)showInView {
    _menuController = [UIMenuController sharedMenuController];
    UIMenuItem *item = [[UIMenuItem alloc] initWithTitle:@"删除" action:@selector(delCellAction:)];
    [_menuController setMenuItems:@[item]];

    if (@available(iOS 13.0, *)) {
        [_menuController showMenuFromView:showInView.superview rect:showInView.frame];
    } else {
        [_menuController setTargetRect:showInView.frame inView:showInView.superview];
        [_menuController setMenuVisible:YES animated:YES];
    }

}

- (void)delTag:(TRTagModel *)model {
    for (NSInteger i = 0; i < _tagArray.count; i++) {
        TRTagModel *tModel = _tagArray[i];
        if ([model.name isEqualToString:tModel.name]) {
            tModel.isChoose = NO;
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
            TRTagCell *cell = (TRTagCell *)[_tagCollectionView cellForItemAtIndexPath:indexPath];
            cell.tagModel = tModel;
            break;
        }
    }
    __weak typeof(self) ws = self;
    NSInteger index = [_selectedArray indexOfObject:model];
    [_selectedArray removeObjectAtIndex:index];
    [_selectedCollectionView performBatchUpdates:^{
        [_selectedCollectionView deleteItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:index inSection:0]]];
    } completion:^(BOOL finished) {
        if (finished) {
            [ws updateSelectedCollectionView];
        }
    }];
}

- (void)updateSelectedCollectionView {
    if (_selectedCollectionContentSizeH != _selectedCollectionView.contentSize.height) {
        _selectedCollectionContentSizeH = _selectedCollectionView.contentSize.height;
        NSInteger contentH = _selectedCollectionContentSizeH;
        if (contentH <= _selectedCollectionViewMaxH) {
            _selectedCollectionViewH = _selectedCollectionView.contentSize.height;
            _tagCollectionMaxH = self.view.frame.size.height - _selectedCollectionViewH - 12 - 80;
            _tagCollectionViewH = _tagCollectionMaxH < _tagCollectionView.contentSize.height ? _tagCollectionMaxH: _tagCollectionView.contentSize.height;
            [self updateView];
        } else {
            [_selectedCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_selectedArray.count inSection:0] atScrollPosition:UICollectionViewScrollPositionBottom animated:YES];
        }
    }
}


- (void)updateView {
    [UIView animateWithDuration:0.1 animations:^{
        [self updateViewConstraints];
        [self.view layoutIfNeeded];
    }];
}

#pragma mark - Action
- (void)profileTagLongPress:(UILongPressGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateBegan) {
        CGPoint locP = [sender locationInView:_selectedCollectionView];
        NSIndexPath *indexPath =[_selectedCollectionView indexPathForItemAtPoint:locP];
        if (indexPath.row == _selectedArray.count) {
            return;
        }
        TRTagCell *cell = (TRTagCell *)[_selectedCollectionView cellForItemAtIndexPath:indexPath];
        _delModel = cell.tagModel;
        [cell becomeFirstResponder];
        [self showMenuController:cell.textLabel];
    }
}

- (void)delCellAction:(id)sender {
    [self delTag:_delModel];
}

#pragma mark - Lazy

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _selectedArray.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < _selectedArray.count) {
        TRTagCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[TRTagCell cellReuseIdentifier] forIndexPath:indexPath];
        cell.tagModel = _selectedArray[indexPath.row];
        cell.type = TRTagCellTypeCreate;
        return cell;
    }
    TRTagTextFieldCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[TRTagTextFieldCell cellReuseIdentifier] forIndexPath:indexPath];
    cell.delegate = self;
    return cell;
}

#pragma mark - TRCollectionViewDelegateLeftAlignedLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(100, 30);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 12;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 12;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(6, 12, 6, 12);
}

#pragma mark - TRChooseDelegate
- (void)chooseTag:(TRTagModel *)tagModel {
    [self addTag:tagModel];
}

- (void)disChooseTag:(TRTagModel *)tagModel {
    [self delTag:tagModel];
}

#pragma mark - TRTagTextFieldCellDelegate

- (void)addTag:(TRTagModel *)model {
    //是否有重复
    for (NSInteger i = 0; i < _selectedArray.count; i++) {
        TRTagModel *tModel = _selectedArray[i];
        if ([model.name isEqualToString:tModel.name]) {
            NSIndexPath *from = [NSIndexPath indexPathForItem:i inSection:0];
            NSIndexPath *to = [NSIndexPath indexPathForItem:_selectedArray.count - 1 inSection:0];
            [_selectedArray moveObjectFromIndex:i toIndex:_selectedArray.count - 1];
            [_selectedCollectionView performBatchUpdates:^{
                [_selectedCollectionView moveItemAtIndexPath:from toIndexPath:to];
            } completion:^(BOOL finished) {
                if (finished) {
                    [self updateSelectedCollectionView];
                }
            }];
            return;
        }
    }
    for (NSInteger i = 0; i < _tagArray.count; i++) {
        TRTagModel *tModel = _tagArray[i];
        if ([model.name isEqualToString:tModel.name]) {
            tModel.isChoose = YES;
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
            TRTagCell *cell = (TRTagCell *)[_tagCollectionView cellForItemAtIndexPath:indexPath];
            cell.tagModel= tModel;
            model = tModel;
            break;
        }
    }
    
    [_selectedArray addObject:model];
    [_selectedCollectionView performBatchUpdates:^{
        [_selectedCollectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:_selectedArray.count - 1 inSection:0]]];
    } completion:^(BOOL finished) {
        if (finished) {
            [self updateSelectedCollectionView];
        }
    }];
    
}

- (void)removeLastTag {
    if (_selectedArray.count > 0) {
        TRTagModel *model = _selectedArray.lastObject;
        [self delTag:model];
    }
}


@end
