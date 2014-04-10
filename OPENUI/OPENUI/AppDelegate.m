//
//  AppDelegate.m
//  OPENUI
//
//  Created by xiaoyu on 14-4-4.
//
//

#import "AppDelegate.h"
#import "Header.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    MenuViewController *menu = [[MenuViewController alloc] init];
    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:menu];
    self.window.rootViewController = navigation;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
#ifdef open_test_function
    NSTimer *timerFunction = [NSTimer scheduledTimerWithTimeInterval:test_time_for_repeat target:self selector:@selector(test) userInfo:nil repeats:YES];
#endif
    
#ifdef memory_test
    //NSTimer *timerMemory = [NSTimer scheduledTimerWithTimeInterval:memory_time target:self selector:@selector(outputMemory) userInfo:nil repeats:YES];
    NSTimer *timerMemory = [NSTimer scheduledTimerWithTimeInterval:memory_time target:self selector:@selector(outputMemory) userInfo:nil repeats:YES];
    CYLog_Info(@"the timer is %@",timerMemory);
#endif
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - test function
#ifdef open_test_function
- (void)test
{
    //the test code of need
}
#endif

#pragma mark - output memroy

#ifdef memory_test
#include <sys/sysctl.h>
#include <mach/mach.h>
- (double)availableMemory
{
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(),HOST_VM_INFO,(host_info_t)&vmStats,&infoCount);
    
    if(kernReturn != KERN_SUCCESS)
    {
        return NSNotFound;
    }
    
    return ((vm_page_size * vmStats.free_count) / 1024.0) / 1024.0;
}

- (double)usedMemory
{
    task_basic_info_data_t taskInfo;
    mach_msg_type_number_t infoCount = TASK_BASIC_INFO_COUNT;
    kern_return_t kernReturn = task_info(mach_task_self(),
                                         TASK_BASIC_INFO, (task_info_t)&taskInfo, &infoCount);
    if(kernReturn != KERN_SUCCESS)
    {
        return NSNotFound;
    }
    
    return taskInfo.resident_size / 1024.0 / 1024.0;
}

- (void)outputMemory
{
    CYLog_Info(@"the memory use now is %fM the available %fM",[self usedMemory],[self availableMemory]);
}
#endif

@end
