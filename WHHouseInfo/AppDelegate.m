//
//  AppDelegate.m
//  WHHouseInfo
//
//  Created by Lei Sun on 3/30/16.
//  Copyright © 2016 IBM. All rights reserved.
//

#import "AppDelegate.h"


#import <MagicalRecord/MagicalRecord.h>

#import "WHRegion.h"
#import "WHCategory.h"
#import "WHSale.h"
#import "ASIHTTPRequest.h"


#import "HTMLNode.h"
#import "NSDate-Helper.h"
#import "ASINetworkQueue.h"


static NSString * const kRecordsStoreName = @"WHHouseInfo.sqlite";

@interface AppDelegate ()
@property(nonatomic,strong)ASINetworkQueue* networkQueue;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    NSLog(@"%@",NSTemporaryDirectory());
    
    
     [self copyDefaultStoreIfNecessary];
    [MagicalRecord setupCoreDataStackWithStoreNamed:kRecordsStoreName];
    
    
//    NSLog(@"")
    

    
    
    dispatch_async(dispatch_queue_create("updateSalesData", NULL), ^{
        
        [self updateSalesData];

    });
    
    
    
//          [self fetchDataWithIndex:24183];
    
//    [self performSelector:@selector(generateDefaultDB) withObject:nil afterDelay:1];
    
    return YES;
}


-(void)generateDefaultDB
{
//    [WHRegion setUpDefaultData];
//    [WHCategory setUpDefaultData];

    
        NSInteger startIndex = 21890;
        NSInteger endIndex = 24187;
    
        NSInteger fromIndex = endIndex-500;
        NSInteger toIndex = endIndex;
    
        for (NSInteger i = fromIndex; i<=toIndex; i++) {
             [self fetchDataWithIndex:i];
        }

    
    [[NSUserDefaults standardUserDefaults] setObject:@(24187) forKey:@"lastFetchIndex"];
    [[NSUserDefaults standardUserDefaults] setObject:[NSDate dateFromString:@"20161006" withFormat:@"yyyyMMdd"] forKey:@"lastFetchDate"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    

    
}


-(void)updateSalesData
{
    //    [WHSale MR_findAll];
    
    [[NSUserDefaults standardUserDefaults] registerDefaults:@{@"lastFetchDate":[NSDate dateFromString:@"20161001" withFormat:@"yyyyMMdd"],@"lastFetchIndex":@(24182)}];
    
    NSDate* lastFetchDate=  [[NSUserDefaults standardUserDefaults] objectForKey:@"lastFetchDate"];
    double lastFetchIndex=  [[[NSUserDefaults standardUserDefaults] objectForKey:@"lastFetchIndex"] doubleValue];
    
    NSInteger days =  [[NSDate date] timeIntervalSinceDate:lastFetchDate]/3600/24;
    
    
    days= days+days*0.1;
    
        for (NSInteger i = 1; i < days; i++) {
            
             [self fetchDataWithIndex:lastFetchIndex+i];
        }
        

    
    

    
//    NSInteger startIndex = 21890;
//    NSInteger endIndex = 24187;
//    
//    NSInteger fromIndex = endIndex-30;
//    NSInteger toIndex = endIndex;
//    
//    for (NSInteger i = fromIndex; i<=toIndex; i++) {
//         [self fetchDataWithIndex:i];
//    }
//    
   
//      [self fetchDataWithIndex:24183];
    
    
    
}
- (void) copyDefaultStoreIfNecessary;
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSURL *storeURL = [NSPersistentStore MR_urlForStoreName:kRecordsStoreName];
    
    NSLog(@"%@",storeURL);
    // If the expected store doesn't exist, copy the default store.
    if (![fileManager fileExistsAtPath:[storeURL path]])
    {
        NSString *defaultStorePath = [[NSBundle mainBundle] pathForResource:[kRecordsStoreName stringByDeletingPathExtension] ofType:[kRecordsStoreName pathExtension]];
        
        if (defaultStorePath)
        {
            NSError *error;
            BOOL success = [fileManager copyItemAtPath:defaultStorePath toPath:[storeURL path] error:&error];
            if (!success)
            {
                NSLog(@"Failed to install default record store");
            }
        }
    }
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}




-(void)requestUrl:(NSString*)url completionBlock:(void (^)(NSData* htmlData))bloc
{
 
    
    if (self.networkQueue == nil) {
        
        self.networkQueue = [ASINetworkQueue queue];
        self.networkQueue.delegate = self;
        self.networkQueue.maxConcurrentOperationCount = 10;
        
        
        [self.networkQueue setQueueDidFinishSelector:@selector(allRequestFinished:)];
        
//        [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
//            
//            NSLog(@"operationCount:%lu",(unsigned long)self.networkQueue.operationCount);
//            
//        }];
        
        [self.networkQueue go];
        
        
        NSLog(@"Start At %@",[NSDate date]);

       
        [self.networkQueue setUserInfo:@{@"beginDate":[NSDate date]}];
       
        
    }
    
    
    ASIHTTPRequest* req = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:url]];
    //    req.setre
    __weak ASIHTTPRequest* request = req;
    [request setCompletionBlock:^{
        
        
        
        NSLog(@"finish %@",request.url.absoluteString);
        bloc(request.responseData);
        
    }];
    
    
    [self.networkQueue addOperation:req];
    
    
    
//    [request startAsynchronous];
    
    
}
-(void)allRequestFinished:(ASINetworkQueue*)queue
{
    
    NSDate* beginDate = queue.userInfo[@"beginDate"];
    NSDate* finishedDate = [NSDate date];
    
    NSTimeInterval cost= [finishedDate timeIntervalSinceDate:beginDate];
    
    NSLog(@"All Finished!!!\nSpend %f seconds",cost);
}

