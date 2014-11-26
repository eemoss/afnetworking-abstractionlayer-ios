//
//  PPHTTPOperation.m
//
//  Created by David Moss
//  Provided under the Apache 2.0 License
//

#import "PPHTTPOperation.h"

@interface PPHTTPOperation ()
@property (nonatomic, strong) NSURLSessionDataTask *task;
@property (nonatomic, strong) AFHTTPRequestOperation *operation;
@end

@implementation PPHTTPOperation

- (id) initWithNSURLSessionDataTask:(NSURLSessionDataTask *)task {
	self = [super init];
	if(self) {
		self.task = task;
		self.operation = nil;
	}
	return self;
}

- (id) initWithAFHTTPRequestOperation:(AFHTTPRequestOperation *)operation {
	self = [super init];
	if(self) {
		self.operation = operation;
		self.task = nil;
	}
	return self;
}

- (void)cancel {
	if(_task) {
		[_task cancel];
	}
	else {
		[_operation cancel];
	}
}


@end
