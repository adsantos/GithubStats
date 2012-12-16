//
//  LanguageReposModel.h
//  GithubStats
//
//  Created by Adriana Santos on 16/12/2012.
//  Copyright (c) 2012 Adriana Santos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RepoCollectionModel.h"

@interface LanguageReposModel : NSObject
@property (nonatomic, strong) NSString *language;
@property (nonatomic, strong) RepoCollectionModel *repos;

-(LanguageReposModel *)initWithLanguage:(NSString *)language andRepos:(RepoCollectionModel *)repositories;

@end
