//
//  RootViewController.m
//  ZLuvContract
//
//  Created by Haifa Carina Baluyos on 4/13/12.
//  Copyright 2012 NMG Resources, Inc. All rights reserved.
//

#import "RootViewController.h"


@implementation RootViewController

#pragma mark -
#pragma mark LifeCycle
- (void) loadView {
    [super loadView];
    
    framesArray = [[NSMutableArray alloc ]init];
    [framesArray addObject:[UIImage imageNamed:@"1.jpg"]];
    [framesArray addObject:[UIImage imageNamed:@"2.jpeg"]];
    [framesArray addObject:[UIImage imageNamed:@"3.jpg"]];
    [framesArray addObject:[UIImage imageNamed:@"4.jpg"]];
    [framesArray addObject:[UIImage imageNamed:@"baroque.png"]];
    [framesArray addObject:[UIImage imageNamed:@"blackandwhite.png"]];
    [framesArray addObject:[UIImage imageNamed:@"blue&whitehearts.png"]];
    
    
    framesScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    framesScrollView.scrollEnabled = YES;
    framesScrollView.showsHorizontalScrollIndicator = YES;
    framesScrollView.showsVerticalScrollIndicator = YES;
    framesScrollView.contentSize = CGSizeMake(self.view.frame.size.width, [framesArray count] * 180);
    
    int yAxis = 10, imgCount = 0;
    for (UIImage *img in framesArray) {
        
        UIButton *template = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [template addTarget:self  action:@selector(templateSelect:) forControlEvents:UIControlEventTouchDown];
        [template setImage:img forState:UIControlStateNormal];
        template.frame = CGRectMake(60, yAxis, 150, 150);
        template.tag = imgCount;
        [framesScrollView addSubview:template];
        
        yAxis += 170;
        imgCount++;
    }
    [self.view addSubview:framesScrollView];
}

#pragma mark -
#pragma mark Custom Methods
- (void) templateSelect: (UIButton *) sender {
    NSLog(@"tapped %d", sender.tag);
    FrameViewController *aController = [[FrameViewController alloc] initWithTemplate: [framesArray objectAtIndex:sender.tag] tag:sender.tag];
    [self.navigationController pushViewController:aController animated:YES];
    [aController release];
}


@end
