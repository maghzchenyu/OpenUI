//
//  ChatContextView.m
//  OPENUI
//
//  Created by chenyu on 14-4-8.
//
//

#import "ChatContextView.h"
#import "Header.h"

@implementation ChatContextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _text = @"";
        _textColor = [UIColor blackColor];
        _font = [UIFont systemFontOfSize:18.0];
        _lineSpacing = 1.5;
        self.chatUnitArray = [[NSMutableArray alloc] init];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    if ([self.chatUnitArray count]>0)
    {
        [self.chatUnitArray removeAllObjects];
    }
    
    NSMutableAttributedString* attString = [[NSMutableAttributedString alloc] initWithString:[self analyzedWithText:self.chatUnitArray withString:_text]];
    
    //set the font
    CTFontRef aFont = CTFontCreateWithName((__bridge CFStringRef)self.font.fontName, self.font.pointSize, NULL);
    [attString addAttribute:(NSString*)kCTFontAttributeName value:(__bridge id)aFont range:NSMakeRange(0,attString.length)];
    CFRelease(aFont);
    
    //set the color
    [attString addAttribute:(NSString*)kCTForegroundColorAttributeName value:self.textColor range:NSMakeRange(0, attString.length)];
    
    for (ChatImageUnit *textRun in self.chatUnitArray)
    {
        [textRun replaceTextWithAttributedString:attString];
    }
    
    //get the current context and modify the coordiate
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGAffineTransform textTran = CGAffineTransformIdentity;
    textTran = CGAffineTransformMakeTranslation(0.0, self.bounds.size.height);
    textTran = CGAffineTransformScale(textTran, 1.0, -1.0);
    CGContextConcatCTM(context, textTran);
    
    //draw
    int lineCount = 0;
    CFRange lineRange = CFRangeMake(0,0);
    CTTypesetterRef typeSetter = CTTypesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attString);
    float drawLineX = 0;
    float drawLineY = self.bounds.origin.y + self.bounds.size.height - self.font.ascender;
    
    BOOL drawFlag = YES;
    while(drawFlag)
    {
        CFIndex testLineLength = CTTypesetterSuggestLineBreak(typeSetter,lineRange.location,self.bounds.size.width);
        check:  lineRange = CFRangeMake(lineRange.location,testLineLength);
        CTLineRef line = CTTypesetterCreateLine(typeSetter,lineRange);
        CFArrayRef runs = CTLineGetGlyphRuns(line);
        
        //边界检查
        CTRunRef lastRun = CFArrayGetValueAtIndex(runs, CFArrayGetCount(runs) - 1);
        CGFloat lastRunAscent;
        CGFloat laseRunDescent;
        CGFloat lastRunWidth  = CTRunGetTypographicBounds(lastRun, CFRangeMake(0,0), &lastRunAscent, &laseRunDescent, NULL);
        CGFloat lastRunPointX = drawLineX + CTLineGetOffsetForStringIndex(line, CTRunGetStringRange(lastRun).location, NULL);
        
        if ((lastRunWidth + lastRunPointX) > self.bounds.size.width)
        {
            testLineLength--;
            CFRelease(line);
            goto check;
        }
        
        //绘制普通行元素
        drawLineX = CTLineGetPenOffsetForFlush(line,0,self.bounds.size.width);
        CGContextSetTextPosition(context,drawLineX,drawLineY);
        CTLineDraw(line,context);
        
        CYLog_Info(@"the run count is %lu",CFArrayGetCount(runs));
        
        //绘制替换过的特殊文本单元
        for (int i = 0; i < CFArrayGetCount(runs); i++)
        {
            CTRunRef run = CFArrayGetValueAtIndex(runs, i);
            NSDictionary* attributes = (__bridge NSDictionary*)CTRunGetAttributes(run);
            ChatImageUnit *textRun = [attributes objectForKey:@"TQRichTextAttribute"];
            
            if (textRun)
            {
                CGFloat runAscent,runDescent;
                CGFloat runWidth  = CTRunGetTypographicBounds(run, CFRangeMake(0,0), &runAscent, &runDescent, NULL);
                
                CGFloat runHeight = runAscent + (-runDescent);
                
                CGFloat runPointX = drawLineX + CTLineGetOffsetForStringIndex(line, CTRunGetStringRange(run).location, NULL);
                CGFloat runPointY = drawLineY - (-runDescent);
                CGRect runRect = CGRectMake(runPointX, runPointY, runWidth, runHeight);
                BOOL isDraw = [textRun drawRunWithRect:runRect];
                NSLog(@"the isDraw %d",isDraw);
                
                /*
                if (textRun.isResponseTouch)
                {
                    if (isDraw)
                    {
                        [self.richTextRunRectDic setObject:textRun forKey:[NSValue valueWithCGRect:runRect]];
                    }
                    else
                    {
                        runRect = CTRunGetImageBounds(run, context, CFRangeMake(0, 0));
                        runRect.origin.x = runPointX;
                        [self.richTextRunRectDic setObject:textRun forKey:[NSValue valueWithCGRect:runRect]];
                    }
                 }
                 */
            }
        }
        
        CFRelease(line);
        
        if(lineRange.location + lineRange.length >= attString.length)
        {
            drawFlag = NO;
        }
        
        lineCount++;
        drawLineY -= self.font.ascender + (- self.font.descender) + self.lineSpacing;
        lineRange.location += lineRange.length;
    }
    
    CFRelease(typeSetter);
}

