//
//  ThemeBaseVIew.m
//  OPENUI
//
//  Created by chenyu on 14-4-10.
//
//

#import "ThemeBaseVIew.h"

@implementation ThemeBaseVIew
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ChangeUIStyle" object:nil];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeUI:) name:@"ChangeUIStyle" object:nil];
    }
    return self;
}

- (void)changeUI:(id)object
{
    NSNotification *noti = (NSNotification *)object;
    self.backgroundColor =(UIColor *)noti.object;
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
