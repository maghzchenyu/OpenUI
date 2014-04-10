//
//  OpenuiChatMainUI.m
//  OPENUI
//
//  Created by chenyu on 14-4-4.
//
//

#import "OpenuiChatMainUI.h"
#import "Header.h"

#define textFieldTag 10


@interface OpenuiChatMainUI ()

@end

@implementation OpenuiChatMainUI

- (void)dealloc
{
    //CYLog_Info(@"the %@ dealloc happen",self);
}
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
    //self.type = defaultType; // set the chat type
    self.type = LabelType;
    
    NSArray *viewArray = [[NSBundle mainBundle] loadNibNamed:@"InPutView" owner:self options:nil];
    self.inputView = [viewArray objectAtIndex:0];
    self.inputView.frame = CGRectMake(0, self.view.frame.size.height - self.inputView.frame.size.height, self.inputView.frame.size.width, self.inputView.frame.size.height);
    
    self.textField = (UITextField*)[self.inputView viewWithTag:textFieldTag];
    self.textField.delegate = self;
    
    self.tableController = [[OpenChatTableController alloc] initWithStyle:UITableViewStylePlain];
    self.tableController.tableView.frame = CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, self.view.bounds.size.width, self.view.bounds.size.height - self.inputView.frame.size.height);
    self.tableController.type = defaultType;//聊天界面的风格
    [self.view addSubview:self.tableController.tableView];
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.tableController.tableView.separatorInset = UIEdgeInsetsZero;
    tableRect = self.tableController.tableView.frame;
    [self.view addSubview:self.inputView];
   
    //表情界面初始化
    {
        self.faceView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 216, 320, 216)];
        self.faceView.backgroundColor = [UIColor whiteColor];
        self.faceView.pagingEnabled = YES;
        self.faceView.delegate = self;
        self.faceView.hidden = YES;
        [self.faceView setContentSize:CGSizeMake(320*2, 100)];
        
        for (int i = 0; i<42; i++)
        {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            
            if(i<10)
            {
                [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"f00%d",i]] forState:UIControlStateNormal];
                
            }else if (i<100)
            {
                [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"f0%d",i]] forState:UIControlStateNormal];
                
            }else
            {
                [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"f%d",i]] forState:UIControlStateNormal];
            }
            button.tag = i;
            int j = i/21;
            int k = i%21;
            int w = 0;
            if (k%7==0)
            {
                w = 3;
            }
            int x = j*320 + k%7*36 + 7*(k%7+1) +w;
            int y = k/7*(36+6)+10;
            [button setFrame:CGRectMake(x, y , 36, 36)];
            [button addTarget:self action:@selector(addFaceImage:) forControlEvents:UIControlEventTouchUpInside];
            [self.faceView addSubview:button];
        }
        [self.view addSubview:self.faceView];
    }
    
    if([[[UIDevice currentDevice] systemVersion] floatValue]<5.0)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillHideNotification object:nil];
    }else
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    CYLog_Info(@"the view frame is %@",NSStringFromCGRect(self.view.frame));
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if([[[UIDevice currentDevice] systemVersion] floatValue]<5.0)
    {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
        
    }else
    {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    }

}

- (void)addFaceImage:(id)sender
{
    UIButton *button = (UIButton*)sender;
    int i = button.tag;
    NSString *str = nil;
    
    if (i<10)
    {
        str = [NSString stringWithFormat:@"[00%d]",i];
        
    }else if(i <100)
    {
        str = [NSString stringWithFormat:@"[0%d]",i];
    }else
    {
        str = [NSString stringWithFormat:@"[%d]",i];
    }
    
    self.textField.text = [NSString stringWithFormat:@"%@%@",self.textField.text,str];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}

