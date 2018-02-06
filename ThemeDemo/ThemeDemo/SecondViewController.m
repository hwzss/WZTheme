//
//  SecondViewController.m
//  ThemeDemo
//
//  Created by qwkj on 2018/2/6.
//  Copyright © 2018年 qwkj. All rights reserved.
//

#import "SecondViewController.h"
#import "UIImageView+WZTheme.h"

@interface SecondViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *themeImageView;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.themeImageView wz_setImageWithName:@"主题云钥匙选中状态@3x"];
    [self.themeImageView wz_setImageWithName:@"主题云钥匙选中状态@3x"];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
