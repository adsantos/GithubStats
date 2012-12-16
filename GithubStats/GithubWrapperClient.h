//
//  GithubWrapperClient.h
//  GithubStats
//
//  Created by Adriana Santos on 15/12/2012.
//  Copyright (c) 2012 Adriana Santos. All rights reserved.
//

#import "RestAPI.h"

@interface GithubWrapperClient : RestAPI

+(GithubWrapperClient *)sharedInstance;

@end
