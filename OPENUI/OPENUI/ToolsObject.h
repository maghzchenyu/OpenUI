//
//  ToolsObject.h
//  OPENUI
//
//  Created by chenyu on 14-4-8.
//
//

#import <Foundation/Foundation.h>
typedef enum {
    currentTime = 0,
    yearMonthDay = 1,
    yearToSecond = 2,
}TIMETYPE;

@interface ToolsObject : NSObject

+ (NSString *)dealTimeWithTime:(long)time Type:(TIMETYPE)type;
+ (BOOL)validateEmail:(NSString *)email;
+ (NSInteger)countHeght:(NSString *)str;
+ (void)logTheInstanceIvar:(id)instance;

@end
