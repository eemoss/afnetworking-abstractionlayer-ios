afnetworking-abstractionlayer-ios
=================================

This is an AFNetworking abstraction layer for iOS.  It enables iOS 6 support with AFHTTPRequestOperationManager, while supporting AFHTTPSessionManager to prevent runaway memory growth. It also forms a layer between your application and AFNetworking, which provides a single choke point to implement changes to the AFNetworking APIs underneath.

Please see http://stackoverflow.com/questions/27023962/ios-8-x-afnetworking-memory-growth

AFNetworking 2.x has 2 entry points: 

 - **AFHTTPSessionManager.m** - Recommended for apps that target iOS 7 and iOS 8
 - **AFHTTPRequestOperationManager.m** - Recommended for apps that need to go back to iOS 6

My target application requires iOS 6 and up, so I started with AFHTTPRequestOperationManager.m.  Unfortunately, AFHTTPRequestOperationManager.m exhibits memory problems on iOS 8, whereas AFHTTPSessionManager.m does not (!).  Double unfortunately, the software APIs for these two managers are completely different.

The solution I found to be most effective was to build an abstraction layer between AFNetworking and the rest of my application. This abstraction layer provides a subset of the functionality of AFNetworking:

 - initWithBaseURL
 - getResponseSerializer - (Explicitly named so we don't get confused)
 - getRequestSerializer - (Explicitly named so we don't get confused)
 - setResponseSerializer - (Explicitly named so we don't get confused)
 - setRequestSerializer - (Explicitly named so we don't get confused)
 - set headers with setValue:forHTTPHeaderField:
 - GET
 - PUT
 - POST
 - DELETE
 - ... and the ability to cancel an operation

The PPAFHTTPBridge.m is the main entry point to AFNetworking, and dynamically selects either AFHTTPRequestOperationManager.m or AFHTTPSessionManager.m underneath depending on the version of iOS being executed upon.  Use the request and response serializers as you normally would in AFNetworking.  API calls will return a PPHTTPOperation.m, which is meant to form an abstraction above the AFHTTPRequestOperation or NSURLSessionDataTask.  In this current implementation, we have the ability to cancel the operation.

One advantage of an abstraction layer above AFNetworking is developers can effectively marshall in changes applied to AFNetworking underneath.  For example, as AFNetworking migrated from 1.x to 2.x, there was significant code-rework needed throughout everyone's applications to align with new APIs.  With an abstraction layer, you have the option of keeping your Application's APIs consistent while translating new AFNetworking APIs at one choke point.  For my team, this translates to an increase in development speed.
