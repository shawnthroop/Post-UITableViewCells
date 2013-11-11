//
//  Constants.h
//  TableViewTest
//
//  Created by Shawn Throop on 11/11/2013.
//  Copyright (c) 2013 Silent H Design. All rights reserved.
//

//#import <Foundation/Foundation.h>
//
//@interface Constants : NSObject
//
//@end

#define kTapped 11
#define kFullNamePointSizeOffset 8
#define kUserNamePointSizeOffset -2
#define kBodyTextPointSizeOffset 3

#define kDefaultCellHeight  345.0f

#define fullNameColor [UIColor colorWithRed:47.0/255.0 green:47.0/255.0 blue:47.0/255.0 alpha:1.0]
#define userNameColor [UIColor colorWithRed:137.0/255.0 green:137.0/255.0 blue:137.0/255.0 alpha:1.0]
#define bodyColor [UIColor colorWithRed:126.0/255.0 green:126.0/255.0 blue:126.0/255.0 alpha:1.0]

#define bodyTextEdgeInsets UIEdgeInsetsMake(-2, -4, 0, -4); // (t, l, b, r)
#define kBodyFont [UIFont fontWithName:@"HelveticaNeue-Light" size:[UIFont preferredFontForTextStyle:UIFontTextStyleHeadline].pointSize + kBodyTextPointSizeOffset]
