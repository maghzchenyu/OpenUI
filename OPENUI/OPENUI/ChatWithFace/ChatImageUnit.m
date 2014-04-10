//
//  ChatImageUnit.m
//  OPENUI
//
//  Created by chenyu on 14-4-8.
//
//

#import "ChatImageUnit.h"
#import "Header.h"
#include <CoreText/CoreText.h>
#import "ChatContextView.h"

static NSMutableArray *imageString = nil;
static const float kZoom = 1.1f;

@implementation ChatImageUnit

+ (void)initialize
{
    CYLog_Info(@"the initialize happen");
    imageString = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 120 ; i++)
    {
        NSString *str = nil;
        if (i<10)
        {
            str = [NSString stringWithFormat:@"[00%d]",i];
            
        }else if (i<100)
        {
            str = [NSString stringWithFormat:@"[0%d]",i];
        }else
        {
            str = [NSString stringWithFormat:@"[%d]",i];
        }
        [imageString addObject:str];
    }
}

+ (NSArray *)emojiStringArray
{
    return imageString;
}
- (void)replaceTextWithAttributedString:(NSMutableAttributedString*) attString
{
    //删除替换的占位字符
    [attString deleteCharactersInRange:self.range];
    //NSLog(@"the base's real class is %@",self);
    
    CTRunDelegateCallbacks emojiCallbacks;
    emojiCallbacks.version      = kCTRunDelegateVersion1;
    emojiCallbacks.dealloc      = TQRichTextRunEmojiDelegateDeallocCallback;
    emojiCallbacks.getAscent    = TQRichTextRunEmojiDelegateGetAscentCallback;
    emojiCallbacks.getDescent   = TQRichTextRunEmojiDelegateGetDescentCallback;
    emojiCallbacks.getWidth     = TQRichTextRunEmojiDelegateGetWidthCallback;
     
    
    NSMutableAttributedString *imageAttributedString = [[NSMutableAttributedString alloc] initWithString:@" "];
    
    //
    CTRunDelegateRef runDelegate = CTRunDelegateCreate(&emojiCallbacks, (__bridge void*)self);
    [imageAttributedString addAttribute:(NSString *)kCTRunDelegateAttributeName value:(__bridge id)runDelegate range:NSMakeRange(0, 1)];
    CFRelease(runDelegate);
    
    [attString insertAttributedString:imageAttributedString atIndex:self.range.location];
    
    //[super replaceTextWithAttributedString:attString];
    [attString addAttribute:@"TQRichTextAttribute" value:self range:self.range];
    
}

- (BOOL)drawRunWithRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    NSString *str = [self.originalText substringWithRange:NSMakeRange(1, 3)];
    NSString *emojiString = [NSString stringWithFormat:@"f%@.png",str];
    UIImage *image = [UIImage imageNamed:emojiString];
    //CYLog_Info(@"the %@ rect is %@",self,NSStringFromCGRect(rect));
    
    if (image)
    {
        CGContextDrawImage(context, rect, image.CGImage);
    }
    
    return YES;
}

#pragma mark - RunDelegateCallback

void TQRichTextRunEmojiDelegateDeallocCallback(void *refCon)
{
    
}


//--上行高度
CGFloat TQRichTextRunEmojiDelegateGetAscentCallback(void *refCon)
{
    ChatImageUnit *run =(__bridge ChatImageUnit *) refCon;
    return run.originFont.ascender * kZoom;
}

//--下行高度
CGFloat TQRichTextRunEmojiDelegateGetDescentCallback(void *refCon)
{
    ChatImageUnit *run =(__bridge ChatImageUnit *) refCon;
    return run.originFont.descender * kZoom;
}

//-- 宽
CGFloat TQRichTextRunEmojiDelegateGetWidthCallback(void *refCon)
{
    ChatImageUnit *run =(__bridge ChatImageUnit *) refCon;
    return (run.originFont.ascender - run.originFont.descender) * kZoom;
}


@end
