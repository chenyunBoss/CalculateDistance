//
//  Test2ViewController.m
//  TEST
//
//  Created by chenyun on 2017/10/18.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "Test2ViewController.h"

@interface Test2ViewController ()

@end

@implementation Test2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)test:(id)sender {
    self.name1 = @"1111";
    self.name2 = @"2222";
    NSLog(@"name1--%@",self.name1);
    NSLog(@"name2--%@",self.name2);
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
