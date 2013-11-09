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
//@property (strong, nonatomic) NSLayoutConstraint *bodyHeightConstraint;

@end


@implementation TVTCell
//@synthesize fullNameLabel, bodyLabel;
@synthesize bodyHeightConstraint;

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
        self.bodyTextView.textContainerInset = UIEdgeInsetsMake(0, -4, 0, -4);
        self.bodyTextView.editable = NO;
        self.bodyTextView.scrollEnabled = NO;

        
        [self.contentView addSubview:self.profileImg];
        [self.contentView addSubview:self.fullNameLabel];
        [self.contentView addSubview:self.userNameLabel];
        [self.contentView addSubview:self.bodyTextView];
        
        
        
        // Debugging Colours
//        self.contentView.backgroundColor = [UIColor greenColor];
//        self.bodyTextView.backgroundColor = [UIColor orangeColor];
//        self.fullNameLabel.backgroundColor = [UIColor blueColor];
//        self.userNameLabel.backgroundColor = [UIColor yellowColor];
        
        self.contentView.backgroundColor = [UIColor clearColor];
        self.bodyTextView.backgroundColor = [UIColor clearColor];
        self.fullNameLabel.backgroundColor = [UIColor clearColor];
        self.userNameLabel.backgroundColor = [UIColor clearColor];
        
        
        
        
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
        

        //    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[bodyText]-(InsetV)-|" options:0 metrics:metricsDictionary views:viewsDictionary];
        //    [self.contentView addConstraints:constraints];
        
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

        
        
//
//
//        [self.contentView addConstraint:[NSLayoutConstraint
//                                         constraintWithItem:self.profileImg
//                                         attribute:NSLayoutAttributeHeight
//                                         relatedBy:NSLayoutRelationEqual
//                                         toItem:nil
//                                         attribute:NSLayoutAttributeNotAnAttribute
//                                         multiplier:1.0f
//                                         constant:pHeight]];
        
        // Body
        //    [self.contentView addConstraint:[NSLayoutConstraint
        //                                     constraintWithItem:self.bodyTextView
        //                                     attribute:NSLayoutAttributeTop
        //                                     relatedBy:NSLayoutRelationEqual
        //                                     toItem:self.fullNameLabel
        //                                     attribute:NSLayoutAttributeBaseline
        //                                     multiplier:1.0f
        //                                     constant:(vInset / 1.6)]];
        
        bodyHeightConstraint = [NSLayoutConstraint constraintWithItem:self.bodyTextView
                                                            attribute:NSLayoutAttributeHeight
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:nil
                                                            attribute:NSLayoutAttributeNotAnAttribute
                                                           multiplier:0.f
                                                             constant:1000.0f];
        [self.contentView addConstraint:bodyHeightConstraint];
    }
    return self;
}


