//
//  FrameViewController.m
//  ZLuvContract
//
//  Created by Haifa Carina Baluyos on 4/13/12.
//  Copyright 2012 NMG Resources, Inc. All rights reserved.
//

#import "FrameViewController.h"


@implementation FrameViewController

@synthesize selectedTemplate;

- (id) initWithTemplate:(UIImage *)templateImage{
    if (self == [super init]) {
        self.selectedTemplate = templateImage;
    }
    return(self);
}

#pragma mark -
#pragma mark LifeCycle
- (void) loadView {
    [super loadView];
    
    UIImageView *imgView = [[UIImageView alloc]initWithImage: selectedTemplate];
    imgView.frame = CGRectMake(0, 0, 300, 300);
    [imgView setCenter:CGPointMake(CGRectGetMidX([self.view bounds]), CGRectGetMidY([self.view bounds])-40)];
    [self.view addSubview:imgView];
    
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[shareButton addTarget:self  action:@selector(share) forControlEvents:UIControlEventTouchDown];
	[shareButton setTitle:@"Share" forState:UIControlStateNormal];
    shareButton.frame = CGRectMake(130.0, 370.0, 80.0,40.0);
    shareButton.tag = 3;
	[self.view addSubview:shareButton];
    
}

#pragma mark -
#pragma mark Custom Methods
- (void) share {
    NSLog(@"share");
}
@end
