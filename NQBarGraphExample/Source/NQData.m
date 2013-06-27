//
//  NQData.m
//  NQBarGraphControl
//
//  Created by AhmedElnaqah on 3/25/13.
//  Copyright (c) 2013 elnaqah. All rights reserved.
//

#import "NQData.h"

@implementation NQData
+(NQData *) dataWithDate:(NSDate *) date andNumber:(NSNumber *) number
{
    NQData * data=[[NQData alloc] init];
    data.date=date;
    data.number=number;
    return data;
}
@end
