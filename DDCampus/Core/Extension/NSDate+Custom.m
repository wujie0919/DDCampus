//
//  NSDate+Custom.m
//  YCBiOSClient
//
//  Created by Aaron on 15/12/2.
//  Copyright © 2015年 ycb. All rights reserved.
//

#import "NSDate+Custom.h"

@implementation NSDate (Custom)

/**********************************************************************/
#pragma mark Decomposing Dates
/**********************************************************************/

- (NSInteger)year{
    NSDateComponents *components = COMPONENTS(self);
    return components.year;
}

- (NSInteger)month{
    NSDateComponents *components = COMPONENTS(self);
    return components.month;
}

- (NSInteger)weekOfYear{
    NSDateComponents *components = COMPONENTS(self);
    return components.weekOfYear;
}

- (NSInteger)weekOfMonth{
    NSDateComponents *components = COMPONENTS(self);
    return components.weekOfMonth;
}

- (NSInteger)weekday{
    NSDateComponents *components = COMPONENTS(self);
    return components.weekday;
}

- (NSInteger)day{
    NSDateComponents *components = COMPONENTS(self);
    return components.day;
}

- (NSInteger)hour{
    NSDateComponents *components = COMPONENTS(self);
    return components.hour;
}

- (NSInteger) minute{
    NSDateComponents *components = COMPONENTS(self);
    return components.minute;
}

- (NSInteger)seconds{
    NSDateComponents *components = COMPONENTS(self);
    return components.second;
}

/**********************************************************************/
#pragma mark Relative Dates
/**********************************************************************/

+ (NSDate *)dateWithWeeksFromNow:(NSUInteger)weeks{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSince1970] + D_WEEK * weeks;
    NSDate *newDate = [NSDate dateWithTimeIntervalSince1970:aTimeInterval];
    return newDate;
}
+ (NSDate *)dateWithWeeksBeforeNow:(NSUInteger)weeks{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSince1970] - D_WEEK * weeks;
    NSDate *newDate = [NSDate dateWithTimeIntervalSince1970:aTimeInterval];
    return newDate;
}

+ (NSDate *)dateWithDaysFromNow:(NSUInteger)days{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSince1970] + D_DAY * days;
    NSDate *newDate = [NSDate dateWithTimeIntervalSince1970:aTimeInterval];
    return newDate;
}

+ (NSDate *)dateWithDaysBeforeNow:(NSUInteger)days{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSince1970] - D_DAY * days;
    NSDate *newDate = [NSDate dateWithTimeIntervalSince1970:aTimeInterval];
    return newDate;
}

+ (NSDate *)dateWithHoursFromNow:(NSUInteger)hours{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSince1970] + D_HOUR * hours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSince1970:aTimeInterval];
    return newDate;
}

+ (NSDate *)dateWithHoursBeforeNow:(NSUInteger)hours{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSince1970] - D_HOUR * hours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSince1970:aTimeInterval];
    return newDate;
}

+ (NSDate *)dateWithMinutesFromNow:(NSUInteger)minutes{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSince1970] + D_MINUTE * minutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSince1970:aTimeInterval];
    return newDate;
}

+ (NSDate *)dateWithMinutesBeforeNow:(NSUInteger)minutes{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSince1970] - D_MINUTE * minutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSince1970:aTimeInterval];
    return newDate;
}

#pragma mark Comparing Dates

- (NSInteger)daysFrom1970{
    return ([self timeIntervalSince1970]+28800)/D_DAY;
}

- (NSInteger)weeksFrom1970{
    return ([self timeIntervalSince1970]+28800)/D_WEEK;
}

- (BOOL)isToday{
    NSInteger dateInterval = [self daysFrom1970];
    NSInteger nowInterval = [[NSDate date] daysFrom1970];
    return dateInterval==nowInterval;
}

- (BOOL)isYesterday{
    NSInteger dateInterval = [self daysFrom1970];
    NSInteger nowInterval = [[NSDate date] daysFrom1970];
    return dateInterval==nowInterval-1;
}

