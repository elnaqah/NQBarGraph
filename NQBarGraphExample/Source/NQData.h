//
//  NQData.h
//  NQBarGraphControl
//
//  Created by AhmedElnaqah on 3/25/13.
//  Copyright (c) 2013 elnaqah. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NQData : NSObject
@property (strong) NSDate * date;
@property (strong) NSNumber * number;
+(NQData *) dataWithDate:(NSDate *) date andNumber:(NSNumber *) number;
@end
