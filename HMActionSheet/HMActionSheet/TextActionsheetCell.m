//
//  TextActionsheetCell.m
//  HMActionSheet
//
//  Created by haoshiqi on 16/4/29.
//  Copyright © 2016年 haoshiqi. All rights reserved.
//

#import "TextActionsheetCell.h"

@interface TextActionsheetCell ()

@property (strong, nonatomic) IBOutlet UILabel *labelContent;

@end

@implementation TextActionsheetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    
    self.labelContent.textColor = [UIColor grayColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)setData:(NSString *)data delegate:(id)delegate
{
    self.labelContent.text = data;
}

@end
