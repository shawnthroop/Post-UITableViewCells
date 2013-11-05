//
//  TVTCell.m
//  TableViewTest
//
//  Created by Shawn Throop on 2013-09-23.
//  Copyright (c) 2013 Silent H Design. All rights reserved.
//

#import "TVTCell.h"

#define fullNameColor [UIColor colorWithRed:47.0/255.0 green:47.0/255.0 blue:47.0/255.0 alpha:1.0]
#define bodyColor [UIColor colorWithRed:126.0/255.0 green:126.0/255.0 blue:126.0/255.0 alpha:1.0]

@interface TVTCell ()

@property (nonatomic, assign) BOOL didSetupConstraints;

@end


@implementation TVTCell
//@synthesize fullNameLabel, bodyLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        // Profile Image for User
        self.profileImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"default-profileImg.png"]];
        
        // Full Name of User
        self.fullNameLabel = [[UILabel alloc] init];
        [self.fullNameLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.fullNameLabel setLineBreakMode:NSLineBreakByTruncatingTail];
        [self.fullNameLabel setNumberOfLines:1];
        [self.fullNameLabel setTextAlignment:NSTextAlignmentLeft];
        [self.fullNameLabel setTextColor:fullNameColor];
        [self.fullNameLabel setBackgroundColor:[UIColor clearColor]];
        
        // Body of Post
        self.bodyLabel = [[UILabel alloc] init];
        [self.bodyLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.bodyLabel setContentCompressionResistancePriority:UILayoutPriorityRequired
                                                        forAxis:UILayoutConstraintAxisVertical];
        [self.bodyLabel setLineBreakMode:NSLineBreakByTruncatingTail];
        [self.bodyLabel setNumberOfLines:0];
        [self.bodyLabel setTextAlignment:NSTextAlignmentLeft];
        [self.bodyLabel setTextColor:bodyColor];
        [self.bodyLabel setBackgroundColor:[UIColor clearColor]];
        
        
        [self.contentView addSubview:self.profileImg];
        [self.contentView addSubview:self.fullNameLabel];
        [self.contentView addSubview:self.bodyLabel];
        
        [self updateFonts];
    }
    return self;
}

- (void)updateConstraints
{
    [super updateConstraints];
    
    
    if (self.didSetupConstraints) return;
    
    // profileImg
//    [self.contentView addConstraint:[NSLayoutConstraint
//                                     constraintWithItem:self.profileImg
//                                     attribute:NSLayoutAttributeLeading
//                                     relatedBy:NSLayoutRelationEqual
//                                     toItem:self.contentView
//                                     attribute:NSLayoutAttributeLeading
//                                     multiplier:1.0f
//                                     constant:kProfileImgHorizontalInsetLeft]];
//    
//    [self.contentView addConstraint:[NSLayoutConstraint
//                                     constraintWithItem:self.profileImg
//                                     attribute:NSLayoutAttributeTop
//                                     relatedBy:NSLayoutRelationEqual
//                                     toItem:self.contentView
//                                     attribute:NSLayoutAttributeTop
//                                     multiplier:1.0f
//                                     constant:(kVerticalInsetTop + 2)]];
//    
//    [self.contentView addConstraint:[NSLayoutConstraint
//                                     constraintWithItem:self.profileImg
//                                     attribute:NSLayoutAttributeTrailing
//                                     relatedBy:NSLayoutRelationEqual
//                                     toItem:self.contentView
//                                     attribute:NSLayoutAttributeLeading
//                                     multiplier:1.0f
//                                     constant:(kProfileImgHorizontalInsetLeft +100)]];
    
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    // fullNameLabel
    [self.contentView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.fullNameLabel
                                     attribute:NSLayoutAttributeLeading
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.contentView
                                     attribute:NSLayoutAttributeLeading
                                     multiplier:1.0f
                                     constant:kFullNameHorizontalInsetLeft]];
    
    [self.contentView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.fullNameLabel
                                     attribute:NSLayoutAttributeTop
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.contentView
                                     attribute:NSLayoutAttributeTop
                                     multiplier:1.0f
                                     constant:(kVerticalInsetTop)]];
    
    [self.contentView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.fullNameLabel
                                     attribute:NSLayoutAttributeTrailing
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.contentView
                                     attribute:NSLayoutAttributeTrailing
                                     multiplier:1.0f
                                     constant:-kHorizontalInsetRight]];
    
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    
    // bodyLabel
    [self.contentView  addConstraint:[NSLayoutConstraint
                                      constraintWithItem:self.bodyLabel
                                      attribute:NSLayoutAttributeLeading
                                      relatedBy:NSLayoutRelationEqual
                                      toItem:self.contentView
                                      attribute:NSLayoutAttributeLeading
                                      multiplier:1.0f
                                      constant:kBodyHorizontalInsetLeft]];
    
    [self.contentView  addConstraint:[NSLayoutConstraint
                                      constraintWithItem:self.bodyLabel
                                      attribute:NSLayoutAttributeTop
                                      relatedBy:NSLayoutRelationEqual
                                      toItem:self.fullNameLabel
                                      attribute:NSLayoutAttributeBottom
                                      multiplier:1.0f
                                      constant:(kVerticalBodySpacing)]];
    
    [self.contentView  addConstraint:[NSLayoutConstraint
                                      constraintWithItem:self.bodyLabel
                                      attribute:NSLayoutAttributeTrailing
                                      relatedBy:NSLayoutRelationEqual
                                      toItem:self.contentView
                                      attribute:NSLayoutAttributeTrailing
                                      multiplier:1.0f
                                      constant:-kHorizontalInsetRight]];
    
    [self.contentView  addConstraint:[NSLayoutConstraint
                                      constraintWithItem:self.bodyLabel
                                      attribute:NSLayoutAttributeBottom
                                      relatedBy:NSLayoutRelationEqual
                                      toItem:self.contentView
                                      attribute:NSLayoutAttributeBottom
                                      multiplier:1.0f
                                      constant:-kVerticalInsetTop]];
    
    self.didSetupConstraints = YES;
}








- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}




- (void)updateFonts
{
    self.fullNameLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    self.bodyLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
}


@end
