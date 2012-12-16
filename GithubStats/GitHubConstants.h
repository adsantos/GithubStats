//
//  GitHubConstants.h
//  GithubStats
//
//  Created by Adriana Santos on 15/12/2012.
//  Copyright (c) 2012 Adriana Santos. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    SECTION_USER,
    SECTION_STATS
} Sections;

typedef enum {
    ROW_REPOS,
    ROW_LANGUAGES,
    ROW_CONTRIBUTIONS
} RowsStats;

@interface GitHubConstants : NSObject

extern NSString * const GITHUB_STATS_USERNAME;
extern NSString * const KEYCHAIN_SERVICE;
extern NSString * const KEYCHAIN_ITEM_PASSWORD;

@end
