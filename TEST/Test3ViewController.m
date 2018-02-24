//
//  Test3ViewController.m
//  TEST
//
//  Created by chenyun on 2017/11/13.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "Test3ViewController.h"
#import "Father.h"
#import "Son.h"

@interface Test3ViewController ()

@end

@implementation Test3ViewController

- (NSInteger)getDifferenceByDate:(NSString *)date {
    //获得当前时间
//    NSDate *now = [NSDate date];
    
    NSString *str = @"2017-11-22";
    
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *oldDate = [dateFormatter dateFromString:date];
    NSDate *now = [dateFormatter dateFromString:str];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    unsigned int unitFlags = NSCalendarUnitDay;
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:oldDate  toDate:now  options:0];
    return [comps day];
    
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    Son *son = [[Son alloc] init];
    
    NSDate *now = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *nowStr = [dateFormatter stringFromDate:now];
    
    NSInteger  aeee  = [self getDifferenceByDate:@"2017-10-21"];
    
    
    // Do any additional setup after loading the view.
    
    NSString *str = @"tuwonncgyewiweoifngvoi";
    NSMutableArray *array = [NSMutableArray array];
    for (NSInteger i = 0; i < str.length; i++) {
        NSString *charStr = [str substringWithRange:NSMakeRange(i, 1)];
        [array addObject:charStr];
    }
    NSLog(@"%@", array);
    
    NSMutableArray *array1 = [NSMutableArray array];    //放不重复的
    NSMutableArray *array2 = [NSMutableArray array];    //放重复的
    for (NSInteger i = 0; i < array.count; i++) {
        NSString *str = array[i];
        if (![array1 containsObject:str]) {
            if ([array2 containsObject:str]) {
                
            } else {
                [array1 addObject:str];
            }
        } else {
            [array2 addObject:str];
            NSInteger index = [array1 indexOfObject:str];
            [array1 removeObjectAtIndex:index];
        }
    }
    NSLog(@"%@", array1);
    NSLog(@"%@", array2);
//    NSMutableArray *array2 = [NSMutableArray array];
//    NSMutableDictionary *eee = [NSMutableDictionary dictionary];
//    [eee setValue:@(1) forKey:array[0]];
//    [array2 addObject:eee];
//
//    for (NSInteger i = 1; i < array.count - 1; i ++) {
//        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//        if (array2.count <= 0) {
//            [dict setValue:@(1) forKey:array[0]];
//            [array2 addObject:dict];
//        }
//        else {
//            NSDictionary *dict2 = array2[i-1];
//            NSString *object = [dict2 objectForKey:array[i]];
//            if ([dict2.allKeys containsObject:object]) {
//                // 在字典中找到了已经保存过的字符，取出记录的数值+1
//                NSInteger count = [dict2[object] integerValue] + 1;
//                [dict2 setValue:@(count) forKey:object];
//                [array2 addObject:dict2];
//            } else {
//                [dict setValue:@(1) forKey:array[i]];
//                [array2 addObject:dict];
//            }
//        }
//    }
//
//    for (NSInteger i = 0; i <array2.count; i++) {
//        NSDictionary *dict = array2[i];
//        NSString *value = dict[dict.allKeys[0]];
//        if ([value isEqualToString:@"1"]) {
//            NSLog(@"找到了第一个不重复出现的字符是%@,出现在%ld", dict.allKeys[0], (long)i);
//            break;
//        }
//    }
    
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
