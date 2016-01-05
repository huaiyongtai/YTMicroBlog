//
//  HYTAlertView.h
//  MP_FinanceApp
//
//  Created by HelloWorld on 15/9/7.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ImagePosTypes) {
    ImagePosTypeDefault,     //图片独占一行，居上 默认
    ImagePosTypeLeft,        //图片居左
    ImagePosTypeRight,       //图片居右
    ImagePosTypeBottom       //图片独占一行，居下
};

@interface HYTAlertView : UIView

/** 用户自定提示信息的视图*/
@property (nonatomic, strong) UIView       *customView;

/** 显示区域的Rect 可不设置默认居中 width: height: */
@property (nonatomic, assign) CGRect       contentRect;
/** 显示区域的的背景色 可不设置默认居中 width: height: */
@property (nonatomic, strong) UIColor      *contentBackgroundColor;

/** 显示区域是否是圆角, 默认为 YES */
@property (nonatomic, assign, getter = isContentRadius) BOOL contentRadius;

/** 设置提示文字的属性 */
@property (nonatomic, strong) NSDictionary *tipMsgAttributes;
/** 设置提示文字颜色 */
@property (nonatomic, strong) UIColor      *tipMsgColor;
//设置提示文字
@property (nonatomic, strong) UIFont       *tipMsgFont;
//
@property (nonatomic, assign) NSTimeInterval hiddenDelay;

//显示
- (void)show;

//显示并在delay秒后自动隐藏, 传入0为时则默认时间0.8秒
- (void)showAndAutoHidden:(NSTimeInterval)delay;

//直接隐藏
- (void)hiddenAlert;

//隐藏并移除,是否需要动画效果
- (void)hiddenAndRemove:(BOOL)animate;

//你可以快速创建你要显示的对象，推荐使用以下方法创建对象
+ (instancetype)alertWithMsg:(NSString *)msg;
+ (instancetype)alertWithImage:(NSString *)imageName;
+ (instancetype)alertWithImage:(NSString *)imageName msg:(NSString *)msg;
+ (instancetype)alertWithImage:(NSString *)imageName imagePosition:(ImagePosTypes)postion msg:(NSString *)msg;

- (instancetype)initWithImage:(NSString *)imageName imagePosition:(ImagePosTypes)postion msg:(NSString *)msg;

//======================直接显示=======================//
+ (void)showAlertMsg:(NSString *)msg;
+ (void)showAlertImage:(NSString *)imageName;
+ (void)showAlertImage:(NSString *)imageName msg:(NSString *)msg;
+ (void)showAlertImage:(NSString *)imageName imagePosition:(ImagePosTypes)postion msg:(NSString *)msg;

@end
