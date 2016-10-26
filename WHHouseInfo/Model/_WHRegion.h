// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to WHRegion.h instead.

#import <CoreData/CoreData.h>

extern const struct WHRegionAttributes {
	__unsafe_unretained NSString *regionName;
} WHRegionAttributes;

extern const struct WHRegionRelationships {
	__unsafe_unretained NSString *sale;
} WHRegionRelationships;

@class WHSale;

@interface WHRegionID : NSManagedObjectID {}
@end

@interface _WHRegion : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) WHRegionID* objectID;

@property (nonatomic, strong) NSString* regionName;

//- (BOOL)validateRegionName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *sale;

- (NSMutableSet*)saleSet;

@end

@interface _WHRegion (SaleCoreDataGeneratedAccessors)
- (void)addSale:(NSSet*)value_;
- (void)removeSale:(NSSet*)value_;
- (void)addSaleObject:(WHSale*)value_;
- (void)removeSaleObject:(WHSale*)value_;

@end

@interface _WHRegion (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveRegionName;
- (void)setPrimitiveRegionName:(NSString*)value;

- (NSMutableSet*)primitiveSale;
- (void)setPrimitiveSale:(NSMutableSet*)value;

@end
