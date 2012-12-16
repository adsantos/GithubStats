//
//  RepoCollectionAdapter.h
//  GithubStats
//
//  Created by Adriana Santos on 15/12/2012.
//  Copyright (c) 2012 Adriana Santos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RepoCollectionModel.h"
#import "LanguageReposCollectionModel.h"

@interface RepoCollectionAdapter : NSObject

+(RepoCollectionModel *)transform:(id)response;
+(LanguageReposCollectionModel *)transformRepoCollection:(RepoCollectionModel *)repoCollectionModel;

@end
