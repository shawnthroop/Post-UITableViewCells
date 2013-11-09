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
        self.contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
//        self.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        
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
        self.fullNameLabel.tag = TappedName;
        
        // Username
        self.userNameLabel = [[UILabel alloc] init];
        self.userNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.userNameLabel setLineBreakMode:NSLineBreakByTruncatingTail];
        [self.userNameLabel setNumberOfLines:1];
        [self.userNameLabel setTextAlignment:NSTextAlignmentLeft];
        [self.userNameLabel setTextColor:userNameColor];
        [self.userNameLabel setBackgroundColor:[UIColor clearColor]];
        
        // Post Body
//        self.bodyLabel = [[UILabel alloc] init];
//        [self.bodyLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
//        [self.bodyLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
//        [self.bodyLabel setLineBreakMode:NSLineBreakByWordWrapping];
//        [self.bodyLabel setNumberOfLines:0];
//        [self.bodyLabel setTextAlignment:NSTextAlignmentLeft];
//        [self.bodyLabel setTextColor:bodyColor];
//        [self.bodyLabel setBackgroundColor:[UIColor redColor]];
//        self.bodyLabel.tag = TappedBody;
        
        // Post Body TextView
        self.bodyTextView = [[UITextView alloc] init];
        self.bodyTextView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.bodyTextView setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        self.bodyTextView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        self.bodyTextView.backgroundColor = [UIColor orangeColor];
//        self.bodyTextView.textContainerInset = UIEdgeInsetsMake(-4, -6, -4, -8);
        self.bodyTextView.editable = NO;
        self.bodyTextView.scrollEnabled = NO;

        
        [self.contentView addSubview:self.profileImg];
        [self.contentView addSubview:self.fullNameLabel];
        [self.contentView addSubview:self.userNameLabel];
//        [self.contentView addSubview:self.bodyLabel];
        [self.contentView addSubview:self.bodyTextView];
        
        [self updateFonts];
        
        float pHeight = self.fullNameLabel.font.capHeight;
        float vInset = (1.0 * self.bodyTextView.font.pointSize);
        float baseline = pHeight + vInset;

        
        NSDictionary *viewsDictionary = @{@"pImg" : self.profileImg,
                                          @"fullName" : self.fullNameLabel,
                                          @"userName" : self.userNameLabel,
                                          @"bodyText" : self.bodyTextView, };
        NSDictionary *metricsDictionary = @{@"BodyInsetL" : @30.0f,
                                            @"ProfileInsetL" : @20.0f,
                                            @"FullInsetL" : @50.0f,
                                            @"InsetR" : @15.0f,
                                            @"pHeight" : @(pHeight),
                                            @"MainBaseline" : @(baseline),
                                            @"InsetV" : @(vInset),
                                            @"InnerSpacing" : @10.0f, @"bodyW" : @275.0f};
        
        NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(InsetV)-[pImg]-[bodyText]-(InsetV)-|" options:0 metrics:metricsDictionary views:viewsDictionary];
        [self.contentView addConstraints:constraints];
        
        //    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[bodyText]-(InsetV)-|" options:0 metrics:metricsDictionary views:viewsDictionary];
        //    [self.contentView addConstraints:constraints];
        
        constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(ProfileInsetL)-[pImg]-(InnerSpacing)-[fullName]-(InnerSpacing)-[userName]" options:0 metrics:metricsDictionary views:viewsDictionary];
        [self.contentView addConstraints:constraints];
        
        
        constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[bodyText(==bodyW)]-(InsetR)-|" options:0 metrics:metricsDictionary views:viewsDictionary];
        [self.contentView addConstraints:constraints];
        
        
        // fullNameLabel
        [self.contentView addConstraint:[NSLayoutConstraint
                                         constraintWithItem:self.fullNameLabel
                                         attribute:NSLayoutAttributeBaseline
                                         relatedBy:NSLayoutRelationEqual
                                         toItem:self.contentView
                                         attribute:NSLayoutAttributeTop
                                         multiplier:1.0f
                                         constant:baseline]];
        
        // userNameLabel
        [self.contentView addConstraint:[NSLayoutConstraint
                                         constraintWithItem:self.userNameLabel
                                         attribute:NSLayoutAttributeBaseline
                                         relatedBy:NSLayoutRelationEqual
                                         toItem:self.contentView
                                         attribute:NSLayoutAttributeTop
                                         multiplier:1.0f
                                         constant:baseline]];
        
        // Profile
        [self.contentView addConstraint:[NSLayoutConstraint
                                         constraintWithItem:self.profileImg
                                         attribute:NSLayoutAttributeBaseline
                                         relatedBy:NSLayoutRelationEqual
                                         toItem:self.contentView
                                         attribute:NSLayoutAttributeTop
                                         multiplier:1.0f
                                         constant:(vInset + pHeight)]];
        
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
                                                             constant:50.0f];
        [self.contentView addConstraint:bodyHeightConstraint];
    }
    return self;
}


- (void)updateConstraints
{
    [super updateConstraints];
    
    
//    float pHeight = self.fullNameLabel.font.capHeight;
//    float vInset = (1.0 * self.bodyTextView.font.pointSize);
//    float baseline = pHeight + vInset;
    
//    self.bodyTextView.frame = self.contentView.bounds;
    CGSize bodySize = self.bodyTextView.contentSize;
    
    [bodyHeightConstraint setConstant:bodySize.height];
    
    NSLog(@"bodyTextView Actual Contents: %@", self.bodyTextView.text);
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


- (void)setBounds:(CGRect)bounds
{
    [super setBounds:bounds];
    NSLog(@"----------------------setBoundsCalled -------");
//    self.bodyTextView.frame = bounds;
//    CGSize bodySize = self.bodyTextView.contentSize;
//    
//    [bodyHeightConstraint setConstant:bodySize.height];
//    
//    [self layoutIfNeeded];
//    
//    NSLog(@"Bounds - TextView: %@ | ContentView: %@ | Cell: %@", NSStringFromCGRect(self.bodyTextView.bounds), NSStringFromCGRect(self.contentView.bounds), NSStringFromCGRect(self.bounds));
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
    
    self.imageView.image = nil;
    [self.bodyTextView invalidateIntrinsicContentSize];
    [self setNeedsUpdateConstraints];
    
    NSAttributedString *aStr = [[NSAttributedString alloc] initWithString:@""];
    self.fullNameLabel.attributedText = aStr;
    self.userNameLabel.attributedText = aStr;
    self.bodyTextView.attributedText = aStr;
}

@end
