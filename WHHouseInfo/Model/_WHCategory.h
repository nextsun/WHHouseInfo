// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to WHCategory.h instead.

#import <CoreData/CoreData.h>

extern const struct WHCategoryAttributes {
	__unsafe_unretained NSString *categoryName;
} WHCategoryAttributes;

extern const struct WHCategoryRelationships {
	__unsafe_unretained NSString *sale;
} WHCategoryRelationships;

@class WHSale;

@interface WHCategoryID : NSManagedObjectID {}
@end

@interface _WHCategory : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) WHCategoryID* objectID;

@property (nonatomic, strong) NSString* categoryName;

//- (BOOL)validateCategoryName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *sale;

- (NSMutableSet*)saleSet;

@end

@interface _WHCategory (SaleCoreDataGeneratedAccessors)
- (void)addSale:(NSSet*)value_;
- (void)removeSale:(NSSet*)value_;
- (void)addSaleObject:(WHSale*)value_;
- (void)removeSaleObject:(WHSale*)value_;

@end

@interface _WHCategory (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveCategoryName;
- (void)setPrimitiveCategoryName:(NSString*)value;

- (NSMutableSet*)primitiveSale;
- (void)setPrimitiveSale:(NSMutableSet*)value;

@end
