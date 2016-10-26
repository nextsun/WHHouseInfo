#import "_WHRegion.h"

#import <MagicalRecord/MagicalRecord.h>


@interface WHRegion : _WHRegion {}
// Custom logic goes here.



+(WHRegion*)fetchOrCreateWithName:(NSString*)regionName;


+(void)setUpDefaultData;


@end
