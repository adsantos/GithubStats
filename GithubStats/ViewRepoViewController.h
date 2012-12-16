//
//  ViewRepoViewController.h
//  GithubStats
//
//  Created by Adriana Santos on 16/12/2012.
//  Copyright (c) 2012 Adriana Santos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewRepoViewController : UIViewController <UIWebViewDelegate>
@property (nonatomic, strong) NSString *repoUrl;

@end
