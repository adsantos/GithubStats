//
//  RepoCollectionAdapter.m
//  GithubStats
//
//  Created by Adriana Santos on 15/12/2012.
//  Copyright (c) 2012 Adriana Santos. All rights reserved.
//

#import "RepoCollectionAdapter.h"
#import "RepoModel.h"
#import "GithubStatsUtil.h"
#import "LanguageReposModel.h"

NSString* const JSON_NAME = @"name";
NSString* const JSON_FULL_NAME = @"full_name";
NSString* const JSON_HTML_URL = @"html_url";
NSString* const JSON_LANGUAGE = @"language";
NSString* const JSON_LANGUAGES_URL = @"languages_url";
NSString* const JSON_FORK = @"fork";

@implementation RepoCollectionAdapter

//Response example:
//"full_name" = "github-objc/gh-unit";
//name = "gh-unit";
//"html_url" = "https://github.com/github-objc/gh-unit";
//language = "Objective-C";
//"languages_url" = "https://api.github.com/repos/github-objc/gh-unit/languages";
//fork = 1;

+(RepoCollectionModel *)transform:(id)response {
    
    if ([GithubStatsUtil isEmpty:response]) {
        return nil;
    }
    
    RepoCollectionModel *repoCollection = [[RepoCollectionModel alloc] init];
    NSMutableArray *reposArray = [[NSMutableArray alloc] initWithCapacity:[response count]];
    for (id repo in response) {
        NSString *name = [repo objectForKey:JSON_NAME];
        NSString *fullName = [repo objectForKey:JSON_FULL_NAME];
        NSString *htmlUrl = [repo objectForKey:JSON_HTML_URL];
        NSString *language = [repo objectForKey:JSON_LANGUAGE];
        if ([GithubStatsUtil isEmpty:language]) {
            language = @"Unknown";
        }
        //TODO: use the language_url to get the list of languages
        NSArray *languages = nil;
        BOOL fork = [[repo objectForKey:JSON_FORK] boolValue];
        
        RepoModel *repo = [[RepoModel alloc] initWithName:name andFullName:fullName andHtmlUrl:htmlUrl andMainLanguage:language andLanguages:languages andIsFork:fork];
        [reposArray addObject:repo];
    }
    [repoCollection setItems:reposArray];
    
    return repoCollection;
}

+(LanguageReposCollectionModel *)transformRepoCollection:(RepoCollectionModel *)repoCollectionModel {
    LanguageReposCollectionModel *result = [[LanguageReposCollectionModel alloc] init];
    
    NSMutableDictionary *languageReposDic = [[NSMutableDictionary alloc] init];
    
    for (RepoModel *repo in repoCollectionModel.items) {
        RepoCollectionModel *repoCollectionForLanguage = [languageReposDic objectForKey:repo.mainLanguage];
        if (repoCollectionForLanguage) {
            NSMutableArray *collectionItemsMutable = [repoCollectionForLanguage.items mutableCopy];
            [collectionItemsMutable addObject:repo];
            repoCollectionForLanguage.items = collectionItemsMutable;
        }
        else {
            repoCollectionForLanguage = [[RepoCollectionModel alloc] init];
            repoCollectionForLanguage.items = [NSArray arrayWithObject:repo];
        }
        [languageReposDic setObject:repoCollectionForLanguage forKey:repo.mainLanguage];
    }
    
    NSArray *languagesArray = [[languageReposDic allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:[languagesArray count]];
    
    for (NSString *language in languagesArray) {
        LanguageReposModel *languageRepos = [[LanguageReposModel alloc] initWithLanguage:language andRepos:[languageReposDic objectForKey:language]];
        [items addObject:languageRepos];
    }
    result.items = items;
    
    return result;
}

@end
