//
//  BeetCacheManager.h
//  iFengNews
//
//  Created by beet on 12/5/14.
//  Copyright (c) 2014 Jan Lion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"
#import "JLResourcePath.h"

@interface BeetCacheManager : NSObject

@property(nonatomic, strong) FMDatabase *dataBase;
@property(nonatomic, strong) FMDatabaseQueue *DBqueue;
@property(nonatomic, assign) BOOL isExsitInDB;
@property(nonatomic, strong) NSData *cacheData;

+(BeetCacheManager *)sharedBeetCacheManager;
- (void)openCahcheFile;
- (BOOL)isDataExsitInDBWith:(NSString *)string;
- (void)saveCacheWithData:(NSData *)data WithKeyword:(NSString *)ID;
- (NSData *)getCacheWithID:(NSString *)string;
@end
