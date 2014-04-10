//
//  ChatImageUnit.h
//  OPENUI
//
//  Created by chenyu on 14-4-8.
//
//

#import <Foundation/Foundation.h>

@interface ChatImageUnit : NSObject

@property (nonatomic) NSRange range;
@property (nonatomic, copy) NSString *originalText;
@property (nonatomic, strong) UIFont *originFont;

+ (NSArray *)emojiStringArray;
- (void)replaceTextWithAttributedString:(NSMutableAttributedString*) attString;
- (BOOL)drawRunWithRect:(CGRect)rect;

@end
