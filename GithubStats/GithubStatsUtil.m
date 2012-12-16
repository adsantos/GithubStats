//
//  GithubStatsUtil.m
//  GithubStats
//
//  Created by Adriana Santos on 15/12/2012.
//  Copyright (c) 2012 Adriana Santos. All rights reserved.
//

#import "GithubStatsUtil.h"
#import "GitHubConstants.h"
#import "MCSMKeychainItem.h"
#import "Credential.h"

@implementation GithubStatsUtil

+(BOOL)isEmpty:(id)value {
    return (nil == value
            || [value isKindOfClass:[NSNull class]]
            || ([value respondsToSelector:@selector(length)] && [(NSData *)value length] == 0)
            || ([value respondsToSelector:@selector(count)]  && [(NSArray *)value count] == 0));
}

+(void)saveCredential:(Credential *)credential {
    [[NSUserDefaults standardUserDefaults] setObject:credential.username forKey:GITHUB_STATS_USERNAME];
    [MCSMGenericKeychainItem genericKeychainItemWithService:KEYCHAIN_SERVICE username:KEYCHAIN_ITEM_PASSWORD password:credential.password];
}

+(BOOL)hasCredential {
    return ![GithubStatsUtil isEmpty:[[NSUserDefaults standardUserDefaults] objectForKey:GITHUB_STATS_USERNAME]] && ![GithubStatsUtil isEmpty:[MCSMGenericKeychainItem genericKeychainItemForService:KEYCHAIN_SERVICE username:KEYCHAIN_ITEM_PASSWORD]];
}

+(Credential *)getCredential {
    return [[Credential alloc] initWithUsername:[[NSUserDefaults standardUserDefaults] objectForKey:GITHUB_STATS_USERNAME] andPassword:[[MCSMGenericKeychainItem genericKeychainItemForService:KEYCHAIN_SERVICE username:KEYCHAIN_ITEM_PASSWORD] password]];
}

@end
