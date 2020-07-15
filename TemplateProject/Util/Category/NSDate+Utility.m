//
//  UIViewController+FunctionInit.h
//  yqjy
//
//  Created by admin on 2019/9/2.
//  Copyright © 2019 易起. All rights reserved.
//

#import "NSDate+Utility.h"

@implementation NSDate (Utility)
+(NSString *)nextDateStringSinceNowWithHMS:(NSString *)HMSStr//根据给定时间获取下一个距离现在最近的日期
{
    
    NSDate *todayDate = [NSDate dateTodayWithHMS:HMSStr];
    NSDate *nowDate = [NSDate date];
    NSString *dateString = [NSDate dateStringFromDate:todayDate];
    if (![todayDate isLaterDate:nowDate]) {
        NSDate *nextDate = [NSDate dateWithTimeInterval:(24*60*60) sinceDate:todayDate];
        dateString = [NSDate dateStringFromDate:nextDate];
    }
    return dateString;
}



+(NSString *)dateStringTodayWithHMS:(NSString *)HMSStr
{
    NSString *dateString = [NSDate dateStringWithDateFormatter:DateFormatterYearToDay];
    dateString = [NSString stringWithFormat:@"%@ %@",dateString,HMSStr];
    return dateString;
}

+(NSString *)dateString
{
    NSString *dateString = [NSDate dateStringWithDateFormatter:DateFormatterDefualt];
    return dateString;
}
+(NSString *)dateStringWithDateFormatter:(NSString *)dateFormat
{
    NSDate *date = [NSDate date];
    
    NSString *dateString = [NSDate dateStringFromDate:date dateFormatter:dateFormat];
    return dateString;
}

+(NSString *)dateStringFromDate:(NSDate *)date
{
    NSString *dateString = [NSDate dateStringFromDate:date dateFormatter:DateFormatterDefualt];
    return dateString;
}
+(NSString *)dateStringFromDate:(NSDate *)date dateFormatter:(NSString *)dateFormat
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = dateFormat;
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

+(NSDate *)dateTodayWithHMS:(NSString *)HMSStr
{
    NSString *todayDayString = [NSDate dateStringTodayWithHMS:HMSStr];
    NSDate *date = [NSDate dateFromDateString:todayDayString dateFormatter:DateFormatterDefualt];
    return date;
}
+(NSDate *)dateFromDateString:(NSString *)dateString
{
  return   [self dateFromDateString:dateString dateFormatter:DateFormatterDefualt];
}
+(NSDate *)dateFromDateString:(NSString *)dateString dateFormatter:(NSString *)dateFormat
{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = dateFormat;
    NSDate *date = [dateFormatter dateFromString:dateString];
    return date;
}

-(BOOL)isLaterDate:(NSDate *)anotherDate
{
    NSDate *laterDate = [self laterDate:anotherDate];
    if (laterDate==self) {
        return YES;
        
    }
    else
    {
        return NO;
    }
}

+(NSInteger)timeSwitchTimestamp:(NSString *)formatTime{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; //(@"YYYY-MM-dd hh:mm:ss") ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    
    NSDate* date = [formatter dateFromString:formatTime]; //------------将字符串按formatter转成nsdate
    //时间转时间戳的方法:
    NSInteger timeSp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] integerValue];
    return timeSp;
}

+(NSInteger)timeSwitchIntervalWith:(NSString *)formatTime{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    if (formatTime.length > 10) {
        [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    }else{
        [formatter setDateFormat:@"YYYY-MM-dd"];
    }
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    
    NSDate* date = [formatter dateFromString:formatTime]; //------------将字符串按formatter转成nsdate
    //时间转时间戳的方法:
    NSInteger timeSp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] integerValue];
    return timeSp;
}

+ (NSString *)timeWithTimeIntervalString:(NSString *)timeString
{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}


