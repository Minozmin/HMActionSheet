//
//  HMActionSheet.m
//  HMActionSheet
//
//  Created by haoshiqi on 16/4/29.
//  Copyright © 2016年 haoshiqi. All rights reserved.
//

#import "HMActionSheet.h"
#import "BaseTableViewCell.h"
#import "UIView+Frame.h"

#define HSQColorBlue  [UIColor colorWithRed:0.0 / 255. green:128.0 / 255. blue:233.0 / 255. alpha:1]

@interface HMActionSheet () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UIView *viewBackground;
@property (nonatomic, strong) UIView *viewTable;
@property (nonatomic, strong) UIButton *buttonCancel;

@end

@implementation HMActionSheet

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self installView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self installView];
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title actoinSheetType:(HMActionSheetType)type
{
    self = [super init];
    if (self) {
        _title = title;
        [self registerNib:type];
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles actoinSheetType:(HMActionSheetType)type completion:(void(^)(NSString *string))completion
{
    self = [super init];
    if (self) {
        self.title = title;
        self.cancelTitle = cancelButtonTitle;
        self.batchArray = otherButtonTitles;
        self.block = [completion copy];
        [self registerNib:type];
    }
    return self;
}

- (void)registerNib:(HMActionSheetType)type
{
    switch (type) {
        case HMActionSheetTypeText:
            [self.tableview registerNib:[UINib nibWithNibName:@"TextActionsheetCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"Cell"];
            break;
            
        case HMActionSheetTypeImageAndText:
            [self.tableview registerNib:[UINib nibWithNibName:@"ImageAndTextCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"Cell"];
            break;
    }
}

- (void)setBatchArray:(NSArray *)batchArray
{
    _batchArray = batchArray;
    
    /**
     先根据传过来的数据 改变改变View的高度
     在覆盖毛玻璃效果
     把毛玻璃效果放在下面
     */
    CGFloat height = 0;
    for (int section = 0; section < [self.tableview numberOfSections]; section ++) {
        for (int row = 0; row < [self.tableview numberOfRowsInSection:section]; row ++) {
            height += [self tableView:self.tableview heightForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:section]];
        }
    }

    self.viewTable.height = height;
    self.tableview.height = height;
    
    [self blurEffect:self.viewTable];
    [self.viewTable bringSubviewToFront:self.tableview];
    self.buttonCancel.y = CGRectGetMaxY(self.viewTable.frame)+10;
    [self.tableview reloadData];
}

#pragma mark - init view

+ (HMActionSheet *)shareActionSheet
{
    UIView *window = [UIApplication sharedApplication].keyWindow;
    return [[self alloc] initWithFrame:window.bounds];
}

- (void)show {
    UIView *windon = [UIApplication sharedApplication].keyWindow;
    self.frame = windon.bounds;
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [windon addSubview:self];
    [self showAnimation];
}

- (void)showAnimation {
    
    CGFloat height = CGRectGetMaxY(self.buttonCancel.frame) + 8;
    self.viewBackground.frame = CGRectMake(0, CGRectGetMaxY(self.bounds), CGRectGetWidth(self.bounds), height);
    [UIView animateWithDuration:0.26 animations:^{
        self.viewBackground.frame = CGRectMake(0, CGRectGetMaxY(self.bounds) - height, CGRectGetWidth(self.bounds), height);
    }];
}

- (void)setTitle:(NSString *)title
{
    _title = title;
}

- (void)setCancelTitle:(NSString *)cancelTitle
{
    _cancelTitle = cancelTitle;
    [self.buttonCancel setTitle:_cancelTitle
              forState:UIControlStateNormal];
    [self.buttonCancel setTitleColor:HSQColorBlue
                   forState:UIControlStateNormal];
}

- (void)installView
{
    [self addSubview:self.viewBackground];
    [self.viewBackground addSubview:self.viewTable];
    [self.viewTable addSubview:self.tableview];
    [self.viewBackground addSubview:self.buttonCancel];
}

- (UIView *)viewBackground
{
    if (!_viewBackground) {
        _viewBackground = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))];
        _viewBackground.backgroundColor = [UIColor clearColor];
    }
    return _viewBackground;
}

- (UIView *)viewTable
{
    if (!_viewTable) {
        _viewTable = [[UIView alloc] initWithFrame:CGRectMake(8, 0, CGRectGetWidth(self.viewBackground.frame) - 16, 44)];
        _viewTable.layer.cornerRadius = 3;
        _viewTable.layer.masksToBounds = YES;
    }
    return _viewTable;
}

- (UITableView *)tableview
{
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.viewTable.bounds), CGRectGetHeight(self.viewTable.bounds)) style:UITableViewStylePlain];
        _tableview.backgroundColor = [UIColor clearColor];
        _tableview.separatorInset = UIEdgeInsetsZero;
        _tableview.scrollEnabled = NO;
        _tableview.dataSource = self;
        _tableview.delegate = self;
        [_tableview registerClass:[BaseTableViewCell class] forCellReuseIdentifier:@"Cell"];
    }
    return _tableview;
}

