//
//  BeetNetworkManager.m
//  iFengNews
//
//  Created by beet on 12/5/14.
//  Copyright (c) 2014 Jan Lion. All rights reserved.
//

#import "BeetNetworkManager.h"

@implementation BeetNetworkManager

+ (BeetNetworkManager *)sharedBeetNetworkManager;
{
    static BeetNetworkManager *instance;
    if (instance == nil) {
        instance = [[BeetNetworkManager alloc] init];
    }
    return instance;
}

#pragma - mark  Get data source with Json

- (NSMutableArray *)analysisJasonWith: (NSString *)http
{
    NSURL *url            = [NSURL URLWithString:http];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    NSData *data          = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    // Could be array/dictionary
    NSArray *jsonArray    = [NSJSONSerialization  JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSMutableArray *array = [jsonArray mutableCopy];
    
    self.analysisDone     = YES;
    return array;
}

- (UIImage *)downloadImageWithHttp:(NSString *)address
{

    NSURL   *url   = [NSURL URLWithString:address];
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
    return image;
}


@end
