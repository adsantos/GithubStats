//
//  LanguagesViewController.m
//  GithubStats
//
//  Created by Adriana Santos on 16/12/2012.
//  Copyright (c) 2012 Adriana Santos. All rights reserved.
//

#import "LanguagesViewController.h"
#import "LabelBadgeCell.h"
#import "LanguageReposModel.h"
#import "ReposViewController.h"

@interface LanguagesViewController ()

@end

@implementation LanguagesViewController
@synthesize tableView = _tableView;
@synthesize activityIndicator = _activityIndicator;
@synthesize languageReposCollection = _languageReposCollection;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"Languages",nil);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.languageReposCollection.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellId = @"Cell";
    LabelBadgeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
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
    LanguageReposModel *model = [self.languageReposCollection.items objectAtIndex:[indexPath row]];
    cell.label.text = [model language];
    [cell.customBadge autoBadgeSizeWithString:[NSString stringWithFormat:@"%d", [model.repos.items count]]];
    [(LabelBadgeCell *)cell layoutBadge];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ReposViewController *reposVC = [[ReposViewController alloc] initWithStyle:UITableViewStylePlain];
    RepoCollectionModel *repoCollection = [[self.languageReposCollection.items objectAtIndex:[indexPath row]] repos];
    [reposVC setTitle:[[self.languageReposCollection.items objectAtIndex:[indexPath row]] language]];
    [reposVC setRepoCollection:repoCollection];
    [self.navigationController pushViewController:reposVC animated:YES];
}

@end
