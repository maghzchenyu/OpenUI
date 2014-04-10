//
//  ChatLabelCell.m
//  OPENUI
//
//  Created by chenyu on 14-4-10.
//
//

#import "ChatLabelCell.h"

@implementation ChatLabelCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        self.nameLable = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 100, 20)];
        [self addSubview:self.nameLable];
        self.timeLable = [[UILabel alloc] initWithFrame:CGRectMake(140, 5, 180, 20)];
        [self addSubview:self.timeLable];
        self.contextLabel = [[ChatLabel alloc] init];
        self.contextLabel.frame = CGRectMake(20, 30, 300, 30);
        [self addSubview:self.contextLabel];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
