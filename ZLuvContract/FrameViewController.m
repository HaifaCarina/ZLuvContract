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
    
    
    UIImageView *templateView = [[UIImageView alloc]initWithImage: selectedTemplate];
    templateView.frame = CGRectMake(0, 0, 300, 300);
    [templateView setCenter:CGPointMake(CGRectGetMidX([self.view bounds]), CGRectGetMidY([self.view bounds])-40)];
    [self.view addSubview:templateView];
    
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[shareButton addTarget:self  action:@selector(share) forControlEvents:UIControlEventTouchDown];
	[shareButton setTitle:@"Share" forState:UIControlStateNormal];
    shareButton.frame = CGRectMake(130.0, 370.0, 80.0,40.0);
    shareButton.tag = 3;
	[self.view addSubview:shareButton];
    
    scrollview1 = [[UIScrollView alloc]initWithFrame: scrollviewRect1];
    
    scrollview1.scrollEnabled = YES;
    scrollview1.showsHorizontalScrollIndicator = TRUE;
    scrollview1.showsVerticalScrollIndicator = TRUE;
    scrollview1.contentSize = CGSizeMake([GlobalData sharedGlobalData].photoView1.image.size.width, [GlobalData sharedGlobalData].photoView1.image.size.height);
    
    scrollview1.delegate = self;
    scrollview1.maximumZoomScale = 50;
    scrollview1.minimumZoomScale = .2;
    scrollview1.tag = 1;
    scrollview1.backgroundColor = [UIColor blueColor];
    
    contentView1 = [[UIView alloc]init];
    contentView1.frame = CGRectMake(0, 0, scrollviewRect1.size.width, scrollviewRect1.size.height);
    /*if ([GlobalData sharedGlobalData].photoView1.image == nil) {
        contentView1.frame = CGRectMake(0, 0, scrollviewRect1.size.width, scrollviewRect1.size.height);
    }else {
        contentView1.frame = CGRectMake(0, 0, [GlobalData sharedGlobalData].photoView1.image.size.width, [GlobalData sharedGlobalData].photoView1.image.size.height);
    }
    */
    [contentView1 addSubview:[GlobalData sharedGlobalData].photoView1];
    [scrollview1 addSubview:contentView1];
    
    UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCaptured: ) ];
    [scrollview1 addGestureRecognizer:singleTap1];
    [singleTap1 release];
    
    [self.view addSubview:scrollview1];
    
    scrollview2 = [[UIScrollView alloc]initWithFrame: scrollviewRect2];
    scrollview2.scrollEnabled = YES;
    scrollview2.showsHorizontalScrollIndicator = TRUE;
    scrollview2.showsVerticalScrollIndicator = TRUE;
    scrollview2.contentSize = CGSizeMake([GlobalData sharedGlobalData].photoView2.image.size.width, [GlobalData sharedGlobalData].photoView2.image.size.height);
    scrollview2.delegate = self;
    scrollview2.maximumZoomScale = 50;
    scrollview2.minimumZoomScale = .2;
    scrollview2.tag = 2;
    scrollview2.backgroundColor = [UIColor blueColor];
    
    contentView2 = [[UIView alloc]init];
    contentView2.frame = CGRectMake(0, 0, scrollviewRect2.size.width, scrollviewRect2.size.height);
    /*
    if ([GlobalData sharedGlobalData].photoView2.image == nil) {
        contentView2.frame = CGRectMake(0, 0, scrollviewRect2.size.width, scrollviewRect2.size.height);
    }else {
        contentView2.frame = CGRectMake(0, 0, [GlobalData sharedGlobalData].photoView2.image.size.width, [GlobalData sharedGlobalData].photoView2.image.size.height);
    }
    */
    [contentView2 addSubview:[GlobalData sharedGlobalData].photoView2];
    [scrollview2 addSubview:contentView2];
    
    UITapGestureRecognizer *singleTap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCaptured: ) ];
    [scrollview2 addGestureRecognizer:singleTap2];
    [singleTap2 release];
    
    [self.view addSubview:scrollview2];
    
    
    imgPicker = [[UIImagePickerController alloc] init];
    imgPicker.allowsEditing = YES;
    imgPicker.delegate = self;
    imgPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
}

