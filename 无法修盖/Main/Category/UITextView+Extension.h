//
//  UITextView+Extension.h
//  无法修盖
//
//  Created by HelloWorld on 16/1/27.
//  Copyright © 2016年 SearchPrefect. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (Extension)

- (void)insertAttributedText:(NSAttributedString *)attributedText;
- (void)insertAttributedText:(NSAttributedString *)attributedText willComplete:(void(^)(NSMutableAttributedString *insertedAttText))willComplete;
@end
