//
//  ChatLabelCell.h
//  OPENUI
//
//  Created by chenyu on 14-4-10.
//
//

#import <UIKit/UIKit.h>
#import "ChatLabel.h"

@interface ChatLabelCell : UITableViewCell

@property (nonatomic, strong) UILabel *nameLable;
@property (nonatomic, strong) UILabel *timeLable;
@property (nonatomic, strong) ChatLabel *contextLabel;

@end
