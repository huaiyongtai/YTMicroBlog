//
//  HYTHttpUpload.h
//  无法修盖
//
//  Created by HelloWorld on 16/1/27.
//  Copyright © 2016年 SearchPrefect. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYTHttpUpload : NSObject

/** 文件Data */
@property (nonatomic, copy) NSData   *fileData;

/** 服务端接受参数名 */
@property (nonatomic, copy) NSString *name;

/** 上传文件名 */
@property (nonatomic, copy) NSString *fileName;

/** 文件类型 */
@property (nonatomic, copy) NSString *mimeType;

@end
