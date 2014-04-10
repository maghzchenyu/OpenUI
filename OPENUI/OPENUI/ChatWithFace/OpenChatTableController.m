//
//  OpenChatTableController.m
//  OPENUI
//
//  Created by chenyu on 14-4-8.
//
//

#import "OpenChatTableController.h"
#import "Header.h"

@interface OpenChatTableController ()

@end

@implementation OpenChatTableController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.dataArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    CYLog_Info(@"the table's view is %@ \n the table's tableview is %@",self.view,self.tableView);
    if (defaultType == self.type)
    {
        // nothing to do
    }else if(WechatType == self.type)
    {
        //to do something
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    // Configure the cell...
    if (nil == cell)
    {
        if (defaultType == self.type)
        {
            cell = [[ChatNormalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier withChatType:self.type];
        }
    }
    
    ChatContentObject *data = [self.dataArray objectAtIndex:indexPath.row];
    if (defaultType == self.type)
    {
        ChatNormalCell *cell1 = (ChatNormalCell *)cell;
        cell1.contextView.frame = CGRectMake(cell1.contextView.frame.origin.x, cell1.contextView.frame.origin.y,300, data.lineCount*25);
        cell1.contextView.text = data.contentString;
        cell1.nameLable.text = data.nameString;
        cell1.timeLable.text = data.timeString;
        
    }else if(WechatType == self.type)
    {
        
    }else if(LabelType == self.type)
    {
        ChatNormalCell *cell1 = (ChatNormalCell *)cell;
        cell1.nameLable.text = data.nameString;
        cell1.timeLable.text = data.timeString;
        cell1.timeLable.text = data.attString;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ( defaultType==self.type ){
        return (30 +((ChatContentObject *)[self.dataArray objectAtIndex:indexPath.row]).lineCount*25);
    }else if(LabelType == self.type){
        return (30 +((ChatContentObject *)[self.dataArray objectAtIndex:indexPath.row]).realHeght);
    }
    return 100;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
