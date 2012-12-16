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
#import "GithubStatsUtil.h"
#import "HomeViewController.h"

@interface LoginViewController ()
@property (nonatomic, weak) IBOutlet UITextField *usernameTextField;
@property (nonatomic, weak) IBOutlet UITextField *passwordTextField;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicator;
@end

@implementation LoginViewController
@synthesize usernameTextField = _usernameTextField;
@synthesize passwordTextField = _passwordTextField;
@synthesize activityIndicator = _activityIndicator;
@synthesize tableView = _tableView;
@synthesize button = _button;
@synthesize delegate = _delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"Login",nil);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelTapped)];
    [self.button setBackgroundColor:[UIColor darkGrayColor]];
    self.button.layer.borderColor = [UIColor darkGrayColor].CGColor;
    self.button.layer.borderWidth = 0.5f;
    self.button.layer.cornerRadius = 10.0f;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
}

-(void)dismissKeyboard {
    [self.usernameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}

-(void)awakeFromNib {
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)cancelTapped {
    [self.delegate loginViewControllerDidCancel];
}

-(IBAction)loginTapped:(id)sender {
    [self.button.titleLabel setEnabled:NO];
    [self.activityIndicator startAnimating];
    [[GithubWrapperClient sharedInstance] validUsername:self.usernameTextField.text andPassword:self.passwordTextField.text onSuccess:^{
        [self.button.titleLabel setEnabled:YES];
        [self.activityIndicator stopAnimating];
        Credential *cred = [[Credential alloc] initWithUsername:self.usernameTextField.text andPassword:self.passwordTextField.text];
        [self.delegate loginViewControllerDidLoginWithCredential:cred];
    } onFailure:^(NSError *error) {
        [self.button.titleLabel setEnabled:YES];
        [self.activityIndicator stopAnimating];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"An error occurred",nil) message:[[error userInfo] objectForKey:NSLocalizedDescriptionKey] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
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
    
    Credential *credential = nil;
    if ([GithubStatsUtil hasCredential]) {
        credential = [GithubStatsUtil getCredential];
    }
    
    if ([indexPath row] == 0) {
        [[(TextFieldCell *)cell textField] setSecureTextEntry:NO];
        [[(TextFieldCell *)cell textField] setPlaceholder:NSLocalizedString(@"github username",nil)];
        if (credential) {
            [[(TextFieldCell *)cell textField] setText:credential.username];
        }
        self.usernameTextField = [(TextFieldCell *)cell textField];
    }
    else {
        [[(TextFieldCell *)cell textField] setSecureTextEntry:YES];
        [[(TextFieldCell *)cell textField] setPlaceholder:NSLocalizedString(@"github password",nil)];
        if (credential) {
            [[(TextFieldCell *)cell textField] setText:credential.password];
        }
        self.passwordTextField = [(TextFieldCell *)cell textField];
    }
    
    return cell;
}

@end
