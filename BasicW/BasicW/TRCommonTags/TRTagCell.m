//
//  TRTagCell.m
//  BasicW
//
//  Created by 小李 on 2019/11/26.
//  Copyright © 2019 lyl. All rights reserved.
//

#import "TRTagCell.h"
#import "UIFont+TRTag.h"
#import "UIColor+TRTag.h"
#import <Masonry/Masonry.h>

@implementation TRTagCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    _textLabel = [[UILabel alloc] init];
    _textLabel.textAlignment = NSTextAlignmentCenter;
    _textLabel.font = [UIFont tagCreateFont];
    _textLabel.layer.cornerRadius = 4;
    _textLabel.layer.borderWidth = 0.5;
    [self.contentView addSubview:_textLabel];
    [_textLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.equalTo(self.contentView).offset(0);
        make.width.equalTo(self);
    }];
}

- (void)setupTextColor:(UIColor *)tColor borderColor:(UIColor *)bColor backGroundColor:(UIColor *)bgColor {
    _textLabel.textColor = tColor;
    _textLabel.backgroundColor = bgColor;
    _textLabel.layer.borderColor = bgColor.CGColor;
}


- (void)setTagModel:(TRTagModel *)tagModel {
    _tagModel = tagModel;
    _textLabel.text = tagModel.name;
    switch (self.type) {
        case TRTagCellTypeCreate:{
            [self setupTextColor:[UIColor tagCreateFontColor] borderColor:[UIColor tagCreateBorderColor] backGroundColor:[UIColor tagCreateBgColor]];
            break;
        }
        case TRTagCellTypeWait:{
            [self setupTextColor:[UIColor tagWaitFontColor] borderColor:[UIColor tagWaitBorderColor] backGroundColor:[UIColor tagWaitBgColor]];
            break;
        }
        case TRTagCellTypeSelected:{
            [self setupTextColor:[UIColor tagSelectedFontColor] borderColor:[UIColor tagSelectedBorderColor] backGroundColor:[UIColor tagSelectedBgColor]];
            break;
        }
    }
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

+ (NSString *)cellReuseIdentifier {
    return NSStringFromClass(self);
}

@end
