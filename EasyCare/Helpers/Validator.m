/*============================================================================
 PROJECT: EasyCare
 FILE:    Validator.m
 AUTHOR:  Vien Tran
 DATE:    12/17/14
 =============================================================================*/

/*============================================================================
 IMPORT
 =============================================================================*/
#import "Validator.h"

/*============================================================================
 PRIVATE MACRO
 =============================================================================*/
static NSString *const EMAIL_PATTERN = @"^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})";

/*============================================================================
 PRIVATE INTERFACE
 =============================================================================*/

@implementation Validator

#pragma mark - Private Methods
+ (BOOL)validateValue:(NSString *)value regularExpression:(NSString *)pattern
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES[d] %@", pattern];
    return [predicate evaluateWithObject:value];
}

#pragma mark - Public Methods
+ (NSString *)validateEmail:(NSString *)email{
    if ([self validateValue:email regularExpression:EMAIL_PATTERN]) {
        return nil;
    }
    return @"Địa chỉ email không hợp lệ";
}

+ (NSString *)validatePassword:(NSString *)password{
    if (password.length < 6) {
        return @"Mật khẩu phải chứa ít nhất 6 kí tự";
    }
    return nil;
}

@end
