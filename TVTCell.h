//
//  TVTCell.h
//  TableViewTest
//
//  Created by Shawn Throop on 2013-09-23.
//  Copyright (c) 2013 Silent H Design. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kBodyHorizontalInsetLeft 30.0f
#define kProfileImgHorizontalInsetLeft 20.0f
#define kFullNameHorizontalInsetLeft 50.0f

#define kHorizontalInsetRight 15.0f

#define kVerticalInsetTop 17.5f
#define kVerticalBodySpacing 8.0f


@interface TVTCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *profileImg;
@property (strong, nonatomic) IBOutlet UILabel *fullNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *bodyLabel;

- (void)updateFonts;

@end
