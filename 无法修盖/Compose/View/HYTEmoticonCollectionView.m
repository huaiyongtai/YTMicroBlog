//
//  HYTEmoticonCollectionView.m
//  无法修盖
//
//  Created by HelloWorld on 16/2/1.
//  Copyright © 2016年 SearchPrefect. All rights reserved.
//

#import "HYTEmoticonCollectionView.h"
#import "HYTEmoticonCell.h"
#import "HYTEmoticon.h"
#import "MJExtension.h"

static CGFloat HYTPageControlHeight = 28;

static NSInteger cols = 0;
static const NSUInteger kSectionCount = 20;

@interface HYTEmoticonCollectionView () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, weak) UICollectionView *emoticonView;
@property (nonatomic, weak) UIPageControl    *pageControl;
@property (nonatomic, strong) NSArray *groups;
@end

@implementation HYTEmoticonCollectionView

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
        UICollectionView *emoticonView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout]; {
            [emoticonView registerClass:[HYTEmoticonCell class] forCellWithReuseIdentifier:@"HYTEmoticonCell"];
            [emoticonView setDelegate:self];
            [emoticonView setDataSource:self];
            [emoticonView setPagingEnabled:YES];
            [emoticonView setShowsHorizontalScrollIndicator:NO];
            [emoticonView setBackgroundColor:[UIColor clearColor]];
        }
        [self addSubview:emoticonView];
        self.emoticonView = emoticonView;
        
        UIPageControl *pageControl = [[UIPageControl alloc] init]; {
            [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_normal"] forKey:@"pageImage"];
            [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_selected"] forKey:@"currentPageImage"];
            [pageControl setUserInteractionEnabled:NO];
            [pageControl setHidesForSinglePage:YES];
        }
        [self addSubview:pageControl];
        self.pageControl = pageControl;
    }
    
    [self loadEmoticonDataSource];
    return self;
}

- (void)setEmoticons:(NSArray *)emoticons {
    
    _emoticons = emoticons;
    cols = (emoticons.count + kSectionCount-1 - 1) / (kSectionCount-1);
    [self.pageControl setNumberOfPages:cols];
    [self.emoticonView reloadData];
}

- (void)loadEmoticonDataSource {
    
    NSString *defaultPath = [[NSBundle mainBundle] pathForResource:@"Emoticons.bundle/com.sina.default/info.plist" ofType:nil];
    NSArray *defaultArray = [NSDictionary dictionaryWithContentsOfFile:defaultPath][@"emoticons"];
    NSArray *defaultEmoticons = [HYTEmoticon mj_objectArrayWithKeyValuesArray:defaultArray];
    [defaultEmoticons setValue:@"com.sina.default" forKeyPath:@"idStr"];
    
    NSString *emojiPath = [[NSBundle mainBundle] pathForResource:@"Emoticons.bundle/com.apple.emoji/info.plist" ofType:nil];
    NSArray *emojiArray = [NSDictionary dictionaryWithContentsOfFile:emojiPath][@"emoticons"];
    NSArray *emojiEmoticons = [HYTEmoticon mj_objectArrayWithKeyValuesArray:emojiArray];
    [emojiEmoticons setValue:@"com.apple.emoji" forKeyPath:@"idStr"];
    
    NSString *lxhPath = [[NSBundle mainBundle] pathForResource:@"Emoticons.bundle/com.sina.lxh/info.plist" ofType:nil];
    NSArray *lxhArray = [NSDictionary dictionaryWithContentsOfFile:lxhPath][@"emoticons"];
    NSArray *lxhEmoticons = [HYTEmoticon mj_objectArrayWithKeyValuesArray:lxhArray];
    [lxhEmoticons setValue:@"com.sina.lxh" forKeyPath:@"idStr"];
    
    NSArray *groups = @[defaultEmoticons, emojiEmoticons, lxhEmoticons];
    self.groups = groups;
    [self.emoticonView reloadData];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    MBLog(@"numberOfSectionsInCollectionView");
    return self.groups.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    MBLog(@"collectionView:numberOfItemsInSection");
    NSArray *emotions = self.groups[section];
    return (emotions.count + kSectionCount -1) / kSectionCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HYTEmoticonCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HYTEmoticonCell" forIndexPath:indexPath];
    NSArray *emoticons = ({
        NSArray *totalEmotions = self.groups[indexPath.section];
        NSUInteger pageOfGroup = (totalEmotions.count + kSectionCount - 1) / kSectionCount;
        NSUInteger pageLength = kSectionCount;
        if (indexPath.item == pageOfGroup - 1) {    //最后一页
            pageLength = (totalEmotions.count % kSectionCount) ? : kSectionCount;
        }
        [totalEmotions subarrayWithRange:NSMakeRange(kSectionCount * indexPath.item, pageLength)];
    });
    cell.emoticons = emoticons;
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    NSInteger currentPage = (NSInteger)((scrollView.contentOffset.x / scrollView.width) + 0.5);
    if (self.pageControl.currentPage != currentPage) {
        self.pageControl.currentPage = currentPage;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(self.width, self.height - HYTPageControlHeight);
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    [self.pageControl setFrame:CGRectMake(0, self.height - HYTPageControlHeight, self.width, HYTPageControlHeight)];
    [self.emoticonView setFrame:CGRectMake(0, 0, self.width, self.pageControl.y)];
}

@end
