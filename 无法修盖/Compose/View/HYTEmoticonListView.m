//
//  HYTEmoticonListView.m
//  无法修盖
//
//  Created by HelloWorld on 16/1/7.
//  Copyright (c) 2016年 SearchPrefect. All rights reserved.
//

#import "HYTEmoticonListView.h"
#import "HYTEmoticonsView.h"

@interface HYTEmoticonListView () <UIScrollViewDelegate>

@property (nonatomic, weak) HYTEmoticonsView *emoticonView;
@property (nonatomic, weak) UIPageControl   *pageControl;
@end

@implementation HYTEmoticonListView

+ (instancetype)listView {
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"emoticon_keyboard_background"]]];
        
        HYTEmoticonsView *emoticonView = [[HYTEmoticonsView alloc] init];
        [emoticonView setDelegate:self];
        [emoticonView setPagingEnabled:YES];
        [emoticonView setShowsHorizontalScrollIndicator:NO];
        [self addSubview:emoticonView];
        self.emoticonView = emoticonView;
        
        UIPageControl *pageControl = ({
            UIPageControl *pageControl = [[UIPageControl alloc] init];
            [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_normal"] forKey:@"pageImage"];
            [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_selected"] forKey:@"currentPageImage"];
            [pageControl setUserInteractionEnabled:NO];
            [pageControl setHidesForSinglePage:YES];
            pageControl;
        });
        [self addSubview:pageControl];
        self.pageControl = pageControl;
    }
    return self;
}

- (void)setEmoticons:(NSArray *)emoticons{
    
    _emoticons = emoticons;
    
    [self.emoticonView setEmoticons:emoticons];
    
    [self.pageControl setNumberOfPages:(emoticons.count + HYTEmotionPageCount - 1) / HYTEmotionPageCount];
    
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger currentPage = (NSInteger)((scrollView.contentOffset.x / scrollView.width) + 0.5);
    if (self.pageControl.currentPage != currentPage) {
        self.pageControl.currentPage = currentPage;
    }
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    CGFloat pageControlHeight = 28;
    [self.pageControl setFrame:CGRectMake(0, self.height - pageControlHeight, self.width, pageControlHeight)];
    [self.emoticonView setFrame:CGRectMake(0, 0, self.width, self.pageControl.y)];
    [self.emoticonView setContentSize:CGSizeMake((self.emoticons.count + HYTEmotionPageCount - 1) / HYTEmotionPageCount *self.width, 0)];
    
}

@end
