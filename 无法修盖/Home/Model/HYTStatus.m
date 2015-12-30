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
    return @{@"pictures" : [HYTStatusPicture class]};
}


//重写创建时间 (当前时间会变化，故重写getter方法，重新setter方法达不到实时效果=)
- (NSString *)createdAt {
    
    /*
     *  Wed Dec 23 22:47:56 +0800 2015  欧美时间
     *  小写的是数字（大体是）， 大写的是字符串
     *  Wed(EEE-->星期几) Dec(MMM-->月份) 23(dd-->几号) 22(HH-->小时):51(mm-->分钟):19(ss-->秒) +0800(Z-->时区) 2015(yyyy-->年份)
     */
    //具体
    /** 关于时间
     {
     G -- 纪元
     一般会显示公元前(BC)和公元(AD)
     
     y -- 年
     假如是2013年，那么yyyy=2013，yy=13
     
     M -- 月
     假如是3月，那么M=3，MM=03，MMM=Mar，MMMM=March
     假如是11月，那么M=11，MM=11，MMM=Nov，MMMM=November
     
     w -- 年包含的周
     假如是1月8日，那么w=2(这一年的第二个周)
     
     W -- 月份包含的周(与日历排列有关)
     假如是2013年4月21日，那么W=4(这个月的第四个周)
     
     F -- 月份包含的周(与日历排列无关)
     和上面的W不一样，F只是单纯以7天为一个单位来统计周，例如7号一定是第一个周，15号一定是第三个周，与日历排列无关。
     
     D -- 年包含的天数
     假如是1月20日，那么D=20(这一年的第20天)
     假如是2月25日，那么D=31+25=56(这一年的第56天)
     
     d -- 月份包含的天数
     假如是5号，那么d=5，dd=05
     假如是15号，那么d=15，dd=15
     
     E -- 星期
     假如是星期五，那么E=Fri，EEEE=Friday
     
     a -- 上午(AM)/下午(PM)
     
     H -- 24小时制，显示为0--23
     假如是午夜00:40，那么H=0:40，HH=00:40
     h -- 12小时制，显示为1--12
     假如是午夜00:40，那么h=12:40
     
     K -- 12小时制，显示为0--11
     假如是午夜00:40，那么K=0:40，KK=00:40
     k -- 24小时制，显示为1--24
     假如是午夜00:40，那么k=24:40
     
     m -- 分钟
     假如是5分钟，那么m=5，mm=05
     假如是45分钟，那么m=45，mm=45
     
     s -- 秒
     假如是5秒钟，那么s=5，ss=05
     假如是45秒钟，那么s=45，ss=45
     S -- 毫秒
     一般用SSS来显示
     
     z -- 时区
     表现形式为GMT+08:00
     Z -- 时区
     表现形式为+0800
     
     *注
     在调用setDateFormat设置格式化字符串时，可以加入一些别的字符串，用单引号来引入，例如：
     [formatter setDateFormat:@"yyyy-MM-dd 'some ''special'' string' HH:mm:ss"];
     )
     */
    
    
    //一、将字符串日记转化为Date时间
    NSDateFormatter *dateFmt = [[NSDateFormatter alloc] init];
    //1.真机要转换欧美时间时间，必须要说明。 模拟器可以不用
    dateFmt.locale = [NSLocale localeWithLocaleIdentifier:@"en_US"];
    //2.告诉dataFormat如何将_createdAt字符串解析成时间的格式date, 必须和字符串严格相同才能正常解析
    dateFmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    NSDate *createDate = [dateFmt dateFromString:_createdAt];
    
    NSDate *nowData = [NSDate date];
    
    //二、创建一个历法对象
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //1.指定要获取组成日期的哪些元素
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    //2.from createDate to nowData 的时间
    NSDateComponents *cmps = [calendar components:unit fromDate:createDate toDate:nowData options:0];

    //三、判断日期确定返回
    //1.指定 特定的日期格式 将日期格式转化为字符串（该转换只将指定的日期字符转化，其余普通字符保留）
    NSString *showDateFmt = nil;
    
    if ([self isThisYear:createDate]) {  //今年
        if ([calendar isDateInYesterday:createDate]) {   //昨天
            showDateFmt = @"'昨天' HH:mm";
        } else if ([calendar isDateInToday:createDate]){ //今天
            if (cmps.hour > 0) { //一小时以上
                showDateFmt = [NSString stringWithFormat:@"'%li小时前'", cmps.hour];
            } else if (cmps.minute >= 1) {  //一分钟以上
                showDateFmt = [NSString stringWithFormat:@"'%li分钟前'", cmps.minute];
            } else {
                showDateFmt = @"'刚刚'";
            }
        } else {
            showDateFmt = @"MMM-dd HH:mm";
        }
    } else {
        showDateFmt = @"yyyy-MMM-dd";
    }
    
    dateFmt.dateFormat = showDateFmt;
    return [dateFmt stringFromDate:createDate];
}
/** 判断是否是今年 */
- (BOOL)isThisYear:(NSDate *)date {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *dateCmps = [calendar components:NSCalendarUnitYear fromDate:date];
    NSDateComponents *nowCmps = [calendar components:NSCalendarUnitYear fromDate:[NSDate date]];
    
    return dateCmps.year == nowCmps.year;
}

- (void)setSource:(NSString *)source {
    /*
    <a href="http://app.weibo.com/t/feed/5yiHuw" rel="nofollow">iPhone 6 Plus</a>
    <a href="http://app.weibo.com/t/feed/68lh5N" rel="nofollow">威锋网</a>
    <a href="http://weibo.com/" rel="nofollow">微博 weibo.com</a>
     */
    
    NSRange startRange = [source rangeOfString:@"\">"];
    NSRange endRange = [source rangeOfString:@"</a>" options:NSBackwardsSearch];
    
    NSInteger sourceLocation = startRange.location + startRange.length;
    NSInteger sourceLength = endRange.location - startRange.location - startRange.length;
    if (sourceLength < 0) {
        sourceLength = 0;
    }
    _source =  [NSString stringWithFormat:@"来自%@", [source substringWithRange:NSMakeRange(sourceLocation, sourceLength)]];
}

@end
