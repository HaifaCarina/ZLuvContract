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
    
    
    
    framesScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    framesScrollView.scrollEnabled = YES;
    framesScrollView.showsHorizontalScrollIndicator = TRUE;
    framesScrollView.showsVerticalScrollIndicator = TRUE;
    framesScrollView.contentSize = CGSizeMake(self.view.frame.size.width, [framesArray count] * 180);
    
    int yAxis = 10, imgCount = 0;
    for (UIImage *img in framesArray) {
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(60, yAxis, 150, 150)];
        imgView.image = img;
        imgView.tag = imgCount;
        imgView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCaptured: )];
        [imgView addGestureRecognizer:singleTap]; 
        [singleTap release];
        
        [framesScrollView addSubview:imgView];
        [imgView release];
        
        yAxis += 170;
        imgCount++;
        
    }
    
    [self.view addSubview:framesScrollView];
    
}

#pragma mark -
#pragma mark Custom Methods
- (void) singleTapGestureCaptured: (UITapGestureRecognizer *) recognizer {
    NSLog(@"tapped %d", [[recognizer view] tag]);
    FrameViewController *aController = [[FrameViewController alloc] initWithTemplate: [framesArray objectAtIndex:recognizer.view.tag] tag:recognizer.view.tag];
    [self.navigationController pushViewController:aController animated:YES];
    [aController release];
}


@end
