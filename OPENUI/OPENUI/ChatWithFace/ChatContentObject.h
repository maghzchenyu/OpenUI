//
//  ChatContentObject.h
//  OPENUI
//
//  Created by chenyu on 14-4-8.
//
//

#import <Foundation/Foundation.h>

@interface ChatContentObject : NSObject

@property (nonatomic, strong) NSString *contentString;
@property (nonatomic, strong) NSString *attString;
@property (nonatomic, strong) NSString *timeString;
@property (nonatomic, strong) NSString *nameString;
@property (nonatomic, assign) NSInteger lineCount;

@end