- (void)setText:(NSString *)text
{
    _text = text;
    [self setNeedsDisplay];
}

- (NSString*)analyzedWithText:(NSMutableArray *)unitArray withString:(NSString *)string
{
    NSMutableArray *runArray = unitArray;
    NSString *markL = @"[";
    NSString *markR = @"]";
    NSMutableArray *stack = [[NSMutableArray alloc] init];
    NSMutableString *newString = [[NSMutableString alloc] initWithCapacity:string.length];
    
    //偏移索引 由于会把长度大于1的字符串替换成一个空白字符。这里要记录每次的偏移了索引。以便简历下一次替换的正确索引
    int offsetIndex = 0;
    
    for (int i = 0; i < string.length; i++)
    {
        NSString *s = [string substringWithRange:NSMakeRange(i, 1)];
        
        if (([s isEqualToString:markL]) || ((stack.count > 0) && [stack[0] isEqualToString:markL]))
        {
            if (([s isEqualToString:markL]) && ((stack.count > 0) && [stack[0] isEqualToString:markL]))
            {
                for (NSString *c in stack)
                {
                    [newString appendString:c];
                }
                [stack removeAllObjects];
            }
            
            [stack addObject:s];
            
            if ([s isEqualToString:markR] || (i == string.length - 1))
            {
                NSMutableString *emojiStr = [[NSMutableString alloc] init];
                for (NSString *c in stack)
                {
                    [emojiStr appendString:c];
                }
                
                if ([[ChatImageUnit emojiStringArray] containsObject:emojiStr])
                {
                    //TQRichTextEmojiRun *emoji = [[TQRichTextEmojiRun alloc] init];
                    ChatImageUnit *emoji = [[ChatImageUnit alloc] init];
                    emoji.range = NSMakeRange(i + 1 - emojiStr.length - offsetIndex, 1);
                    emoji.originalText = emojiStr;
                    [runArray addObject:emoji];
                    [newString appendString:@" "];
                    offsetIndex += emojiStr.length - 1;
                }
                else
                {
                    [newString appendString:emojiStr];
                }
                
                [stack removeAllObjects];
            }
        }
        else
        {
            [newString appendString:s];
        }
    }
    [self.chatUnitArray makeObjectsPerformSelector:@selector(setOriginFont:) withObject:self.font];
    return newString;
}

@end
