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
    
    /**注意:子控件添加的顺序，必须先添加自定义textView 再添加toolbar，若textView后添加 self.automaticallyAdjustsScrollViewInsets=YES将失效，并且可能会遮挡toolbar显示*/
    
    [self setupTextView];
    
    [self setupToolbar];
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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
}

- (void)setupToolbar {
    
    HYTComposeToolbar *toolbar = [HYTComposeToolbar toolbar];
    CGFloat toolbarHeight = 44;
    [toolbar setFrame:CGRectMake(0, self.view.height-toolbarHeight, self.view.width, toolbarHeight)];
    [toolbar setDelegate:self];
    [self.view addSubview:toolbar];
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

- (void)keyboardWillChangeFrame:(NSNotification *)notification {
    /*
     *  UIKeyboardAnimationCurveUserInfoKey = 7;
     *  UIKeyboardAnimationDurationUserInfoKey = "0.25";
     *  UIKeyboardBoundsUserInfoKey = "NSRect: {{0, 0}, {320, 253}}";
     *  UIKeyboardCenterBeginUserInfoKey = "NSPoint: {160, 372}";
     *  UIKeyboardCenterEndUserInfoKey = "NSPoint: {160, 353.5}";
     *  UIKeyboardFrameBeginUserInfoKey = "NSRect: {{0, 264}, {320, 216}}";
     *  UIKeyboardFrameEndUserInfoKey = "NSRect: {{0, 227}, {320, 253}}";
     */
    
    NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationOptions animationOption = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    CGFloat endKeyboardY = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
    
    if (endKeyboardY >= SCREEN_HEIGHT) {
        endKeyboardY = SCREEN_HEIGHT;
    }
    CGFloat endToolbarY = endKeyboardY - self.toolbar.height;
    CGRect endToolbarRect = CGRectMake(0, endToolbarY, self.toolbar.width, self.toolbar.height);
    [UIView animateWithDuration:duration
                          delay:0
                        options:animationOption
                     animations:^{
                         [self.toolbar setFrame:endToolbarRect];
                     }
                     completion:nil];
}

@end
