//
//  ViewController.m
//  ZhenZhenTime
//
//  Created by 苏苏 on 2019/8/8.
//  Copyright © 2019 susu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextView *ZhenTextView;
- (IBAction)changeBtn:(UIButton *)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

}


- (IBAction)changeBtn:(UIButton *)sender {
    
    //NSLog(@" - - %@",_ZhenTextView.text);
    NSArray *array = [_ZhenTextView.text componentsSeparatedByString:@"\n"]; //字符串按照\n分隔成数组
    //截取时间
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSMutableArray *timeArray = [NSMutableArray new];
        for (NSInteger i = 0; i < array.count; i++) {
            NSString *timeStr = [array[i] substringWithRange:NSMakeRange(1, 14)];
            [timeArray addObject:timeStr];
        }
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSMutableArray *formatterTimeArray = [NSMutableArray new];
                NSMutableString *formatterTimeStr = [NSMutableString string];
                for (NSInteger i = 0; i < timeArray.count; i++) {
                    NSString *date = [[self class] timeStrToTimestamp:timeArray[i]];
                    [formatterTimeArray addObject:date];
                    [formatterTimeStr appendString:date];
                    [formatterTimeStr appendString:@"\n"];
                }
                self->_ZhenTextView.text = formatterTimeStr;
            });
        });
}

//将时间字符串转换为指定时间字符
+ (NSString *)timeStrToTimestamp:(NSString *)timeStr {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 设置日期格式
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    // 要转换的日期字符串
    NSDate *someDay = [formatter dateFromString:timeStr];
    //NSLog(@"%@", someDay);
    //重新转换的格式
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *time = [formatter stringFromDate:someDay];
    return time;
}


@end
