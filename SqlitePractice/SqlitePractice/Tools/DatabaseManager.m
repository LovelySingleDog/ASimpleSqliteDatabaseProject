//
//  DatabaseManager.m
//  SqlitePractice
//
//  Created by wyzc03 on 17/1/18.
//  Copyright © 2017年 wyzc03. All rights reserved.
//

#import "DatabaseManager.h"
#import <sqlite3.h>
NSString * const TABLE_NAME = @"Person";
NSString * const NAME = @"name";
NSString * const PHONE = @"phone";


@interface DatabaseManager ()
@property (nonatomic,strong) NSMutableArray * array;
@end

@implementation DatabaseManager
- (instancetype)init{
    if (self = [super init]) {
        //在初始化时创建表
        [self createTable];

    }
    return self;
}
//数据库柄
sqlite3 *db;
//创建沙盒路径
- (NSString *)databasePath{
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    path = [path stringByAppendingString:@"database.sqlite"];
    return path;
}
//打开数据库
- (void)openDatabase{
    int resutlt = sqlite3_open([self databasePath].UTF8String, &db);
    if (resutlt == SQLITE_OK){
        
    }else{
        NSLog(@"打开数据库失败");
    }
}
//关闭数据库
- (void)closeDatabase{
    int result = sqlite3_close(db);
    if (result == SQLITE_OK){
        
    }else{
        NSLog(@"关闭数据库失败");
    }
}
//创建表
- (void)createTable{
    [self openDatabase];
    NSString *sql = [[NSString alloc] initWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,%@ TEXT,%@ TEXT)",TABLE_NAME,NAME,PHONE];
    //存储错误信息
    char * error;
    
    int result = sqlite3_exec(db, sql.UTF8String, NULL, NULL, &error);
    if (result == SQLITE_OK){
        
    }else{
        NSLog(@"创建表失败%s",error);
    }
    [self closeDatabase];
}
//插入信息
- (void)insertDataWithName:(NSString *)name phone:(NSString *)phone{
   
    
    //不能插入空字符串
    if ([name isEqualToString:@""] || [phone isEqualToString:@""] || name == nil || phone == nil) {
        return;
    }
    //判断电话号码或人名是否同时相同 如果同时相同就不能插入新的数据
    if ([self databaseContainTheSameString:name] && [self databaseContainTheSameString:phone]) {
        return;
    }
    //执行插入数据
    [self openDatabase];
    NSString * sql = [[NSString alloc] initWithFormat:@"INSERT INTO %@ (%@,%@) VALUES ('%@','%@')",TABLE_NAME,NAME,PHONE,name,phone];
    
    char *error;
    int result = sqlite3_exec(db, sql.UTF8String, NULL, NULL, &error);
    if (result == SQLITE_OK){
        
    }else{
        NSLog(@"添加数据失败%s",error);
    }
    
    [self closeDatabase];
}
//查询数据
- (void)selectData{
    self.array = [NSMutableArray array];
    [self openDatabase];
    
    NSString * sql = [[NSString alloc] initWithFormat:@"SELECT * FROM %@ ORDER BY ID ASC",TABLE_NAME];
    
    sqlite3_stmt * stmt;//查询数据的陈述
    //准备查询数据
    int result = sqlite3_prepare_v2(db, sql.UTF8String, -1, &stmt, NULL);
    if (result == SQLITE_OK){
        //当
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            const unsigned char *cName = sqlite3_column_text(stmt, 1);
            const unsigned char *cPhone = sqlite3_column_text(stmt, 2);
            NSString *name = [[NSString alloc] initWithUTF8String:(const char *)cName];
            NSString *phone = [[NSString alloc] initWithUTF8String:(const char *)cPhone];
            //NSLog(@"name:%@  phone:%@",name,phone);
            Person * per = [[Person alloc] init];
            per.name = name;
            per.phone = phone;
            //将模型添加到数组中
            [self.array addObject:per];
        }
    }else{
        NSLog(@"准备查询失败");
    }
    //释放陈述才能成功关闭数据库
    sqlite3_finalize(stmt);
    
    [self closeDatabase];
}
//删除数据
- (void)deletePhoneNumber:(NSString *)phone{
    [self openDatabase];
    //sql语句
    NSString *sql = [[NSString alloc] initWithFormat:@"DELETE FROM %@ WHERE %@ = '%@'",TABLE_NAME,PHONE,phone];
    char *error;
    int result = sqlite3_exec(db, sql.UTF8String, NULL, NULL, &error);
    if (result == SQLITE_OK) {
        
    }else{
        NSLog(@"delete failed %s",error);
    }
    
    [self closeDatabase];
}
//更新数据
- (BOOL)updateName:(NSString *)name phone:(NSString *)phone oldName:(NSString *)oldName oldPhone:(NSString *)oldPhone{
    //不能插入空字符串
    if ([name isEqualToString:@""] || [phone isEqualToString:@""] || name == nil || phone == nil) {
        return NO;
    }
    //判断电话号码或人名是否相同 如果相同就不能更新的数据
    if ([self databaseContainTheSameString:name] && [self databaseContainTheSameString:phone]) {
        return NO;
    }
    
    //执行数据更新
    [self openDatabase];
    NSString *sql = [[NSString alloc] initWithFormat:@"UPDATE %@ SET %@ = '%@' , %@ = '%@' WHERE %@ = '%@' AND %@ = '%@'",TABLE_NAME,NAME,name,PHONE,phone,NAME,oldName,PHONE,oldPhone];
    char *error;
    int result = sqlite3_exec(db, sql.UTF8String, NULL, NULL, &error);
    
    if (result == SQLITE_OK) {
        [self closeDatabase];
        return YES;
    }else {
        NSLog(@"update failed %s",error);
        [self closeDatabase];
        return NO;
    }
}
//判断数据库是否有相同的数据
- (BOOL)databaseContainTheSameString:(NSString *)str{
    for (Person *per in self.dataArray) {
        if ([str isEqualToString:per.phone] || [str isEqualToString:per.name]) {
            return YES;
        }
    }
    return NO;
}



#pragma 重写get方法
- (NSArray *)dataArray{
    //查询数据 将数据放入array中
    [self selectData];
    //NSLog(@"%@",self.array);
    //返回数据结果
    return self.array;
}










@end
