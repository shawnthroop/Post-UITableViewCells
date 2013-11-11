//
//  TVTCell.h
//  TableViewTest
//
//  Created by Shawn Throop on 2013-09-23.
//  Copyright (c) 2013 Silent H Design. All rights reserved.
//


#import <UIKit/UIKit.h>

#import "Constants.h"

@interface TVTCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *profileImg;
@property (strong, nonatomic) IBOutlet UILabel *fullNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *userNameLabel;

@property (strong, nonatomic) IBOutlet UITextView *bodyTextView;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bodyHeightConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *profileHeightConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *profileWidthConstraint;

- (void)updateFonts;

@end
