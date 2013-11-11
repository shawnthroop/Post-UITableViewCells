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
@synthesize bodyHeightConstraint,cellHeightConstraint;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight & UIViewAutoresizingFlexibleWidth;
        
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
        self.fullNameLabel.tag = kTapped;
        
        // Username
        self.userNameLabel = [[UILabel alloc] init];
        self.userNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.userNameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.userNameLabel.numberOfLines = 1;
        self.userNameLabel.textAlignment = NSTextAlignmentLeft;
        self.userNameLabel.textColor = userNameColor;
        
        // Post Body
        self.bodyTextView = [[UITextView alloc] init];
        self.bodyTextView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.bodyTextView setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        self.bodyTextView.autoresizingMask = UIViewAutoresizingFlexibleHeight & UIViewAutoresizingFlexibleWidth;
        self.bodyTextView.textContainerInset = UIEdgeInsetsMake(-2, -4, 0, -4); // (t, l, b, r)
        self.bodyTextView.editable = NO;
        self.bodyTextView.scrollEnabled = NO;
        self.bodyTextView.userInteractionEnabled = NO;

        
        [self.contentView addSubview:self.profileImg];
        [self.contentView addSubview:self.fullNameLabel];
        [self.contentView addSubview:self.userNameLabel];
        [self.contentView addSubview:self.bodyTextView];
        
        // Normal Colours
        self.contentView.backgroundColor = [UIColor clearColor];
        self.bodyTextView.backgroundColor = [UIColor clearColor];
        self.fullNameLabel.backgroundColor = [UIColor clearColor];
        self.userNameLabel.backgroundColor = [UIColor clearColor];
        
        // Debugging Colours
//        self.contentView.backgroundColor = [UIColor greenColor];
//        self.bodyTextView.backgroundColor = [UIColor orangeColor];
//        self.fullNameLabel.backgroundColor = [UIColor blueColor];
//        self.userNameLabel.backgroundColor = [UIColor yellowColor];
        
        
        
        
        self.contentView.frame = CGRectMake(0,0, self.frame.size.width,kDefaultCellHeight);
        
        [self updateFonts];
        float pHeight = self.fullNameLabel.font.capHeight;
       
        
        NSDictionary *viewsDictionary = @{@"profileImg" : self.profileImg,
                                          @"fullName" : self.fullNameLabel,
                                          @"userName" : self.userNameLabel,
                                          @"bodyText" : self.bodyTextView, };
        NSDictionary *metricsDictionary = @{@"PadLeftBody" : @30.0f,
                                            @"PadLeftProfile" : @20.0f,
                                            @"PadRight" : @15.0f,
                                            @"PadInner" : @9.0f};
        
        
        
        NSArray *verticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[fullName]-[bodyText]-|" options:0 metrics:metricsDictionary views:viewsDictionary];
        [self.contentView addConstraints:verticalConstraints];
        

        // Constraints for top elements (profileimg, fullNameLabel, userNameLabel)
        NSArray *topConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(PadLeftProfile)-[profileImg]-(PadInner)-[fullName]-(PadInner)-[userName]-(>=PadRight)-|" options:0 metrics:metricsDictionary views:viewsDictionary];
        [self.contentView addConstraints:topConstraints];

        // Horizontal Constraint for bodyTextView
        NSArray *horizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(PadLeftBody)-[bodyText]-(PadRight)-|" options:0 metrics:metricsDictionary views:viewsDictionary];
        [self.contentView addConstraints:horizontalConstraints];
        
//        // userNameLabel
        [self.contentView addConstraint:[NSLayoutConstraint
                                         constraintWithItem:self.userNameLabel
                                         attribute:NSLayoutAttributeBaseline
                                         relatedBy:NSLayoutRelationEqual
                                         toItem:self.fullNameLabel
                                         attribute:NSLayoutAttributeBaseline
                                         multiplier:1.0f
                                         constant:-1.0]];

        // Profile
        [self.contentView addConstraint:[NSLayoutConstraint
                                         constraintWithItem:self.profileImg
                                         attribute:NSLayoutAttributeBaseline
                                         relatedBy:NSLayoutRelationEqual
                                         toItem:self.fullNameLabel
                                         attribute:NSLayoutAttributeBaseline
                                         multiplier:1.0f
                                         constant:1.0f]];
        
        [self.contentView addConstraint:[NSLayoutConstraint
                                         constraintWithItem:self.profileImg
                                         attribute:NSLayoutAttributeWidth
                                         relatedBy:NSLayoutRelationEqual
                                         toItem:nil
                                         attribute:NSLayoutAttributeNotAnAttribute
                                         multiplier:1.0f
                                         constant:pHeight]];
        
        [self.contentView addConstraint:[NSLayoutConstraint
                                         constraintWithItem:self.profileImg
                                         attribute:NSLayoutAttributeHeight
                                         relatedBy:NSLayoutRelationEqual
                                         toItem:nil
                                         attribute:NSLayoutAttributeNotAnAttribute
                                         multiplier:1.0f
                                         constant:pHeight]];
        
        bodyHeightConstraint = [NSLayoutConstraint constraintWithItem:self.bodyTextView
                                                            attribute:NSLayoutAttributeHeight
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:nil
                                                            attribute:NSLayoutAttributeNotAnAttribute
                                                           multiplier:0.f
                                                             constant:(kDefaultCellHeight - 70)];
        [self.contentView addConstraint:bodyHeightConstraint];
    }
    return self;
}


- (void)updateConstraints
{
    [super updateConstraints];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}




- (void)updateFonts
{
    self.fullNameLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light"
                                              size:[UIFont preferredFontForTextStyle:UIFontTextStyleHeadline].pointSize + kFullNamePointSizeOffset];
    self.bodyTextView.font = [UIFont fontWithName:@"HelveticaNeue-Light"
                                             size:[UIFont preferredFontForTextStyle:UIFontTextStyleHeadline].pointSize];
    self.userNameLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light"
                                          size:[UIFont preferredFontForTextStyle:UIFontTextStyleHeadline].pointSize - kUserNamePointSizeOffset];
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    
//    [self.contentView setNeedsLayout];
//    [self.contentView layoutIfNeeded];
    
    self.imageView.image = nil;
    self.contentView.frame = CGRectMake(0,0, self.frame.size.width,kDefaultCellHeight);

    [self.bodyHeightConstraint setConstant:(kDefaultCellHeight - 71.0f)];
}

@end
