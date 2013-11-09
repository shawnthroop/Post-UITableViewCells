//
//  RJSimpleModel.m
//  Collection
//
//  Created by Kevin Muldoon & Tyler Fox on 10/5/13.
//  Copyright (c) 2013 RobotJackalope. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#define bodyColor [UIColor colorWithRed:126.0/255.0 green:126.0/255.0 blue:126.0/255.0 alpha:1.0]


#import "RJModel.h"

@implementation RJModel

- (id)init {
    
    if (self = [super init]) {
        
    }
    return self;
}

- (void)populateDataSource {
    
    NSArray *fontFamilies = [NSArray arrayWithArray:[UIFont familyNames]];
    NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:[fontFamilies count]];

    for ( NSString *familyName in fontFamilies ) {
        NSAttributedString *usernameString = [[NSAttributedString alloc] initWithString:familyName attributes:nil]; // @{NSFontAttributeName:userFont}
        NSDictionary *dictionary = [[NSDictionary alloc] initWithObjectsAndKeys:[self randomFullName], @"name",
                                    [self randomLorumIpsum], @"body",
                                    usernameString, @"user",
                                    nil];
        [result addObject:dictionary];
    }
    
    self.dataSource = [NSArray arrayWithArray:result];
    
}

- (NSAttributedString *)randomLorumIpsum {
    
    NSString *lorumIpsum = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent non quam ac massa viverra semper. Maecenas mattis justo ac augue volutpat congue. Maecenas laoreet, nulla eu faucibus gravida, felis orci dictum risus, sed sodales sem eros eget risus. Morbi imperdiet sed diam et sodales. Vestibulum ut est id mauris ultrices gravida. Nulla malesuada metus ut erat malesuada, vitae ornare neque semper. Aenean a commodo justo, vel placerat odio. Curabitur vitae consequat tortor. Aenean eu magna ante. Integer tristique elit ac augue laoreet, eget pulvinar lacus dictum.";
    
    // Split lorum ipsum words into an array
    //
    NSArray *lorumIpsumArray = [lorumIpsum componentsSeparatedByString:@" "];
    
    // Randomly choose words for variable length
    //
//    int r = arc4random() % [lorumIpsumArray count];
    int r = arc4random() % 30 + 5;
    NSArray *lorumIpsumRandom = [lorumIpsumArray objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, r)]];

    // Array to string. Adding '!!!' to end of string to ensure all text is visible.
    //
    NSString *sSimple = [NSString stringWithFormat:@"%@!!!", [lorumIpsumRandom componentsJoinedByString:@" "]];
    
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:sSimple attributes:nil];
    return attrString;
}



- (NSAttributedString *)randomFullName {
    
    NSString *randomUser = @"Billy Joe Shmoe John Idiot Hailey Bridges Truck TowMator Cableguy Erik Martin Gandalf";
    
    NSArray *randomUserNames = [randomUser componentsSeparatedByString:@" "];
    
    // Randomly choose words for variable length
    //
    //    int r = arc4random() % [lorumIpsumArray count];
    int r = arc4random() % randomUserNames.count - 2;
    r = abs(r);
    NSArray *randomUserArray = [randomUserNames objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(r, 2)]];
    
    NSString *sSimple = [NSString stringWithFormat:@"%@!!!", [randomUserArray componentsJoinedByString:@" "]];
    
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:sSimple attributes:nil];
    return attrString;
}


@end
