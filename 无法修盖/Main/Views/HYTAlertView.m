//
//  HYTAlertView.m
//  MP_FinanceApp
//
//  Created by HelloWorld on 15/9/7.
//  Copyright (c) 2015年 SearchPrefect. All rights reserved.
//

#import "HYTAlertView.h"

static CGFloat kContainerWitdth        = 200;
static CGFloat kContainerHeight        = 100;
static CGFloat kContainerMargin        = 50;
static CGFloat kContentMarginVertical  = 10;    //内容距离边框的水平距离
static CGFloat kContentMarginHorizonta = 20;    //内容距离边框的竖直距离
static CGFloat kContentPadding         = 10;    //文字与图片之间的间距

@interface HYTAlertView ()

//大的容器
@property (nonatomic, strong) UIView        *container;
@property (nonatomic, copy  ) NSString      *tipImageName;
@property (nonatomic, copy  ) NSString      *tipMsg;
@property (nonatomic, assign) ImagePosTypes postionType;

@end

@implementation HYTAlertView

//=========================直接显示===========================//
+ (void)showAlertMsg:(NSString *)msg {
    [self showAlertImage:nil msg:msg];
}
+ (void)showAlertImage:(NSString *)imageName {
    [self showAlertImage:imageName msg:nil];
}
+ (void)showAlertImage:(NSString *)imageName msg:(NSString *)msg {
    [self showAlertImage:imageName imagePosition:ImagePosTypeDefault msg:msg];
}
+ (void)showAlertImage:(NSString *)imageName imagePosition:(ImagePosTypes)postion msg:(NSString *)msg {
    HYTAlertView *alert = [HYTAlertView alertWithImage:imageName imagePosition:postion msg:msg];
    [alert showAndAutoHidden:1.0];
}

//=========================创建对象===========================//
+ (instancetype)alertWithMsg:(NSString *)msg {
    return [self alertWithImage:nil msg:msg];
}

+ (instancetype)alertWithImage:(NSString *)imageName {
    return [self alertWithImage:imageName msg:nil];
}

+ (instancetype)alertWithImage:(NSString *)imageName msg:(NSString *)msg {
    return [self alertWithImage:imageName imagePosition:ImagePosTypeDefault msg:msg];
}

+ (instancetype)alertWithImage:(NSString *)imageName imagePosition:(ImagePosTypes)postion msg:(NSString *)msg {
    return [[self alloc] initWithImage:imageName imagePosition:postion msg:msg];
}

- (instancetype)initWithImage:(NSString *)imageName imagePosition:(ImagePosTypes)postion msg:(NSString *)msg {
    
    if (self = [super init]) {
        _customView   = nil;
        _tipImageName = imageName;
        _postionType  = postion;
        _tipMsg       = msg;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        _contentRadius = YES;
        _hiddenDelay   = 0.9;
        CGFloat containerX = ([UIScreen mainScreen].bounds.size.width - kContainerWitdth) * 0.5;
        CGFloat containerY = ([UIScreen mainScreen].bounds.size.height - kContainerHeight) * 0.5;
        _contentRect = CGRectMake(containerX, containerY, kContainerWitdth, kContainerHeight);
        _contentBackgroundColor = [UIColor colorWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:0.95];
    }
    return self;
}

//懒加载containerView
- (UIView *)container {
    if (_container == nil) {
        
        _container = [[UIView alloc] init];
        [_container setBackgroundColor:self.contentBackgroundColor];
        [_container setFrame:self.contentRect];
        if (_contentRadius) {
            [_container.layer setMasksToBounds:self.contentRadius];
            [_container.layer setCornerRadius:10];
        }
        [self addSubview:_container];
    }
    return _container;
}

- (void)setContentRect:(CGRect)contentRect {
    
    _contentRect = contentRect;
    self.container.frame = contentRect;
}

- (void)setContentRadius:(BOOL)contentRadius {
    _contentRadius = contentRadius;
    
    [self.container.layer setMasksToBounds:contentRadius];
    [self.container.layer setCornerRadius:10];
}

- (NSDictionary *)tipMsgAttributes {
    if (_tipMsgAttributes == nil) {
        _tipMsgAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:17],
                              NSForegroundColorAttributeName:[UIColor whiteColor]};
    }
    return _tipMsgAttributes;
}

- (void)setTipMsgColor:(UIColor *)tipMsgColor {
    _tipMsgColor = tipMsgColor;
    [self.tipMsgAttributes setValue:tipMsgColor forKey:NSForegroundColorAttributeName];
}

- (void)setTipMsgFont:(UIFont *)tipMsgFont {
    _tipMsgFont = tipMsgFont;
    [self.tipMsgAttributes setValue:tipMsgFont forKey:NSFontAttributeName];
}

