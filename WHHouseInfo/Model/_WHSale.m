// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to WHSale.m instead.

#import "_WHSale.h"

const struct WHSaleAttributes WHSaleAttributes = {
	.recordDate = @"recordDate",
	.soldArea = @"soldArea",
	.soldCount = @"soldCount",
};

const struct WHSaleRelationships WHSaleRelationships = {
	.category = @"category",
	.region = @"region",
};

@implementation WHSaleID
@end

@implementation _WHSale

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"WHSale" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"WHSale";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"WHSale" inManagedObjectContext:moc_];
}

- (WHSaleID*)objectID {
	return (WHSaleID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"soldAreaValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"soldArea"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"soldCountValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"soldCount"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic recordDate;

@dynamic soldArea;

- (double)soldAreaValue {
	NSNumber *result = [self soldArea];
	return [result doubleValue];
}

- (void)setSoldAreaValue:(double)value_ {
	[self setSoldArea:[NSNumber numberWithDouble:value_]];
}

- (double)primitiveSoldAreaValue {
	NSNumber *result = [self primitiveSoldArea];
	return [result doubleValue];
}

- (void)setPrimitiveSoldAreaValue:(double)value_ {
	[self setPrimitiveSoldArea:[NSNumber numberWithDouble:value_]];
}

@dynamic soldCount;

- (double)soldCountValue {
	NSNumber *result = [self soldCount];
	return [result doubleValue];
}

- (void)setSoldCountValue:(double)value_ {
	[self setSoldCount:[NSNumber numberWithDouble:value_]];
}

- (double)primitiveSoldCountValue {
	NSNumber *result = [self primitiveSoldCount];
	return [result doubleValue];
}

- (void)setPrimitiveSoldCountValue:(double)value_ {
	[self setPrimitiveSoldCount:[NSNumber numberWithDouble:value_]];
}

@dynamic category;

@dynamic region;

@end