- (void)updateConstraints
{
    NSLog(@"------ updateConstraints ------");
    [super updateConstraints];
    
//    CGSize bodySize = self.bodyTextView.contentSize;
//    NSLog(@"Updating Constraints, body.TextView.contentSize: %@", NSStringFromCGSize(bodySize));
//    [bodyHeightConstraint setConstant:bodySize.height];
    
    
//
//    NSLog(@"Bounds - TextView: %@ | ContentView: %@ | Cell: %@ | BodySize: %@", NSStringFromCGSize(self.bodyTextView.bounds.size), NSStringFromCGSize(self.contentView.bounds.size), NSStringFromCGSize(self.bounds.size), NSStringFromCGSize(bodySize));
//    
//    
//    if (self.didSetupConstraints) return;
    
//    NSDictionary *viewsDictionary = @{@"pImg" : self.profileImg,
//                                      @"fullName" : self.fullNameLabel,
//                                      @"userName" : self.userNameLabel,
//                                      @"bodyText" : self.bodyTextView, };
//    NSDictionary *metricsDictionary = @{@"BodyInsetL" : @30.0f,
//                                        @"ProfileInsetL" : @20.0f,
//                                        @"FullInsetL" : @50.0f,
//                                        @"InsetR" : @15.0f,
//                                        @"pHeight" : @(pHeight),
//                                        @"MainBaseline" : @(baseline),
//                                        @"InsetV" : @(vInset),
//                                        @"InnerSpacing" : @10.0f};
//    
//    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(InsetV)-[pImg]-[bodyText]-(InsetV)-|" options:0 metrics:metricsDictionary views:viewsDictionary];
//    [self.contentView addConstraints:constraints];
//    
////    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[bodyText]-(InsetV)-|" options:0 metrics:metricsDictionary views:viewsDictionary];
////    [self.contentView addConstraints:constraints];
//    
//    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(ProfileInsetL)-[pImg]-(InnerSpacing)-[fullName]-(InnerSpacing)-[userName]" options:0 metrics:metricsDictionary views:viewsDictionary];
//    [self.contentView addConstraints:constraints];
//    
//    
//    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(BodyInsetL)-[bodyText]-(InsetR)-|" options:0 metrics:metricsDictionary views:viewsDictionary];
//    [self.contentView addConstraints:constraints];
//    
//    
//    // fullNameLabel
//    [self.contentView addConstraint:[NSLayoutConstraint
//                                     constraintWithItem:self.fullNameLabel
//                                     attribute:NSLayoutAttributeBaseline
//                                     relatedBy:NSLayoutRelationEqual
//                                     toItem:self.contentView
//                                     attribute:NSLayoutAttributeTop
//                                     multiplier:1.0f
//                                     constant:baseline]];
//    
//    // userNameLabel
//    [self.contentView addConstraint:[NSLayoutConstraint
//                                     constraintWithItem:self.userNameLabel
//                                     attribute:NSLayoutAttributeBaseline
//                                     relatedBy:NSLayoutRelationEqual
//                                     toItem:self.contentView
//                                     attribute:NSLayoutAttributeTop
//                                     multiplier:1.0f
//                                     constant:baseline]];
//    
//    // Profile
////    [self.contentView addConstraint:[NSLayoutConstraint
////                                     constraintWithItem:self.profileImg
////                                     attribute:NSLayoutAttributeBaseline
////                                     relatedBy:NSLayoutRelationEqual
////                                     toItem:self.contentView
////                                     attribute:NSLayoutAttributeTop
////                                     multiplier:1.0f
////                                     constant:(vInset + pHeight)]];
//    
////    [self.contentView addConstraint:[NSLayoutConstraint
////                                     constraintWithItem:self.profileImg
////                                     attribute:NSLayoutAttributeWidth
////                                     relatedBy:NSLayoutRelationEqual
////                                     toItem:nil
////                                     attribute:NSLayoutAttributeNotAnAttribute
////                                     multiplier:1.0f
////                                     constant:pHeight]];
//    
////    [self.contentView addConstraint:[NSLayoutConstraint
////                                     constraintWithItem:self.profileImg
////                                     attribute:NSLayoutAttributeHeight
////                                     relatedBy:NSLayoutRelationEqual
////                                     toItem:nil
////                                     attribute:NSLayoutAttributeNotAnAttribute
////                                     multiplier:1.0f
////                                     constant:pHeight]];
//    
//    // Body
////    [self.contentView addConstraint:[NSLayoutConstraint
////                                     constraintWithItem:self.bodyTextView
////                                     attribute:NSLayoutAttributeTop
////                                     relatedBy:NSLayoutRelationEqual
////                                     toItem:self.fullNameLabel
////                                     attribute:NSLayoutAttributeBaseline
////                                     multiplier:1.0f
////                                     constant:(vInset / 1.6)]];
//    
//    bodyHeightConstraint = [NSLayoutConstraint constraintWithItem:self.bodyTextView
//                                                        attribute:NSLayoutAttributeHeight
//                                                        relatedBy:NSLayoutRelationEqual
//                                                           toItem:nil
//                                                        attribute:NSLayoutAttributeNotAnAttribute
//                                                       multiplier:0.f
//                                                         constant:50.0f];
//    [self.contentView addConstraint:bodyHeightConstraint];
    
//    self.didSetupConstraints = YES;
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

- (void)prepareForReuse
{
    [super prepareForReuse];
    
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
    
    self.imageView.image = nil;
    [self.bodyHeightConstraint setConstant:1000.0f];
    
//    NSAttributedString *aStr = [[NSAttributedString alloc] initWithString:@""];
//    self.fullNameLabel.attributedText = nil;
//    self.userNameLabel.attributedText = aStr;
//    self.bodyTextView.attributedText = nil;
}

@end
