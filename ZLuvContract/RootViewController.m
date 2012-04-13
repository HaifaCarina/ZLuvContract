//
//  RootViewController.m
//  ZLuvContract
//
//  Created by Haifa Carina Baluyos on 4/13/12.
//  Copyright 2012 NMG Resources, Inc. All rights reserved.
//

#import "RootViewController.h"


@implementation RootViewController

- (void) loadView {
    [super loadView];
    
    NSMutableArray *framesArray = [[NSMutableArray alloc ]init];
    [framesArray addObject:[UIImage imageNamed:@"1.jpg"]];
    [framesArray addObject:[UIImage imageNamed:@"2.jpeg"]];
    [framesArray addObject:[UIImage imageNamed:@"3.jpg"]];
    [framesArray addObject:[UIImage imageNamed:@"4.jpg"]];
    
    
    
    framesScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    framesScrollView.scrollEnabled = YES;
    framesScrollView.showsHorizontalScrollIndicator = TRUE;
    framesScrollView.showsVerticalScrollIndicator = TRUE;
    framesScrollView.contentSize = CGSizeMake(self.view.frame.size.width, [framesArray count] * 180);
    
    int yAxis = 0;
    for (UIImage *img in framesArray) {
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(60, yAxis, 150, 150)];
        imgView.image = img;
        [framesScrollView addSubview:imgView];
        [imgView release];
        
        yAxis += 170;
        
    }
    
    [self.view addSubview:framesScrollView];
     
    
}
@end
