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
    stickersCount = 101;
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] 
                                   initWithTitle:@"Done"                                            
                                   style:UIBarButtonItemStyleBordered 
                                   target:self 
                                   action:@selector(doneAction)];
    
    self.navigationItem.rightBarButtonItem = doneButton;
    [doneButton release];
    
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
    
    sticker1 = [UIImage imageNamed:@"spongebob.png"];
    UIImageView *stickerView1 = [[UIImageView alloc]initWithImage:sticker1];
    stickerView1.frame = CGRectMake(0, 10, 50,50);
    stickerView1.tag = 1;
    stickerView1.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCaptured: )];
    [stickerView1 addGestureRecognizer:singleTap1]; 
    [singleTap1 release];
    [stickersScrollView addSubview:stickerView1];
    [stickerView1 release];
    
    sticker2 = [UIImage imageNamed:@"bunny.png"];
    UIImageView *stickerView2 = [[UIImageView alloc]initWithImage:sticker2];
    stickerView2.frame = CGRectMake(60, 10, 50,50);
    stickerView2.tag = 2;
    stickerView2.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCaptured: )];
    [stickerView2 addGestureRecognizer:singleTap2]; 
    [singleTap2 release];
    [stickersScrollView addSubview:stickerView2];
    [stickerView2 release];
    
    sticker3 = [UIImage imageNamed:@"heart.png"];
    UIImageView *stickerView3 = [[UIImageView alloc]initWithImage:sticker3];
    stickerView3.frame = CGRectMake(120, 10, 50,50);
    stickerView3.tag = 3;
    stickerView3.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCaptured: )];
    [stickerView3 addGestureRecognizer:singleTap3]; 
    [singleTap3 release];
    [stickersScrollView addSubview:stickerView3];
    [stickerView3 release];
    
    sticker4 = [UIImage imageNamed:@"star.png"];
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
    
    for (UIImageView *s in [GlobalData sharedGlobalData].stickersArray) {
        [contentView addSubview:s];
    }
    
    [self.view addSubview:contentView];
    
}

#pragma mark -
#pragma mark Custom Methods
- (void) doneAction {
    NSLog(@"done!");
    [GlobalData sharedGlobalData].fromEffectsTag = 1;
}
- (void) singleTapSticker: (id) sender {
    NSLog(@"tapped  a sticker");
}
- (void) selectfilter: (UIButton *) button {
    NSLog(@"selectfilter %d", button.tag);
    
    switch (button.tag) {
        case 1:
            NSLog(@"b&w");
            break;
        case 2:
            NSLog(@"sepia");
            break;
        case 3:
            NSLog(@"blue");
            break;
            
    }
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
- (void) addSticker: (UIImage *)img{
    UIImageView *imgView = [[UIImageView alloc]initWithImage:img];
    imgView.frame = CGRectMake(0, 0, 50, 50);
    imgView.tag = stickersCount;
    stickersCount++;
    imgView.userInteractionEnabled = YES;
    
    [contentView addSubview:imgView];
    [[GlobalData sharedGlobalData].stickersArray addObject:imgView];
    [imgView release];
    
}
- (void) singleTapGestureCaptured: (UITapGestureRecognizer *) recognizer {
    NSLog(@"%d",[recognizer view].tag);
    
    switch ([recognizer view].tag) {
        case 1: 
            [self addSticker:sticker1];
            break;
        case 2: 
            [self addSticker:sticker2];
            break;
        case 3: 
            [self addSticker:sticker3];
            break;
        case 4: 
            [self addSticker:sticker4];
            break;
            
    }
    
}

#pragma mark -
#pragma mark Touches & Moves Delegate
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    
    contentView.backgroundColor = [UIColor greenColor];
    for (int i = 1; i < [[contentView subviews] count]; i++ ) {
        UIImageView *aView = [[contentView subviews] objectAtIndex:i];
        
        if (CGRectContainsPoint([aView frame], [touch locationInView:contentView])) {
            sticker = aView;
        }
    }
    
    // If triple tap remove sticker
    if ([touch tapCount] == 3) {
        NSLog(@"remove sticker");
        [sticker removeFromSuperview];
        [[GlobalData sharedGlobalData].stickersArray removeObjectIdenticalTo:sticker];
    } else {
        
        NSArray *allTouches = [touches allObjects];
        
        UITouch* t;
        if([[event allTouches] count]==1){
            if (CGRectContainsPoint([sticker frame], [[allTouches objectAtIndex:0] locationInView:contentView])) {
                t=[[[event allTouches] allObjects] objectAtIndex:0];
                touch1=[t locationInView:nil];
            }
        }else{
            t=[[[event allTouches] allObjects] objectAtIndex:0];
            touch1=[t locationInView:nil];
            t=[[[event allTouches] allObjects] objectAtIndex:1];
            touch2=[t locationInView:nil];
        }
        
        
    }
}

-(double)distance:(CGPoint)point1 toPoint:(CGPoint)point2
{
	double deltaX, deltaY;
	deltaX = point1.x - point2.x;
	deltaY = point1.y - point2.y;
	return sqrt(deltaX * deltaX + deltaY * deltaY);
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	
	CGPoint currentTouch1;
	CGPoint currentTouch2;
	NSArray *allTouches = [touches allObjects];
	UITouch* t;
	float scale = 1;
    rotation = 0;
	
	if([[event allTouches] count]==1){
		t=[[[event allTouches] allObjects] objectAtIndex:0];
		if (CGRectContainsPoint([sticker frame], [[allTouches objectAtIndex:0] locationInView:contentView]) )
		{ 
			touch2=[t locationInView:nil];
			sticker.center=CGPointMake(sticker.center.x+touch2.x-touch1.x,sticker.center.y+touch2.y-touch1.y);
			touch1=touch2;
		}
	}
	else if([[event allTouches] count]==2)
	{
		t=[[[event allTouches] allObjects] objectAtIndex:0];
		currentTouch1=[t locationInView:nil];
		
		t=[[[event allTouches] allObjects] objectAtIndex:1];
		currentTouch2=[t locationInView:nil];
		
		double distance1 =  [self distance:currentTouch1 toPoint:currentTouch2];
		double distance2 = [self distance:touch1 toPoint:touch2];
		
		if (distance2 == 0)
		{
			//handle the case where distance is zero
		}
		else {
			scale =distance1 / distance2;
        }
        
		rotation = atan2(currentTouch2.y-currentTouch1.y, currentTouch2.x-currentTouch1.x)-atan2(touch2.y-touch1.y,touch2.x-touch1.x);
        //rotation = angle - rotation; 
        
		if(isnan(scale)){
			scale=1.0f;
		}
		
        sticker.transform=CGAffineTransformScale(sticker.transform, scale,scale);
        sticker.transform=CGAffineTransformRotate(sticker.transform, rotation);
        
		touch1=currentTouch1;
		touch2=currentTouch2;
	}
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    angle = atan2(sticker.transform.b, sticker.transform.a);
    NSLog(@"touch ended with angle %f", angle);
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
