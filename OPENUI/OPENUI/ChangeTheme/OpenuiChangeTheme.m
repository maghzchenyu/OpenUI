//
//  OpenuiChangeTheme.m
//  OPENUI
//
//  Created by chenyu on 14-4-10.
//
//

#import "OpenuiChangeTheme.h"
#import "Header.h"

@interface OpenuiChangeTheme ()

@end
static NSNotification *notifi = nil;
@implementation OpenuiChangeTheme

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    [OpenuiChangeTheme registerNotification];
    ThemeLeftViewController *left = [[ThemeLeftViewController alloc] init];
    //left.view.backgroundColor = [UIColor yellowColor];
    ThemeRightViewController *right = [[ThemeRightViewController alloc] init];
    //right.view.backgroundColor = [UIColor blackColor];
    self.viewControllers = [NSArray arrayWithObjects:left,right, nil];
    self.selectedIndex = 0;
    //self.tabBar.items
    UITabBarItem *item0 = [self.tabBar.items objectAtIndex:0];
    item0.title = @"Left";
    item0.image = [UIImage imageNamed:@"f001"];
    UITabBarItem *item1 = [self.tabBar.items objectAtIndex:1];
    item1.image = [UIImage imageNamed:@"f002"];
    item1.title = @"Right";
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (void)registerNotification
{
    notifi = [[NSNotification alloc] initWithName:@"ChangeUIStyle" object:nil userInfo:nil];
}

- (void)pressedLeftButton:(id)sender
{
    self.selectedIndex = 0;
}

- (void)PressedRightButton:(id)sender
{
    self.selectedIndex = 1;
}

@end
