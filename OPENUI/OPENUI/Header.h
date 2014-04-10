//
//  Header.h
//  OPENUI
//
//  Created by xiaoyu on 14-4-4.
//
//

#ifndef OPENUI_Header_h
#define OPENUI_Header_h

#import "ToolsObject.h"
#import "OpenAlertView.h"

#define memory_test
//#define open_test_function
#define test_time_for_repeat 1 //测试函数间隔多久调用一次 /s
#define memory_time 60  //内存打印函数多久调用一次 /s
#define IOS_SYSTEM ([[[UIDevice currentDevice] systemVersion] floatValue])

/* 日志打印函数  */
#define CYLog_Info(format,...)    NSLog(@"[INFO] {%s,%d}" format, __FUNCTION__,__LINE__,##__VA_ARGS__)
#define CYLog_Error(format,...)   NSLog(@"[ERROR] {%s,%d}" format, __FUNCTION__,__LINE__,##__VA_ARGS__)
#define CYLog_WARN(format,...)    NSLog(@"[WARNING] {%s,%d}" format, __FUNCTION__,__LINE__,##__VA_ARGS__)

#endif
