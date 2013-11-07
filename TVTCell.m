//
//  TVTCell.m
//  TableViewTest
//
//  Created by Shawn Throop on 2013-09-23.
//  Copyright (c) 2013 Silent H Design. All rights reserved.
//

#import "TVTCell.h"

#define fullNameColor [UIColor colorWithRed:47.0/255.0 green:47.0/255.0 blue:47.0/255.0 alpha:1.0]
#define userNameColor [UIColor colorWithRed:137.0/255.0 green:137.0/255.0 blue:137.0/255.0 alpha:1.0]
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
        
        self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
        
        // Profile Image for User
        self.profileImg = [[UIImageView alloc] init];
        [self.profileImg setTranslatesAutoresizingMaskIntoConstraints:NO];
//        self.profileImg.contentMode = UIViewContentModeScaleAspectFill;
        self.profileImg.backgroundColor = [UIColor lightGrayColor];
        
        // Full Name of User
        self.fullNameLabel = [[UILabel alloc] init];
        [self.fullNameLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.fullNameLabel setLineBreakMode:NSLineBreakByTruncatingTail];
        [self.fullNameLabel setNumberOfLines:1];
        [self.fullNameLabel setTextAlignment:NSTextAlignmentLeft];
        [self.fullNameLabel setTextColor:fullNameColor];
        [self.fullNameLabel setBackgroundColor:[UIColor blueColor]];
        
        // Username
        self.userNameLabel = [[UILabel alloc] init];
        [self.userNameLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.userNameLabel setLineBreakMode:NSLineBreakByTruncatingTail];
        [self.userNameLabel setNumberOfLines:1];
        [self.userNameLabel setTextAlignment:NSTextAlignmentLeft];
        [self.userNameLabel setTextColor:userNameColor];
        [self.userNameLabel setBackgroundColor:[UIColor redColor]];
        
        // Body of Post
//        self.bodyLabel = [[UILabel alloc] init];
//        [self.bodyLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
//        [self.bodyLabel setContentCompressionResistancePriority:UILayoutPriorityRequired
//                                                        forAxis:UILayoutConstraintAxisVertical];
//        [self.bodyLabel setLineBreakMode:NSLineBreakByTruncatingTail];
//        [self.bodyLabel setNumberOfLines:0];
//        [self.bodyLabel setTextAlignment:NSTextAlignmentLeft];
//        [self.bodyLabel setTextColor:bodyColor];
//        [self.bodyLabel setBackgroundColor:[UIColor clearColor]];
        
        self.bodyTextView = [[UITextView alloc] init];
        [self.bodyTextView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.bodyTextView setContentCompressionResistancePriority:UILayoutPriorityRequired
                                                        forAxis:UILayoutConstraintAxisVertical];
        [self.bodyTextView setEditable:NO];
        [self.bodyTextView setTextAlignment:NSTextAlignmentLeft];
        [self.bodyTextView setTextColor:bodyColor];
        [self.bodyTextView setBackgroundColor:[UIColor orangeColor]];

        
        
        [self.contentView addSubview:self.profileImg];
        [self.contentView addSubview:self.fullNameLabel];
        [self.contentView addSubview:self.userNameLabel];
//        [self.contentView addSubview:self.bodyLabel];
        [self.contentView addSubview:self.bodyTextView];
        
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
//                                     attribute:NSLayoutAttributeBottom
//                                     relatedBy:NSLayoutRelationEqual
//                                     toItem:self.contentView
//                                     attribute:NSLayoutAttributeTop
//                                     multiplier:1.0f
//                                     constant:(kMainBaseline + 1)]];
//    
//    [self.contentView addConstraint:[NSLayoutConstraint
//                                     constraintWithItem:self.profileImg
//                                     attribute:NSLayoutAttributeWidth
//                                     relatedBy:NSLayoutRelationEqual
//                                     toItem:nil
//                                     attribute:NSLayoutAttributeNotAnAttribute
//                                     multiplier:1.0f
//                                     constant:20.0f]];
//    
//    [self.contentView addConstraint:[NSLayoutConstraint
//                                     constraintWithItem:self.profileImg
//                                     attribute:NSLayoutAttributeHeight
//                                     relatedBy:NSLayoutRelationEqual
//                                     toItem:nil
//                                     attribute:NSLayoutAttributeNotAnAttribute
//                                     multiplier:1.0f
//                                     constant:20.0f]];
    
    
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    
    
    // fullNameLabel
//    [self.contentView addConstraint:[NSLayoutConstraint
//                                     constraintWithItem:self.fullNameLabel
//                                     attribute:NSLayoutAttributeLeading
//                                     relatedBy:NSLayoutRelationEqual
//                                     toItem:self.contentView
//                                     attribute:NSLayoutAttributeLeading
//                                     multiplier:1.0f
//                                     constant:50.0f]];
//
//    [self.contentView addConstraint:[NSLayoutConstraint
//                                     constraintWithItem:self.fullNameLabel
//                                     attribute:NSLayoutAttributeBaseline
//                                     relatedBy:NSLayoutRelationEqual
//                                     toItem:self.contentView
//                                     attribute:NSLayoutAttributeTop
//                                     multiplier:1.0f
//                                     constant:kMainBaseline]];

//    [self.contentView addConstraint:[NSLayoutConstraint
//                                     constraintWithItem:self.fullNameLabel
//                                     attribute:NSLayoutAttributeTop
//                                     relatedBy:NSLayoutRelationEqual
//                                     toItem:self.contentView
//                                     attribute:NSLayoutAttributeTop
//                                     multiplier:1.0f
//                                     constant:(kVerticalInsetTop)]];
    
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    
    // userNameLabel
