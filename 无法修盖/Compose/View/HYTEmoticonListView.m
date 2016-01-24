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

//使用CollectionView的简单实现
/*
static NSInteger cols = 0;
static const NSUInteger kSectionCount = 21;

@interface HYTEmoticonListView () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, weak) UICollectionView *emoticonView;
@property (nonatomic, weak) UIPageControl    *pageControl;
@end

@implementation HYTEmoticonListView

+ (instancetype)listView {
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self setBackgroundColor:HYTCOLORANDOM];
        [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"emoticon_keyboard_background"]]];
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        
        UICollectionView *emoticonView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        [emoticonView registerClass:[HYTEmoticonCell class] forCellWithReuseIdentifier:@"HYTEmoticonCell"];
        [emoticonView setDelegate:self];
        [emoticonView setDataSource:self];
        [emoticonView setPagingEnabled:YES];
        [emoticonView setShowsHorizontalScrollIndicator:NO];
        [emoticonView setBackgroundColor:[UIColor clearColor]];
        [self addSubview:emoticonView];
        self.emoticonView = emoticonView;
        
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_normal"] forKey:@"pageImage"];
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_selected"] forKey:@"currentPageImage"];
        [pageControl setUserInteractionEnabled:NO];
        [self addSubview:pageControl];
        self.pageControl = pageControl;
    }
    return self;
}

- (void)setEmoticons:(NSArray *)emoticons {
    
    _emoticons = emoticons;
    cols = (emoticons.count + kSectionCount-1 - 1) / (kSectionCount-1);
    [self.pageControl setNumberOfPages:cols];
    [self.emoticonView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return cols * kSectionCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HYTEmoticonCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HYTEmoticonCell" forIndexPath:indexPath];
    BOOL isDelete = (indexPath.item+1) % kSectionCount == 0;    //删除按钮
    NSUInteger emoticonIndex =  indexPath.item - ((indexPath.item+1) / kSectionCount);  //表情模型索引
    if (isDelete) {
        cell.title = @"删除";
    } else if (emoticonIndex < self.emoticons.count) {
        HYTEmoticon *emoticon = self.emoticons[emoticonIndex];
        cell.emoticon = emoticon;
    } else {
        cell.title = @"";
    }
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger currentPage = (NSInteger)((scrollView.contentOffset.x / scrollView.width) + 0.5);
    if (self.pageControl.currentPage != currentPage) {
        self.pageControl.currentPage = currentPage;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(SCREEN_WIDTH/7, 188/3);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if ((indexPath.item+1) % kSectionCount == 0) return;
    
    NSUInteger emoticonIndex =  indexPath.item - ((indexPath.item+1) / kSectionCount);  //表情模型索引
    HYTEmoticon *emoticon = self.emoticons[emoticonIndex];
    NSLog(@"=======:%@", emoticon);
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    CGFloat pageControlHeight = 28;
    [self.pageControl setFrame:CGRectMake(0, self.height - pageControlHeight, self.width, pageControlHeight)];
    [self.emoticonView setFrame:CGRectMake(0, 0, self.width, self.pageControl.y)];
    self.emoticonView.contentSize = CGSizeMake(cols * self.width, 0);
}

@end
*/
