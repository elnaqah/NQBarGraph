//
//  NQViewController.m
//  NQBarGraphExample
//
//  Created by AhmedElnaqah on 6/2/13.
//  Copyright (c) 2013 elnaqah. All rights reserved.
//

#import "NQViewController.h"
#import "NQBarGraph.h"
#import "NQData.h"
@interface NQViewController ()

@end

@implementation NQViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NQBarGraph * barGraph=[[NQBarGraph alloc] initWithFrame:CGRectMake(10, 10, self.view.bounds.size.width-20, self.view.bounds.size.height-20)];
    barGraph.autoresizingMask=(UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth);
    [self.view addSubview:barGraph];
    NSMutableArray * dataArray=[NSMutableArray array];
    NSDate * nowDate=[NSDate date];
    NQData * firstData=[NQData dataWithDate:nowDate andNumber:[NSNumber numberWithInt:3]];
    [dataArray addObject:firstData];
    for (int i=86400; i<864000; i+=86400) {
        int rand=1+arc4random()%8;
        NQData * data=[NQData dataWithDate:[NSDate dateWithTimeInterval:i sinceDate:nowDate] andNumber:[NSNumber numberWithInt:rand]];
        [dataArray addObject:data];
    }
    
barGraph.dataSource=dataArray;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
