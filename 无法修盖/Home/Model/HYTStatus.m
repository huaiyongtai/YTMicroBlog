//
//  HYTStatus.m
//  无法修盖
//
//  Created by HelloWorld on 15/11/29.
//  Copyright (c) 2015年 SearchPrefect. All rights reserved.
//

#import "HYTStatus.h"
#import "MJExtension.h"

@implementation HYTStatus

+ (NSString *)mj_replacedKeyFromPropertyName121:(NSString *)propertyName {
    
    if ([propertyName isEqualToString:@"statusID"]) {
        return @"idstr";
    }
    
    if ([propertyName isEqualToString:@"pictures"]) {
        return @"pic_urls";
    }
    
    return [propertyName mj_underlineFromCamel];
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"pictures" : [HYTPicture class]};
}


//重写创建时间 (当前时间会变化，故重写getter方法，重新setter方法达不到实时效果=)
- (NSString *)createdAt {
    
    /*
     *  Wed Dec 23 22:47:56 +0800 2015  欧美时间
     *  小写的是数字（小时除外）， 大写的是字符串
     *  Wed(EEE-->星期几) Dec(MMM-->月份) 23(dd-->几号) 22(HH-->小时):51(mm-->分钟):19(ss-->秒) +0800(Z-->时区) 2015(yyyy-->年份)
     */
    
    //一、将字符串日记转化为Date时间
    NSDateFormatter *dateFmt = [[NSDateFormatter alloc] init];
    //1.真机要转换欧美时间时间，必须要说明。 模拟器可以不用
    dateFmt.locale = [NSLocale localeWithLocaleIdentifier:@"en_US"];
    //2.告诉dataFormat如何将_createdAt字符串解析成时间的格式date, 必须和字符串严格相同才能正常解析
    dateFmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    NSDate *createDate = [dateFmt dateFromString:_createdAt];
    
    NSDate *nowData = [NSDate date];
    
    //二、创建一个日历对象
    NSCalendar *nowCalendar = [NSCalendar currentCalendar];
    //1.指定要获取组成日期的哪些元素
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    //2.from createDate to nowData 的时间
    NSDateComponents *cmps = [nowCalendar components:unit fromDate:createDate toDate:nowData options:0];

    //三、判断日期确定返回
    //1.指定 特定的日期格式 将日期格式转化为字符串（该转换只将指定的日期字符转化，其余普通字符保留）
    NSString *showDateFmt = nil;
    
    if (/* DISABLES CODE */ (1)) {  //今年
        if ([nowCalendar isDateInYesterday:createDate]) {   //昨天
            showDateFmt = @"昨天 HH:mm";
        } else if ([nowCalendar isDateInToday:createDate]){ //今天
            if (是一小内以上) { //一小时以上
                showDateFmt = @"HH 小时前";
            } else if (一分钟以上) {  //一分钟以上
                showDateFmt = @"mm 分钟前";
            } else {
                showDateFmt = @"刚刚";
            }
        } else {
            showDateFmt = @"MMM-dd HH:mm";
        }
    } else {
        showDateFmt = @"yyyy-MMM-dd";
    }
    dateFmt.dateFormat = showDateFmt;
    return [dateFmt stringFromDate:createDate];
    
//    MBLog(@"%@----%@------%@",showDate, createDate, _createdAt);
    return @"1小时";
}


- (void)setSource:(NSString *)source {
    
//    _source = source;
    _source = @"我不是iPhone 10S Plus";
}




@end
