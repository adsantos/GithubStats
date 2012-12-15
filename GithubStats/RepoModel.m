//
//  RepoModel.m
//  GithubStats
//
//  Created by Adriana Santos on 15/12/2012.
//  Copyright (c) 2012 Adriana Santos. All rights reserved.
//

#import "RepoModel.h"

@implementation RepoModel
@synthesize name = _name;
@synthesize fullName = _fullName;
@synthesize htmlUrl = _htmlUrl;
@synthesize mainLanguage = _mainLanguage;
@synthesize languages = _languages;
@synthesize isFork = _isFork;

-(RepoModel *)initWithName:(NSString *)name andFullName:(NSString *)fullName andHtmlUrl:(NSString *)htmlUrl andMainLanguage:(NSString *)mainLanguage andLanguages:(NSArray *)languages andIsFork:(BOOL)isFork {
    self = [super init];
    if (self != nil) {
        [self setName:name];
        [self setFullName:fullName];
        [self setHtmlUrl:htmlUrl];
        [self setMainLanguage:mainLanguage];
        [self setLanguages:languages];
        [self setIsFork:isFork];
    }
    return self;
}

@end