- (BOOL)isTomorrow{
    NSInteger dateInterval = [self daysFrom1970];
    NSInteger nowInterval = [[NSDate date] daysFrom1970];
    return dateInterval==nowInterval+1;
}

- (BOOL)isThisWeek{
    NSInteger dateInterval = [self weeksFrom1970];
    NSInteger nowInterval = [[NSDate date] weeksFrom1970];
    return dateInterval==nowInterval;
}

- (BOOL)isLastWeek{
    NSInteger dateInterval = [self weeksFrom1970];
    NSInteger nowInterval = [[NSDate date] weeksFrom1970];
    return dateInterval==nowInterval-1;
}

- (BOOL)isNextWeek{
    NSInteger dateInterval = [self weeksFrom1970];
    NSInteger nowInterval = [[NSDate date] weeksFrom1970];
    return dateInterval==nowInterval+1;
}

- (BOOL)isThisMonth{
    NSDateComponents *components1 = COMPONENTS(self);
    NSDateComponents *components2 = COMPONENTS([NSDate date]);;
    return ((components1.year == components2.year) &&
            (components1.month == components2.month));
}

- (BOOL)isNextMonth{
    NSDateComponents *components1 = COMPONENTS(self);
    NSDateComponents *components2 = COMPONENTS([NSDate date]);;
    if (components1.year == components2.year+1 && components1.month==1 && components2.month==12) {
        return YES;
    }
    return ((components1.year == components2.year) &&
            (components1.month == components2.month + 1));
}

- (BOOL)isLastMonth{
    NSDateComponents *components1 = COMPONENTS(self);
    NSDateComponents *components2 = COMPONENTS([NSDate date]);;
    if (components1.year == components2.year-1 && components1.month==12 && components2.month==1) {
        return YES;
    }
    return ((components1.year == components2.year) &&
            (components1.month == components2.month - 1));
}

- (BOOL)isThisYear{
    NSDateComponents *components1 = COMPONENTS(self);
    NSDateComponents *components2 = COMPONENTS([NSDate date]);;
    return (components1.year == (components2.year));
}

- (BOOL)isNextYear{
    NSDateComponents *components1 = COMPONENTS(self);
    NSDateComponents *components2 = COMPONENTS([NSDate date]);;
    return (components1.year == (components2.year + 1));
}

- (BOOL)isLastYear{
    NSDateComponents *components1 = COMPONENTS(self);
    NSDateComponents *components2 = COMPONENTS([NSDate date]);;
    return (components1.year == (components2.year - 1));
}

- (BOOL)isEarlierThanDate:(NSDate *)date{
    return ([self earlierDate:date] == self);
}

- (BOOL)isLaterThanDate:(NSDate *)date{
    return ([self laterDate:date] == self);
}

- (BOOL)isSameDayAsDate:(NSDate *)date{
    NSDateComponents *components1 = COMPONENTS(self);
    NSDateComponents *components2 = COMPONENTS(date);
    return ((components1.year == components2.year) &&
            (components1.month == components2.month) &&
            (components1.day == components2.day));
}

- (BOOL)isSameWeekAsDate:(NSDate *)date{
    NSDateComponents *components1 = COMPONENTS(self);
    NSDateComponents *components2 = COMPONENTS(date);
    return ((components1.year == components2.year) &&
            (components1.weekOfYear == components2.weekOfYear));
}

- (BOOL)isSameMonthAsDate:(NSDate *)date{
    NSDateComponents *components1 = COMPONENTS(self);
    NSDateComponents *components2 = COMPONENTS(date);
    return ((components1.year == components2.year) &&
            (components1.month == components2.month));
}

- (BOOL)isSameYearAsDate:(NSDate *)date{
    NSDateComponents *components1 = COMPONENTS(self);
    NSDateComponents *components2 = COMPONENTS(date);
    return (components1.year == components2.year);
}

/**********************************************************************/
#pragma mark Adjusting Dates
/**********************************************************************/

- (NSDate *)dateByAddingWeeks:(NSUInteger)weeks{
    NSTimeInterval aTimeInterval = [self timeIntervalSince1970] + D_WEEK * weeks;
    NSDate *newDate = [NSDate dateWithTimeIntervalSince1970:aTimeInterval];
    return newDate;
}

