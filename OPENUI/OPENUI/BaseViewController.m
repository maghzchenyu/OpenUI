//
//  BaseViewController.m
//  OPENUI
//
//  Created by xiaoyu on 14-4-4.
//
//

#import "BaseViewController.h"
#import "Header.h"
@interface BaseViewController ()

@end

@implementation BaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

/*
- (void)loadView
{
    UIWindow *window = (UIWindow*)[[[UIApplication sharedApplication] windows] objectAtIndex:0];
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, window.frame.size.width, window.frame.size.height)];
    self.view.autoresizesSubviews = NO;
    
    
    CYLog_Info(@"the view frame is %@",NSStringFromCGRect(self.view.frame));
}
*/

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    

    
    if (NO == self.navigationController.navigationBarHidden)
    {
        if (IOS_SYSTEM>=7.0)
        {
            self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height - self.navigationController.navigationBar.frame.size.height - 20);
        }else
        {
            self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height - self.navigationController.navigationBar.frame.size.height);
        }
        
    }else
    {
        if (IOS_SYSTEM>=7.0)
        {
            self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height - 20);
        }
    }
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    /*
    if (NO == self.navigationController.navigationBarHidden)
    {
        if (IOS_SYSTEM>=7.0)
        {
            self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height - self.navigationController.navigationBar.frame.size.height - 20);
        }else
        {
            self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height - self.navigationController.navigationBar.frame.size.height);
        }
        
    }else
    {
        if (IOS_SYSTEM>=7.0)
        {
            self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height - 20);
        }
    }
     */
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}


@end
