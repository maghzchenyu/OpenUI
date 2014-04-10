//
//  ChatContextView.h
//  OPENUI
//
//  Created by chenyu on 14-4-8.
//
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>
#import "ChatImageUnit.h"

@interface ChatContextView : UIView

@property (nonatomic, copy) NSString *text;
@property (nonatomic, readonly) NSString *analyzedText;
@property (nonatomic, strong) NSMutableArray *chatUnitArray;
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, assign) float lineSpacing;

@end
