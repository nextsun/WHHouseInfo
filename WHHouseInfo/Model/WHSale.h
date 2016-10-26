#import "_WHSale.h"


#import <MagicalRecord/MagicalRecord.h>


@interface WHSale : _WHSale {}
// Custom logic goes here.



+(void)updateData:(float)soldCount soldArea:(float)soldArea region:(WHRegion*)region category:(WHCategory*)category  forDate:(NSDate*)date;



@end
