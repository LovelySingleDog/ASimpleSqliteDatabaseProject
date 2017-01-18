//
//  TableViewCell.m
//  SqlitePractice
//
//  Created by wyzc03 on 17/1/18.
//  Copyright © 2017年 wyzc03. All rights reserved.
//

#import "TableViewCell.h"
#import "DatabaseManager.h"
#import "UpdateViewController.h"

NSString  *PRESENTVCNOTIFICATION = @"TableViewCellPresentVCNotificationName";


@interface TableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLable;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (nonatomic, strong) DatabaseManager *manager;
@end
@implementation TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (DatabaseManager *)manager{
    if (!_manager) {
        _manager = [[DatabaseManager alloc] init];
    }
    return _manager;
}
- (void)setModel:(Person *)model{
    
    _model = model;
    self.nameLabel.text = model.name;
    self.phoneLable.text = model.phone;
}
//删除按钮
- (IBAction)deleteAction:(UIButton *)sender {
    [self.manager deletePhoneNumber:self.model.phone];
    
    //删除对应的数据
    [self.dataArray removeObject:self.model];
    //刷洗tableView;
    [self.tableView reloadData];
}
//更新按钮
- (IBAction)updateAction:(UIButton *)sender {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:PRESENTVCNOTIFICATION object:self userInfo:@{@"name":_model.name,@"phone":_model.phone}];
}

- (void)setFrame:(CGRect)frame{
    
    frame.size.height -= 10;
    
    [super setFrame:frame];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
