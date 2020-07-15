//
//  UIViewController+FunctionInit.h
//  yqjy
//
//  Created by admin on 2019/9/2.
//  Copyright © 2019 易起. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DateFormatterDefualt @"yyyy-MM-dd HH:mm:ss"
#define DateFormatterMonthToMinutes @"MM-dd HH:mm"
#define DateFormatterHourToSeconds @"HH:mm:ss"
#define DateFormatterYearToDay @"yyyy-MM-dd"

#define DateStringFromDate(date,formatter)   [NSDate dateStringFromDate:date dateFormatter:formatter]

@interface NSDate (Utility)
+(NSString *)nextDateStringSinceNowWithHMS:(NSString *)HMSStr;//根据给定时间获取下一个距离现在最近的日期
+(NSString *)dateString;//当前时间字符串
+(NSString *)dateStringWithDateFormatter:(NSString *)dateFormat;//当前时间字符串
+(NSString *)dateStringFromDate:(NSDate *)date dateFormatter:(NSString *)dateFormat;
+(NSInteger)timeSwitchTimestamp:(NSString *)formatTime;
+(NSInteger)timeSwitchIntervalWith:(NSString *)formatTime;
+(NSDate *)dateFromDateString:(NSString *)dateString;
+(NSDate *)dateFromDateString:(NSString *)dateString dateFormatter:(NSString *)dateFormat;
+ (NSString *)timeWithTimeIntervalString:(NSString *)timeString;
+ (NSString *)timeWithYearMonthString:(NSString *)timeString;
+ (NSString *)timeWithTimeIntervalToMinuteAndSecondString:(NSString *)timeString;
+ (NSString *)timeWithMonsYearString:(NSString *)timeString;
+ (NSString *)timeWithMonthDayString:(NSString *)timeString;
+ (NSString *)timeWithMonth_DayString:(NSString *)timeString;
+(NSInteger)timeSwitchWithYearMonthDay:(NSString *)formatTime;
+(NSString *)timeSwitchNoLineTimestamp:(NSString *)formatTime;
+ (NSString *)timeForUploadFormat:(NSString *)timeString;
+(NSString *)lastMonth;
+(NSString *)thisYear;
+(NSString *)thisMonth;
+(NSString *)thisWeekMonday;
+(NSString *)yesterday;
+(NSString *)today;
@end
