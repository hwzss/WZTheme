//
//  ViewController.m
//  ThemeDemo
//
//  Created by qwkj on 2017/12/20.
//  Copyright © 2017年 qwkj. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+WZTheme.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *aImageV;
@property (weak, nonatomic) IBOutlet UIImageView *secondImageV;

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *bundlePath = [NSBundle mainBundle].resourcePath;
    NSString *defaultBundlePath = [bundlePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.bundle",@"main"]];
    NSBundle *imageBundle = [NSBundle bundleWithPath:defaultBundlePath];
    NSString *imagePath = [imageBundle pathForResource:@"电费@3x" ofType:@"png"];
    
    
    self.aImageV.image = [UIImage wz_themeImageName:@"电费@3x"];
    self.secondImageV.image = [UIImage wz_themeImageName:@"主题云钥匙选中状态@3x"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