#pragma mark -
#pragma mark Custom Methods

- (void) singleTapGestureCaptured : (id) sender {
    
    currentPhotoTag = [(UIGestureRecognizer *)sender view].tag;
    
    UIActionSheet *photoOptions = [[UIActionSheet alloc] initWithTitle:@"Photo"
                                                              delegate:self cancelButtonTitle:@"Cancel"
                                                destructiveButtonTitle:nil
                                                     otherButtonTitles:@"From Library",@"From Camera",@"Effects",nil,nil];
	
	// use the same style as the nav bar
	photoOptions.actionSheetStyle = self.navigationController.navigationBar.barStyle;
	[photoOptions showInView:self.view];
	[photoOptions release];
    
}
- (void) share {
    NSLog(@"share");
    
    ZLuvContractAppDelegate *delegate = (ZLuvContractAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSArray* permissions = [[NSArray alloc] initWithObjects:
                            @"publish_stream",@"read_stream", nil];
    [delegate.facebook authorize:permissions delegate:self];
    [permissions release];

}
#pragma mark -
#pragma mark UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)img editingInfo:(NSDictionary *)editInfo {
	
    NSLog(@"image picker %d",currentPhotoTag);
    switch (currentPhotoTag) {
        case 1: {
            [GlobalData sharedGlobalData].photoView1.image = img;
            [GlobalData sharedGlobalData].photoView1.frame = CGRectMake(0, 0, img.size.width, img.size.height);
            scrollview1.contentSize = CGSizeMake(img.size.width, img.size.height);
            contentView1.frame = CGRectMake(0, 0, img.size.width, img.size.height);
            break;
        }
        case 2: {
            
            [GlobalData sharedGlobalData].photoView2.image = img;
            [GlobalData sharedGlobalData].photoView2.frame = CGRectMake(0, 0, img.size.width, img.size.height);
            scrollview2.contentSize = CGSizeMake(img.size.width, img.size.height);
            contentView2.frame = CGRectMake(0, 0, img.size.width, img.size.height);
            break;
        }
        default:
            break;
    }
    
	[[picker parentViewController] dismissModalViewControllerAnimated:YES];
}
#pragma mark -
#pragma mark UIScrollView Delegate
- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view {
    
}
- (UIView*)viewForZoomingInScrollView:(UIScrollView *)aScrollView {
    NSLog(@"%d",aScrollView.tag);
    switch (aScrollView.tag) {
        case 1:
            return contentView1;
            break;
        case 2:
            return contentView2;
            break;
    } 
    return nil;
}
- (void)scrollViewDidEndZooming:(UIScrollView *)zoomedScrollView withView:(UIView *)view atScale:(float)scale
{
	NSLog(@"%f ", scale);
}

#pragma mark -
#pragma mark UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)modalView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        case 0:
        {
            NSLog(@"Get From Library");
            imgPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentModalViewController:imgPicker animated:YES];
            break;
        }
        case 1:
        {
            NSLog(@"Camera");
            imgPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentModalViewController:imgPicker animated:YES];
            break;
        }
        case 2:
        {
            NSLog(@"Effects");
            
            if (currentPhotoTag == 1) {
                [GlobalData sharedGlobalData].currentPhotoView = [GlobalData sharedGlobalData].photoView1;
                [GlobalData sharedGlobalData].currentScrollView = scrollview1;
                [GlobalData sharedGlobalData].currentPhotoTag = 1;
                
            } else {
                [GlobalData sharedGlobalData].currentPhotoView = [GlobalData sharedGlobalData].photoView2;
                [GlobalData sharedGlobalData].currentScrollView = scrollview2;
                [GlobalData sharedGlobalData].currentPhotoTag = 2;
            }
            
            
            PhotoEditViewController *aController = [[PhotoEditViewController alloc]init];
            [self.navigationController pushViewController:aController animated:YES];
            //aController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            //[self presentModalViewController:aController animated:YES];
            [aController release];
            
            break;
        }
    }
}

#pragma mark -
#pragma mark Facebook Methods
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
