//
//  BeetNetworkManager.h
//  iFengNews
//
//  Created by beet on 12/5/14.
//  Copyright (c) 2014 Jan Lion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BeetNetworkManager : NSObject

@property (nonatomic, assign) BOOL analysisDone;

+ (BeetNetworkManager *)sharedBeetNetworkManager;

- (NSMutableArray *)analysisJasonWith: (NSString *)http;

- (UIImage *)downloadImageWithHttp:(NSString *)address;

@end
