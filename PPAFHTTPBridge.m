//
//  PPAFHTTPBridge.m
//
//  Created by David Moss
//  Provided under the Apache 2.0 License
//

#import "PPAFHTTPBridge.h"
#import "AFNetworking.h"

#import "PPAFHTTPRequestOperationManager.h"
#import "PPAFHTTPSessionManager.h"

@interface PPAFHTTPBridge ()
@property (nonatomic, strong) PPAFHTTPSessionManager *ios7Manager;
@property (nonatomic, strong) PPAFHTTPRequestOperationManager *ios6Manager;
@end

@implementation PPAFHTTPBridge


/**
 * Constructor
 * @param baseURL
 */
- (id) initWithBaseURL:(NSURL *)baseURL {
	self = [super init];
	if(self ) {
		if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
			self.ios7Manager = [[PPAFHTTPSessionManager alloc] initWithBaseURL:baseURL];
			self.ios6Manager = nil;
			_ios7Manager.responseSerializer = [AFHTTPResponseSerializer serializer];
			
		}
		else {
			self.ios6Manager = [[PPAFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
			self.ios7Manager = nil;
			_ios6Manager.responseSerializer = [AFHTTPResponseSerializer serializer];
		}
	}
	return self;
}

/**
 * @return the response serializer
 */
- (AFHTTPResponseSerializer <AFURLResponseSerialization> *)getResponseSerializer {
	if(_ios7Manager) {
		return _ios7Manager.responseSerializer;
		
	}
	else {
		return _ios6Manager.responseSerializer;
	}
}

/**
 * @return the request serializer
 */
- (AFHTTPRequestSerializer <AFURLRequestSerialization> *)getRequestSerializer {
	if(_ios7Manager) {
		return _ios7Manager.requestSerializer;
		
	}
	else {
		return _ios6Manager.requestSerializer;
	}
}

/**
 * Set the response serializer
 * @param responseSerializer
 */
- (void)setResponseSerializer:(AFHTTPResponseSerializer <AFURLResponseSerialization> *)responseSerializer {
	if(_ios7Manager) {
		_ios7Manager.responseSerializer = responseSerializer;
		
	}
	else {
		_ios6Manager.responseSerializer = responseSerializer;
	}
}

/**
 * Set the request serializer
 * @param requestSerializer
 */
- (void)setRequestSerializer:(AFHTTPRequestSerializer <AFURLRequestSerialization> *)requestSerializer {
	if(_ios7Manager) {
		_ios7Manager.requestSerializer = requestSerializer;
		
	}
	else {
		_ios6Manager.requestSerializer = requestSerializer;
	}
}

/**
 * Set the default value for the default HTTP Header field
 * Case-sensitive.  nil to erase it.
 * @param value
 * @param field
 */
- (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field {
	if(_ios7Manager) {
		[_ios7Manager.requestSerializer setValue:value forHTTPHeaderField:field];
		
	}
	else {
		[_ios6Manager.requestSerializer setValue:value forHTTPHeaderField:field];
	}
}

/**
 * @return the base URL
 */
- (NSURL *)getBaseURL {
	if(_ios7Manager) {
		return _ios7Manager.baseURL;
	}
	else {
		return _ios6Manager.baseURL;
	}
}

/**
 * Perform an operation that uploads data to the server
 */
- (PPHTTPOperation *)operationWithRequest:(NSURLRequest *)request
								  success:(void (^)(NSData *responseData))success
								  failure:(void (^)(NSError *error))failure {
	
	if(_ios7Manager) {
		NSURLSessionDataTask *task = [_ios7Manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
			if(error) {
				failure(error);
			}
			else {
				success(responseObject);
			}
		}];
		
		[task resume];
		
		return [[PPHTTPOperation alloc] initWithNSURLSessionDataTask:task];
	}
	else {
		AFHTTPRequestOperation *operation = [_ios6Manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
			success(operation.responseData);
			
		} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
			failure(error);
		}];
		
		[operation start];
		
		return [[PPHTTPOperation alloc] initWithAFHTTPRequestOperation:operation];
	}
}

/**
 * GET
 * @param URLString the full URL
 * @param success
 * @param failure
 */
- (PPHTTPOperation *)GET:(NSString *)URLString
				 success:(void (^)(NSData *responseData))success
				 failure:(void (^)(NSError *error))failure {
	
	if(_ios7Manager) {
		NSURLSessionDataTask *task = [_ios7Manager GET:URLString parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
			success(responseObject);
			
		} failure:^(NSURLSessionDataTask *task, NSError *error) {
			failure(error);
			
		}];
		
		return [[PPHTTPOperation alloc] initWithNSURLSessionDataTask:task];
		
	}
	else {
		AFHTTPRequestOperation *operation = [_ios6Manager GET:URLString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
			success(operation.responseData);
			
		} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
			failure(error);
			
		}];
		
		return [[PPHTTPOperation alloc] initWithAFHTTPRequestOperation:operation];
		
	}
}


/**
 * POST
 * @param URLString the full URL
 * @param success
 * @param failure
 */
- (PPHTTPOperation *)POST:(NSString *)URLString
				  success:(void (^)(NSData *responseData))success
				  failure:(void (^)(NSError *error))failure {
	
	if(_ios7Manager) {
		NSURLSessionDataTask *task = [_ios7Manager POST:URLString parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
			success(responseObject);
			
		} failure:^(NSURLSessionDataTask *task, NSError *error) {
			failure(error);
			
		}];
		
		return [[PPHTTPOperation alloc] initWithNSURLSessionDataTask:task];
		
	}
	else {
		AFHTTPRequestOperation *operation = [_ios6Manager POST:URLString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
			success(operation.responseData);
			
		} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
			failure(error);
			
		}];
		
		return [[PPHTTPOperation alloc] initWithAFHTTPRequestOperation:operation];
		
	}
}


/**
 * PUT
 * @param URLString the full URL
 * @param success
 * @param failure
 */
- (PPHTTPOperation *)PUT:(NSString *)URLString
				 success:(void (^)(NSData *responseData))success
				 failure:(void (^)(NSError *error))failure {
	if(_ios7Manager) {
		NSURLSessionDataTask *task = [_ios7Manager PUT:URLString parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
			success(responseObject);
			
		} failure:^(NSURLSessionDataTask *task, NSError *error) {
			failure(error);
			
		}];
		
		return [[PPHTTPOperation alloc] initWithNSURLSessionDataTask:task];
		
	}
	else {
		AFHTTPRequestOperation *operation = [_ios6Manager PUT:URLString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
			success(operation.responseData);
			
		} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
			failure(error);
			
		}];
		
		return [[PPHTTPOperation alloc] initWithAFHTTPRequestOperation:operation];
		
	}
}


/**
 * DELETE
 * @param URLString the full URL
 * @param success
 * @param failure
 */
- (PPHTTPOperation *)DELETE:(NSString *)URLString
					success:(void (^)(NSData *responseData))success
					failure:(void (^)(NSError *error))failure {
	
	if(_ios7Manager) {
		NSURLSessionDataTask *task = [_ios7Manager DELETE:URLString parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
			success(responseObject);
			
		} failure:^(NSURLSessionDataTask *task, NSError *error) {
			failure(error);
			
		}];
		
		return [[PPHTTPOperation alloc] initWithNSURLSessionDataTask:task];
		
	}
	else {
		AFHTTPRequestOperation *operation = [_ios6Manager DELETE:URLString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
			success(operation.responseData);
			
		} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
			failure(error);
			
		}];
		
		return [[PPHTTPOperation alloc] initWithAFHTTPRequestOperation:operation];
		
	}
}


@end
