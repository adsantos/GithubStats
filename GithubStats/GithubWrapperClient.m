//
//  GithubWrapperClient.m
//  GithubStats
//
//  Created by Adriana Santos on 15/12/2012.
//  Copyright (c) 2012 Adriana Santos. All rights reserved.
//

#import "GithubWrapperClient.h"

@implementation GithubWrapperClient

+(GithubWrapperClient *)sharedInstance {
    static GithubWrapperClient *client = nil;
    @synchronized(self) {
        if (client == nil) {
            client = [[GithubWrapperClient alloc] init];
        }
    }
    return client;
}

@end
