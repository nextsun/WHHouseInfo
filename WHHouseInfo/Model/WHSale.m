#import "WHSale.h"
#import "WHRegion.h"
#import "WHCategory.h"


@interface WHSale ()

// Private interface goes here.

@end


@implementation WHSale

// Custom logic goes here.

+(void)updateData:(float)soldCount soldArea:(float)soldArea region:(WHRegion*)region category:(WHCategory*)category  forDate:(NSDate*)date
{
    
    
//    NSLog(@"%@",date);
    
//    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"(recordDate == %@) AND (region.regionName == %@ ) AND (category.categoryName == %@)",date,region.regionName,category.categoryName];
    
    NSPredicate * predicate1 = [NSPredicate predicateWithFormat:@"recordDate == %@",date];
    NSPredicate * predicate2 = [NSPredicate predicateWithFormat:@"region == %@",region];
    NSPredicate * predicate3 = [NSPredicate predicateWithFormat:@"category == %@",category];
    
    
    NSCompoundPredicate* predicate = [NSCompoundPredicate andPredicateWithSubpredicates:@[predicate1,predicate2,predicate3]];
    
    WHSale* info =   [WHSale MR_findFirstWithPredicate:predicate];
    if (info == nil) {
        
        info = [WHSale MR_createEntity];
        info.recordDate = date;
        
        info.region = region;
        info.category = category;
        
        
    }
    info.soldCountValue = soldCount;
    info.soldAreaValue = soldArea;
    [info.managedObjectContext MR_saveToPersistentStoreAndWait];
}

@end
