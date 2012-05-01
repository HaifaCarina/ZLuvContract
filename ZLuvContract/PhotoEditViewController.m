//
//  PhotoEditViewController.m
//  ZLuvContract
//
//  Created by Haifa Carina Baluyos on 4/23/12.
//  Copyright 2012 NMG Resources, Inc. All rights reserved.
//

#import "PhotoEditViewController.h"


@implementation PhotoEditViewController
#pragma mark -
#pragma mark LifeCycle Methods
- (void) loadView {
    [super loadView];
    UINavigationBar *navBar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 370, self.view.bounds.size.width, 50)];
    
    NSArray *itemArray = [NSArray arrayWithObjects: @"Filter", @"Stickers", nil];
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:itemArray];
    [segmentedControl addTarget:self action:@selector(segmentedControlAction:) forControlEvents:UIControlEventValueChanged];
    segmentedControl.frame = CGRectMake(10, 10, 150, 30);
    segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
    segmentedControl.selectedSegmentIndex = 0;
    //navBar.navigationItem.titleView = segmentedControl;
    [navBar addSubview:segmentedControl];
    
    [self.view addSubview:navBar];
    
    CGRect effectsRect = CGRectMake(0, 300, 320, 70);
    
    filtersScrollView = [[UIScrollView alloc]initWithFrame:effectsRect];
    filtersScrollView.backgroundColor = [UIColor redColor];
    filtersScrollView.contentSize = CGSizeMake(500, 70);
    
    UIButton *bwButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[bwButton addTarget:self  action:@selector(selectfilter:) forControlEvents:UIControlEventTouchDown];
	[bwButton setTitle:@"B&W" forState:UIControlStateNormal];
    bwButton.frame = CGRectMake(0, 10, 50,50);
    bwButton.tag = 1;
    [filtersScrollView addSubview:bwButton];
    
    UIButton *sepiaButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[sepiaButton addTarget:self  action:@selector(selectfilter:) forControlEvents:UIControlEventTouchDown];
	[sepiaButton setTitle:@"Sepia" forState:UIControlStateNormal];
    sepiaButton.frame = CGRectMake(60, 10, 50,50);
    sepiaButton.tag = 2;
    [filtersScrollView addSubview:sepiaButton];
    
    UIButton *blueButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[blueButton addTarget:self  action:@selector(selectfilter:) forControlEvents:UIControlEventTouchDown];
	[blueButton setTitle:@"Blue" forState:UIControlStateNormal];
    blueButton.frame = CGRectMake(120, 10, 50,50);
	blueButton.tag = 3;
    [filtersScrollView addSubview:blueButton];

    stickersScrollView = [[UIScrollView alloc]initWithFrame:effectsRect];
    stickersScrollView.backgroundColor = [UIColor greenColor];
    stickersScrollView.contentSize = CGSizeMake(500, 70);
    
    UIImage *sticker1 = [UIImage imageNamed:@"spongebob.png"];
    UIImageView *stickerView1 = [[UIImageView alloc]initWithImage:sticker1];
    stickerView1.frame = CGRectMake(0, 10, 50,50);
    stickerView1.tag = 1;
    stickerView1.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCaptured: )];
    [stickerView1 addGestureRecognizer:singleTap1]; 
    [singleTap1 release];
    [stickersScrollView addSubview:stickerView1];
    [stickerView1 release];
    
    UIImage *sticker2 = [UIImage imageNamed:@"bunny.png"];
    UIImageView *stickerView2 = [[UIImageView alloc]initWithImage:sticker2];
    stickerView2.frame = CGRectMake(60, 10, 50,50);
    stickerView2.tag = 2;
    stickerView2.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCaptured: )];
    [stickerView2 addGestureRecognizer:singleTap2]; 
    [singleTap2 release];
    [stickersScrollView addSubview:stickerView2];
    [stickerView2 release];
    
    UIImage *sticker3 = [UIImage imageNamed:@"heart.png"];
    UIImageView *stickerView3 = [[UIImageView alloc]initWithImage:sticker3];
    stickerView3.frame = CGRectMake(120, 10, 50,50);
    stickerView3.tag = 3;
    stickerView3.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCaptured: )];
    [stickerView3 addGestureRecognizer:singleTap3]; 
    [singleTap3 release];
    [stickersScrollView addSubview:stickerView3];
    [stickerView3 release];
    
    UIImage *sticker4 = [UIImage imageNamed:@"star.png"];
    UIImageView *stickerView4 = [[UIImageView alloc]initWithImage:sticker4];
    stickerView4.frame = CGRectMake(180, 10, 50,50);
    stickerView4.tag = 4;
    stickerView4.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCaptured: )];
    [stickerView4 addGestureRecognizer:singleTap4]; 
    [singleTap4 release];
    [stickersScrollView addSubview:stickerView4];
    [stickerView4 release];
    
    UIScrollView *tmpScrollView = [GlobalData sharedGlobalData].currentScrollView;
    imageScrollView = [[UIScrollView alloc]initWithFrame: CGRectMake(0, 0, tmpScrollView.frame.size.width, tmpScrollView.frame.size.height)];
    imageScrollView.delegate = self;
    imageScrollView.scrollEnabled = YES;
    imageScrollView.showsHorizontalScrollIndicator = YES;
    imageScrollView.showsVerticalScrollIndicator = YES;
    
    imageScrollView.maximumZoomScale = tmpScrollView.maximumZoomScale;
    imageScrollView.minimumZoomScale = tmpScrollView.minimumZoomScale;
    imageScrollView.backgroundColor = [UIColor greenColor];
    
    imageScrollView.contentSize = [GlobalData sharedGlobalData].currentPhotoView.frame.size;
    contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [GlobalData sharedGlobalData].currentPhotoView.frame.size.width, [GlobalData sharedGlobalData].currentPhotoView.frame.size.height)];
    [contentView addSubview:[GlobalData sharedGlobalData].currentPhotoView];
    [contentView sendSubviewToBack:[GlobalData sharedGlobalData].currentPhotoView];
    [imageScrollView addSubview:contentView];
    
    // SET ZOOM SCALE AND OFFSETS
    // Must be set after all scrollview subviews are added
    [imageScrollView setZoomScale:tmpScrollView.zoomScale animated:NO];
    [imageScrollView setContentOffset:CGPointMake(tmpScrollView.contentOffset.x , tmpScrollView.contentOffset.y)];
    
    [imageScrollView setCenter:CGPointMake(CGRectGetMidX([self.view bounds]), CGRectGetMidY([self.view bounds])-20)];
    
    CGSize pageSize1 = imageScrollView.frame.size;
    UIGraphicsBeginImageContext(pageSize1);
    CGContextRef resizedContext1 = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(resizedContext1, -imageScrollView.contentOffset.x, -imageScrollView.contentOffset.y);
    [imageScrollView.layer renderInContext:resizedContext1];
    UIImage *p1 = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    [imageScrollView release];
    
    UIImageView *photoView1 = [[UIImageView alloc]initWithImage:p1];
    photoView1.frame = CGRectMake(0, 0, p1.size.width, p1.size.height);
    
    
    contentView = [[UIView alloc]initWithFrame: photoView1.frame]; 
    [contentView setCenter:CGPointMake(CGRectGetMidX([self.view bounds]), CGRectGetMidY([self.view bounds])-100)];
    contentView.backgroundColor = [UIColor greenColor];
    [contentView addSubview:photoView1];
    [photoView1 release];
    
    
    [self.view addSubview:contentView];
    
}

#pragma mark -
#pragma mark Custom Methods
- (void) singleTapSticker: (id) sender {
    NSLog(@"tapped  a sticker");
}
- (void) segmentedControlAction: (UISegmentedControl *)segmentedControl {
    
    if ([segmentedControl selectedSegmentIndex] == 0) 
    {
        NSLog(@"filter");
        [stickersScrollView removeFromSuperview];
        [self.view addSubview:filtersScrollView];
      
	} else 
    {
		NSLog(@"Stickers");
        [filtersScrollView removeFromSuperview];
        [self.view addSubview:stickersScrollView];
    }
}
#pragma mark -
#pragma mark UIScrollView Delegate

- (UIView*)viewForZoomingInScrollView:(UIScrollView *)aScrollView {
    NSLog(@"PhotoEditView Zoom");
    
    return contentView;
}
- (void)scrollViewDidEndZooming:(UIScrollView *)zoomedScrollView withView:(UIView *)view atScale:(float)scale
{
    NSLog(@"view scale %f", scale);
    
}
@end
