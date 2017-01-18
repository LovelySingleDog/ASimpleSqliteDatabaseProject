//
//  DatabaseManager.h
//  SqlitePractice
//
//  Created by wyzc03 on 17/1/18.
//  Copyright © 2017年 wyzc03. All rights reserved.
//

#import <Foundation/Foundation.h>
//导入模型
#import "Person.h"
//数据库表的名称
extern NSString * const TABLE_NAME;
//字段名称
extern NSString * const NAME;//姓名
extern NSString * const PHONE;//电话


@interface DatabaseManager : NSObject
@property (nonatomic,strong,readonly) NSArray * dataArray;//存储结果的数组


//插入信息
- (void)insertDataWithName:(NSString *)name phone:(NSString *)phone;
//删除数据
- (void)deletePhoneNumber:(NSString *)phone;
//更新数据
- (BOOL)updateName:(NSString *)name phone:(NSString *)phone oldName:(NSString *)oldName oldPhone:(NSString *)oldPhone;
@end
