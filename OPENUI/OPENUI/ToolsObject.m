//
//  ToolsObject.m
//  OPENUI
//
//  Created by chenyu on 14-4-8.
//
//

#import "ToolsObject.h"
#import "Header.h"

@implementation ToolsObject

+ (NSString*)dealTimeWithTime:(long)time Type:(TIMETYPE)type
{
    NSString *dateString = nil;
    
    if (currentTime == type)
    {
        NSDate *date = [[NSDate alloc] init];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        dateString = [formatter stringFromDate:date];
        
    }else if(yearMonthDay == type)
    {
        NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:time/1000.0];
        NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy年MM月dd日"];
        dateString = [formatter stringFromDate:date];
        
    }else if(yearToSecond == type)
    {
        NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:time/1000.0];
        NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy年MM月dd日HH时mm分"];
        dateString = [formatter stringFromDate:date];
    }
    return dateString;
}

+ (BOOL)validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

+ (NSInteger)countHeght:(NSString*)str
{
    int count = 0;
    float real_len = 0;
    int len = [str length];
    for (int i = 0; i<len; i++)
    {
        int  a = [str characterAtIndex:i];
        
        if (a == '[')
        {
            if (i+4<len)
            {
                int b = [str characterAtIndex:i+4];
                if (b == ']')
                {
                    //count = count +2;
                    real_len = real_len +25;
                    
                    i = i+4;
                    continue;
                }
            }
            
        }
        
        if (a == '1'||a == '2'||a == '3'||a == '4'||a == '5'||a == '6'||a == '7'||a == '8'||a == '9'||a == '0')
        {
            real_len = real_len + 10.3448;
            continue;
        }
        
        if( a > 0x4e00 && a < 0x9fff)
        {
            real_len = real_len +18.75;
            //count = count + 2;
            continue;
            
        }
        
        if (a == 'i'||a=='j'||a=='l')
        {
            real_len = real_len + 4.2857;
            continue;
        }
        
        if (a == 'w' || a == 'm')
        {
            real_len = real_len +14.2587;
            continue;
        }
        
        real_len = real_len + 10;
        
    }
    
    count = real_len/300;
    
    if ((int)real_len%300 >0)
    {
        count = count +1;
    }
    
    CYLog_Info(@"the real length %f  the count %d",real_len,count);
    
    return count;
    
}

@end
