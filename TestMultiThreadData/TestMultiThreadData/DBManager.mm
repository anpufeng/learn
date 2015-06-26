//
//  DBManager.m
//  ETImClient
//
//  Created by xuqing on 15/4/17.
//  Copyright (c) 2015年 Pingan. All rights reserved.
//

#import "DBManager.h"
#import "FMDatabase.h"
#import "Model.h"
#import "UtilFileManager.h"

static NSString *const localDbName = @"etim.db";
static NSString *const tableMessage = @"message";
static NSString *const tableDraft = @"draft";
static NSString *const tableUser = @"user";
static NSString *const userNoSignature = @"暂无签名";


@interface DBManager () {
    FMDatabase      *_db;
}

@end


@implementation DBManager

- (void)dealloc {

    [_db close];
}

static DBManager *sharedDBManager = nil;
static dispatch_once_t predicate;


+(DBManager*)sharedInstance {
    dispatch_once(&predicate, ^{
        sharedDBManager = [[DBManager alloc]init];
        //忽略send产生的sigpipe信号
        //signal(SIGPIPE, SIG_IGN);
    });
    
    return sharedDBManager;
}


- (id)init {
    if (self = [super init]) {
        [self initDataBase];
    }
    
    return self;
}

- (void)initDataBase {
    NSString *dbPath = [self defaultDbPath];
    BOOL created = NO;
    if (![UtilFileManager fileExist:dbPath]) {
        created = [UtilFileManager createDir:[self defaultDbDir]];
    }
    NSLog(@"用户数据库路径: %@", dbPath);
    _db = [[FMDatabase alloc] initWithPath:dbPath];
    if (![_db open]) {
        NSLog(@"open db faile : %@", dbPath);
    } else {
        if (created) {
            //第一次
            [_db beginTransaction];
            
            NSString *dropUserSql = [NSString stringWithFormat:@"DROP TABLE IF EXISTS `%@`;", tableUser];
            NSString *userSql = [NSString stringWithFormat:@"CREATE TABLE `%@` (`mId` text NOT NULL, `name` text NOT NULL, `title` text NOT NULL);", tableUser];

            [_db executeUpdate:dropUserSql];
            [_db executeUpdate:userSql];
            
            if (![_db commit]) {
                NSLog(@"create table error %@", [_db lastError]);
                [_db close];
                [UtilFileManager deleteDir:[self defaultDbDir]];
            }
        }
    }

}

- (BOOL)insertOneModel:(Model *)model {
    BOOL result = NO;
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@ (mId, name, title) VALUES (%@, '%@', '%@')",
                     tableUser,
                     model.mId,
                     model.name,
                     model.title];
    result = [_db executeUpdate:sql];
    if (!result) {
        NSLog(@"insert error : %@", [_db lastError]);
    }

    return result;
}


#pragma mark - util

///每个用户一个DB目录
- (NSString *)defaultDbDir  {
    NSString *dbDir = [[[UtilFileManager documentDir] stringByAppendingPathComponent:@"111"] stringByAppendingPathComponent:@"etimdb"];
    return dbDir;
}

- (NSString *)defaultDbPath {
    return [[self defaultDbDir] stringByAppendingPathComponent:localDbName];
}
@end