- (UIButton *)buttonCancel
{
    if (!_buttonCancel) {
        _buttonCancel = [UIButton buttonWithType:UIButtonTypeCustom];
        _buttonCancel.frame = CGRectMake(8, CGRectGetMaxY(self.viewTable.bounds)+10, CGRectGetWidth(self.viewTable.bounds), 44);
        
        UIButton *clickBtn = [[UIButton alloc] initWithFrame:_buttonCancel.bounds];
        clickBtn.backgroundColor = [UIColor clearColor];
        
        [self blurEffect:_buttonCancel];
        [_buttonCancel addSubview:clickBtn];
        clickBtn.titleLabel.font = [UIFont systemFontOfSize:18.0f];
        [clickBtn addTarget:self
                     action:@selector(onCancel)
           forControlEvents:UIControlEventTouchUpInside];
        
        _buttonCancel.layer.cornerRadius = 3;
        _buttonCancel.layer.masksToBounds = YES;
    }
    return _buttonCancel;
}

#pragma mark - 毛玻璃特效
- (void)blurEffect:(UIView *)view
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0) {
        view.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.9];
    }else {
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        effectView.frame = CGRectMake(0, 0, CGRectGetWidth(view.bounds), CGRectGetHeight(view.bounds));
        [view addSubview:effectView];
    }
}

#pragma mark - action

- (void)onCancel
{
    [self disapperAnimation];
}

#pragma mark - tableview delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.batchArray.count + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row != 0) {
        return [[[tableView dequeueReusableCellWithIdentifier:@"Cell"] class] heightWithData:self.batchArray[indexPath.row - 1]];
    }
    
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        static NSString *str = @"TitleCell";
        BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if (cell == nil) {
            cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
            if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
                cell.preservesSuperviewLayoutMargins = NO;
                cell.layoutMargins = UIEdgeInsetsZero;
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.font = [UIFont systemFontOfSize:18.0f];
            cell.backgroundColor = [UIColor clearColor];
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
        }
        cell.textLabel.text = self.title;
        return cell;
    }else{
        BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        [cell setData:self.batchArray[indexPath.row - 1] delegate:self];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row != 0) {
        if (self.block) {
            self.block(self.batchArray[indexPath.row - 1]);
        }
    }
    
    [self disapperAnimation];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    UIView *window = [UIApplication sharedApplication].keyWindow;
    self.frame =  window.bounds;
}

#pragma mark - touch

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self disapperAnimation];
}

- (void)disapperAnimation
{
    [UIView animateWithDuration:0.26 animations:^{
        CGFloat height = CGRectGetMaxY(self.buttonCancel.frame) + 8;
        self.viewBackground.frame = CGRectMake(0, CGRectGetMaxY(self.bounds), CGRectGetWidth(self.bounds), height);
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    } ];
}

@end
