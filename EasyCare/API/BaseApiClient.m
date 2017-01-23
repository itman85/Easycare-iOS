/*============================================================================
 PROJECT: EasyCare
 FILE:    BaseApiClient.m
 AUTHOR:  Vien Tran
 DATE:    12/12/14
 =============================================================================*/

/*============================================================================
 IMPORT
 =============================================================================*/
#import "BaseApiClient.h"
#import "User.h"
/*============================================================================
 PRIVATE MACRO
 =============================================================================*/
typedef NS_ENUM(NSInteger, ApiStatusCode) {
    ApiStatusSuccess = 200,
    ApiStatusNotLogin = 401,
    ApiStatusError = 400
};
/*============================================================================
 PRIVATE INTERFACE
 =============================================================================*/

@implementation BaseApiClient

- (RACSignal *)enqueueRequest:(NSURLRequest *)request{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        AFHTTPRequestOperation *operation = [self performRequest:request withSubcriber:subscriber];
        
        return [RACDisposable disposableWithBlock:^{
            [operation cancel];
        }];
    }];
    
    return [signal replayLazily];
}

- (AFHTTPRequestOperation*)performRequest:(NSURLRequest*)request withSubcriber:(id<RACSubscriber>)subscriber{    
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {

        DLog(@"Response for %@: \n %@", request.URL.absoluteString, operation.responseString);
        
        NSInteger errorCode = [responseObject[@"code"] integerValue];
        if (errorCode == ApiStatusSuccess) {
            [subscriber sendNext:responseObject];
        }else {
            NSString *errorMessage = ERROR_MESSAGE_SERVER_PROBLEM;
            if (errorCode == ApiStatusNotLogin) {
                errorMessage = ERROR_MESSAGE_TOKEN_EXPIRE;
                
                [[[[User loggedUser] signalLogout] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
                    [appDelegate openLoginView];
                } error:^(NSError *error) {
                    [Utils showMessage:error.localizedDescription];
                }];
                
            }else if (errorCode == ApiStatusError){
//                NSDictionary *errorDict = responseObject[@"errors"];
//                if (errorDict && errorDict.allKeys.count > 0) {
//                    errorMessage = errorDict[errorDict.allKeys[0]];
//                }
                
                id errors = responseObject[@"errors"];
                if (errors && [errors isKindOfClass:[NSArray class]]) {
                    NSArray *errorArr = errors;
                    if (errorArr.count > 0) {
                        errorMessage = errorArr[0];
                    }
                }else if (errors && [errors isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *errorDict = errors;
                    if (errorDict.allKeys.count > 0) {
                        errorMessage = errorDict[errorDict.allKeys[0]];
                    }
                }
            }
            
            NSError *error = [NSError errorWithDomain:@"" code:0 userInfo:@{NSLocalizedDescriptionKey : errorMessage}];
            [subscriber sendError:error];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"Request fail %@: \n %@", request.URL.absoluteString, error.description);
        
        [subscriber sendError:error];
    }];
    
    operation.completionQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    [self.operationQueue addOperation:operation];
    
    return operation;
}

@end
