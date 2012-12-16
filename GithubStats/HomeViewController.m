//
//  ViewController.m
//  GithubStats
//
//  Created by Adriana Santos on 15/12/2012.
//  Copyright (c) 2012 Adriana Santos. All rights reserved.
//

#import "HomeViewController.h"
#import "GitHubConstants.h"
#import "LabelBadgeCell.h"
#import "CustomBadge.h"
#import "SearchTextFieldCell.h"
#import "ReposViewController.h"
#import "GithubWrapperClient.h"
#import "RepoCollectionAdapter.h"
#import "UIBarButtonItem+Image.h"
#import "LanguagesViewController.h"
#import "LanguageReposCollectionModel.h"
#import "GithubStatsUtil.h"

@interface HomeViewController ()
@property (nonatomic, strong) NSArray *statsKeywords;
@property (nonatomic, strong) RepoCollectionModel *repoCollection;
@property (nonatomic, strong) LanguageReposCollectionModel *languageReposCollection;
@property (nonatomic, strong) UITextField *searchUsername;
@property (nonatomic) BOOL viewDidAppearBefore;
@end

@implementation HomeViewController
@synthesize statsKeywords = _statsKeywords;
@synthesize repoCollection = _repoCollection;
@synthesize languageReposCollection = _languageReposCollection;
@synthesize searchUsername = _searchUsername;
@synthesize viewDidAppearBefore = _viewDidAppearBefore;
@synthesize tableView = _tableView;
@synthesize activityIndicator = _activityIndicator;
@synthesize infoTextView = _infoTextView;

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.statsKeywords = [NSArray arrayWithObjects:NSLocalizedString(@"Repositories",nil), NSLocalizedString(@"Languages",nil), nil];
        self.title = NSLocalizedString(@"Home", nil);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"settings"] target:self action:@selector(settingsTapped:)];
    self.viewDidAppearBefore = NO;
    if ([GithubStatsUtil hasCredential]) {
        [self.infoTextView setHidden:YES];
    }
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
}

-(void)dismissKeyboard {
    [self.searchUsername resignFirstResponder];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSIndexPath *selectedRow = [self.tableView indexPathForSelectedRow];
    if (selectedRow) {
        [self.tableView deselectRowAtIndexPath:selectedRow animated:YES];
    }
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (!self.viewDidAppearBefore) {
        [self refresh];
    }
    self.viewDidAppearBefore = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    int numberOfRows = 0;
    switch (section) {
        case SECTION_USER:
            numberOfRows = 1;
            break;
        case SECTION_STATS:
            numberOfRows = [self.statsKeywords count];
            break;
        default:
            break;
    }
    return numberOfRows;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == SECTION_STATS) {
        return @"Stats";
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    id cell;// = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    
    switch ([indexPath section]) {
        case SECTION_USER:
        {
            static NSString *CellIdUser = @"CellUser";
            cell = [tableView dequeueReusableCellWithIdentifier:CellIdUser];
            if (cell == nil) {
                NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"SearchTextFieldCell" owner:self options:nil];
                
                for(id currentObject in topLevelObjects)
                {
                    if([currentObject isKindOfClass:[UITableViewCell class]])
                    {
                        cell = (SearchTextFieldCell *)currentObject;
                        break;
                    }
                }
                self.searchUsername = [(SearchTextFieldCell *)cell searchUser];
            }
            [[(SearchTextFieldCell *)cell searchUser] setDelegate:self];
            break;
        }
        case SECTION_STATS:
        {
            static NSString *CellIdStats = @"CellStats";
            cell = [tableView dequeueReusableCellWithIdentifier:CellIdStats];
            if (cell == nil) {
                NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"LabelBadgeCell" owner:self options:nil];
                
                for(id currentObject in topLevelObjects)
                {
                    if([currentObject isKindOfClass:[UITableViewCell class]])
                    {
                        cell = (LabelBadgeCell *)currentObject;
                        break;
                    }
                }
            }
            [[(LabelBadgeCell *)cell label] setText:[self.statsKeywords objectAtIndex:[indexPath row]]];
            if (![GithubStatsUtil hasCredential]) {
                [[(LabelBadgeCell *)cell label] setEnabled:NO];
            }
            else {
                [[(LabelBadgeCell *)cell label] setEnabled:YES];
            }
            
            switch ([indexPath row]) {
                case ROW_REPOS:
                    [[(LabelBadgeCell *)cell customBadge] autoBadgeSizeWithString:[NSString stringWithFormat:@"%d", [self.repoCollection.items count]]];
                    [(LabelBadgeCell *)cell layoutBadge];
                    break;
                case ROW_LANGUAGES:
                    [[(LabelBadgeCell *)cell customBadge] autoBadgeSizeWithString:[NSString stringWithFormat:@"%d", [self.languageReposCollection.items count]]];
                    [(LabelBadgeCell *)cell layoutBadge];
                    break;
                default:
                    break;
            }
            

//            If search is nil or search result fails, disable stats
//            [(LabelBadgeCell *)cell setUserInteractionEnabled:NO];
//            [[(LabelBadgeCell *)cell label] setEnabled:NO];
            
            break;
        }
        default:
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath section] == SECTION_USER) {
        return;
    }
    switch ([indexPath row]) {
        case ROW_REPOS:
        {
            ReposViewController *reposVC = [[ReposViewController alloc] initWithStyle:UITableViewStylePlain];
            [reposVC setRepoCollection:self.repoCollection];
            [reposVC setTitle:NSLocalizedString(@"Repositories",nil)];
            [self.navigationController pushViewController:reposVC animated:YES];
            break;
        }
        case ROW_LANGUAGES:
        {
            LanguagesViewController *languagesVC = [[LanguagesViewController alloc] initWithNibName:@"LanguagesViewController" bundle:[NSBundle mainBundle]];
            [languagesVC setLanguageReposCollection:self.languageReposCollection];
            [self.navigationController pushViewController:languagesVC animated:YES];
            break;
        }
        case ROW_CONTRIBUTIONS:
            
            break;
            
        default:
            break;
    }
}

