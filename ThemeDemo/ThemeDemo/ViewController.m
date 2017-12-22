//
//  ViewController.m
//  ThemeDemo
//
//  Created by qwkj on 2017/12/20.
//  Copyright © 2017年 qwkj. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+WZTheme.h"
#import "WZThemeManger.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *aImageV;
@property (weak, nonatomic) IBOutlet UIImageView *secondImageV;

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.aImageV wz_setImageWithName:@"电费@3x"];
    [self.secondImageV wz_setImageWithName:@"主题云钥匙选中状态@3x"];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [[WZThemeManger manger] useDefaultTheme];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
