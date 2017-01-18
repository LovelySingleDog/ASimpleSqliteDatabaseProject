//
//  InsertDataViewController.m
//  SqlitePractice
//
//  Created by wyzc03 on 17/1/18.
//  Copyright © 2017年 wyzc03. All rights reserved.
//

#import "InsertDataViewController.h"
#import "ViewController.h"
#import "DatabaseManager.h"
@interface InsertDataViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (nonatomic,strong) DatabaseManager *manager;
@end

@implementation InsertDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
#pragma lazy load
- (DatabaseManager *)manager{
    if (!_manager) {
        _manager = [[DatabaseManager alloc] init];
    }
    return _manager;
}
- (IBAction)insertDataAction:(UIButton *)sender {
    [self.manager insertDataWithName:self.nameTextField.text phone:self.phoneTextField.text];
}
- (IBAction)presentVCAction:(UIButton *)sender {
    
    //在storyBoard中加载视图控制器
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //这里的identifier是VC在story中设置的storyboard ID
    ViewController *VC = [story instantiateViewControllerWithIdentifier:@"VC"];
    
    [self presentViewController:VC animated:YES completion:^{
        
    }];
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
