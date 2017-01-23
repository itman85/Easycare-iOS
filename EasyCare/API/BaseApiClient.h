/*============================================================================
 PROJECT: EasyCare
 FILE:    BaseApiClient.h
 AUTHOR:  Vien Tran
 DATE:    12/12/14
 =============================================================================*/

/*============================================================================
 IMPORT
 =============================================================================*/
#import "AFHTTPRequestOperationManager.h"

/*============================================================================
 MACRO
 =============================================================================*/

/*============================================================================
 PROTOCOL
 =============================================================================*/

/*============================================================================
 Interface:   BaseApiClient
 =============================================================================*/


@interface BaseApiClient : AFHTTPRequestOperationManager

- (RACSignal*)enqueueRequest:(NSURLRequest*)request;

@end
