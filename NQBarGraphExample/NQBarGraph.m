//
//  NQBarGraph.m
//  NQBarGraphExample
//
//  Created by AhmedElnaqah on 6/2/13.
//  Copyright (c) 2013 elnaqah. All rights reserved.
//

#import "NQBarGraph.h"
#import "NQData.h"
#import <QuartzCore/QuartzCore.h>

#define BAR_WIDTH_MAX 100
#define BAR_WIDTH_MIN 3
#define BAR_WIDTH_DEFAULT 20
#define BAR_SPACES_DEFAULT 10
#define HORIZONTAL_PADDING 20
#define VERTICAL_PADDING 30
#define HORIZONTAL_START_LINE 0.2
#define VERTICAL_START_LINE 0.2
#define VERTICALE_DATA_SPACES 20
#define LABEL_DIM 20

@interface NQBarGraph()
@property CGPoint contentScroll;
@property int maxHeight;
@property int maxWidth;
@end
@implementation NQBarGraph
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.barWidth=BAR_WIDTH_DEFAULT;
        self.spaceBetweenBars=BAR_SPACES_DEFAULT;
        self.backgroundColor=[UIColor grayColor];
        self.linesColor=[UIColor whiteColor];
        self.numbersColor=[UIColor colorWithWhite:0.5 alpha:0.9];
        self.numbersTextColor=[UIColor whiteColor];
        self.dateColor=[UIColor whiteColor];
        self.ContentScroll=CGPointZero;
        self.layer.cornerRadius=20;
        self.layer.masksToBounds=YES;
        self.numberOfVerticalElements=8;
    }
    return self;
}

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self setNeedsDisplay];
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    float minOfTwo=MIN(self.bounds.size.width, self.bounds.size.height);
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0.0f, self.bounds.size.height);
    CGContextScaleCTM(context, 1, -1);
    
    CGContextSetLineWidth(context, 1);
    CGContextMoveToPoint(context, HORIZONTAL_START_LINE*minOfTwo, VERTICAL_START_LINE*minOfTwo);
    [self.linesColor set];
    
    CGContextAddLineToPoint(context, HORIZONTAL_START_LINE*minOfTwo, self.bounds.size.height);
    CGContextStrokePath(context);
    
    CGContextMoveToPoint(context, HORIZONTAL_START_LINE*minOfTwo, VERTICAL_START_LINE*minOfTwo);
    CGContextAddLineToPoint(context, self.bounds.size.width, VERTICAL_START_LINE*minOfTwo);
    CGContextStrokePath(context);
    
    CGFloat dashPattern[]= {3.0, 2};
    CGContextSetLineWidth(context, 1.0);
    CGContextSetLineDash(context, 0.0, dashPattern, 2);
    
    
    CGContextSelectFont (context,"Helvetica",12,kCGEncodingMacRoman);
    //CGContextSetCharacterSpacing (context, 5);
    CGContextSetTextDrawingMode (context, kCGTextFill);
    
    
    UIColor * backRectColor=[UIColor colorWithWhite:0.2 alpha:0.5];
    [backRectColor set];
    CGContextShowTextAtPoint (context, (HORIZONTAL_START_LINE*minOfTwo)-35, VERTICAL_START_LINE*minOfTwo -15, [@"Day" UTF8String], 3);
    CGContextShowTextAtPoint (context, (HORIZONTAL_START_LINE*minOfTwo)-35, VERTICAL_START_LINE*minOfTwo -30, [@"Month" UTF8String], 5);
    //write tasks and date
    CGContextSelectFont (context,"Helvetica",20,kCGEncodingMacRoman);
     CGContextSetTextDrawingMode (context, kCGTextFill);
    [[UIColor whiteColor] set];
    CGContextShowTextAtPoint(context, self.bounds.size.width/2-35, 10, [@"Date" UTF8String], 4);
    
    CGContextSetTextMatrix(context, CGAffineTransformMakeRotation(90*M_PI/180));
    CGContextShowTextAtPoint(context, 20, self.bounds.size.height/2-35, [@"Tasks" UTF8String], 5);
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextSelectFont (context,"Helvetica",12,kCGEncodingMacRoman);
    
    for (int i=0; i<=self.numberOfVerticalElements; i++) {
        int height=VERTICALE_DATA_SPACES* i;
        float verticalLine=height+VERTICAL_START_LINE*minOfTwo-self.contentScroll.y;
        if (verticalLine>VERTICAL_START_LINE*minOfTwo) {
            backRectColor=[UIColor colorWithWhite:0.8 alpha:1];
            [backRectColor set];
            CGContextMoveToPoint(context, HORIZONTAL_START_LINE*minOfTwo, verticalLine);
            CGContextAddLineToPoint(context, self.bounds.size.width, verticalLine);
            CGContextStrokePath(context);
            NSString * numberString=[NSString stringWithFormat:@"%d",i];
            UIColor * backRectColor=[UIColor colorWithWhite:0.2 alpha:0.2];
            [backRectColor set];
            CGContextFillRect(context, CGRectMake((HORIZONTAL_START_LINE*minOfTwo)/2-4, verticalLine-8, 15, 15));
            backRectColor=[UIColor colorWithWhite:0.8 alpha:1];
            [backRectColor set];
            CGContextShowTextAtPoint (context, (HORIZONTAL_START_LINE*minOfTwo)/2, verticalLine-5, [numberString UTF8String], 1);
        }
    }
    [[UIColor whiteColor] set];
    int index=0;
    //for (int index=0; index<numberOfDataObjects; index++) {
    for (NQData * dataObject in self.dataSource) {
        int height=VERTICALE_DATA_SPACES* [dataObject.number intValue];
        
        if (VERTICAL_START_LINE*minOfTwo-self.contentScroll.y <VERTICAL_START_LINE*minOfTwo) {
            height-=self.contentScroll.y;
        }
        float xPosition=HORIZONTAL_START_LINE*minOfTwo+(index+1)* self.spaceBetweenBars + index * self.barWidth+self.contentScroll.x;
        
        if (xPosition>=HORIZONTAL_START_LINE*minOfTwo && xPosition<self.bounds.size.width ){
        UIColor * backRectColor=[UIColor colorWithWhite:0.2 alpha:0.5];
        [backRectColor set];
        
        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:dataObject.date];
        NSInteger day = [components day];
        NSInteger month = [components month];

        NSString * dayString=[NSString stringWithFormat:@"%d",day];
        NSString * monthString=[NSString stringWithFormat:@"%d",month];

        
        CGContextShowTextAtPoint (context, xPosition+self.barWidth/2-2, VERTICAL_START_LINE*minOfTwo -15, [dayString UTF8String], 1);
        CGContextShowTextAtPoint (context, xPosition+self.barWidth/2-((month>9)?7:2), VERTICAL_START_LINE*minOfTwo -30, [monthString UTF8String], (month>9)?2:1);

        
        [[UIColor whiteColor] set];
        }
        
        if (height>0) {
            
            if (xPosition>=HORIZONTAL_START_LINE*minOfTwo && xPosition<self.bounds.size.width ) {
                UIRectFill(CGRectMake(xPosition, VERTICAL_START_LINE*minOfTwo, self.barWidth, height));
            }
            else if(xPosition+self.barWidth >HORIZONTAL_START_LINE*minOfTwo  && xPosition<HORIZONTAL_START_LINE*minOfTwo )
            {
                NSLog(@"%f",self.barWidth-(HORIZONTAL_START_LINE*minOfTwo-xPosition));
                UIRectFill(CGRectMake(HORIZONTAL_START_LINE*minOfTwo, VERTICAL_START_LINE*minOfTwo, self.barWidth-(HORIZONTAL_START_LINE*minOfTwo-xPosition), height));
            }
            
           
            
        }

        index++;
    }
    
    
    
    
}


