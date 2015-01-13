//
//  BeetCacheManager.m
//  iFengNews
//
//  Created by beet on 12/5/14.
//  Copyright (c) 2014 Jan Lion. All rights reserved.
//

#import "BeetCacheManager.h"

@implementation BeetCacheManager

+ (BeetCacheManager *)sharedBeetCacheManager
{
    static BeetCacheManager *instance;
    if (instance == nil) {
        instance = [[BeetCacheManager alloc] init];
    }
    return instance;
}

- (void)openCahcheFile
{
    NSString *filePath = GetCachePathWithFile(@"CacheFile.db");
    self.dataBase = [FMDatabase databaseWithPath:filePath];
    self.DBqueue = [FMDatabaseQueue databaseQueueWithPath:filePath];
    if ([self.dataBase open]) {
        NSLog(@"data base open success!");
        if (![self.dataBase tableExists:@"Table1"]) {
            //define the cache file structure with below SQL 
            [self.dataBase executeUpdate:@"CREATE TABLE Table1(ImageID INTEGER PRIMARY KEY AUTOINCREMENT, tid TEXT, doc BLOB)"];
            [self.dataBase close];
        }
    }
    else NSLog(@"dataBase cannot open");
    
}

- (BOOL)isDataExsitInDBWith:(NSString *)string
{
    self.isExsitInDB = NO;
   [self.DBqueue inDatabase:^(FMDatabase *db)   {

       [db open];
        FMResultSet *resultSet = [db executeQuery:@"SELECT * FROM Table1"];
        while ([resultSet next]) {
            // search cache DB data with keyword
            if ([string isEqualToString:[resultSet stringForColumn:@"tid"]]){
                self.isExsitInDB = YES;
            }
        }
       [db close];
    }];
    return self.isExsitInDB;
}

- (void)saveCacheWithData:(NSData *)data WithKeyword:(NSString *)ID
{
    
    [self.DBqueue inDatabase:^(FMDatabase *db)   {
        [db open];
        [db executeUpdate:@"INSERT INTO Table1 (tid, doc) VALUES (?, ?)", ID, data];
        [db close];
    }];
}

- (NSData *)getCacheWithID:(NSString *)string
{
    [self.DBqueue inDatabase:^(FMDatabase *db)   {
    
        [db open];
        FMResultSet *resultSet = [db executeQuery:@"SELECT * FROM Table1"];
        while ([resultSet next]) {
            if ([string isEqualToString:[resultSet stringForColumn:@"tid"]]){
                self.cacheData = [resultSet dataForColumn:@"doc"];
                [db close];
            }
        }
    }];
    return self.cacheData;
}
@end
