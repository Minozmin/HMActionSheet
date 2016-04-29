//
//  HMActionSheet.h
//  HMActionSheet
//
//  Created by haoshiqi on 16/4/29.
//  Copyright © 2016年 haoshiqi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^HMActionSheetBlock)(NSString *string);

@interface HMActionSheet : UIView

@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSArray *batchArray;
@property (nonatomic, copy)   HMActionSheetBlock block;

+ (HMActionSheet *)shareActionSheet;

- (void)show;

@end