- (NSDate *)dateBySubtractingWeeks:(NSUInteger)weeks{
    NSTimeInterval aTimeInterval = [self timeIntervalSince1970] - D_WEEK * weeks;
    NSDate *newDate = [NSDate dateWithTimeIntervalSince1970:aTimeInterval];
    return newDate;
}

- (NSDate *)dateByAddingDays:(NSUInteger)days{
    NSTimeInterval aTimeInterval = [self timeIntervalSince1970] + D_DAY * days;
    NSDate *newDate = [NSDate dateWithTimeIntervalSince1970:aTimeInterval];
    return newDate;
}

- (NSDate *)dateBySubtractingDays:(NSUInteger)days{
    NSTimeInterval aTimeInterval = [self timeIntervalSince1970] - D_DAY * days;
    NSDate *newDate = [NSDate dateWithTimeIntervalSince1970:aTimeInterval];
    return newDate;
}

- (NSDate *)dateByAddingHours:(NSUInteger)hours{
    NSTimeInterval aTimeInterval = [self timeIntervalSince1970] + D_HOUR * hours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSince1970:aTimeInterval];
    return newDate;
}

- (NSDate *)dateBySubtractingHours:(NSUInteger)hours{
    NSTimeInterval aTimeInterval = [self timeIntervalSince1970] - D_HOUR * hours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSince1970:aTimeInterval];
    return newDate;
}

- (NSDate *)dateByAddingMinutes:(NSUInteger)minutes{
    NSTimeInterval aTimeInterval = [self timeIntervalSince1970] + D_MINUTE * minutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSince1970:aTimeInterval];
    return newDate;
}

- (NSDate *)dateBySubtractingMinutes:(NSUInteger)minutes{
    NSTimeInterval aTimeInterval = [self timeIntervalSince1970] - D_MINUTE * minutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSince1970:aTimeInterval];
    return newDate;
}

- (NSDate *)dateAtStartOfYear{
    NSDateComponents *components = COMPONENTS(self);
    [components setMonth:1];
    [components setDay:1];
    [components setHour:0];
    [components setMinute:0];
    [components setSecond:0];
    return [CALENDAR_CURRENT dateFromComponents:components];
}

- (NSDate *)dateAtStartOfMonth{
    NSDateComponents *components = COMPONENTS(self);
    [components setDay:1];
    [components setHour:0];
    [components setMinute:0];
    [components setSecond:0];
    return [CALENDAR_CURRENT dateFromComponents:components];
}

- (NSDate *)dateAtStartOfWeek{
    NSDateComponents *components = COMPONENTS(self);
    [components setWeekday:1];
    [components setHour:0];
    [components setMinute:0];
    [components setSecond:0];
    return [CALENDAR_CURRENT dateFromComponents:components];
}

- (NSDate *)dateAtStartOfDay{
    NSDateComponents *components = COMPONENTS(self);
    [components setHour:0];
    [components setMinute:0];
    [components setSecond:0];
    return [CALENDAR_CURRENT dateFromComponents:components];
}

- (NSDate *)dateAtStartOfDayWithHour:(NSInteger)hour{
    NSDateComponents *components = COMPONENTS(self);
    [components setHour:hour];
    [components setMinute:0];
    [components setSecond:0];
    return [CALENDAR_CURRENT dateFromComponents:components];
}

- (NSDate *)lastYear{
    NSDateComponents *components = COMPONENTS(self);
    [components setYear:self.year-1];
    [components setMonth:1];
    [components setDay:1];
    [components setHour:0];
    [components setMinute:0];
    [components setSecond:0];
    return [CALENDAR_CURRENT dateFromComponents:components];
}

- (NSDate *)nextYear{
    NSDateComponents *components = COMPONENTS(self);
    [components setYear:self.year+1];
    [components setMonth:1];
    [components setDay:1];
    [components setHour:0];
    [components setMinute:0];
    [components setSecond:0];
    return [CALENDAR_CURRENT dateFromComponents:components];
}

