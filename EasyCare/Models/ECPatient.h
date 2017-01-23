/*============================================================================
 PROJECT: EasyCare
 FILE:    Patient.h
 AUTHOR:  Vien Tran
 DATE:    12/24/14
 =============================================================================*/

/*============================================================================
 IMPORT
 =============================================================================*/
#import <Foundation/Foundation.h>

/*============================================================================
 MACRO
 =============================================================================*/

/*============================================================================
 PROTOCOL
 =============================================================================*/

/*============================================================================
 Interface:   Patient
 =============================================================================*/


@interface ECPatient : NSObject

@property (nonatomic) NSNumber *patientID;
@property (nonatomic) NSString *fullName;
@property (nonatomic) NSString *birthday;
@property (nonatomic) NSString *address;
@property (nonatomic) NSString *avatarUrl;
@property (nonatomic) NSString *avatarThumbUrl;
@property (nonatomic) NSString *email;
@property (nonatomic) NSString *phoneNumber;
@property (nonatomic) NSNumber *visitsCount;
@property (nonatomic) NSNumber *cancelVisitsCount;
@property (nonatomic) NSNumber *commentCount;
@property (nonatomic) NSNumber *changeAppointmentCount;
@property (nonatomic) BOOL gender;


+ (ECPatient*)patientWithDictionary:(NSDictionary *)dict;
+ (RACSignal *)signalGetPatientsWithBanned:(BOOL)banned pageIndex:(NSInteger)pageIndex;

- (RACSignal *)signalBan;
- (RACSignal *)signalUnban;


@end
