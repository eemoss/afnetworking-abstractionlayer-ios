//
//  PPHTTPOperation.h
//
//  Created by David Moss
//  Provided under the Apache 2.0 License
//

#import <Foundation/Foundation.h>

#import "AFNetworking.h"

@interface PPHTTPOperation : NSObject

/**
 * iOS 7.x+ Constructor
 * @param task
 */
- (id) initWithNSURLSessionDataTask:(NSURLSessionDataTask *)task;

/**
 * iOS 6.x Constructor
 * @param operation
 */
- (id) initWithAFHTTPRequestOperation:(AFHTTPRequestOperation *)operation;


/**
 * Cancel this operation
 */
- (void)cancel;


@end
