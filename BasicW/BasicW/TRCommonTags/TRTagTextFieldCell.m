//
//  TRTagTextFieldCell.m
//  BasicW
//
//  Created by 小李 on 2019/11/26.
//  Copyright © 2019 lyl. All rights reserved.
//

#import "TRTagTextFieldCell.h"
#import "UIColor+TRTag.h"
#import <Masonry/Masonry.h>
#import "TRTagModel.h"

#define kMaxWords   12

@interface TRTagTextFieldCell()<UITextFieldDelegate>

@end

@implementation TRTagTextFieldCell {
    UITextField *_textField;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    _textField = [[UITextField alloc] init];
    _textField.placeholder = @" 输入标签";
    _textField.backgroundColor = [UIColor redColor];
    _textField.delegate = self;
    _textField.tintColor = [UIColor tagCreateBgColor];
    _textField.font = [UIFont fontWithName:@"PingFangSC-Regular" size:17] == nil ? [UIFont systemFontOfSize:17]: [UIFont fontWithName:@"PingFangSC-Regular" size:17];
    [_textField addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.contentView addSubview:_textField];
    [_textField mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(-3.5);
    }];
}

+ (NSString *)cellReuseIdentifier {
    return NSStringFromClass(self);
}

 


#pragma mark - UITextFieldDelegate
- (void)textFieldChanged:(UITextField *)textField {
    NSString *toStr = textField.text;
    NSString *language = [[UIApplication sharedApplication] textInputMode].primaryLanguage;
    if ([language isEqualToString:@"zh-Hans"]) {
        UITextRange *selectedRange = [textField markedTextRange];
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        //高亮部分不算字数
        if (!position) {
            if (toStr.length > kMaxWords) {
                textField.text = [toStr substringToIndex:kMaxWords];
            }
        }
    } else { //非中文输入
        if (toStr.length > kMaxWords) {
            textField.text = [toStr substringToIndex:kMaxWords];
        }
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSString *text = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (text.length == 0) {
        return NO;
    }
    TRTagModel *model = [[TRTagModel alloc] init];
    model.name = text;
    textField.text = @" ";
    if ([self.delegate respondsToSelector:@selector(addTag:)]) {
        [self.delegate addTag:model];
    }
    return NO;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if ([textField.text isEqualToString:@" "]) {
        textField.text = @"";
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField.text.length == 0) {
        textField.text = @" ";
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (range.length == 1 && range.location == 0) {
        if ([self.delegate respondsToSelector:@selector(removeLastTag)]) {
            [self.delegate removeLastTag];
        }
        return NO;
    }
    return YES;
}

@end
