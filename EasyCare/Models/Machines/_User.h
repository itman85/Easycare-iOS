// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to User.h instead.

#import <CoreData/CoreData.h>

extern const struct UserAttributes {
	__unsafe_unretained NSString *avatarThumbUrl;
	__unsafe_unretained NSString *avatarUrl;
	__unsafe_unretained NSString *email;
	__unsafe_unretained NSString *fullName;
	__unsafe_unretained NSString *token;
	__unsafe_unretained NSString *userID;
} UserAttributes;

@interface UserID : NSManagedObjectID {}
@end

@interface _User : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) UserID* objectID;

@property (nonatomic, strong) NSString* avatarThumbUrl;

//- (BOOL)validateAvatarThumbUrl:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* avatarUrl;

//- (BOOL)validateAvatarUrl:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* email;

//- (BOOL)validateEmail:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* fullName;

//- (BOOL)validateFullName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* token;

//- (BOOL)validateToken:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* userID;

@property (atomic) int32_t userIDValue;
- (int32_t)userIDValue;
- (void)setUserIDValue:(int32_t)value_;

//- (BOOL)validateUserID:(id*)value_ error:(NSError**)error_;

@end

@interface _User (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveAvatarThumbUrl;
- (void)setPrimitiveAvatarThumbUrl:(NSString*)value;

- (NSString*)primitiveAvatarUrl;
- (void)setPrimitiveAvatarUrl:(NSString*)value;

- (NSString*)primitiveEmail;
- (void)setPrimitiveEmail:(NSString*)value;

- (NSString*)primitiveFullName;
- (void)setPrimitiveFullName:(NSString*)value;

- (NSString*)primitiveToken;
- (void)setPrimitiveToken:(NSString*)value;

- (NSNumber*)primitiveUserID;
- (void)setPrimitiveUserID:(NSNumber*)value;

- (int32_t)primitiveUserIDValue;
- (void)setPrimitiveUserIDValue:(int32_t)value_;

@end
