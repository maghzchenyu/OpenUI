//
//  OpenAlertView.h
//  OPENUI
//
//  Created by chenyu on 14-4-8.
//
//

#import <UIKit/UIKit.h>

@interface OpenAlertView : UIAlertView

- (id)initWithContent:(NSString*)content Delegate:(NSObject*)openDelegate;

- (id)initWithContent:(NSString *)content;

@end
