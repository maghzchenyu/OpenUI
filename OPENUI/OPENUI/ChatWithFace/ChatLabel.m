//
//  ChatLabel.m
//  OPENUI
//
//  Created by chenyu on 14-4-9.
//
//

#import "ChatLabel.h"

@implementation ChatLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setChatText:(NSString *)chatText
{
    self.text = chatText;
    for ( NSObject *object in self.subviews ) {
        if ([object isKindOfClass:[UIImage class]]) {
            [((UIView*)object) removeFromSuperview];
        }
    }
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
