//
//  TVTCell.h
//  TableViewTest
//
//  Created by Shawn Throop on 2013-09-23.
//  Copyright (c) 2013 Silent H Design. All rights reserved.
//

typedef enum {
    TappedBody,
    TappedName
} TappedLocation;

#import <UIKit/UIKit.h>

#define kBodyHorizontalInsetLeft 30.0f
#define kProfileImgHorizontalInsetLeft 20.0f
#define kFullNameHorizontalInsetLeft 50.0f

#define kHorizontalInsetRight 15.0f
#define kInsetRight 15.0f

#define kMainBaseline 41.5f

#define kVerticalInset 17.5f
#define kVerticalBodySpacing 10.0f


@interface TVTCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *profileImg;
@property (strong, nonatomic) IBOutlet UILabel *fullNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *userNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *bodyLabel;

@property (strong, nonatomic) IBOutlet UITextView *bodyTextView;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bodyHeightConstraint;

- (void)updateFonts;

@end
