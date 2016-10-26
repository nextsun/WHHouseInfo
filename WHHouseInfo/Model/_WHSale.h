// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to WHSale.h instead.

#import <CoreData/CoreData.h>

extern const struct WHSaleAttributes {
	__unsafe_unretained NSString *recordDate;
	__unsafe_unretained NSString *soldArea;
	__unsafe_unretained NSString *soldCount;
} WHSaleAttributes;

extern const struct WHSaleRelationships {
	__unsafe_unretained NSString *category;
	__unsafe_unretained NSString *region;
} WHSaleRelationships;

@class WHCategory;
@class WHRegion;

@interface WHSaleID : NSManagedObjectID {}
@end

@interface _WHSale : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) WHSaleID* objectID;

@property (nonatomic, strong) NSDate* recordDate;

//- (BOOL)validateRecordDate:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* soldArea;

@property (atomic) double soldAreaValue;
- (double)soldAreaValue;
- (void)setSoldAreaValue:(double)value_;

//- (BOOL)validateSoldArea:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* soldCount;

@property (atomic) double soldCountValue;
- (double)soldCountValue;
- (void)setSoldCountValue:(double)value_;

//- (BOOL)validateSoldCount:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) WHCategory *category;

//- (BOOL)validateCategory:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) WHRegion *region;

//- (BOOL)validateRegion:(id*)value_ error:(NSError**)error_;

@end

@interface _WHSale (CoreDataGeneratedPrimitiveAccessors)

- (NSDate*)primitiveRecordDate;
- (void)setPrimitiveRecordDate:(NSDate*)value;

- (NSNumber*)primitiveSoldArea;
- (void)setPrimitiveSoldArea:(NSNumber*)value;

- (double)primitiveSoldAreaValue;
- (void)setPrimitiveSoldAreaValue:(double)value_;

- (NSNumber*)primitiveSoldCount;
- (void)setPrimitiveSoldCount:(NSNumber*)value;

- (double)primitiveSoldCountValue;
- (void)setPrimitiveSoldCountValue:(double)value_;

- (WHCategory*)primitiveCategory;
- (void)setPrimitiveCategory:(WHCategory*)value;

- (WHRegion*)primitiveRegion;
- (void)setPrimitiveRegion:(WHRegion*)value;

@end
