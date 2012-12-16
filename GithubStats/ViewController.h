//
//  ViewController.h
//  GithubStats
//
//  Created by Adriana Santos on 15/12/2012.
//  Copyright (c) 2012 Adriana Santos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"

@interface ViewController : UIViewController <UITextFieldDelegate, LoginViewControllerDelegate>
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicator;

-(void)refresh;

@end
