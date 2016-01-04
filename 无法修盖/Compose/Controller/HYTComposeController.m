//
//  HYTComposeController.m
//  无法修盖
//
//  Created by HelloWorld on 15/12/31.
//  Copyright (c) 2015年 SearchPrefect. All rights reserved.
//

#import "HYTComposeController.h"
#import "HYTAccountTool.h"
#import "HYTTextView.h"
#import "HYTComposeToolbar.h"

@interface HYTComposeController () <HYTComposeToolbarDelegate, UITextViewDelegate>

@property (nonatomic, weak) HYTTextView *textView;
@property (nonatomic, strong) HYTComposeToolbar *toolbar;

@end

@implementation HYTComposeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.view setBackgroundColor:[UIColor whiteColor]];

    [self setupNavInfo];
    
    [self setupToolbar];
    
    [self setupTextView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setupNavInfo {
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(cancelCompose)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(sendCompose)];
//    self.navigationItem.rightBarButtonItem.enabled = NO;
    [self.navigationItem.rightBarButtonItem setEnabled:NO];
    
    NSLog(@"%@ \n %@",  [[self.navigationItem rightBarButtonItem] titleTextAttributesForState:UIControlStateNormal],
                        [[self.navigationItem rightBarButtonItem] titleTextAttributesForState:UIControlStateDisabled]);
    
    NSString *accountName = [HYTAccountTool accountInfo].accountScreenName ? : @"";
    NSString *titleStr = @"发微博";
    NSString *navString = titleStr;
    if (accountName.length) {
        navString = [NSString stringWithFormat:@"%@\n%@", titleStr, accountName];
    }
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:navString];
    [attString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:17] range:[navString rangeOfString:titleStr]];
    [attString addAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14],
                               NSForegroundColorAttributeName : HYTCOLOR(164, 164, 164)}
                       range:[navString rangeOfString:accountName]];
    UILabel *navTitleView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    [navTitleView setNumberOfLines:0];
    [navTitleView setTextAlignment:NSTextAlignmentCenter];
    [navTitleView setAttributedText:attString];
    self.navigationItem.titleView = navTitleView;
}

- (void)setupTextView {
    
    HYTTextView *textView = [[HYTTextView alloc] init];
    textView.placeholder = @"分享新鲜事...";
    [textView setFrame:self.view.bounds];
    [textView setAlwaysBounceVertical:YES];
    [textView setDelegate:self];
    [self.view addSubview:textView];
    self.textView = textView;
    
}

- (void)setupToolbar {
    
    HYTComposeToolbar *toolbar = [HYTComposeToolbar toolbar];
    CGFloat toolbarHeight = 44;
    [toolbar setFrame:CGRectMake(0, 0, self.view.width, toolbarHeight)];
    [toolbar setDelegate:self];
//    [self.view addSubview:toolbar];
    self.toolbar = toolbar;
}

#pragma mark HYTComposeToolbarDelegate
- (void)composeToolbar:(HYTComposeToolbar *)toolbar didSelectedItemType:(HYTComposeToolbarItemType)itemType {
    
    switch (itemType) {
        case HYTComposeToolbarItemPicture: {
            
            break;
        }
        case HYTComposeToolbarItemMention: {
            
            break;
        }
        case HYTComposeToolbarItemTrend: {
            
            break;
        }
        case HYTComposeToolbarItemEmoticon: {
            
            break;
        }
        case HYTComposeToolbarItemMore: {
            
            break;
        }
    }
}


#pragma mark UITextViewDelegate 
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [self.textView resignFirstResponder];
}
- (void)textViewDidChangeSelection:(UITextView *)textView {
    
    self.navigationItem.rightBarButtonItem.enabled = textView.hasText;
}

- (void)cancelCompose {
    
    NSLog(@"-----取消-----");
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)sendCompose {
    NSLog(@"-----发送-----");
}

- (void)keyboardWillShow:(NSNotification *)notification {
    
    self.textView.inputAccessoryView = self.toolbar;
    NSLog(@"");
}

- (void)keyboardDidShow:(NSNotification *)notification {
    
//    self.textView.inputAccessoryView = nil;
    CGFloat toolbarHeight = 44;
    [self.textView setFrame:CGRectMake(0, self.view.height = toolbarHeight, self.view.width, toolbarHeight)];
    NSLog(@"");
}

@end
