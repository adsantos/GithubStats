//
//  LanguagesViewController.h
//  GithubStats
//
//  Created by Adriana Santos on 16/12/2012.
//  Copyright (c) 2012 Adriana Santos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LanguageReposCollectionModel.h"

@interface LanguagesViewController : UIViewController
@property (nonatomic, assign) IBOutlet UITableView *tableView;
@property (nonatomic, assign) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) LanguageReposCollectionModel *languageReposCollection;

@end
