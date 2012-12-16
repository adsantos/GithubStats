//
//  LoginViewController.h
//  GithubStats
//
//  Created by Adriana Santos on 16/12/2012.
//  Copyright (c) 2012 Adriana Santos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Credential.h"

@protocol LoginViewControllerDelegate <NSObject>

-(void)loginViewControllerDidLoginWithCredential:(Credential *)credential;
-(void)loginViewControllerDidCancel;

@end

@interface LoginViewController : UIViewController
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UIButton *button;
@property (nonatomic, weak) id <LoginViewControllerDelegate> delegate;

@end

