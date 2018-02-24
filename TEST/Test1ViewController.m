//
//  Test1ViewController.m
//  TEST
//
//  Created by chenyun on 2017/10/18.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "Test1ViewController.h"
#import "Test2ViewController.h"

@interface Test1ViewController ()

@end

@implementation Test1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)test:(id)sender {
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    Test2ViewController *test2 = [story instantiateViewControllerWithIdentifier:@"test2"];
    test2.name1 = @"4444444";
    test2.name2 = @"veefefee";
    [self.navigationController pushViewController:test2 animated:YES];
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
