//
//  TVTHeightCalculator.m
//  TableViewTest
//
//  Created by Shawn Throop on 11/9/2013.
//  Copyright (c) 2013 Silent H Design. All rights reserved.
//

#import "TVTHeightCalculator.h"

@implementation TVTHeightCalculator

+ (TVTHeightCalculator *)sharedStore
{
    static TVTHeightCalculator *sharedStore = nil;
    if (!sharedStore)
        sharedStore = [[super allocWithZone:nil] init];
    
    return sharedStore;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self sharedStore];
}

- (id)init
{
    self = [super init];
    if (self) {
        allHeights = [[NSDictionary alloc] init];
    }
    return self;
}



- (void)heightForIndexPath:(NSIndexPath *)indexPath
{
    CGFloat cellHeight;
    UIFont *userFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:[UIFont preferredFontForTextStyle:UIFontTextStyleHeadline].pointSize];
    UILabel *_label = [[UILabel alloc] initWithFrame:CGRectInfinite];
    _label.font = userFont;
    _label.text = @"boogers";
    cellHeight = [_label sizeThatFits:CGSizeMake(320, FLT_MAX)].height;

}



@end
