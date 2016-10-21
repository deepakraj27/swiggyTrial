//
//  WebServices.m
//  swiggyApp
//
//  Created by deepakraj murugesan on 20/10/16.
//  Copyright © 2016 deepakraj murugesan. All rights reserved.
//

#import "WebServices.h"
#import "DefinesURL.h"
@implementation WebServices

#pragma mark - sharedInstance
+(WebServices*)sharedInstance {
    static WebServices *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}


#pragma mark - BumperURLFn
-(void)swiggyURL:(NSString *)urlPath HTTPmethod:(NSString *)MethodName forParameters:(NSString *)params Authorization: (NSString *)auth ContentType:(NSString *)content onCompletion:(JSONResponseBlockBumper)completionBlock{
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate:nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSString *pathString=[BaseURL stringByAppendingString:urlPath];
    NSURL * url = [NSURL URLWithString:[pathString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:MethodName];
    [request setValue:content forHTTPHeaderField:@"Content-Type"];
    [request setValue:auth forHTTPHeaderField:@"Authorization"];
    
    
    if ([MethodName isEqualToString:@"POST"] || [MethodName isEqualToString:@"PATCH"] ) {
        NSData *postData = [params dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setHTTPBody:postData];
    }
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:request
                                                       completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                      {
                                          NSLog(@"Response:%@ \n error:%@\n ", [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding], error);
                                          if(error == nil)
                                          {
                                              if (data != nil) {
                                                  NSError *errorPaserJSON = nil;
                                                  NSDictionary *jsonContents = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&errorPaserJSON];
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                      completionBlock(jsonContents, response);
                                                  });
                                              }
                                          }
                                          else{
                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                  completionBlock([NSDictionary dictionaryWithObject:[error localizedDescription] forKey:@"error"], response);
                                              });
                                          }
                                      }];
    [dataTask resume];
}

@end