+(NSString *)timeSwitchNoLineTimestamp:(NSString *)formatTime{
      // 格式化时间
      NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
      formatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
      [formatter setDateStyle:NSDateFormatterMediumStyle];
      [formatter setTimeStyle:NSDateFormatterShortStyle];
      [formatter setDateFormat:@"yyyyMMdd"];
      
      // 毫秒值转化为秒
      NSDate* date = [NSDate dateWithTimeIntervalSince1970:[formatTime doubleValue]];
      NSString* dateString = [formatter stringFromDate:date];
      return dateString;
}



+ (NSString *)timeForUploadFormat:(NSString *)timeString
{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyyMMddhhmmsss"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}

+ (NSString *)timeWithMonsYearString:(NSString *)timeString
{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}

+ (NSString *)timeWithMonthDayString:(NSString *)timeString
{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"MMdd"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}

+ (NSString *)timeWithMonth_DayString:(NSString *)timeString
{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"MM-dd"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}

+ (NSString *)timeWithTimeIntervalToMinuteAndSecondString:(NSString *)timeString
{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"hh:mm"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}

+(NSInteger)timeSwitchWithYearMonthDay:(NSString *)formatTime{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"]; //(@"YYYY-MM-dd hh:mm:ss") ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    
    NSDate* date = [formatter dateFromString:formatTime]; //------------将字符串按formatter转成nsdate
    //时间转时间戳的方法:
    NSInteger timeSp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] integerValue];
    return timeSp;
}

+(NSString *)today{
    return [NSDate timeWithTimeIntervalString:[NSString stringWithFormat:@"%ld",time(NULL)*1000]];
}

+(NSString *)yesterday{
    return [NSDate timeWithTimeIntervalString:[NSString stringWithFormat:@"%ld",(time(NULL)-24*3600)*1000]];
}

+(NSString *)thisWeekMonday{
    // 计算当前时间
    time_t timeinterval = time(NULL);
    // 计算当前时间对应个各个信息的结构体（结构体内包含了所需的各种信息）
    struct tm *info = localtime(&timeinterval);
    NSInteger monday = 0;
    //因为咱们计算周的开始一般是周一到周末，如果==0  说明是周末，应该从今天往前推七天。
    if (info->tm_wday == 0) {
        monday = timeinterval - 7*24*3600;
    }else{
        monday = timeinterval - (info->tm_wday-1)*24*3600;
    }
    
    return [NSDate timeWithTimeIntervalString:[NSString stringWithFormat:@"%ld",monday*1000]];
}

+(NSString *)thisMonth{
    time_t timeinterval = time(NULL);
    struct tm *info = localtime(&timeinterval);
    NSInteger monday = timeinterval - (info->tm_mday-1)*24*3600;
    
    return [NSDate timeWithTimeIntervalString:[NSString stringWithFormat:@"%ld",monday*1000]];
}

+(NSString *)lastMonth{
    time_t timeinterval = time(NULL);
    struct tm *info = localtime(&timeinterval);
    NSInteger month = info->tm_mon;
    //上月月初时间戳
    NSInteger lastMonFirstDay = 0;
    //本月月初时间戳
    NSInteger lastMonthInterval = (timeinterval - info->tm_mday*24*3600);
    if (month == 1 || month == 3  || month == 5 || month == 7 || month == 8 || month == 10 || month== 12) {
        lastMonFirstDay = (lastMonthInterval - 30 * 24*3600);
    }else{
        lastMonFirstDay = (lastMonthInterval - 29 * 24*3600);
    }
    NSString *monFirst = [NSDate timeWithTimeIntervalString:[NSString stringWithFormat:@"%ld",lastMonFirstDay*1000]];
    return monFirst;
}

+(NSString *)thisYear{
    time_t timeInterval = time(NULL);
    struct tm *stm = localtime(&timeInterval);
    NSInteger days = timeInterval - stm->tm_yday*24*3600;
    return [NSDate timeWithTimeIntervalString:[NSString stringWithFormat:@"%ld",days*1000]];
}

@end
