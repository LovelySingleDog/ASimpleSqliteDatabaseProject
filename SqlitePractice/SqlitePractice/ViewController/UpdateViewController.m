//
//  UpdateViewController.m
//  SqlitePractice
//
//  Created by wyzc03 on 17/1/18.
//  Copyright © 2017年 wyzc03. All rights reserved.
//

#import "UpdateViewController.h"
#import "UpdateViewController.h"
#import "DatabaseManager.h"
@interface UpdateViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextFeld;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (nonatomic,strong) DatabaseManager *manager;
@end

@implementation UpdateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nameTextFeld.text = self.name;
    self.phoneTextField.text = self.phone;
    // Do any additional setup after loading the view.
}
- (DatabaseManager *)manager{
    if (!_manager) {
        _manager = [[DatabaseManager alloc] init];
    }
    return _manager;
}

- (IBAction)updateAction:(UIButton *)sender {
    
    [self.manager updateName:_nameTextFeld.text phone:_phoneTextField.text oldName:self.name oldPhone:self.phone];
    //[self.manager updateName:self.name phone:self.phone oldName:_nameTextFeld.text oldPhone:_phoneTextField.text];
    
    NSLog(@"%@%@",self.name,self.phone);
    
    
}
- (IBAction)backAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
