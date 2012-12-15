//
//  RepoModel.h
//  GithubStats
//
//  Created by Adriana Santos on 15/12/2012.
//  Copyright (c) 2012 Adriana Santos. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RepoModel : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *fullName;
@property (nonatomic, strong) NSString *htmlUrl;
@property (nonatomic, strong) NSString *mainLanguage;
@property (nonatomic, strong) NSArray *languages;
@property (nonatomic) BOOL isFork;

-(RepoModel *)initWithName:(NSString *)name andFullName:(NSString *)fullName andHtmlUrl:(NSString *)htmlUrl andMainLanguage:(NSString *)mainLanguage andLanguages:(NSArray *)languages andIsFork:(BOOL)isFork;

@end
