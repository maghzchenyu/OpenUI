//
//  ThemeRightViewController.m
//  OPENUI
//
//  Created by chenyu on 14-4-10.
//
//

#import "ThemeRightViewController.h"
#import "Header.h"

@interface ThemeRightViewController ()
@property (nonatomic, strong) NSArray *data;
@end

@implementation ThemeRightViewController

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
    UITableView *table = [[UITableView alloc] initWithFrame:self.view.frame];
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
    self.data = [NSArray arrayWithObjects:@"red",@"blue",@"yellow",nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - table delegate and data
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.data count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if ( nil==cell ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    cell.textLabel.text = [self.data objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIColor *color = nil;
    if (indexPath.row == 0){
        color = [UIColor redColor];
    }else if( indexPath.row==1 ){
        color = [UIColor blueColor];
    }else if ( indexPath.row==2 ){
        color = [UIColor yellowColor];
    }else{
        return;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeUIStyle" object:color];
    OpenAlertView *alert = [[OpenAlertView alloc] initWithContent:@"设置完成"];
    [alert show];
}

@end
