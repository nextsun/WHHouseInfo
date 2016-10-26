#import "WHRegion.h"


@interface WHRegion ()

// Private interface goes here.

@end


@implementation WHRegion

// Custom logic goes here.


+(WHRegion*)fetchOrCreateWithName:(NSString*)regionName
{
  
      WHRegion* region=nil;
    
    region= [WHRegion MR_findFirstByAttribute:WHRegionAttributes.regionName withValue:regionName];
    
    if (region==nil) {
        region=[WHRegion MR_createEntity];
        region.regionName = regionName;
    }
    
    [region.managedObjectContext MR_saveToPersistentStoreAndWait];
    return region;
    
    
}


+(void)setUpDefaultData
{
    
    NSArray* defaultData = @[@"江岸区",
                             @"江汉区",
                             @"硚口区",
                             @"汉阳区",
                             @"青山区",
                             @"武昌区",
                             @"洪山区",
                             @"东西湖区",
                             @"东湖高新区",
                             @"经济开发区",
                             @"江夏区",
                             @"黄陂区",
                             @"蔡甸区",
                             @"新洲区",
                             @"汉南区"];
    [defaultData enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [self fetchOrCreateWithName:obj];
    }];
    
}

@end
