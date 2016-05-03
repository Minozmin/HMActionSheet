//
//  ViewController.m
//  HMActionSheet
//
//  Created by haoshiqi on 16/4/29.
//  Copyright © 2016年 haoshiqi. All rights reserved.
//

#import "ViewController.h"
#import "HMActionSheet.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UILabel *labelImageAndText;
@property (strong, nonatomic) IBOutlet UILabel *labelText;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - action

- (IBAction)onImageAndTextActionsheet:(UIButton *)sender {
    HMActionSheet *selectedView = [[HMActionSheet shareActionSheet] initWithTitle:@"图文action" cancelButtonTitle:@"取消" otherButtonTitles:@[@"15688888888", @"15699999999", @"15677777777"] actoinSheetType:HMActionSheetTypeImageAndText completion:^(NSString *string) {
        self.labelImageAndText.text = string;
    }];
    
    [selectedView show];
}

- (IBAction)onTextActionsheet:(UIButton *)sender {
    HMActionSheet *selectedView = [[HMActionSheet shareActionSheet] initWithTitle:@"选择" actoinSheetType:HMActionSheetTypeText];
    selectedView.cancelTitle = @"取消";
    selectedView.batchArray = @[@"张三", @"李四", @"王五"];
    [selectedView setBlock:^(NSString *string){
        self.labelText.text = string;
    }];
    [selectedView show];
}

@end