- (NSDate *)lastMonth{
    NSDateComponents *components = COMPONENTS(self);
    if(self.month == 1){
        [components setYear:self.year-1];
        [components setMonth:12];
    }else{
        [components setMonth:self.month-1];
    }
    [components setDay:1];
    [components setHour:0];
    [components setMinute:0];
    [components setSecond:0];
    return [CALENDAR_CURRENT dateFromComponents:components];
}

- (NSDate *)nextMonth{
    NSDateComponents *components = COMPONENTS(self);
    if(self.month == 12){
        [components setYear:self.year+1];
        [components setMonth:1];
    }else{
        [components setMonth:self.month+1];
    }
    [components setDay:1];
    [components setHour:0];
    [components setMinute:0];
    [components setSecond:0];
    return [CALENDAR_CURRENT dateFromComponents:components];
}

- (NSDate *) dateAtLastOfMonth{
    NSDateComponents *components = COMPONENTS(self);
    if(self.month == 1){
        [components setMonth:12];
        [components setYear:self.year-1];
    }else{
        [components setMonth:self.month-1];
    }
    
    [components setDay:1];
    [components setHour:0];
    [components setMinute:0];
    [components setSecond:0];
    
    return [CALENDAR_CURRENT dateFromComponents:components];
}

- (NSDate *) dateAtNextOfMonth{
    NSDateComponents *components = COMPONENTS(self);
    if(self.month == 12){
        [components setMonth:1];
        [components setYear:self.year+1];
    }else{
        [components setMonth:self.month+1];
    }
    
    [components setDay:1];
    [components setHour:0];
    [components setMinute:0];
    [components setSecond:0];
    
    return [CALENDAR_CURRENT dateFromComponents:components];
}

/**********************************************************************/
#pragma mark Retrieving Intervals
/**********************************************************************/

- (NSInteger)weeksAfterDate:(NSDate *)date{
    NSTimeInterval ti = [self timeIntervalSinceDate:date];
    return (NSInteger) (ti / D_WEEK);
}

- (NSInteger)weeksBeforeDate:(NSDate *)date{
    NSTimeInterval ti = [date timeIntervalSinceDate:self];
    return (NSInteger) (ti / D_WEEK);
}

- (NSInteger)daysAfterDate:(NSDate *)date{
    NSTimeInterval ti = [self timeIntervalSinceDate:date];
    return (NSInteger) (ti / D_DAY);
}

- (NSInteger)daysBeforeDate:(NSDate *)date{
    NSTimeInterval ti = [date timeIntervalSinceDate:self];
    return (NSInteger) (ti / D_DAY);
}

- (NSInteger)hoursAfterDate:(NSDate *)date{
    NSTimeInterval ti = [self timeIntervalSinceDate:date];
    return (NSInteger) (ti / D_HOUR);
}

- (NSInteger)hoursBeforeDate:(NSDate *)date{
    NSTimeInterval ti = [date timeIntervalSinceDate:self];
    return (NSInteger) (ti / D_HOUR);
}

- (NSInteger)minutesAfterDate:(NSDate *)date{
    NSTimeInterval ti = [self timeIntervalSinceDate:date];
    return (NSInteger) (ti / D_MINUTE);
}

- (NSInteger)minutesBeforeDate:(NSDate *)date{
    NSTimeInterval ti = [date timeIntervalSinceDate:self];
    return (NSInteger) (ti / D_MINUTE);
}

- (NSString *)dateSince1970
{
    NSTimeInterval time=[[NSDate date] timeIntervalSince1970]*1000;
    return [NSString stringWithFormat:@"%li",(long)time];
}

static NSDateFormatter *dateFormatter = nil;
- (NSString *)stringWithFormate:(NSString *)formate{
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
    }
    [dateFormatter setDateFormat:formate];
    return [dateFormatter stringFromDate:self];
}

+ (NSString *)getDateValue:(NSString *)date  format:(NSString *)format
{
    double publishLong = [date doubleValue];
    NSDate *pDate = [NSDate dateWithTimeIntervalSince1970:publishLong];
    return [pDate stringWithFormate:format];
}

