//
//  SecondViewController.m
//  WHHouseInfo
//
//  Created by Lei Sun on 3/30/16.
//  Copyright © 2016 IBM. All rights reserved.
//

#import "SecondViewController.h"
#import "WHSale.h"
#import "WHRegion.h"
#import "WHCategory.h"
#import "NSDate-Helper.h"
#import "AMPopTip.h"
#import "FSCalendar.h"

@interface SecondViewController ()

@property(nonatomic,strong)NSDate* date;
@property(nonatomic,strong)NSArray* datas;
@property(nonatomic,strong)AMPopTip* popTip;
@end

@implementation SecondViewController


-(void)updateTitle
{
    
    UIButton* titleView  = (UIButton*)self.navigationItem.titleView;
    
    if (![titleView isKindOfClass:[UIButton class]]) {
        
        titleView = [[UIButton alloc] initWithFrame:(CGRectMake(0, 2, self.view.frame.size.width-100, 40))];
        [titleView addTarget:self action:@selector(titleAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [titleView setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        self.navigationItem.titleView = titleView;
    }
    NSString* titleString = [[self.date stringWithFormat:@"yyyy-MM-dd EEEE"] stringByAppendingString:@"▾"];
    
    [((UIButton*)titleView) setTitle:titleString forState:(UIControlStateNormal)];
}

-(void)titleAction:(UIButton*)btn
{
    
    
   
    
     // Configure your view
    
    if (!self.popTip) {
        
        self.popTip = [AMPopTip popTip];
        self.popTip.popoverColor = [UIColor darkGrayColor];
        
       
        
        self.popTip.shouldDismissOnTapOutside = YES;


    }
    
    FSCalendar *calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(0, 0, 320, 300)];
    calendar.dataSource = self;
    calendar.delegate = self;
    calendar.backgroundColor = [UIColor whiteColor];
    
    [self.popTip showCustomView:calendar direction:AMPopTipDirectionDown inView:self.navigationController.view fromFrame:UIEdgeInsetsInsetRect(btn.frame, UIEdgeInsetsMake(20, 0, -20, 0))];
    
}
- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date{
    
    [self.popTip hide];
    
    self.date = [date beginningOfDay];
    
    [self reloadData];
    
    
}

- (void)hsDatePickerPickedDate:(NSDate *)date
{
    
    
    self.date = [date beginningOfDay] ;
    
    
    [self reloadData];

}
-(void)goPrev
{
    
    self.date = [[self.date dateAfterDay:-50] beginningOfDay] ;
    
    [self reloadData];
    
}
-(void)goNext
{
    
    self.date = [[self.date dateAfterDay:1] beginningOfDay] ;
    
    
    [self reloadData];
    
}

-(void)reloadData{
    
    NSLog(@"%f",[self.date timeIntervalSinceReferenceDate]);
    
    self.datas = [WHSale MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"recordDate == %@",self.date]];
    [self updateTitle];
    [self updateContent];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemRewind) target:self action:@selector(goPrev)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemFastForward) target:self action:@selector(goNext)];

    
    
    self.date = [[[NSDate date] dateAfterDay:-2] beginningOfDay] ;
    
    
    
    
   [self reloadData];
    
    
    
    
//    WHSale MR_find
//    [infos enumerateObjectsUsingBlock:^(WHSale* obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        
//        obj.region.
//    }];
    
    
}

-(void)updateContent
{
    
    NSArray* regions = @[@"江岸区",
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
    NSArray* categorys = @[@"商品住房",
                           @"写字楼",
                           @"商业",
                           @"其他"];
    
    
    
    [[self.view subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    
    
    float w = self.view.frame.size.width / (categorys.count+1);
    
    [regions enumerateObjectsUsingBlock:^(NSString*  obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        
        UILabel* label = [[UILabel alloc] initWithFrame:(CGRectMake(10, 64 + 35*(idx+1), w-5-10, 30))];
        label.text =obj;
        
        label.font = [UIFont systemFontOfSize:12];
        [self.view addSubview:label];
        
        
        [categorys enumerateObjectsUsingBlock:^(NSString* obj2, NSUInteger idx2, BOOL * _Nonnull stop2) {
            
            if (idx==0) {
                
                UILabel* label = [[UILabel alloc] initWithFrame:(CGRectMake(w*(idx2+1), 64, w-5, 30))];
                label.text =obj2;
                label.textAlignment = NSTextAlignmentCenter;
                label.font = [UIFont systemFontOfSize:12];
                [self.view addSubview:label];
            }
          
            
            [self.datas enumerateObjectsUsingBlock:^(WHSale* obj3, NSUInteger idx3, BOOL * _Nonnull stop3) {
                
                
                if ([obj3.region.regionName isEqualToString:obj] && [obj3.category.categoryName isEqualToString:obj2]) {
                    
                    
                    
                    
                    UILabel* label = [[UILabel alloc] initWithFrame:(CGRectMake(w*(idx2+1), 64 + 35*(idx+1), w-5, 30))];
                    
                    label.font = [UIFont systemFontOfSize:11];
                    label.numberOfLines = 2;
                    label.textAlignment = NSTextAlignmentCenter;
                    label.text =[NSString stringWithFormat:@"%@套\n%.2f㎡", obj3.soldCount,obj3.soldAreaValue ];
                    
                    [self.view addSubview:label];
                }
                
            }];
            
            
            
            
        }];
        
        
        
        
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
