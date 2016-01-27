//
//  HYTComposeController.m
//  无法修盖
//
//  Created by HelloWorld on 15/12/31.
//  Copyright (c) 2015年 SearchPrefect. All rights reserved.
//

#import "HYTComposeController.h"
#import "HYTAccountTool.h"
#import "HYTEmoticonTextView.h"
#import "HYTComposeToolbar.h"
#import "HYTComposePicturesView.h"
//#import "AFNetworking.h"
#import "HYTEmoticonKeyboardView.h"
#import "HYTEmoticon.h"
#import "HYTTextAttachment.h"

@interface HYTComposeController () <HYTComposeToolbarDelegate, UITextViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate>

@property (nonatomic, weak  ) HYTEmoticonTextView     *textView;
@property (nonatomic, strong) HYTComposeToolbar       *toolbar;
@property (nonatomic, strong) HYTEmoticonKeyboardView *emoticonKeyboardView;
@property (nonatomic, assign, getter = isSwitchingKeyboard) BOOL switchingKeyboard;


@property (nonatomic, weak  ) HYTComposePicturesView *picturesView;

@end

@implementation HYTComposeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];

    [self setupNavInfo];
    
    /**注意:子控件添加的顺序，必须先添加自定义textView 再添加toolbar，若textView后添加 self.automaticallyAdjustsScrollViewInsets=YES将失效，并且可能会遮挡toolbar显示*/
    [self setupTextView];
    
    [self setupToolbar];
    
}
- (void)dealloc {
    NSLog(@"HYTComposeController 被释放");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (HYTComposePicturesView *)picturesView {
    
    if (_picturesView == nil) {
        HYTComposePicturesView *picturesView = [HYTComposePicturesView picturesView];
        [picturesView setFrame:CGRectMake(0, 100, self.view.width, self.view.height)];
        [self.textView addSubview:picturesView];
        _picturesView = picturesView;
    }
    return _picturesView;
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
    [self.navigationItem.rightBarButtonItem setEnabled:NO];
    
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
    
    HYTEmoticonTextView *textView = [[HYTEmoticonTextView alloc] init];
    textView.placeholder = @"分享新鲜事...";
    [textView setFrame:self.view.bounds];
    [textView setAlwaysBounceVertical:YES];
    [textView setDelegate:self];
    [textView becomeFirstResponder];
    [self.view addSubview:textView];
    self.textView = textView;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillChangeFrame:)
                                                 name:UIKeyboardWillChangeFrameNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(emoticonDidSelected:)
                                                 name:HYTEmoticonDidSelectedNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(emoticonDeleteDidSelected:)
                                                 name:HYTEmoticonDeleteDidSelectedNotification
                                               object:nil];
    
}
- (void)setupToolbar {
    
    HYTComposeToolbar *toolbar = [HYTComposeToolbar toolbar];
    CGFloat toolbarHeight = 44;
    [toolbar setFrame:CGRectMake(0, self.view.height-toolbarHeight, self.view.width, toolbarHeight)];
    [toolbar setDelegate:self];
    [self.view addSubview:toolbar];
    self.toolbar = toolbar;
}

- (void)cancelCompose {
    
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)emoticonDidSelected:(NSNotification *)emoticonNotification {
    
    HYTEmoticon *emoticon = emoticonNotification.userInfo[HYTEmoticonDidSelectedKey];
    [self.textView insertEmoticon:emoticon];;
}

- (void)emoticonDeleteDidSelected:(NSNotification *)deleteNotification {
    [self.textView deleteBackward];
}
- (void)sendCompose {
    
    NSString *statusText = self.textView.plainText; {
        if (statusText.length == 0) {
            [HYTAlertView showAlertImage:@"请输入合法字符"];
            return;
        }
    }
    
    if (self.picturesView.pictures.count) {
        [self sendAttachImageOfComposeStateWithText:statusText];
    } else {
        [self sendPlainTextOfComposeStateStateWithText:statusText];
    }
}

#pragma mark - 发送带有图片的微博
- (void)sendAttachImageOfComposeStateWithText:(NSString *)stutusText {
    
    /*
    https://upload.api.weibo.com/2/statuses/upload.json //上传图片并发布一条新微博
    
    access_token 	false 	string 	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
    status 	true 	string 	要发布的微博文本内容，必须做URLencode，内容不超过140个汉字。
    visible 	false 	int 	微博的可见性，0：所有人能看，1：仅自己可见，2：密友可见，3：指定分组可见，默认为0。
    list_id 	false 	string 	微博的保护投递指定分组ID，只有当visible参数为3时生效且必选。
    pic 	true 	binary 	要上传的图片，仅支持JPEG、GIF、PNG格式，图片大小小于5M。
    */
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"status"] = stutusText;
    HYTAccount *account = [HYTAccountTool accountInfo];
    parameters[@"access_token"] = account.accessToken;
        NSData *picData = ({
        UIImage *firstImage = [self.picturesView.pictures firstObject];
        UIImageJPEGRepresentation(firstImage, 0.5);
    });
    
    NSMutableArray *files = [NSMutableArray array];
    for (int index=0; index<3; index++) {
        HYTHttpUpload *upload = [[HYTHttpUpload alloc] init];
        upload.fileData = picData;
        upload.name = @"pic";
        upload.mimeType = @"image/jpeg";
        upload.fileName = [NSString stringWithFormat:@"asdfa%i", arc4random_uniform(2)];
        [files addObject:upload];
    }
    [HYTHttpTool post:@"https://upload.api.weibo.com/2/statuses/upload.json"
           parameters:parameters
                files:files
              success:^(id responseObject) {
                  [HYTAlertView showAlertMsg:@"发送成功"];
                  [self dismissViewControllerAnimated:YES completion:nil];
              } failure:^(NSError *error) {
                  [HYTAlertView showAlertMsg:@"发送失败"];
              }
     ];
}

