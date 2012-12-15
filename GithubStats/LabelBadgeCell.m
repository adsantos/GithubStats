//
//  LabelBadgeCell.m
//  GithubStats
//
//  Created by Adriana Santos on 15/12/2012.
//  Copyright (c) 2012 Adriana Santos. All rights reserved.
//

#import "LabelBadgeCell.h"

@interface LabelBadgeCell ()
@property (nonatomic, strong) IBOutlet UIView *badgeView;

@end

@implementation LabelBadgeCell
@synthesize label = _label;
@synthesize badgeView = _badgeView;
@synthesize customBadge = _customBadge;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)awakeFromNib {
    [super awakeFromNib];
    if (self) {
        // Initialization code
        self.customBadge = [CustomBadge customBadgeWithString:@" " withStringColor:[UIColor whiteColor] withInsetColor:[UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:1.0f] withBadgeFrame:NO withBadgeFrameColor:nil withScale:1.0 withShining:NO withCornerRoundness:0.1];
        [self addSubview:self.customBadge];
        [self layoutBadge];
    }
    
}

-(void)layoutBadge {
    if(self.customBadge) {
        self.customBadge.center = self.badgeView.center;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