//    [self.contentView addConstraint:[NSLayoutConstraint
//                                     constraintWithItem:self.userNameLabel
//                                     attribute:NSLayoutAttributeLeading
//                                     relatedBy:NSLayoutRelationEqual
//                                     toItem:self.fullNameLabel
//                                     attribute:NSLayoutAttributeTrailing
//                                     multiplier:1.0f
//                                     constant:(10.0f + self.fullNameLabel.bounds.size.width)]];
//    
//    
//    [self.contentView addConstraint:[NSLayoutConstraint
//                                     constraintWithItem:self.userNameLabel
//                                     attribute:NSLayoutAttributeBaseline
//                                     relatedBy:NSLayoutRelationEqual
//                                     toItem:self.contentView
//                                     attribute:NSLayoutAttributeTop
//                                     multiplier:1.0f
//                                     constant:kMainBaseline]];

    
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    
    
    
    // bodyLabel
//    [self.contentView  addConstraint:[NSLayoutConstraint
//                                      constraintWithItem:self.bodyLabel
//                                      attribute:NSLayoutAttributeLeading
//                                      relatedBy:NSLayoutRelationEqual
//                                      toItem:self.contentView
//                                      attribute:NSLayoutAttributeLeading
//                                      multiplier:1.0f
//                                      constant:kBodyHorizontalInsetLeft]];
//    
//    [self.contentView  addConstraint:[NSLayoutConstraint
//                                      constraintWithItem:self.bodyLabel
//                                      attribute:NSLayoutAttributeTop
//                                      relatedBy:NSLayoutRelationEqual
//                                      toItem:self.contentView
//                                      attribute:NSLayoutAttributeTop
//                                      multiplier:1.0f
//                                      constant:(kVerticalBodySpacing + kMainBaseline)]];
//    
//    [self.contentView  addConstraint:[NSLayoutConstraint
//                                      constraintWithItem:self.bodyLabel
//                                      attribute:NSLayoutAttributeTrailing
//                                      relatedBy:NSLayoutRelationEqual
//                                      toItem:self.contentView
//                                      attribute:NSLayoutAttributeTrailing
//                                      multiplier:1.0f
//                                      constant:-kHorizontalInsetRight]];
//    
//    [self.contentView  addConstraint:[NSLayoutConstraint
//                                      constraintWithItem:self.bodyLabel
//                                      attribute:NSLayoutAttributeBottom
//                                      relatedBy:NSLayoutRelationEqual
//                                      toItem:self.contentView
//                                      attribute:NSLayoutAttributeBottom
//                                      multiplier:1.0f
//                                      constant:-kVerticalInset]];
    
    
    
    ////
    
    // bodyTextView
//    [self.contentView  addConstraint:[NSLayoutConstraint
//                                      constraintWithItem:self.bodyTextView
//                                      attribute:NSLayoutAttributeLeading
//                                      relatedBy:NSLayoutRelationEqual
//                                      toItem:self.contentView
//                                      attribute:NSLayoutAttributeLeading
//                                      multiplier:1.0f
//                                      constant:kBodyHorizontalInsetLeft]];
//    
//    [self.contentView  addConstraint:[NSLayoutConstraint
//                                      constraintWithItem:self.bodyTextView
//                                      attribute:NSLayoutAttributeTop
//                                      relatedBy:NSLayoutRelationEqual
//                                      toItem:self.contentView
//                                      attribute:NSLayoutAttributeTop
//                                      multiplier:1.0f
//                                      constant:(kVerticalBodySpacing + kMainBaseline)]];
//
//    [self.contentView  addConstraint:[NSLayoutConstraint
//                                      constraintWithItem:self.bodyTextView
//                                      attribute:NSLayoutAttributeTrailing
//                                      relatedBy:NSLayoutRelationEqual
//                                      toItem:self.contentView
//                                      attribute:NSLayoutAttributeTrailing
//                                      multiplier:1.0f
//                                      constant:-kHorizontalInsetRight]];
//    
//    [self.contentView  addConstraint:[NSLayoutConstraint
//                                      constraintWithItem:self.bodyTextView
//                                      attribute:NSLayoutAttributeBottom
//                                      relatedBy:NSLayoutRelationEqual
//                                      toItem:self.contentView
//                                      attribute:NSLayoutAttributeBottom
//                                      multiplier:1.0f
//                                      constant:-kVerticalInset]];
    
    self.didSetupConstraints = YES;
}








- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}




- (void)updateFonts
{
    self.fullNameLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light"
                                              size:[UIFont preferredFontForTextStyle:UIFontTextStyleHeadline].pointSize + 6];
//    self.bodyLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light"
//                                              size:[UIFont preferredFontForTextStyle:UIFontTextStyleHeadline].pointSize];
    self.bodyTextView.font = [UIFont fontWithName:@"HelveticaNeue-Light"
                                          size:[UIFont preferredFontForTextStyle:UIFontTextStyleHeadline].pointSize];
//    NSMutableParagraphStyle *pStyle = [[NSMutableParagraphStyle alloc] init];
//    [pStyle setLineHeightMultiple:1.0f];
//    NSDictionary *attributes = @{
//                                NSParagraphStyleAttributeName : pStyle,
//                                };
//    self.bodyTextView.attributedText = [[NSAttributedString alloc] initWithString:@"" attributes:attributes];
    
    self.userNameLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light"
                                          size:[UIFont preferredFontForTextStyle:UIFontTextStyleHeadline].pointSize - 3];
}


@end
