//
//  OpenAlertView.m
//  OPENUI
//
//  Created by chenyu on 14-4-8.
//
//

#import "OpenAlertView.h"
#import "Header.h"

@implementation OpenAlertView

- (void)dealloc
{
    CYLog_Info(@"the %@ dealloc happen",self);
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithContent:(NSString *)content Delegate:(NSObject *)openDelegate
{
    self = [super initWithTitle:@"提示"
                        message:content
                       delegate:openDelegate
              cancelButtonTitle:@"确定"
              otherButtonTitles:@"取消",nil];
    
    return self;
}

- (id)initWithContent:(NSString *)content
{
    self = [super initWithTitle:@"提示"
                        message:content
                       delegate:nil
              cancelButtonTitle:@"确定"
              otherButtonTitles:nil];
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
