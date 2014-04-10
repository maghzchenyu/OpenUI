//
//  ChatNormalCell.m
//  OPENUI
//
//  Created by chenyu on 14-4-8.
//
//

#import "ChatNormalCell.h"

@implementation ChatNormalCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withChatType:(ChatType)type
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        // Initialization code
        self.nameLable = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 100, 20)];
        [self addSubview:self.nameLable];
        self.timeLable = [[UILabel alloc] initWithFrame:CGRectMake(140, 5, 180, 20)];
        [self addSubview:self.timeLable];
        if (type == defaultType) {
            self.contextView = [[ChatContextView alloc] init];
            self.contextView.frame = CGRectMake(20, 30, 300, 25);
            [self addSubview:self.contextView];
            self.contextView.backgroundColor = [UIColor clearColor];
        }else if (type==LabelType){
            self.contextLabel = [[ChatLabel alloc] init];
            self.contextLabel.frame = CGRectMake(20, 30, 300, 30);
            [self addSubview:self.contextLabel];
        }
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
