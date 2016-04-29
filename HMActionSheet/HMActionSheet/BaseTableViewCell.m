//
//  BaseTableViewCell.m
//  Haoshiqi
//
//  Created by haoshiqi on 15/11/18.
//  Copyright © 2015年 haoshiqi. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    if ([self respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        self.preservesSuperviewLayoutMargins = NO;
        self.layoutMargins = UIEdgeInsetsZero;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)setData:(id)data delegate:(id)delegate
{
    
}

+ (CGFloat)heightWithData:(id)data
{
    return 45;
}

@end
