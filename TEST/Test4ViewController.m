//
//  Test4ViewController.m
//  TEST
//
//  Created by chenyun on 2017/12/1.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "Test4ViewController.h"
#import "TestView.h"
#import "TestCell.h"

@interface Test4ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation Test4ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor yellowColor];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imgView.image = [UIImage imageNamed:@"854037.jpg"];
//    [self.view addSubview:imgView];
    
//    TestView *testView = [[TestView alloc] initWithFrame:CGRectMake(30, 200, 300, 100)];
//    testView.clipsToBounds = YES;
//    testView.layer.cornerRadius = 4;
//    [self.view addSubview:testView];
//    self.view.backgroundColor = [UIColor redColor];
//    self.tableView.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
//    self.tableView.backgroundColor = [UIColor clearColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor redColor];
//    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"TestCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TestCell *cell = (TestCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"eeeeeeeeeeee");
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"退票成功!" preferredStyle:UIAlertControllerStyleAlert];
//    alert.ctripDic = @{@"ctTitle" : @"退票险理赔申请提示"};
    //修改按钮的颜色
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"退票险理赔" style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action) {
        
    }];
    [sure setValue:[UIColor orangeColor] forKey:@"_titleTextColor"];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"知道了"  style:UIAlertActionStyleCancel handler:^(UIAlertAction *_Nonnull action) {
        
    }];
    //    [cancle setValue:[UIColor orangeColor] forKey:@"_titleTextColor"];
    [alert addAction:sure];
    [alert addAction:cancle];
    
    [self presentViewController:alert animated:YES completion:nil];
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