-(void)convertHtmlDataAndSaveToDB:(NSData*)htmlData tag:(NSInteger)index
{
    
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSString* responseString  =[[NSString alloc] initWithData:htmlData encoding:enc];
    
    
    
    
    NSString* tempStr = [responseString componentsSeparatedByString:@"</html>"][1];
    
    tempStr = [tempStr componentsSeparatedByString:@"<html>"][0];
    
//     NSLog(@"%@",tempStr);
    
    if (!([tempStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length>0)) {
        return;
    }
    
    
    NSString* htmlString = [NSString stringWithFormat:@"<html><body>%@</body></html>",tempStr];
    
    NSError *error = nil;
    
    HTMLParser *parser = [[HTMLParser alloc] initWithString:htmlString error:&error];
    if (error) {
        NSLog(@"Error: %@", error);
        return;
    }
    
    //    HTMLNode
    
    HTMLNode *bodyNode = [parser body];
    
     HTMLNode *artibody  = [bodyNode findChildOfClass:@"artibody"];
    
    
    HTMLNode *newstitle  = [bodyNode findChildOfClass:@"newstitle"];
    
//    NSLog(@"%@", newstitle.allContents);
    
    
    NSDate* date = [NSDate dateFromString:newstitle.allContents withFormat:@"yyyy年MM月d日新建商品房成交统计情况"];
    

    
    
            
            NSArray* trs =  [[artibody findChildTag:@"table"] findChildTags:@"tr"];
            
            
            [trs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                HTMLNode *tr = obj;
                
                
                
                if (idx == 0 || idx == 1) {
//                    NSLog(@"%@", tr.allContents);
                }
                else  if (idx == trs.count-1||idx == trs.count-2||idx == trs.count-3)
                {
                    
                    
//                    NSLog(@"%@", tr.allContents);
                    
                    
                    
                    
                }else
                {
                    NSArray* tds =  [tr findChildTags:@"td"];
                    
                    
                    NSString* regionName = [[tds[0] allContents] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                    
                    
                    
                    double (^getDoubleValueFromHTMLNode)(HTMLNode* node) = ^(HTMLNode* node){
                        
                        return [[[node allContents] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] doubleValue];;
                    };
                    
                    CGFloat value1 = getDoubleValueFromHTMLNode(tds[1]);
                    CGFloat value2 = getDoubleValueFromHTMLNode(tds[2]);
                    CGFloat value3 = getDoubleValueFromHTMLNode(tds[3]);
                    CGFloat value4 = getDoubleValueFromHTMLNode(tds[4]);
                    CGFloat value5 = getDoubleValueFromHTMLNode(tds[5]);
                    CGFloat value6 = getDoubleValueFromHTMLNode(tds[6]);
                    CGFloat value7 = getDoubleValueFromHTMLNode(tds[7]);
                    CGFloat value8 = getDoubleValueFromHTMLNode(tds[8]);
                    
//                    
//                    NSLog(@"%@", regionName);
//                    
//                    NSLog(@"%@、%@、%@", [tds[1] allContents],[tds[1] contents],[tds[1] rawContents]);
//                    
//                    NSLog(@"%f", value1);
//                    NSLog(@"%f", value2);
//                    NSLog(@"%f", value3);
//                    NSLog(@"%f", value4);
//                    NSLog(@"%f", value5);
//                    NSLog(@"%f", value6);
//                    NSLog(@"%f", value7);
//                    NSLog(@"%f", value8);
                    
                    
                    //                    [tds enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    //                        
                    //                         HTMLNode *td = obj;
                    //                        
                    //                        NSLog(@"%@", td.allContents);
                    //                        
                    //                    }];
                    
                    WHRegion* region = [WHRegion fetchOrCreateWithName:regionName];
                    
                    
                     WHCategory* category1 = [WHCategory fetchOrCreateWithName:@"商品住房"];
                     WHCategory* category2 = [WHCategory fetchOrCreateWithName:@"写字楼"];
                     WHCategory* category3 = [WHCategory fetchOrCreateWithName:@"商业"];
                     WHCategory* category4 = [WHCategory fetchOrCreateWithName:@"其他"];
                    
                    
                    
                    [WHSale updateData:value1 soldArea:value2 region:region category:category1 forDate:date];
                    [WHSale updateData:value3 soldArea:value4 region:region category:category2 forDate:date];
                    [WHSale updateData:value5 soldArea:value6 region:region category:category3 forDate:date];
                    [WHSale updateData:value7 soldArea:value8 region:region category:category4 forDate:date];

                    
                    
                }
                
                
                
                
            }];
    
    if (trs.count>0) {
        
        double lastFetchIndex=  [[[NSUserDefaults standardUserDefaults] objectForKey:@"lastFetchIndex"] doubleValue];
        
        if (lastFetchIndex < index) {
            
            [[NSUserDefaults standardUserDefaults] setObject:@(index) forKey:@"lastFetchIndex"];
            [[NSUserDefaults standardUserDefaults] setObject:date forKey:@"lastFetchDate"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }

    }

    
   
//    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    
    
}


-(void)fetchDataWithIndex:(NSInteger)index
{
    
    NSString* url =  [NSString stringWithFormat:@"http://scxx.whfcj.gov.cn/scxxbackstage/whfcj/contents/854/%ld.html",(long)index];
    
   
    [self requestUrl:url completionBlock:^(NSData *htmlData) {
        
//         NSLog(@"%@",url);
        [self convertHtmlDataAndSaveToDB:htmlData tag:index];
    }];
    
}

@end
