//
//  ReposViewController.h
//  GithubStats
//
//  Created by Adriana Santos on 15/12/2012.
//  Copyright (c) 2012 Adriana Santos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RepoCollectionModel.h"

@interface ReposViewController : UITableViewController
@property (nonatomic, strong) RepoCollectionModel *repoCollection;

@end
