//
//  SwiggyUtility.m
//  swiggyApp
//
//  Created by deepakraj murugesan on 20/10/16.
//  Copyright © 2016 deepakraj murugesan. All rights reserved.
//

#import "SwiggyUtility.h"
#import "Reachability.h"

@implementation SwiggyUtility

+ (BOOL)isConnectedTointernet{
    BOOL status = NO;
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    int networkStatus = reachability.currentReachabilityStatus;
    status = (networkStatus != NotReachable)? YES:NO;
    return status;
}

- (UIAlertController*)dynamicAlert:(NSString*)title :(NSString*) message :(NSArray*)dynamicBtn
{
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:title
                                  message:message
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    for (NSString * btnTitle in dynamicBtn) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:btnTitle
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction *action) {
                                                           //you can check here on what button is pressed using title
                                                           if ([self.delegate respondsToSelector:@selector(alertbtn:)])
                                                           {
                                                               [self.delegate alertbtn:btnTitle];
                                                           }
                                                       }];
        [alert addAction:action];
    }
    
    
    return alert;
}
@end
