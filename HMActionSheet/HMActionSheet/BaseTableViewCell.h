//
//  BaseTableViewCell.h
//  Haoshiqi
//
//  Created by haoshiqi on 15/11/18.
//  Copyright © 2015年 haoshiqi. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kCellHight 45

@interface BaseTableViewCell : UITableViewCell

- (void)setData:(id)data delegate:(id)delegate;

+ (CGFloat)heightWithData:(id)data;

@end
