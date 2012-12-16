//
//  LoginViewController.m
//  GithubStats
//
//  Created by Adriana Santos on 16/12/2012.
//  Copyright (c) 2012 Adriana Santos. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "LoginViewController.h"
#import "TextFieldCell.h"
#import "GithubWrapperClient.h"

@interface LoginViewController ()
@property (nonatomic, weak) IBOutlet UITextField *usernameTextField;
@property (nonatomic, weak) IBOutlet UITextField *passwordTextField;

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(dismiss)];
    [self.button setBackgroundColor:[UIColor darkGrayColor]];
    self.button.layer.borderColor = [UIColor darkGrayColor].CGColor;
    self.button.layer.borderWidth = 0.5f;
    self.button.layer.cornerRadius = 10.0f;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dismiss {
//    [super dismissViewControllerAnimated:flag completion:completion];
    [self.presentingViewController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(IBAction)buttonTapped:(id)sender {
//    [self.button.titleLabel setEnabled:NO];
    [[GithubWrapperClient sharedInstance] validUsername:self.usernameTextField.text andPassword:self.passwordTextField.text onSuccess:^{
        [self.presentingViewController dismissViewControllerAnimated:YES completion:^{
            
        }];
    } onFailure:^(NSError *error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"An error occurred" message:[[error userInfo] objectForKey:NSLocalizedDescriptionKey] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"TextFieldCell" owner:self options:nil];
        
        for(id currentObject in topLevelObjects)
        {
            if([currentObject isKindOfClass:[UITableViewCell class]])
            {
                cell = (TextFieldCell *)currentObject;
                break;
            }
        }
    }
    if ([indexPath row] == 0) {
        [[(TextFieldCell *)cell textField] setSecureTextEntry:NO];
        [[(TextFieldCell *)cell textField] setPlaceholder:@"github username"];
        self.usernameTextField = [(TextFieldCell *)cell textField];
    }
    else {
        [[(TextFieldCell *)cell textField] setSecureTextEntry:YES];
        [[(TextFieldCell *)cell textField] setPlaceholder:@"github password"];
        self.passwordTextField = [(TextFieldCell *)cell textField];
    }
    
    return cell;
}

@end
