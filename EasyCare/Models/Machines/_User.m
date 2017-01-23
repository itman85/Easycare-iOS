// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to User.m instead.

#import "_User.h"

const struct UserAttributes UserAttributes = {
	.avatarThumbUrl = @"avatarThumbUrl",
	.avatarUrl = @"avatarUrl",
	.email = @"email",
	.fullName = @"fullName",
	.token = @"token",
	.userID = @"userID",
};

@implementation UserID
@end

@implementation _User

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"User";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"User" inManagedObjectContext:moc_];
}

- (UserID*)objectID {
	return (UserID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"userIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"userID"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic avatarThumbUrl;

@dynamic avatarUrl;

@dynamic email;

@dynamic fullName;

@dynamic token;

@dynamic userID;

- (int32_t)userIDValue {
	NSNumber *result = [self userID];
	return [result intValue];
}

- (void)setUserIDValue:(int32_t)value_ {
	[self setUserID:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveUserIDValue {
	NSNumber *result = [self primitiveUserID];
	return [result intValue];
}

- (void)setPrimitiveUserIDValue:(int32_t)value_ {
	[self setPrimitiveUserID:[NSNumber numberWithInt:value_]];
}

@end

