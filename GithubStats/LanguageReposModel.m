//
//  LanguageReposModel.m
//  GithubStats
//
//  Created by Adriana Santos on 16/12/2012.
//  Copyright (c) 2012 Adriana Santos. All rights reserved.
//

#import "LanguageReposModel.h"

@implementation LanguageReposModel
@synthesize language = _language;
@synthesize repos = _repos;

-(LanguageReposModel *)initWithLanguage:(NSString *)language andRepos:(RepoCollectionModel *)repositories {
    self = [super init];
    if (self != nil) {
        [self setLanguage:language];
        [self setRepos:repositories];
    }
    return self;
}

@end
