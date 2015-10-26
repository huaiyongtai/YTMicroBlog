//
//  HYTNewFeatureController.m
//  无法修盖
//
//  Created by HelloWorld on 15/10/19.
//  Copyright (c) 2015年 SearchPrefect. All rights reserved.
//

#import "HYTNewFeatureController.h"
#import "HYTabbarController.h"

static NSInteger const kNewFeatureCount = 3;

@interface HYTNewFeatureController () <UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView *featureView;

@property (nonatomic, weak) UIPageControl *pageControl;

@end

@implementation HYTNewFeatureController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //新特性展示页
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
        
        if (index == kNewFeatureCount-1) {
            [self addBtnTolastFeatureImage:featureImage];
        }
    }
    [self.view addSubview:featureView];
    self.featureView = featureView;
    
    //特性展示页码指示
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    pageControl.pageIndicatorTintColor = [UIColor blueColor];
    pageControl.center = self.view.center;
    pageControl.y = self.view.height * 0.9;
    pageControl.numberOfPages = kNewFeatureCount;
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
}

- (void)addBtnTolastFeatureImage:(UIImageView *)lastFeatureImage {
    
    //开启ImageView的交互事件
    [lastFeatureImage setUserInteractionEnabled:YES];
    
    //分享按钮
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareBtn setTitle:@"分享到微博" forState:UIControlStateNormal];
    [shareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    [shareBtn addTarget:self action:@selector(sharedToMicroBlog:) forControlEvents:UIControlEventTouchUpInside];
    [shareBtn setSize:CGSizeMake(200, 30)];
    [shareBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    [shareBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
    [shareBtn setOrigin:CGPointMake((lastFeatureImage.width - shareBtn.width) * 0.5, lastFeatureImage.height * 0.72)];
    [lastFeatureImage addSubview:shareBtn];
    
    //开始微博
    UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_button"] forState:UIControlStateNormal];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_button_highlighted"] forState:UIControlStateHighlighted];
    [startBtn addTarget:self action:@selector(startEnterMicroBlog) forControlEvents:UIControlEventTouchUpInside];
    [startBtn setSize:startBtn.currentBackgroundImage.size];
    [startBtn setOrigin:CGPointMake((lastFeatureImage.width-startBtn.size.width) * 0.5, CGRectGetMaxY(shareBtn.frame))];
    [lastFeatureImage addSubview:startBtn];
}

#pragma mark - ScrollViewDelegate
///滚动时设置pageControl的页码
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat currentPageOffset = scrollView.contentOffset.x / scrollView.width;
    NSInteger currentPage = (int)(currentPageOffset + 0.5);
    if (self.pageControl.currentPage != currentPage) {
        self.pageControl.currentPage = currentPage;
    }
}

#pragma mark - 设置分享
- (void)sharedToMicroBlog:(UIButton *)shareBtn {
    shareBtn.selected = !shareBtn.selected;
}

#pragma mark - 进入微博
///开始进入微博
- (void)startEnterMicroBlog {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    keyWindow.rootViewController = [[HYTabbarController alloc] init];
}

@end
