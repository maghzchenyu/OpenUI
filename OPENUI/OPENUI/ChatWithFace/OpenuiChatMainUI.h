//
//  OpenuiChatMainUI.h
//  OPENUI
//
//  Created by chenyu on 14-4-4.
//
//

#import "BaseViewController.h"
#import <UIKit/UIKit.h>
#import "ChatContentObject.h"
#import "OpenChatTableController.h"
#import "ChatHeader.h"
@interface OpenuiChatMainUI : BaseViewController<UITextFieldDelegate,UIScrollViewDelegate>
{
    CGRect tableRect;
    float  keyBoardHeght;
}

@property (nonatomic, strong) UIView *inputView;
@property (nonatomic, weak)   UITextField *textField;
@property (nonatomic, strong) UIScrollView *faceView;
@property (nonatomic, strong) OpenChatTableController *tableController;
@property (nonatomic, assign) ChatType type;

@end
