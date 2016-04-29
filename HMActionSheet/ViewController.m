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
    HMActionSheet *selectedView = [HMActionSheet shareActionSheet];
    [selectedView.tableview registerNib:[UINib nibWithNibName:@"ImageAndTextCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"Cell"];
    selectedView.title = @"图文action";
    selectedView.batchArray = @[@"15688888888", @"15699999999", @"15677777777"];
    [selectedView setBlock:^(NSString *string){
        self.labelImageAndText.text = string;
    }];
    [selectedView show];
}

- (IBAction)onTextActionsheet:(UIButton *)sender {
    HMActionSheet *selectedView = [HMActionSheet shareActionSheet];
    [selectedView.tableview registerNib:[UINib nibWithNibName:@"TextActionsheetCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"Cell"];
    selectedView.title = @"选择";
    selectedView.batchArray = @[@"张三", @"李四", @"王五"];
    [selectedView setBlock:^(NSString *string){
        self.labelText.text = string;
    }];
    [selectedView show];
}

@end
