//
//  ChatNormalCell.h
//  OPENUI
//
//  Created by chenyu on 14-4-8.
//
//

#import <UIKit/UIKit.h>
#import "ChatContextView.h"

@interface ChatNormalCell : UITableViewCell

@property (nonatomic, strong) UILabel *nameLable;
@property (nonatomic, strong) UILabel *timeLable;
@property (nonatomic, strong) ChatContextView *contextView;

@end
