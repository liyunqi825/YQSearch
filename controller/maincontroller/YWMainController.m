//
//  YWMainController.m
//  YQSearch
//
//  Created by yunqi on 16/8/13.
//  Copyright © 2016年 yunqi. All rights reserved.
//

#import "YWMainController.h"
#import "YWSearchController.h"
@interface YWMainController ()<UITextFieldDelegate>
{
    UITextField *texiField;
    UIButton *btnSearch;
}
@end

@implementation YWMainController

- (void)viewDidLoad {
    self.title=@"为有搜索";
    [super viewDidLoad];
    texiField=[[UITextField alloc]init];
    texiField.returnKeyType=UIReturnKeyDone;
//    texiField.backgroundColor=[UIColor redColor];
    self.view.backgroundColor=UIColorFromRGB(243, 243, 243);
    texiField.borderStyle=UITextBorderStyleRoundedRect;
    [self.view addSubview:texiField];
    texiField.delegate=self;
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickView)]];
    // Do any additional setup after loading the view.
}
-(void)clickView
{
    [texiField resignFirstResponder];
}
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    texiField.frame=CGRectMake(15, 130, self.view.frame.size.width-30, 50);
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self doSearch];
    [self clickView];
    return YES;
}
-(void)doSearch
{
    if (texiField.text.length) {
        YWSearchController *searchController=[[YWSearchController alloc]init];
        searchController.keyWorld=texiField.text;
        [self.navigationController pushViewController:searchController animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
