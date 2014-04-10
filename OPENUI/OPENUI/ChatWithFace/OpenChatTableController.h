//
//  OpenChatTableController.h
//  OPENUI
//
//  Created by chenyu on 14-4-8.
//
//

#import <UIKit/UIKit.h>
#import "ChatContentObject.h"
#import "ChatHeader.h"
#import "ChatNormalCell.h"
@interface OpenChatTableController : UITableViewController

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) ChatType type;

@end
