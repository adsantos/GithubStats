//
//  LabelBadgeCell.h
//  GithubStats
//
//  Created by Adriana Santos on 15/12/2012.
//  Copyright (c) 2012 Adriana Santos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomBadge.h"

@interface LabelBadgeCell : UITableViewCell
@property (nonatomic, strong) IBOutlet UILabel *label;
@property (nonatomic, strong) CustomBadge *customBadge;

-(void)layoutBadge;

@end
