//
//  ViewController.m
//  SqlitePractice
//
//  Created by wyzc03 on 17/1/18.
//  Copyright © 2017年 wyzc03. All rights reserved.
//

#import "ViewController.h"
#import "TableViewCell.h"
#import "DatabaseManager.h"
#import "UpdateViewController.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray * dataArr;
@property (nonatomic,strong) DatabaseManager * manager;
@end

static NSString * reuseID = @"cell";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = 88;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //拿到数据
    self.dataArr = [self.manager.dataArray mutableCopy];
    //刷新tableView
    [self.tableView reloadData];
    //添加通知中心
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notification:) name:PRESENTVCNOTIFICATION object:nil];
}
- (void)notification:(NSNotification *)noti{
    UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UpdateViewController *VC = [mainStory instantiateViewControllerWithIdentifier:@"UPVC"];
    
    VC.name = noti.userInfo[@"name"];
    VC.phone = noti.userInfo[@"phone"];
    //NSLog(@"%@ %@",noti.userInfo[@"name"],noti.userInfo[@"phone"]);
    [self presentViewController:VC animated:YES completion:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseID forIndexPath:indexPath];
    
    cell.model = self.dataArr[indexPath.row];
    cell.tableView = tableView;
    cell.dataArray = self.dataArr;
    //NSLog(@"%@",self.dataArr[indexPath.row]);
    if (indexPath.row % 2 == 0) {
        cell.backgroundColor = [UIColor greenColor];
    }else {
        cell.backgroundColor = [UIColor yellowColor];
    }
    return cell;
}





- (IBAction)backAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma lazy load
- (DatabaseManager *)manager{
    if (!_manager) {
        _manager = [[DatabaseManager alloc] init];
    }
    return _manager;
}









- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
