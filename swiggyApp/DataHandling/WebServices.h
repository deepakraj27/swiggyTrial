//
//  WebServices.h
//  swiggyApp
//
//  Created by deepakraj murugesan on 20/10/16.
//  Copyright © 2016 deepakraj murugesan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WebServices : NSObject
+(WebServices*)sharedInstance;
typedef void (^JSONResponseBlockBumper)(NSDictionary* responseData, NSURLResponse *statusCode);
-(void)swiggyURL:(NSString *)urlPath HTTPmethod:(NSString *)MethodName forParameters:(NSString *)params Authorization: (NSString *)auth ContentType:(NSString *)content onCompletion:(JSONResponseBlockBumper)completionBlock;

@end