//重写自定义视图setter方法
- (void)setCustomView:(UIView *)customView {
    _customView = customView;
    [self.container setBounds:CGRectMake(0, 0, customView.frame.size.width, customView.frame.size.height)];
}

//显示
- (void)show {

    //创建遮盖、阻塞底层view的交互
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    [self setFrame:keyWindow.bounds];
    [self setHidden:NO];
    [keyWindow addSubview:self];
    
//    if ((![UIImage imageNamed:_tipImageName] || _tipImageName.length<=0) && !(_tipImageName==nil)) {
//        self.tipMsg = @"开发者!!!!你传入的图片名异常";
//        self.tipImageName = nil;
//    }
    
    //自定义视图 就直接显示自定义视图
    if (self.customView != nil) {
        [self.container addSubview:self.customView];
        return;
    }
    
    //显示图片和信息
    if (_tipMsg != nil && _tipImageName != nil) {
       [self showImageAndMsg];
    }
    
    //显示图片或者信息
    [self showImageOrMsg];
    return;
}

//显示并且在延迟delay秒后自动隐藏
- (void)showAndAutoHidden:(NSTimeInterval)delay {
    
    self.hiddenDelay = delay;
    
    [self show];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.hiddenDelay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self hiddenAndRemove:YES];
    });
}

//显示提示图片和提示信息
- (void)showImageAndMsg {
    
    UILabel *tipLabel = [[UILabel alloc] init];
    [tipLabel setText:_tipMsg];
    [tipLabel setFont:self.tipMsgAttributes[NSFontAttributeName]];
    [tipLabel setTextColor:self.tipMsgAttributes[NSForegroundColorAttributeName]];
    [tipLabel setTextAlignment:NSTextAlignmentCenter];
    [tipLabel setNumberOfLines:0];
    [self.container addSubview:tipLabel];
    
    UIImageView *tipImageView = [[UIImageView alloc] init];
    [tipImageView setImage:[UIImage imageNamed:_tipImageName]];
    [tipImageView setContentMode:UIViewContentModeScaleAspectFit];
    [self.container addSubview:tipImageView];
    
    CGSize tipLabelSize    = CGSizeZero;
    CGSize tipImageSize    = CGSizeZero;
    CGPoint tipLabelOrigin = CGPointZero;
    CGPoint tipImageOrigin = CGPointZero;
    
    if (self.postionType == ImagePosTypeLeft || self.postionType == ImagePosTypeRight) {
        
        CGFloat tipImageSizeFactor = (self.container.height - 2*kContentMarginHorizonta) / tipImageView.image.size.height;
        tipImageSize = CGSizeMake(tipImageView.image.size.width * tipImageSizeFactor, tipImageView.image.size.height * tipImageSizeFactor);
        NSStringDrawingOptions option = NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin  | NSStringDrawingUsesFontLeading;
        
        tipLabelSize = [_tipMsg boundingRectWithSize:CGSizeMake(self.container.width-tipImageSize.width-2*kContentMarginVertical, CGFLOAT_MAX)
                                             options:option
                                          attributes:self.tipMsgAttributes
                                             context:nil].size;
        
        CGFloat tipLabelOriginY = (CGRectGetHeight(self.container.bounds) - tipLabelSize.height) * 0.5;
        CGFloat tipImageOriginY = (CGRectGetHeight(self.container.bounds) - tipImageSize.height) * 0.5;
        
        CGFloat marginVertical = (CGRectGetWidth(self.container.bounds) - (tipImageSize.width + tipLabelSize.width + kContentPadding)) * 0.5;  //距离container的边距
        
        if (self.postionType == ImagePosTypeLeft) {
            tipImageOrigin = CGPointMake(marginVertical, tipImageOriginY);
            tipLabelOrigin = CGPointMake(tipImageOrigin.x+tipImageSize.width+kContentPadding, tipLabelOriginY);
        } else if (self.postionType == ImagePosTypeRight) {
            tipLabelOrigin = CGPointMake(marginVertical, tipLabelOriginY);
            tipImageOrigin = CGPointMake(tipLabelOrigin.x+tipLabelSize.width+kContentPadding, tipImageOriginY);
        }
        
    } else if (self.postionType == ImagePosTypeDefault || self.postionType == ImagePosTypeBottom) {

        NSStringDrawingOptions option = NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin  | NSStringDrawingUsesFontLeading;
        tipLabelSize = [_tipMsg boundingRectWithSize:CGSizeMake(self.container.width-2*kContentMarginVertical, CGFLOAT_MAX)
                                             options:option
                                          attributes:self.tipMsgAttributes
                                             context:nil].size;
        
        CGFloat tipImageSizeFactor = (self.container.height - 2*kContentMarginHorizonta) *0.5 / tipImageView.image.size.height;
        tipImageSize = CGSizeMake(tipImageView.image.size.width * tipImageSizeFactor, tipImageView.image.size.height * tipImageSizeFactor);
        
        CGFloat tipLabelX = (CGRectGetWidth(self.container.bounds) - tipLabelSize.width) * 0.5;
        CGFloat tipImageX = (CGRectGetWidth(self.container.bounds) - tipImageSize.width) * 0.5;

        CGFloat marginHorizonta = (CGRectGetHeight(self.container.bounds) - (tipImageSize.height + tipLabelSize.height + kContentPadding)) * 0.5;  //距离container的边距
        
        if (self.postionType == ImagePosTypeDefault) {
            tipImageOrigin = CGPointMake(tipImageX, marginHorizonta);
            tipLabelOrigin = CGPointMake(tipLabelX, tipImageOrigin.y + tipImageSize.height + kContentPadding);
            
        } else if (self.postionType == ImagePosTypeBottom) {
            tipLabelOrigin = CGPointMake(tipLabelX, marginHorizonta);
            tipImageOrigin = CGPointMake(tipImageX, tipLabelOrigin.y + tipLabelSize.height + kContentPadding);
        }
    }

    [tipLabel setSize:tipLabelSize];
    [tipLabel setOrigin:tipLabelOrigin];
    
    [tipImageView setSize:tipImageSize];
    [tipImageView setOrigin:tipImageOrigin];
}

