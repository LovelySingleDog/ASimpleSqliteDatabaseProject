//
//  TableViewCell.h
//  SqlitePractice
//
//  Created by wyzc03 on 17/1/18.
//  Copyright © 2017年 wyzc03. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Person.h"

extern NSString  *PRESENTVCNOTIFICATION;


@interface TableViewCell : UITableViewCell
@property (nonatomic,strong) Person * model;
//用于更新tableVeiw;
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) NSMutableArray * dataArray;
@end
