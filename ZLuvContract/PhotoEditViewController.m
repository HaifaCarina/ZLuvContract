//
//  PhotoEditViewController.m
//  ZLuvContract
//
//  Created by Haifa Carina Baluyos on 4/23/12.
//  Copyright 2012 NMG Resources, Inc. All rights reserved.
//

#import "PhotoEditViewController.h"


@implementation PhotoEditViewController

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
}

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
@end
