// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to WHRegion.m instead.

#import "_WHRegion.h"

const struct WHRegionAttributes WHRegionAttributes = {
	.regionName = @"regionName",
};

const struct WHRegionRelationships WHRegionRelationships = {
	.sale = @"sale",
};

@implementation WHRegionID
@end

@implementation _WHRegion

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"WHRegion" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"WHRegion";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"WHRegion" inManagedObjectContext:moc_];
}

- (WHRegionID*)objectID {
	return (WHRegionID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic regionName;

@dynamic sale;

- (NSMutableSet*)saleSet {
	[self willAccessValueForKey:@"sale"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"sale"];

	[self didAccessValueForKey:@"sale"];
	return result;
}

@end

