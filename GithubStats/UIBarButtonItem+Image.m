//
//  UIBarButtonItem+Image.m
//  GithubStats
//
//  Created by Adriana Santos on 16/12/2012.
//  Copyright (c) 2012 Adriana Santos. All rights reserved.
//

#import "UIBarButtonItem+Image.h"

@implementation UIBarButtonItem (Image)

-(id)initWithImage:(UIImage *)image target:(id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame= CGRectMake(0.0, 0.0, image.size.width, image.size.height);
    button.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    button.titleLabel.shadowOffset = CGSizeMake(0, -1);
    button.titleLabel.shadowColor = [UIColor colorWithWhite:0 alpha:0.5];
    
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchDown];
    
    //    UIView *view =[[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, image.size.width, image.size.height) ];
    //    [view addSubview:button];
    
    self = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    return self;
}

@end
