//
//  ViewController.m
//  GithubStats
//
//  Created by Adriana Santos on 15/12/2012.
//  Copyright (c) 2012 Adriana Santos. All rights reserved.
//

#import "ViewController.h"
#import "GitHubConstants.h"
#import "LabelBadgeCell.h"
#import "CustomBadge.h"
#import "SearchTextFieldCell.h"
#import "ReposViewController.h"
#import "GithubWrapperClient.h"
#import "RepoCollectionAdapter.h"
#import "UIBarButtonItem+Image.h"

@interface ViewController ()
@property (nonatomic, strong) NSArray *statsKeywords;
@property (nonatomic, strong) RepoCollectionModel *repoCollection;
@end

@implementation ViewController
@synthesize statsKeywords = _statsKeywords;
@synthesize repoCollection = _repoCollection;
@synthesize tableView = _tableView;
@synthesize activityIndicator = _activityIndicator;

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.statsKeywords = [NSArray arrayWithObjects:NSLocalizedString(@"Repositories",nil), NSLocalizedString(@"Languages",nil), NSLocalizedString(@"Contributions",nil), nil];
        self.title = NSLocalizedString(@"Home", nil);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"settings"] target:self action:nil];
}

-(void)viewWillAppear:(BOOL)animated {
    NSIndexPath *selectedRow = [self.tableView indexPathForSelectedRow];
    if (selectedRow) {
        [self.tableView deselectRowAtIndexPath:selectedRow animated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
                        cell = (LabelBadgeCell *)currentObject;
                        break;
                    }
                }
            }
            
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
            [[(LabelBadgeCell *)cell customBadge] autoBadgeSizeWithString:[NSString stringWithFormat:@"%d", [self.repoCollection.items count]]];
            [(LabelBadgeCell *)cell layoutBadge];

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
    switch ([indexPath row]) {
        case ROW_REPOS:
        {
            ReposViewController *reposVC = [[ReposViewController alloc] initWithStyle:UITableViewStyleGrouped];
            [reposVC setRepoCollection:self.repoCollection];
            [self.navigationController pushViewController:reposVC animated:YES];
            break;
        }
        case ROW_LANGUAGES:
            
            break;
        case ROW_CONTRIBUTIONS:
            
            break;
            
        default:
            break;
    }
}

-(void)refresh {
    [self.activityIndicator startAnimating];
    self.repoCollection = nil;
    
    if (![[GithubWrapperClient sharedInstance] credential]) {
        Credential *credential = [[Credential alloc] initWithUsername:@"github-objc" andPassword:@"passw0rd"];
        [[GithubWrapperClient sharedInstance] setCredential:credential];
    }
    
    [[GithubWrapperClient sharedInstance] getAllReposForUser:@"adsantos" withReposPerPage:100 onSuccess:^(AFHTTPRequestOperation *request, id reponse, BOOL isFinished) {
        [self.tableView reloadData];
        self.repoCollection = [RepoCollectionAdapter transform:reponse];
        [self.activityIndicator stopAnimating];
    } onFailure:^(NSError *error) {
        NSLog(@"getAllReposForUser failed with error: %@", error.description);
        [self.activityIndicator stopAnimating];
    }];
}

@end
