# HMActionSheet
模仿UIActionSheet效果实现图文及纯文字效果

两种使用方法：
第一种

```
- (IBAction)onImageAndTextActionsheet:(UIButton *)sender {
    HMActionSheet *selectedView = [[HMActionSheet shareActionSheet] initWithTitle:@"图文action" cancelButtonTitle:@"取消" otherButtonTitles:@[@"15688888888", @"15699999999", @"15677777777"] actoinSheetType:HMActionSheetTypeImageAndText completion:^(NSString *string) {
        self.labelImageAndText.text = string;
    }];
    
    [selectedView show];
}
```

第二种

```
- (IBAction)onTextActionsheet:(UIButton *)sender {
    HMActionSheet *selectedView = [[HMActionSheet shareActionSheet] initWithTitle:@"选择" actoinSheetType:HMActionSheetTypeText];
    selectedView.cancelTitle = @"取消";
    selectedView.batchArray = @[@"张三", @"李四", @"王五"];
    [selectedView setBlock:^(NSString *string){
        self.labelText.text = string;
    }];
    [selectedView show];
}
```