#pragma mark setDataSource
-(void)setDataSource:(NSArray *)dataSource
{
    _dataSource=dataSource;
    
    //calculate the limit of height
    _maxHeight=0;
    for (NQData * dataObject in _dataSource) {
        int height=VERTICALE_DATA_SPACES* [dataObject.number intValue];
        _maxHeight=MAX(height, _maxHeight);
    }
    _maxHeight-=self.spaceBetweenBars;
    //calculate the limit of width
    _maxWidth=([_dataSource count]-1)*(self.barWidth+self.spaceBetweenBars);
}
#pragma mark touch handling
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint touchLocation=[[touches anyObject] locationInView:self];
    CGPoint prevouseLocation=[[touches anyObject] previousLocationInView:self];
    float xDiffrance=touchLocation.x-prevouseLocation.x;
    float yDiffrance=touchLocation.y-prevouseLocation.y;
    
        _contentScroll.x+=xDiffrance;
        _contentScroll.y+=yDiffrance;
    
    if (_contentScroll.x >0) {
        _contentScroll.x=0;
    }
    if(_contentScroll.y<0)
    {
        _contentScroll.y=0;
    }
    
    if (-_contentScroll.x>self.maxWidth) {
        _contentScroll.x=-self.maxWidth;
    }
    if (_contentScroll.y>self.maxHeight) {
        _contentScroll.y=self.maxHeight;
    }
    [self setNeedsDisplay];
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}



@end
