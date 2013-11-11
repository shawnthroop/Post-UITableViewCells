//
//  TVTHeightCalculator.h
//  TableViewTest
//
//  Created by Shawn Throop on 11/9/2013.
//  Copyright (c) 2013 Silent H Design. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TVTHeightCalculator : NSObject
{
    NSDictionary *allHeights;
}

+ (TVTHeightCalculator *)sharedStore;

- (void)heightForIndexPath:(NSIndexPath *)indexPath;

@end
