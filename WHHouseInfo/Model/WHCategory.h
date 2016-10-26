#import "_WHCategory.h"

#import <MagicalRecord/MagicalRecord.h>


@interface WHCategory : _WHCategory {}
// Custom logic goes here.

+(WHCategory*)fetchOrCreateWithName:(NSString*)categoryName;


+(void)setUpDefaultData;

@end
