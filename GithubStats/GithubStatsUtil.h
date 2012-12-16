//
//  GithubStatsUtil.h
//  GithubStats
//
//  Created by Adriana Santos on 15/12/2012.
//  Copyright (c) 2012 Adriana Santos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Credential.h"

@interface GithubStatsUtil : NSObject

+(BOOL)isEmpty:(id)value;
+(void)saveCredential:(Credential *)credential;
+(BOOL)hasCredential;
+(Credential *)getCredential;


@end
