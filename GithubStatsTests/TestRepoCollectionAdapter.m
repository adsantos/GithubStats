//
//  TestRepoCollectionAdapter.m
//  GithubStats
//
//  Created by Adriana Santos on 16/12/2012.
//  Copyright (c) 2012 Adriana Santos. All rights reserved.
//

#import <GHUnitIOS/GHUnit.h>
#import "GithubWrapperClient.h"
#import "AFHTTPRequestOperation.h"
#import "RepoCollectionAdapter.h"
#import "RepoCollectionModel.h"
#import "RepoModel.h"
#import "LanguageReposModel.h"

@interface TestRepoCollectionAdapter : GHAsyncTestCase { }
@property (nonatomic, strong) GithubWrapperClient *wrapper;
@end


@implementation TestRepoCollectionAdapter
@synthesize wrapper = _wrapper;

- (void)setUpClass {
    Credential *credential = [[Credential alloc] initWithUsername:@"github-objc" andPassword:@"passw0rd"];
    self.wrapper = [[GithubWrapperClient sharedInstance] initWithCredential:credential];
}

-(void)testTransformResponseIntoRepoCollection {
    
    NSString* reposFileRoot = [[NSBundle mainBundle] pathForResource:@"repos" ofType:@"json"];
    NSString* fileContent = [NSString stringWithContentsOfFile:reposFileRoot encoding:NSUTF8StringEncoding error:nil];
    NSData *response = [fileContent dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *error;
    id transformedResponse = [NSJSONSerialization JSONObjectWithData:response options:kNilOptions error:&error];
    
    RepoCollectionModel *repoCollection = [RepoCollectionAdapter transform:transformedResponse];
    
    int totalRepos = [[repoCollection items] count];
    
    GHAssertTrue(totalRepos==3, @"There should be 1 repository");
    
    RepoModel *repo = [repoCollection.items objectAtIndex:0];
    GHAssertEqualStrings(repo.name, @"gh-unit", @"Repo name should match");
    GHAssertEqualStrings(repo.fullName, @"github-objc/gh-unit", @"Repo full name should match");
    GHAssertEqualStrings(repo.htmlUrl, @"https://github.com/github-objc/gh-unit", @"Repo html url should match");
    GHAssertEqualStrings(repo.mainLanguage, @"Objective-C", @"Repo language should match");
    GHAssertTrue([repo.languages count] == 0, @"Not supported yet. TODO: Execute request and set with the response");
    GHAssertTrue(repo.isFork, @"It should be a fork");
}

-(void)testTransformRepoCollectionIntoLanguagesModel {
    NSString* reposFileRoot = [[NSBundle mainBundle] pathForResource:@"repos" ofType:@"json"];
    NSString* fileContent = [NSString stringWithContentsOfFile:reposFileRoot encoding:NSUTF8StringEncoding error:nil];
    NSData *response = [fileContent dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *error;
    id transformedResponse = [NSJSONSerialization JSONObjectWithData:response options:kNilOptions error:&error];
    
    RepoCollectionModel *repoCollection = [RepoCollectionAdapter transform:transformedResponse];
    LanguageReposCollectionModel *languageReposCol = [RepoCollectionAdapter transformRepoCollection:repoCollection];
    
    LanguageReposModel *languageRepos = [languageReposCol.items objectAtIndex:0];
    GHAssertEqualStrings([languageRepos language], @"Objective-C", @"Repo language should match");
    
    RepoCollectionModel *filteredRepos = [languageRepos repos];
    GHAssertTrue([filteredRepos.items count] == 2, @"There should be 2 repos with objective-c for this user");
    
    RepoModel *repo = [filteredRepos.items objectAtIndex:1];
    GHAssertEqualStrings(repo.name, @"JSONKit", @"Repo name should match");
    GHAssertEqualStrings(repo.fullName, @"github-objc/JSONKit", @"Repo full name should match");
    GHAssertEqualStrings(repo.htmlUrl, @"https://github.com/github-objc/JSONKit", @"Repo html url should match");
    GHAssertEqualStrings(repo.mainLanguage, @"Objective-C", @"Repo language should match");
    GHAssertTrue([repo.languages count] == 0, @"Not supported yet. TODO: Execute request and set with the response");
    GHAssertTrue(repo.isFork, @"It should be a fork");
}

@end
