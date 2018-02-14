//
//  TableViewController.m
//  ThemeDemo
//
//  Created by qwkj on 2018/2/8.
//  Copyright © 2018年 qwkj. All rights reserved.
//

#import "TableViewController.h"
#import "TableViewCell.h"
#import "UIImageView+WZTheme.h"

@interface TableViewController ()

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)initUI {
    self.title = @"列表";
    self.tableView.tableFooterView = [UIView new];
    self.tableView.rowHeight = 66;
    [self.tableView registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:nil] forCellReuseIdentifier:@"TableViewCell"];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCell" forIndexPath:indexPath];
    [cell.imageView wz_setImageWithName:@"电费@3x"];
    return cell;
}

@end
