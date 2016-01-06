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
#import "HYTComposePicturesView.h"
#import "AFNetworking.h"

@interface HYTComposeController () <HYTComposeToolbarDelegate, UITextViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate>

@property (nonatomic, weak  ) HYTTextView       *textView;
@property (nonatomic, strong) HYTComposeToolbar *toolbar;


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

- (void)cancelCompose {
    
    NSLog(@"-----取消-----");
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)sendCompose {
    
    /*
    https://api.weibo.com/2/statuses/update.json        //发布一条新微博
    https://upload.api.weibo.com/2/statuses/upload.json //上传图片并发布一条新微博
    
    access_token 	false 	string 	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
    status 	true 	string 	要发布的微博文本内容，必须做URLencode，内容不超过140个汉字。
    visible 	false 	int 	微博的可见性，0：所有人能看，1：仅自己可见，2：密友可见，3：指定分组可见，默认为0。
    list_id 	false 	string 	微博的保护投递指定分组ID，只有当visible参数为3时生效且必选。
    pic 	true 	binary 	要上传的图片，仅支持JPEG、GIF、PNG格式，图片大小小于5M。
    */
    
    NSString *stutusText = ({
        NSString *stutusText = self.textView.text;
        if (stutusText.length == 0 || stutusText.length > 140) {
            [HYTAlertView showAlertImage:@"请输入合法字符"];
            return;
        }
        stutusText;
    });
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"status"] = stutusText;
    HYTAccount *account = [HYTAccountTool accountInfo];
    parameters[@"access_token"] = account.accessToken;
    
    NSData *picData = ({
        UIImage *firstImage = [self.picturesView.pictures firstObject];
        UIImageJPEGRepresentation(firstImage, 0.5);
    });
    
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    if (!picData.length) {  //无图片
        [manger POST:@"https://api.weibo.com/2/statuses/update.json"
          parameters:parameters
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 
                 MBLog(@"success:%@", responseObject);
             }
             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 NSLog(@"error:%@", error);
             }
         ];
        return;
    }
    
    [manger POST:@"https://upload.api.weibo.com/2/statuses/upload.json"
      parameters:parameters constructingBodyWithBlock:^(id <AFMultipartFormData> formData) {
          
          [formData appendPartWithFileData:picData name:@"pic" fileName:@"helloworld.jpg" mimeType:@"image/jpeg"];
      }
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             MBLog(@"success:%@", responseObject);
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"error:%@", error);
         }
     ];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark HYTComposeToolbarDelegate
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
            [HYTAlertView showAlertMsg:@"照相机不可用"];
            break;
        }
        case HYTComposeToolbarItemMore: {
            
            break;
        }
    }
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