-(void)refresh {
    
    if (![GithubStatsUtil hasCredential]) {
        self.tableView.userInteractionEnabled = NO;
        [self presentLogin];
        return;
    }
    else {
        self.tableView.userInteractionEnabled = YES;
    }
    
    if ([self.searchUsername.text length] == 0) {
        self.searchUsername.text = [[GithubStatsUtil getCredential] username];
    }
    
    [self.activityIndicator startAnimating];
    self.repoCollection = nil;
    self.languageReposCollection = nil;
    [self.tableView reloadSections:[[NSIndexSet alloc] initWithIndex:SECTION_STATS] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    if (![[GithubWrapperClient sharedInstance] credential]) {
        Credential *credential = [[Credential alloc] initWithUsername:@"github-objc" andPassword:@"passw0rd"];
        [[GithubWrapperClient sharedInstance] setCredential:credential];
    }
    
    [[GithubWrapperClient sharedInstance] getAllReposForUser:self.searchUsername.text withReposPerPage:100 onSuccess:^(AFHTTPRequestOperation *request, id response, BOOL isFinished) {
        
        RepoCollectionModel *responseRepoCollection = [RepoCollectionAdapter transform:response];
        NSMutableArray *existingRepos = [self.repoCollection.items mutableCopy];
        if (!existingRepos) {
            existingRepos = [[NSMutableArray alloc] init];
        }
        [existingRepos addObjectsFromArray:responseRepoCollection.items];
        if (!self.repoCollection) {
            self.repoCollection = [[RepoCollectionModel alloc] init];
        }
        self.repoCollection.items = existingRepos;
        if (isFinished) {
            self.languageReposCollection = [RepoCollectionAdapter transformRepoCollection:self.repoCollection];
            [self.tableView reloadSections:[[NSIndexSet alloc] initWithIndex:SECTION_STATS] withRowAnimation:UITableViewRowAnimationAutomatic];
            [self.activityIndicator stopAnimating];
        }
    } onFailure:^(NSError *error) {
        NSLog(@"getAllReposForUser failed with error: %@", error.description);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"An error occurred" message:[error.userInfo objectForKey:NSLocalizedDescriptionKey] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [self.activityIndicator stopAnimating];
    }];
}

-(void)presentLogin {
    LoginViewController *loginVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:[NSBundle mainBundle]];
    loginVC.delegate = self;
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:loginVC];
    navController.navigationBar.barStyle = UIBarStyleBlack;
    [self presentViewController:navController animated:YES completion:^{
        
    }];
}

-(IBAction)settingsTapped:(id)sender {
    [self presentLogin];
}

#pragma mark - Text field delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [self refresh];
    return YES;
}

#pragma mark - Login delegate

-(void)loginViewControllerDidLoginWithCredential:(Credential *)credential {
    [GithubStatsUtil saveCredential:credential];
    [self.infoTextView setHidden:YES];
    [self refresh];
    [self dismissViewControllerAnimated:YES completion:^{

    }];
}

-(void)loginViewControllerDidCancel {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
