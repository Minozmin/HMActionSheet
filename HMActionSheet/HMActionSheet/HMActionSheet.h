//
//  HMActionSheet.h
//  HMActionSheet
//
//  Created by haoshiqi on 16/4/29.
//  Copyright © 2016年 haoshiqi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HMActionSheetType)
{
    HMActionSheetTypeText,
    HMActionSheetTypeImageAndText
};

typedef void(^HMActionSheetBlock)(NSString *string);

@interface HMActionSheet : UIView

@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *cancelTitle;
@property (nonatomic, strong) NSArray *batchArray;
@property (nonatomic, copy)   HMActionSheetBlock block;
@property (nonatomic, assign) HMActionSheetType actionSheetType;

+ (HMActionSheet *)shareActionSheet;

- (instancetype)initWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles actoinSheetType:(HMActionSheetType)type completion:(void(^)(NSString *string))completion;
- (instancetype)initWithTitle:(NSString *)title actoinSheetType:(HMActionSheetType)type;
- (void)show;

@end
