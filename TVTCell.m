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
        self.contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        
        // Profile Image for User
        self.profileImg = [[UIImageView alloc] init];
        self.profileImg.translatesAutoresizingMaskIntoConstraints = NO;
        self.profileImg.backgroundColor = [UIColor lightGrayColor];
        
        // Full Name of User
        self.fullNameLabel = [[UILabel alloc] init];
        self.fullNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.fullNameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.fullNameLabel.numberOfLines = 1;
        self.fullNameLabel.textAlignment = NSTextAlignmentLeft;
        self.fullNameLabel.textColor = fullNameColor;
        self.fullNameLabel.backgroundColor = [UIColor clearColor];
        
        // Username
        self.userNameLabel = [[UILabel alloc] init];
        self.userNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.userNameLabel setLineBreakMode:NSLineBreakByTruncatingTail];
        [self.userNameLabel setNumberOfLines:1];
        [self.userNameLabel setTextAlignment:NSTextAlignmentLeft];
        [self.userNameLabel setTextColor:userNameColor];
        [self.userNameLabel setBackgroundColor:[UIColor clearColor]];
        
        // Post Body
        self.bodyLabel = [[UILabel alloc] init];
        [self.bodyLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.bodyLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        [self.bodyLabel setLineBreakMode:NSLineBreakByTruncatingTail];
        [self.bodyLabel setNumberOfLines:0];
        [self.bodyLabel setTextAlignment:NSTextAlignmentLeft];
        [self.bodyLabel setTextColor:bodyColor];
        [self.bodyLabel setBackgroundColor:[UIColor clearColor]];
        
        
        [self.contentView addSubview:self.profileImg];
        [self.contentView addSubview:self.fullNameLabel];
        [self.contentView addSubview:self.userNameLabel];
        [self.contentView addSubview:self.bodyLabel];
        
        [self updateFonts];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)updateConstraints
{
    [super updateConstraints];
    
    
    if (self.didSetupConstraints) return;
    
    NSDictionary *viewsDictionary = @{@"pImg" : self.profileImg,
                                      @"fullName" : self.fullNameLabel,
                                      @"userName" : self.userNameLabel,
                                      @"bodyText" : self.bodyLabel,
                                      @"contentView" : self.contentView };
    
    NSDictionary *metricsDictionary = @{@"BodyInsetL" : @30.0f,
                            @"ProfileInsetL" : @20.0f,
                            @"FullInsetL" : @50.0f,
                            @"InsetR" : @15.0f,
                            @"MainBaseline" : @41.5f,
                            @"InsetV" : @17.5f,
                            @"InnerSpacing" : @10.0f};
    

    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[pImg(==20)]-(InnerSpacing)-[bodyText(>=1)]-(InsetV)-|" options:0 metrics:metricsDictionary views:viewsDictionary];
    [self.contentView addConstraints:constraints];
    
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(ProfileInsetL)-[pImg(==20)]-(InnerSpacing)-[fullName]-(InnerSpacing)-[userName]" options:0 metrics:metricsDictionary views:viewsDictionary];
    [self.contentView addConstraints:constraints];
    
    
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(BodyInsetL)-[bodyText]-(InsetR)-|" options:0 metrics:metricsDictionary views:viewsDictionary];
    [self.contentView addConstraints:constraints];
    
    
    // fullNameLabel
    [self.contentView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.fullNameLabel
                                     attribute:NSLayoutAttributeBaseline
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.contentView
                                     attribute:NSLayoutAttributeTop
                                     multiplier:1.0f
                                     constant:kMainBaseline]];
    
    // userNameLabel
    [self.contentView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.userNameLabel
                                     attribute:NSLayoutAttributeBaseline
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.contentView
                                     attribute:NSLayoutAttributeTop
                                     multiplier:1.0f
                                     constant:kMainBaseline]];
    
    // Profile
    [self.contentView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.profileImg
                                     attribute:NSLayoutAttributeBaseline
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.contentView
                                     attribute:NSLayoutAttributeTop
                                     multiplier:1.0f
                                     constant:kMainBaseline + 2]];
    
    [self.contentView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.profileImg
                                     attribute:NSLayoutAttributeHeight
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.profileImg
                                     attribute:NSLayoutAttributeWidth
                                     multiplier:1.0f
                                     constant:0.0f]];
    
    // Body
//    [self.contentView addConstraint:[NSLayoutConstraint
//                                     constraintWithItem:self.bodyLabel
//                                     attribute:NSLayoutAttributeTop
//                                     relatedBy:NSLayoutRelationEqual
//                                     toItem:self.profileImg
//                                     attribute:NSLayoutAttributeBaseline
//                                     multiplier:1.0f
//                                     constant:kVerticalBodySpacing]];
//    
//    [self.contentView addConstraint:[NSLayoutConstraint
//                                     constraintWithItem:self.bodyLabel
//                                     attribute:NSLayoutAttributeBottom
//                                     relatedBy:NSLayoutRelationEqual
//                                     toItem:self.contentView
//                                     attribute:NSLayoutAttributeBottom
//                                     multiplier:1.0f
//                                     constant:-kVerticalInset]];
    
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
    self.bodyLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light"
                                          size:[UIFont preferredFontForTextStyle:UIFontTextStyleHeadline].pointSize];
    self.userNameLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light"
                                          size:[UIFont preferredFontForTextStyle:UIFontTextStyleHeadline].pointSize - 3];
}


@end
