//
//  FrameViewController.m
//  ZLuvContract
//
//  Created by Haifa Carina Baluyos on 4/13/12.
//  Copyright 2012 NMG Resources, Inc. All rights reserved.
//

#import "FrameViewController.h"
#import "ZLuvContractAppDelegate.h"

@implementation FrameViewController

@synthesize selectedTag, selectedTemplate;

- (id) initWithTemplate:(UIImage *)templateImage tag:(int)tag {
    if (self == [super init]) {
        self.selectedTemplate = templateImage;
        self.selectedTag = tag;
    }
    return(self);
}

#pragma mark -
#pragma mark LifeCycle
- (void) loadView {
    [super loadView];
    switch (selectedTag) {
        case 0: 
            scrollviewRect1 = CGRectMake(40, 120, 100, 180);
            scrollviewRect2 = CGRectMake(160, 90, 100, 180);
            break;
        case 1:
            scrollviewRect1 = CGRectMake(35, 145, 85, 160);
            scrollviewRect2 = CGRectMake(200, 80, 85, 160);
            break;
        case 2:
            scrollviewRect1 = CGRectMake(35, 120, 100, 140);
            scrollviewRect2 = CGRectMake(180, 120, 100, 140);
            break;
        case 3: 
            scrollviewRect1 = CGRectMake(40, 100, 100, 160);
            scrollviewRect2 = CGRectMake(190, 100, 100, 160);
            break;    
        default:
            break;
    }
    
    
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
    
    UIImageView *first = [[UIImageView alloc]initWithFrame:scrollviewRect1];
    first.backgroundColor = [UIColor grayColor];
    [self.view addSubview:first];
    
    UIImageView *second = [[UIImageView alloc]initWithFrame:scrollviewRect2];
    second.backgroundColor = [UIColor grayColor];
    [self.view addSubview:second];
    
}

#pragma mark -
#pragma mark Custom Methods
- (void) share {
    NSLog(@"share");
    
    ZLuvContractAppDelegate *delegate = (ZLuvContractAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSArray* permissions = [[NSArray alloc] initWithObjects:
                            @"publish_stream",@"read_stream", nil];
    [delegate.facebook authorize:permissions delegate:self];
    [permissions release];

}
- (void)fbDidLogin {
    NSLog(@"viewController DIDlogin");
    
    ZLuvContractAppDelegate *delegate = (ZLuvContractAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
    NSMutableDictionary *params1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                    selectedTemplate, @"source", 
                                    @"Kontrata de Amor", @"message",             
                                    nil];
    
    [delegate.facebook requestWithGraphPath:@"/me/photos"
                                  andParams:params1 andHttpMethod:@"POST" andDelegate:self];
    
}

-(void)fbDidNotLogin:(BOOL)cancelled {
	NSLog(@"viewController did not login");
}

- (void)request:(FBRequest *)request didLoad:(id)result {
	if ([result isKindOfClass:[NSArray class]]) {
		result = [result objectAtIndex:0];
	}
	NSLog(@"viewController Result of API call: %@", result);
}

- (void)request:(FBRequest *)request didFailWithError:(NSError *)error {
    NSLog(@"viewController Failed with error: %@", [error localizedDescription]);
    NSLog(@"viewController Error: %@", [error description]);
}

@end
