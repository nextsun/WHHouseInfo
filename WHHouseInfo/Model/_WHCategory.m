// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to WHCategory.m instead.

#import "_WHCategory.h"

const struct WHCategoryAttributes WHCategoryAttributes = {
	.categoryName = @"categoryName",
};

const struct WHCategoryRelationships WHCategoryRelationships = {
	.sale = @"sale",
};

@implementation WHCategoryID
@end

@implementation _WHCategory

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"WHCategory" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"WHCategory";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"WHCategory" inManagedObjectContext:moc_];
}

- (WHCategoryID*)objectID {
	return (WHCategoryID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic categoryName;

@dynamic sale;

- (NSMutableSet*)saleSet {
	[self willAccessValueForKey:@"sale"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"sale"];

	[self didAccessValueForKey:@"sale"];
	return result;
}

@end

