//
//  TVTCell.h
//  TableViewTest
//
//  Created by Shawn Throop on 2013-09-23.
//  Copyright (c) 2013 Silent H Design. All rights reserved.
//


#import <UIKit/UIKit.h>


#define kTapped 11
#define kFullNamePointSizeOffset 6
#define kUserNamePointSizeOffset -3
#define kBodyTextPointSizeOffset 1

#define kDefaultCellHeight 345.0f

#define fullNameColor [UIColor colorWithRed:47.0/255.0 green:47.0/255.0 blue:47.0/255.0 alpha:1.0]
#define userNameColor [UIColor colorWithRed:137.0/255.0 green:137.0/255.0 blue:137.0/255.0 alpha:1.0]
#define bodyColor [UIColor colorWithRed:126.0/255.0 green:126.0/255.0 blue:126.0/255.0 alpha:1.0]

@interface TVTCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *profileImg;
@property (strong, nonatomic) IBOutlet UILabel *fullNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *userNameLabel;

@property (strong, nonatomic) IBOutlet UITextView *bodyTextView;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bodyHeightConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *cellHeightConstraint;

- (void)updateFonts;

@end
