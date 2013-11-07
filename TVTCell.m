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
        
        self.contentView.backgroundColor = [UIColor greenColor];
        
        // Profile Image for User
        self.profileImg = [[UIImageView alloc] init];
        self.profileImg.translatesAutoresizingMaskIntoConstraints = NO;
        self.profileImg.backgroundColor = [UIColor lightGrayColor];
        
        // Full Name of User
        self.fullNameLabel = [[UILabel alloc] init];
        self.fullNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.fullNameLabel setLineBreakMode:NSLineBreakByTruncatingTail];
        [self.fullNameLabel setNumberOfLines:1];
        [self.fullNameLabel setTextAlignment:NSTextAlignmentLeft];
        [self.fullNameLabel setTextColor:fullNameColor];
        [self.fullNameLabel setBackgroundColor:[UIColor blueColor]];
        
        // Username
        self.userNameLabel = [[UILabel alloc] init];
        self.userNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.userNameLabel setLineBreakMode:NSLineBreakByTruncatingTail];
        [self.userNameLabel setNumberOfLines:1];
        [self.userNameLabel setTextAlignment:NSTextAlignmentLeft];
        [self.userNameLabel setTextColor:userNameColor];
        [self.userNameLabel setBackgroundColor:[UIColor redColor]];
        
        // Post Body
        self.bodyTextView = [[UITextView alloc] init];
        self.bodyTextView.translatesAutoresizingMaskIntoConstraints = NO;

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

        NSLog(@"Added Subviews to contentView");
        
        [self updateFonts];
    }
    return self;
}

- (void)updateConstraints
{
    [super updateConstraints];
    
    
//    // Set the frame of bodyTextView
//    CGRect bodyFrame = self.bodyTextView.frame;
//    bodyFrame.size.width = 320 - (kBodyHorizontalInsetLeft + kInsetRight);
//    bodyFrame.size.height = self.bodyTextView.contentSize.height;
//    self.bodyTextView.frame = bodyFrame;
    
    
    if (self.didSetupConstraints) {
        return;
    } else {
        
        NSDictionary *viewsDictionary = @{@"pImg" : self.profileImg,
                                          @"fullName" : self.fullNameLabel,
                                          @"userName" : self.userNameLabel,
                                          @"bodyText" : self.bodyTextView};
        
        NSDictionary *metricsDictionary = @{@"BodyInsetL" : @30.0f,
                                @"ProfileInsetL" : @20.0f,
                                @"FullInsetL" : @50.0f,
                                @"InsetR" : @15.0f,
                                @"MainBaseline" : @41.5f,
                                @"InsetV" : @17.5f,
                                @"InnerSpacing" : @10.0f};
        
        NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(21.5)-[pImg(==20)]"
                                                options:0 metrics:metricsDictionary views:viewsDictionary];
        [self.contentView addConstraints:constraints];
        
        constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[fullName]-(InnerSpacing)-[bodyText]-|"
                                                                       options:0 metrics:metricsDictionary views:viewsDictionary];
        [self.contentView addConstraints:constraints];
        
        constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(ProfileInsetL)-[pImg(==20)]-(InnerSpacing)-[fullName]-(InnerSpacing)-[userName]"
                                                              options:0 metrics:metricsDictionary views:viewsDictionary];
        [self.contentView addConstraints:constraints];
        constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(BodyInsetL)-[bodyText]-(InsetR)-|"
                                                              options:0 metrics:metricsDictionary views:viewsDictionary];
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
        
        self.didSetupConstraints = YES;
    }
    NSLog(@"bodyTextView.frame: %f,%f (via updateConstraints)", self.bodyTextView.frame.size.width, self.bodyTextView.frame.size.height);
    NSLog(@"contentView.frame: %f,%f (via updateConstraints)", self.contentView.frame.size.width, self.contentView.frame.size.height);
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
    self.bodyTextView.font = [UIFont fontWithName:@"HelveticaNeue-Light"
                                          size:[UIFont preferredFontForTextStyle:UIFontTextStyleHeadline].pointSize];
    self.userNameLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light"
                                          size:[UIFont preferredFontForTextStyle:UIFontTextStyleHeadline].pointSize - 3];
}


@end
