//
//  GithubStatsUtil.m
//  GithubStats
//
//  Created by Adriana Santos on 15/12/2012.
//  Copyright (c) 2012 Adriana Santos. All rights reserved.
//

#import "GithubStatsUtil.h"

@implementation GithubStatsUtil

+(BOOL)isEmpty:(id)value {
    return (nil == value
            || [value isKindOfClass:[NSNull class]]
            || ([value respondsToSelector:@selector(length)] && [(NSData *)value length] == 0)
            || ([value respondsToSelector:@selector(count)]  && [(NSArray *)value count] == 0));
}

@end
