//
//  ChatNormalCell.h
//  OPENUI
//
//  Created by chenyu on 14-4-8.
//
//

#import <UIKit/UIKit.h>
#import "ChatContextView.h"
#import "ChatHeader.h"
#import "ChatLabel.h"

@interface ChatNormalCell : UITableViewCell

@property (nonatomic, strong) UILabel *nameLable;
@property (nonatomic, strong) UILabel *timeLable;
@property (nonatomic, strong) ChatContextView *contextView;
@property (nonatomic, strong) ChatLabel *contextLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withChatType:(ChatType)type;

@end
