#import "WHCategory.h"


@interface WHCategory ()

// Private interface goes here.

@end


@implementation WHCategory

// Custom logic goes here.




+(WHCategory*)fetchOrCreateWithName:(NSString*)categoryName
{
    WHCategory* item=nil;
    
    item= [WHCategory MR_findFirstByAttribute:WHCategoryAttributes.categoryName withValue:categoryName];
    
    if (item==nil) {
        item=[WHCategory MR_createEntity];
        item.categoryName = categoryName;
    }
    
    [item.managedObjectContext MR_saveToPersistentStoreAndWait];
    return item;
    
    
}


+(void)setUpDefaultData
{
    NSArray* defaultData = @[@"商品住房",
                             @"写字楼",
                             @"商业",
                             @"其他"];    
    
    [defaultData enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [self fetchOrCreateWithName:obj];
    }];
}


@end
