//
//  ThemeLeftViewController.m
//  OPENUI
//
//  Created by chenyu on 14-4-10.
//
//

#import "ThemeLeftViewController.h"
#import "ThemeBaseVIew.h"

@interface ThemeLeftViewController ()

@end

@implementation ThemeLeftViewController

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
    ThemeBaseVIew *baseView = [[ThemeBaseVIew alloc] initWithFrame:CGRectMake(0, 0, 160, 160)];
    [self.view addSubview:baseView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