#pragma mark - key board hide or show
- (void)keyboardWillShow:(NSNotification *)notification
{
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_3_2
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
#endif
            
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_3_2
        NSValue *keyboardBoundsValue = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
#else
        NSValue *keyboardBoundsValue = [[notification userInfo] objectForKey:UIKeyboardBoundsUserInfoKey];
#endif
        CGRect keyboardBounds;
        [keyboardBoundsValue getValue:&keyboardBounds];
            
        [UIView beginAnimations:@"keyboard" context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        if (CGRectEqualToRect(self.tableController.tableView.frame, tableRect))
        {
            self.tableController.tableView.frame = CGRectMake(self.tableController.view.frame.origin.x, self.tableController.tableView.frame.origin.y, self.tableController.tableView.frame.size.width,self.tableController.tableView.frame.size.height - keyboardBounds.size.height);
                keyBoardHeght = keyboardBounds.size.height;
            self.inputView.frame = CGRectMake(0, self.tableController.tableView.frame.size.height, self.inputView.frame.size.width, self.inputView.frame.size.height);
            //- self.inputView.frame.size.height
            //CYLog_Info(@"CGRectEqualToRect(self.tableController.tableView.frame, tableRect) is ture is happen the tableview frame is %@",NSStringFromCGRect(self.tableController.tableView.frame));
        }else
        {
            self.tableController.tableView.frame = CGRectMake(self.tableController.view.frame.origin.x, self.tableController.tableView.frame.origin.y, self.tableController.tableView.frame.size.width,self.tableController.tableView.frame.size.height+ keyBoardHeght - keyboardBounds.size.height);
            keyBoardHeght = keyboardBounds.size.height;
            self.inputView.frame = CGRectMake(0, self.tableController.tableView.frame.size.height, self.inputView.frame.size.width, self.inputView.frame.size.height);
                //CYLog_Info(@"table rect not equal original rect table frame is/n %@",NSStringFromCGRect(self.tableController.tableView.frame));
        }
        [UIView commitAnimations];
    }
}

#pragma mark - IBAction
- (IBAction)toFace:(id)sender
{
    if (self.faceView.hidden == YES)
    {
        self.faceView.hidden = NO;
        if ([self.textField isFirstResponder])
        {
            [self.textField resignFirstResponder];
            
        }else
        {
            if (CGRectEqualToRect(self.tableController.tableView.frame, tableRect))
            {
                self.tableController.tableView.frame = CGRectMake(self.tableController.view.frame.origin.x, self.tableController.tableView.frame.origin.y, self.tableController.tableView.frame.size.width,self.tableController.tableView.frame.size.height - self.faceView.frame.size.height);
                keyBoardHeght = self.faceView.frame.size.height;
                self.inputView.frame = CGRectMake(0, self.tableController.tableView.frame.size.height, self.inputView.frame.size.width, self.inputView.frame.size.height);
            }
        }
    }else
    {
        
        self.faceView.hidden = YES;
        if (![self.textField isFirstResponder])
        {
            [self.textField becomeFirstResponder];
            
        }else
        {
            //self.tableController.tableView.frame = tableRect;
            //self.inputView.frame = CGRectMake(0, self.tableController.tableView.frame.size.height, self.inputView.frame.size.width, self.inputView.frame.size.height);
        }
    }
}

- (IBAction)didSendMessage:(id)sender
{
    if ([self.textField.text isEqualToString:@""] || self.textField.text == nil)
    {
        OpenAlertView *alert = [[OpenAlertView alloc] initWithContent:@"输入内容不能为空"];
        [alert show];
        return;
    }
    
    ChatContentObject *data = [[ChatContentObject alloc] init];
    if ( defaultType==self.type ){
        data.timeString = [ToolsObject dealTimeWithTime:0 Type:currentTime];
        data.contentString = [NSString stringWithFormat:@"%@",self.textField.text];
        data.nameString = @"Jack";
        data.lineCount = [ToolsObject countHeght:data.contentString];
    }else if( LabelType==self.type ){
        data.timeString = [ToolsObject dealTimeWithTime:0 Type:currentTime];
        data.contentString = [NSString stringWithFormat:@"%@",self.textField.text];
        data.nameString = @"Jack";
        //data.lineCount = [ToolsObject countHeght:data.contentString];
        CGSize size = [self.textField.text sizeWithFont:[UIFont systemFontOfSize:18.0] constrainedToSize:CGSizeMake(300, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    
    }
    
    [self.tableController.dataArray addObject:data];
    NSIndexPath *path = [NSIndexPath indexPathForRow:[self.tableController.dataArray count]-1 inSection:0];
    NSArray *array = [NSArray arrayWithObjects:path, nil];
    [self.tableController.tableView insertRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationBottom];
    [self.tableController.tableView scrollToRowAtIndexPath:[array lastObject] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

#pragma mark - text field delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    //[textField becomeFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    self.tableController.tableView.frame = tableRect;
    if (NO == self.faceView.hidden)
    {
        self.faceView.hidden = YES;
    }
    return YES;
}

@end
