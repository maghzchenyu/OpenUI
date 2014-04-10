//
//  MenuViewController.h
//  OPENUI
//
//  Created by xiaoyu on 14-4-4.
//
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface MenuViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *nameArray;

@end
