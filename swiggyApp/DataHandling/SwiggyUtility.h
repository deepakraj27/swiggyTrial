//
//  SwiggyUtility.h
//  swiggyApp
//
//  Created by deepakraj murugesan on 20/10/16.
//  Copyright © 2016 deepakraj murugesan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@protocol alertViewBtnHandle <NSObject>
@required
-(void)alertbtn: (NSString*)btnHeading;
@end

@interface SwiggyUtility : NSObject
@property (nonatomic, weak)id<alertViewBtnHandle> delegate;
- (UIAlertController*)dynamicAlert:(NSString*)title :(NSString*) message :(NSArray*)dynamicBtn;
+ (BOOL)isConnectedTointernet;
@end
