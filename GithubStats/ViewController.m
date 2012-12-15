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

@interface ViewController ()
@property (nonatomic, strong) NSArray *statsKeywords;
@end

@implementation ViewController
@synthesize statsKeywords = _statsKeywords;

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
            [[(LabelBadgeCell *)cell customBadge] autoBadgeSizeWithString:@"0"];
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

@end
