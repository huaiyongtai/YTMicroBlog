//
//  HYTNewFeatureController.m
//  无法修盖
//
//  Created by HelloWorld on 15/10/19.
//  Copyright (c) 2015年 SearchPrefect. All rights reserved.
//

#import "HYTNewFeatureController.h"

static NSInteger const kNewFeatureCount = 3;

@interface HYTNewFeatureController () <UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView *featureView;

@property (nonatomic, weak) UIPageControl *pageControl;

@end

@implementation HYTNewFeatureController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIScrollView *featureView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    
    [featureView setBackgroundColor:[UIColor redColor]];
    [featureView setContentSize:CGSizeMake(featureView.width * kNewFeatureCount, 0)];
    [featureView setPagingEnabled:YES];
    [featureView setBounces:NO];
    [featureView setShowsHorizontalScrollIndicator:NO];
    [featureView setDelegate:self];

    for (int index = 0; index < kNewFeatureCount; index++) {
        UIImageView *featureImage = [[UIImageView alloc] initWithFrame:featureView.bounds];
        featureImage.x = index * featureView.width;
        [featureImage setImage:[UIImage imageNamed:@"new_feature"]];
        [featureView addSubview:featureImage];
    }
    [self.view addSubview:featureView];
    self.featureView = featureView;
    
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    pageControl.pageIndicatorTintColor = [UIColor blueColor];
    pageControl.center = self.view.center;
    pageControl.y = self.view.height * 0.85;
    pageControl.numberOfPages = kNewFeatureCount;
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat currentPageOffset = scrollView.contentOffset.x / scrollView.width;
    NSInteger currentPage = (int)(currentPageOffset + 0.5);
    if (self.pageControl.currentPage != currentPage) {
        self.pageControl.currentPage = currentPage;
    }
}

@end