#pragma mark 发送纯文本微博
- (void)sendPlainTextOfComposeStateStateWithText:(NSString *)stutusText {
    /*
     https://api.weibo.com/2/statuses/update.json        //发布一条新微博
     access_token 	false 	string 	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
     status 	true 	string 	要发布的微博文本内容，必须做URLencode，内容不超过140个汉字。
     visible 	false 	int 	微博的可见性，0：所有人能看，1：仅自己可见，2：密友可见，3：指定分组可见，默认为0。
     list_id 	false 	string 	微博的保护投递指定分组ID，只有当visible参数为3时生效且必选。
     pic 	true 	binary 	要上传的图片，仅支持JPEG、GIF、PNG格式，图片大小小于5M。
     */
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"status"] = stutusText;
    HYTAccount *account = [HYTAccountTool accountInfo];
    parameters[@"access_token"] = account.accessToken;
    
    [HYTHttpTool post:@"https://api.weibo.com/2/statuses/update.json"
           parameters:parameters success:^(id responseObject) {
               [HYTAlertView showAlertMsg:@"发送成功"];
               [self dismissViewControllerAnimated:YES completion:nil];
           } failure:^(NSError *error) {
               [HYTAlertView showAlertMsg:@"发送失败"];
               [self dismissViewControllerAnimated:YES completion:nil];
           }
     ];
}

#pragma mark - 懒加载
- (HYTEmoticonKeyboardView *)emoticonKeyboardView {
    
    if (_emoticonKeyboardView == nil) {
        
        HYTEmoticonKeyboardView *emoticonKeyboardView = [HYTEmoticonKeyboardView emoticonKeyboard];
        [emoticonKeyboardView setFrame:CGRectMake(0, 0, self.view.width, 216)];
        _emoticonKeyboardView = emoticonKeyboardView;
    }
    return _emoticonKeyboardView;
}

#pragma mark - HYTComposeToolbarDelegate
- (void)composeToolbar:(HYTComposeToolbar *)toolbar didSelectedItemType:(HYTComposeToolbarItemType)itemType {
    
    switch (itemType) {
        case HYTComposeToolbarItemPicture: {
            [self.textView resignFirstResponder];
            [self inputImageFromPhone];
            break;
        }
        case HYTComposeToolbarItemMention: {
            
            break;
        }
        case HYTComposeToolbarItemTrend: {
            
            break;
        }
        case HYTComposeToolbarItemEmoticon: {
            [self switchKeyboard];
            break;
        }
        case HYTComposeToolbarItemMore: {
            
            break;
        }
    }
}

#pragma mark 切换键盘（系统键盘-表情键盘）
- (void)switchKeyboard {
    
    if (self.textView.inputView) {
        self.textView.inputView = nil;
        self.toolbar.itemShowKeyBoard = NO;
    } else {
        self.textView.inputView = self.emoticonKeyboardView;
        self.toolbar.itemShowKeyBoard = YES;
    }
    
    //1.标识切换键盘
    self.switchingKeyboard = YES;
    //2.退出键盘
    [self.textView resignFirstResponder];
    
    //3.标识键盘退出结束
    self.switchingKeyboard = NO;
    //4.交出键盘
    [self.textView becomeFirstResponder];
}

#pragma mark - UITextViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.textView resignFirstResponder];
}
- (void)textViewDidChangeSelection:(UITextView *)textView {
    
    self.navigationItem.rightBarButtonItem.enabled = textView.hasText;
}

#pragma mark - 键盘Frame改变通知
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
    
//    BOOL isShowkeyboard = [notification.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue].origin.y < SCREEN_HEIGHT;
    if (self.isSwitchingKeyboard) return;
    
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
                     } completion:nil];
}

- (void)inputImageFromPhone {
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"图片选择"
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:@"手机拍照", @"相册", nil];
    [sheet showInView:self.view];
    
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    //在下面代理方法中的keyWindow 是，_UIAlertControllerShimPresenterWindow 他会Dismiss掉，随意提示框应该在它Dismiss后加到不会Dismiss的keyWindow上
    //- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
    
    if (buttonIndex > 1) return;
    
    UIImagePickerControllerSourceType sourceType = 0;
    if (buttonIndex == 0) {
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            [HYTAlertView showAlertMsg:@"照相机不可用"];
            return;
        }
        sourceType = UIImagePickerControllerSourceTypeCamera;
    } else if (buttonIndex == 1) {
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            [HYTAlertView showAlertMsg:@"相册不可用"];
            return;
        }
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    UIImagePickerController *imagePickerVC = [[UIImagePickerController alloc] init];
    imagePickerVC.sourceType = sourceType;
    imagePickerVC.delegate = self;
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

#pragma mark - UINavigationControllerDelegate, UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {

    NSString *key = info[UIImagePickerControllerReferenceURL];
    UIImage *valueImage = info[UIImagePickerControllerOriginalImage];
    [self.picturesView addImageWithKey:key valueImage:valueImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    MBLog(@"已取消相册选择图片");
    [picker dismissViewControllerAnimated:YES completion:nil];
}


@end