//显示提示image或者提示msg
- (void)showImageOrMsg {
    
    CGSize contentSize = CGSizeZero;
    
    UIView *contentView = nil;
    if ( _tipMsg.length>0 ) {
        UILabel *tipLabel = [[UILabel alloc] init];
        [tipLabel setText:_tipMsg];
        [tipLabel setFont:self.tipMsgAttributes[NSFontAttributeName]];
        [tipLabel setTextColor:self.tipMsgAttributes[NSForegroundColorAttributeName]];
        [tipLabel setNumberOfLines:0];
        [tipLabel setTextAlignment:NSTextAlignmentCenter];
        contentView = tipLabel;

        NSStringDrawingOptions option = NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin  | NSStringDrawingUsesFontLeading;
        CGSize realSize = [_tipMsg boundingRectWithSize:CGSizeMake(self.container.width-2*kContentMarginVertical, CGFLOAT_MAX)
                                             options:option
                                          attributes:self.tipMsgAttributes
                                             context:nil].size;
        contentSize = CGSizeMake(realSize.width, CGRectGetHeight(self.container.bounds) - 2*kContentMarginHorizonta);
    } else {
        
        UIImageView *tipImageView = [[UIImageView alloc] init];
        [tipImageView setImage:[UIImage imageNamed:_tipImageName]];
        [tipImageView setContentMode:UIViewContentModeScaleAspectFit];
        contentView = tipImageView;
        
        CGFloat tipImageSizeFactor = (self.container.height-2*kContentMarginHorizonta) / tipImageView.image.size.height;
        contentSize = CGSizeMake(tipImageView.image.size.width*tipImageSizeFactor, tipImageView.image.size.height*tipImageSizeFactor);
        
    }
    
    CGFloat contentViewX = (CGRectGetWidth(self.container.bounds) - contentSize.width) * 0.5;
    CGFloat contentViewY = (CGRectGetHeight(self.container.bounds) - contentSize.height) * 0.5;
    
    [contentView setSize:contentSize];
    [contentView setOrigin:CGPointMake(contentViewX, contentViewY)];
    [self.container addSubview:contentView];
}

//隐藏并移除
- (void)hiddenAndRemove:(BOOL)animate {
    
    if (animate ==  NO) {
        self.hidden = YES;
        self.container = nil;
        [self removeFromSuperview];
        return;
    }
    
    [UIView animateWithDuration:1 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        self.hidden = YES;
        self.container = nil;
        [self removeFromSuperview];
    }];
}

- (void)hiddenAlert {
    [self hiddenAndRemove:NO];
}

//- (CGSize)textScaleSizeWithText:(NSString *)text {
//    
//    NSStringDrawingOptions option = NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin  | NSStringDrawingUsesFontLeading;
//    CGSize tempSize = [text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)
//                                         options:option
//                                      attributes:self.tipMsgAttributes
//                                         context:nil].size;
//    
//    CGFloat scaleFactore = 4/3;
//    CGFloat width = sqrt((tempSize.width * tempSize.height) / scaleFactore);
//    CGFloat height = width / scaleFactore;
//    if (height % tempSize.height) {
//        <#statements#>
//    }
//
//    return CGSizeMake(width, height);
//}

@end
