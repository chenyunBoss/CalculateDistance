//
//  Test5ViewController.m
//  TEST
//
//  Created by chenyun on 2017/12/11.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "Test5ViewController.h"
#import "Son.h"

@interface Test5ViewController ()

@property (nonatomic, strong) UILabel *infoLabel;

@property (nonatomic, strong) UIButton *btn;

@end

@implementation Test5ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    Son *son = [[Son alloc] init];
//    [son fatherMethod];
    
//    self.infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 200, 100, 40)];
//    self.infoLabel.text = @"frgrgrgg";
//    self.infoLabel.backgroundColor = [UIColor redColor];
//    [self.view addSubview:self.infoLabel];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(30, 200, 142, 133)];
    [btn setImage:[UIImage imageNamed:@"test"] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    self.btn = btn;
    [self.btn addTarget:self action:@selector(test) forControlEvents:UIControlEventTouchUpInside];
    
    CABasicAnimation* shake = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    shake.fromValue = [NSNumber numberWithFloat:-5];
    shake.toValue = [NSNumber numberWithFloat:5];
    shake.duration = 0.1;//执行时间
    shake.autoreverses = YES; //是否重复
    shake.repeatCount = 8;//次数
    [self.btn.layer addAnimation:shake forKey:@"shakeAnimation"];
    self.btn.alpha = 1.0;
//    [UIView animateWithDuration:2.0 delay:0.0 options:UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionAllowUserInteraction animations:^{
//        //self.infoLabel.alpha = 0.0; //透明度变0则消失
//    } completion:nil];
}

- (void)test {
    NSLog(@"rrrrr");
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
