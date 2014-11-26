//
//  PPAFHTTPBridge.h
//
//  Created by David Moss on 11/19/14.
//  Provided under the Apache 2.0 License
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "PPHTTPOperation.h"

@interface PPAFHTTPBridge : NSObject

/**
 * Constructor
 * @param baseURL
 */
- (id) initWithBaseURL:(NSURL *)baseURL;

/**
 * @return the response serializer
 */
- (AFHTTPResponseSerializer <AFURLResponseSerialization> *)getResponseSerializer;

/**
 * @return the request serializer
 */
- (AFHTTPRequestSerializer <AFURLRequestSerialization> *)getRequestSerializer;

/**
 * Set the response serializer
 * @param responseSerializer
 */
- (void)setResponseSerializer:(AFHTTPResponseSerializer <AFURLResponseSerialization> *)responseSerializer;

/**
 * Set the request serializer
 * @param requestSerializer
 */
- (void)setRequestSerializer:(AFHTTPRequestSerializer <AFURLRequestSerialization> *)requestSerializer;

/**
 * @return the base URL
 */
- (NSURL *)getBaseURL;

/**
 * Set the default value for the default HTTP Header field
 * Case-sensitive.  nil to erase it.
 * @param value
 * @param field
 */
- (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field;


/**
 * Perform an operation that uploads data to the server
 */
- (PPHTTPOperation *)operationWithRequest:(NSURLRequest *)request
													success:(void (^)(NSData *responseData))success
													failure:(void (^)(NSError *error))failure;

/**
 * GET
 * @param URLString the full URL
 * @param success
 * @param failure
 */
- (PPHTTPOperation *)GET:(NSString *)URLString
						success:(void (^)(NSData *responseData))success
						failure:(void (^)(NSError *error))failure;


/**
 * POST
 * @param URLString the full URL
 * @param success
 * @param failure
 */
- (PPHTTPOperation *)POST:(NSString *)URLString
						 success:(void (^)(NSData *responseData))success
						 failure:(void (^)(NSError *error))failure;


/**
 * PUT
 * @param URLString the full URL
 * @param success
 * @param failure
 */
- (PPHTTPOperation *)PUT:(NSString *)URLString
						success:(void (^)(NSData *responseData))success
						failure:(void (^)(NSError *error))failure;


/**
 * DELETE
 * @param URLString the full URL
 * @param success
 * @param failure
 */
- (PPHTTPOperation *)DELETE:(NSString *)URLString
						   success:(void (^)(NSData *responseData))success
						   failure:(void (^)(NSError *error))failure;




@end