+ (NSString *)getDateValue:(NSString *)date 
{
    double publishLong = [date doubleValue];
    NSDate *pDate = [NSDate dateWithTimeIntervalSince1970:publishLong];
    return [pDate stringWithFormate:@"yyyy-MM-dd HH:mm:ss"];
}

- (NSString *)formatDate:(NSDate *)date format:(NSString *)format
{
    return [date stringWithFormate:format];
}

+ (NSString *)getDayValue:(NSString *)date
{
    double publishLong = [date doubleValue];
    NSDate *pDate = [NSDate dateWithTimeIntervalSince1970:publishLong];
    NSDateComponents *_comps = [[NSDateComponents alloc] init];
    [_comps setDay:[pDate day]];
    [_comps setMonth:[pDate month]];
    [_comps setYear:[pDate year]];
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *_date = [gregorian dateFromComponents:_comps];
    NSDateComponents *weekdayComponents =
    [gregorian components:NSWeekdayCalendarUnit fromDate:_date];
    NSInteger _weekday = [weekdayComponents weekday];
    NSString *weekDay = @"";
    switch (_weekday) {
        case 1:
            weekDay = @"星期日";
            break;
        case 2:
            weekDay = @"星期一";
            break;
        case 3:
            weekDay = @"星期二";
            break;
        case 4:
            weekDay = @"星期三";
            break;
        case 5:
            weekDay = @"星期四";
            break;
        case 6:
            weekDay = @"星期五";
            break;
        case 7:
            weekDay = @"星期六";
            break;
    }
    return weekDay;
}

+ (NSString *)getMonthAndDay:(NSString *)date
{
    double publishLong = [date doubleValue];
    NSDate *pDate = [NSDate dateWithTimeIntervalSince1970:publishLong];
    return [pDate stringWithFormate:@"MM月dd日"];
}

+ (NSString *)compareWithCloseDate:(NSString *)preDate
{
    if(!preDate || [preDate isEqualToString:@""]) return nil;
    // preDate  2104-12-23 15:21:27
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat: @"yyyy-MM-dd"];
    NSDate *pDate = [formatter dateFromString:[NSString stringWithUTF8String:[preDate UTF8String]]];
    //    NSTimeInterval t = [[NSDate date] timeIntervalSinceDate:pDate];
    NSInteger t = [[NSDate date] daysBeforeDate:pDate];
    NSString *remainDay = [NSString stringWithFormat:@"%d",(int)t];
    t = [[NSDate date] hoursBeforeDate:pDate];
    
    if(remainDay.intValue == 0){
        if(t > 0){
            remainDay = @"1";
        }
    }else{
        if(t > 0){
            remainDay = [NSString stringWithFormat:@"%d",remainDay.intValue + 1];
        }
    }
    return remainDay;
}
+ (NSString *)compareWithOther:(NSString *)preDate day:(BOOL)isOnly
{
    if(!preDate) return nil;

//    NSDate *pDate = [formatter dateFromString:[NSString stringWithUTF8String:[preDate UTF8String]]];
    double publishLong = [preDate doubleValue];
    NSDate *pDate = [NSDate dateWithTimeIntervalSince1970:publishLong];
    NSInteger t = [[NSDate date] daysAfterDate:pDate];
    if (t>3) {
        return [pDate stringWithFormate:@"yyyy-MM-dd HH:mm"];
    }
    NSString *str = [NSString stringWithFormat:@"%d天前",(int)t];
    if(isOnly)
        return [NSString stringWithFormat:@"%d",(int)t];
    
    if(t == 0){
        t = [[NSDate date] hoursAfterDate:pDate];
        str = [NSString stringWithFormat:@"%d小时前",(int)t];
    }
    if(t == 0){
        t = [[NSDate date] minutesAfterDate:pDate];
        str = [NSString stringWithFormat:@"%d分钟前",(int)t];
    }
    return str;
}

+ (BOOL)canSummitRecommendPerson:(NSString *)date
{
    if(!date)
        return YES;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    NSDate *pDate = [formatter dateFromString:[NSString stringWithUTF8String:[date UTF8String]]];
    NSTimeInterval t = [pDate timeIntervalSinceNow];
    return abs((int)t) < D_DAY*3;
}

@end
