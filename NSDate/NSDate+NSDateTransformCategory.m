 

#import "NSDate+NSDateTransformCategory.h" 

@implementation NSDate(NSDateTransformCategory)



static NSDateFormatter *FORMATOR;
static NSDateFormatter *FORMATOR_YMDHM;
static NSDateFormatter *FORMATOR_YMD;

static NSDateFormatter *FORMATOR_SIMPLE;
static NSDateFormatter *FORMATOR_HOUR_MINUTE;
static NSDateFormatter *FORMATOR_HMS;


-(NSString *)transformToString{
    
    if(!FORMATOR){
        FORMATOR = [[NSDateFormatter alloc] init];
        [FORMATOR setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    
    return [FORMATOR stringFromDate:self];
}

-(NSString *)transformToYMDHmString{
    if(!FORMATOR_YMDHM){
        FORMATOR_YMDHM = [[NSDateFormatter alloc] init];
        [FORMATOR_YMDHM setDateFormat:@"yyyy-MM-dd HH:mm"];
    }
    
    return [FORMATOR_YMDHM stringFromDate:self];
}


-(NSString *)transformToYMDString{
    if(!FORMATOR_YMD){
        FORMATOR_YMD = [[NSDateFormatter alloc] init];
        [FORMATOR_YMD setDateFormat:@"yyyy-MM-dd"];
    }
    return [FORMATOR_YMD stringFromDate:self];
}

-(NSString *)transformToSimpleString{
    if(!FORMATOR_SIMPLE){
        FORMATOR_SIMPLE = [[NSDateFormatter alloc] init];
        [FORMATOR_SIMPLE setDateFormat:@"yyyyMMddHHmmss"];
    }
    return [FORMATOR_SIMPLE stringFromDate:self];
}

-(NSString *)transformToHmString{
    if(!FORMATOR_HOUR_MINUTE){
        FORMATOR_HOUR_MINUTE = [[NSDateFormatter alloc] init];
        [FORMATOR_HOUR_MINUTE setDateFormat:@"HH:mm"];
    }
    return [FORMATOR_HOUR_MINUTE stringFromDate:self];
}

-(NSString *)transformToHmsString{
    if(!FORMATOR_HMS){
        FORMATOR_HMS = [[NSDateFormatter alloc] init];
        [FORMATOR_HMS setDateFormat:@"HH:mm:ss"];
    }
    return [FORMATOR_HMS stringFromDate:self];
}

-(NSString *) compareCurrentTime
{
    NSTimeInterval  timeInterval = [self timeIntervalSinceNow];
    timeInterval = -timeInterval;
    NSInteger temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%d分前",(int)temp];
    }
    
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%d小时前",(int)temp];
    }
    
    else if((temp = temp/24) <30){
        result = [NSString stringWithFormat:@"%d天前",(int)temp];
    }
    
    else if((temp = temp/30) <12){
        result = [NSString stringWithFormat:@"%d个月前",(int)temp];
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"%d年前",(int)temp];
    }
    
    return  result;
}

-(NSString *) compareFutureTime
{
    NSTimeInterval  timeInterval = [self timeIntervalSinceNow];
    timeInterval =  timeInterval;
    NSInteger temp = 0;
    NSString *result;
    if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"剩余%d分",(int)temp];
    }
    
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"剩余%d小时",(int)temp];
    }
    
    else if((temp = temp/24) <30){
        result = [NSString stringWithFormat:@"剩余%d天",(int)temp];
    }
    
    else if((temp = temp/30) <12){
        result = [NSString stringWithFormat:@"剩余%d个月",(int)temp];
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"剩余%d年",(int)temp];
    }
    
    return  result;
}

@end

@implementation NSString(NSDateTransformCategory)

-(NSDate *)transformFromString{
    if(!FORMATOR){
        FORMATOR = [[NSDateFormatter alloc] init];
        [FORMATOR setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    return [FORMATOR dateFromString:self];
}

-(NSDate *)transformYMDHmFromString{
    if(!FORMATOR_YMDHM){
        FORMATOR_YMDHM = [[NSDateFormatter alloc] init];
        [FORMATOR_YMDHM setDateFormat:@"yyyy-MM-dd HH:mm"];
    }
    
    return [FORMATOR_YMDHM dateFromString:self];
}
 
-(NSDate *)transformYMDFromString{
    if(!FORMATOR_YMD){
        FORMATOR_YMD = [[NSDateFormatter alloc] init];
        [FORMATOR_YMD setDateFormat:@"yyyy-MM-dd"];
    }
    return [FORMATOR_YMD dateFromString:self];
}

-(NSDate *)transformSimpleFromString{
    if(!FORMATOR_SIMPLE){
        FORMATOR_SIMPLE = [[NSDateFormatter alloc] init];
        [FORMATOR_SIMPLE setDateFormat:@"yyyyMMddHHmmss"];
    }
    return [FORMATOR_SIMPLE dateFromString:self];
}

-(NSDate *)transformHmFromString{
    if(!FORMATOR_HOUR_MINUTE){
        FORMATOR_HOUR_MINUTE = [[NSDateFormatter alloc] init];
        [FORMATOR_HOUR_MINUTE setDateFormat:@"HH:mm"];
    }
    return [FORMATOR_HOUR_MINUTE dateFromString:self];
}

-(NSDate *)transformHmsFromString{
    if(!FORMATOR_HMS){
        FORMATOR_HMS = [[NSDateFormatter alloc] init];
        [FORMATOR_HMS setDateFormat:@"HH:mm:ss"];
    }
    return [FORMATOR_HMS dateFromString:self];
}


@end
