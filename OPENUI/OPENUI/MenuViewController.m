//
//  MenuViewController.m
//  OPENUI
//
//  Created by xiaoyu on 14-4-4.
//
//

#import "MenuViewController.h"
#import <objc/runtime.h>
#import "OpenuiChatMainUI.h"
@interface MenuViewController ()

@end

@implementation MenuViewController

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
    self.navigationController.title = @"main menu";
    
    int numClasses;
    Class *classes = NULL;
    
    classes = NULL;
    numClasses = objc_getClassList(NULL, 0);
    //NSLog(@"Number of classes: %d", numClasses);
    const char *staticChar = "Openui";
    
    self.nameArray = [[NSMutableArray alloc] init];
    
    if (numClasses > 0)
    {
        classes = (__unsafe_unretained Class *)malloc(sizeof(Class) * numClasses);
        numClasses = objc_getClassList(classes, numClasses);
        for (int i = 0; i < numClasses; i++) {
            //NSLog(@"Class name: %s", class_getName(classes[i]));
          const char *name = class_getName(classes[i]);
          if(0 == strncmp(staticChar, name, 6))
          {
              NSString *nameString = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
              [self.nameArray addObject:nameString];
          }
        }
        free(classes);
    }
    
    UITableView *table = [[UITableView alloc] initWithFrame:self.view.bounds];
    
    table.delegate = self;
    table.dataSource = self;
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        table.separatorInset =  UIEdgeInsetsZero;
    [self.view addSubview:table];
    
    OpenuiChatMainUI *label = [[OpenuiChatMainUI alloc] init];
    unsigned int numIvars = 0;
    NSString *key=nil;
    Ivar * ivars = class_copyIvarList([label class], &numIvars);
    for(int i = 0; i < numIvars; i++) {
        Ivar thisIvar = ivars[i];
        key = [NSString stringWithUTF8String:ivar_getName(thisIvar)];
        CYLog_Info(@"the class ivar label is %@",key);
    }
    free(ivars);
    /*测试类成员变量
    {
     
    }
     */
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - table view data and delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.nameArray count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (nil == cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    cell.textLabel.text = [self.nameArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Class controllerClass = objc_getClass([[self.nameArray objectAtIndex:indexPath.row] UTF8String]);
    id controller = [[NSClassFromString([self.nameArray objectAtIndex:indexPath.row])  alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}
@end
