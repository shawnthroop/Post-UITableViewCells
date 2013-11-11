//
//  TVTListViewController.m
//  TableViewTest
//
//  Created by Shawn Throop on 2013-09-23.
//  Copyright (c) 2013 Silent H Design. All rights reserved.
//

#import "TVTListViewController.h"
#import "TVTCell.h"
#import "RJModel.h"

static NSString *CellIdentifier = @"PostCell";

@interface TVTListViewController ()
@property (strong, nonatomic) RJModel *model;
@property (strong, nonatomic) NSArray *cellHeights;
@property CGFloat bodyWidth;
@end

@implementation TVTListViewController
{
    UIFont *bodyFontAttributes;
}
@synthesize bodyWidth;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        NSLog(@"initWithStyle");
        
        self.model = [[RJModel alloc] init];
        [self.model populateDataSource];
        
        self.title = @"Table View Test Controller";
        bodyWidth = 275;
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
        [self.tableView setSeparatorColor:[UIColor clearColor]];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self calculateHeightsForAllCells];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[self tableView] registerClass:[TVTCell class] forCellReuseIdentifier:CellIdentifier];
}




- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(contentSizeCategoryChanged:)
                                                 name:UIContentSizeCategoryDidChangeNotification
                                               object:nil];
}


- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIContentSizeCategoryDidChangeNotification
                                                  object:nil];
}


- (void)contentSizeCategoryChanged:(NSNotification *)notification
{
    [self.tableView reloadData];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.model.dataSource.count;

//    return 1;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TVTCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.contentView.frame = CGRectMake(0,0, cell.frame.size.width,kDefaultCellHeight);
    
    [cell updateFonts];
    bodyFontAttributes = [UIFont fontWithName:@"HelveticaNeue-Light" size:[UIFont preferredFontForTextStyle:UIFontTextStyleHeadline].pointSize];
    UIColor *color = fullNameColor;
    
    // Change Profile Image
    [cell.profileImg setImage:[UIImage imageNamed:@"profileImg-default.png"]];
    
    // Populate labels
    NSDictionary *dataSourceItem = [self.model.dataSource objectAtIndex:indexPath.row];
    cell.fullNameLabel.text =  [dataSourceItem valueForKey:@"name"];
    cell.userNameLabel.text =  [dataSourceItem valueForKey:@"user"];
    
    // Populate set style and text of textview
    NSMutableAttributedString *bodyText = [[dataSourceItem valueForKey:@"body"] mutableCopy];
    NSRange bodyStringLength = NSMakeRange(0, bodyText.length);
    [bodyText addAttribute:NSFontAttributeName value:bodyFontAttributes range:bodyStringLength];
    [bodyText addAttribute:NSForegroundColorAttributeName value:color range:bodyStringLength];
    cell.bodyTextView.attributedText = bodyText;
    
    // Set body cell height so layout will
    CGSize size = [cell.bodyTextView sizeThatFits:CGSizeMake(275, FLT_MAX)];
    [cell.bodyHeightConstraint setConstant:size.height];
    
    [cell.contentView setNeedsLayout];
    [cell.contentView layoutIfNeeded];
    [cell.contentView setNeedsUpdateConstraints];
    [cell.contentView updateConstraintsIfNeeded];
    
    return cell;
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = [[self.cellHeights objectAtIndex:indexPath.row] floatValue];
    if (height == 0) {
        height = [self heightForRowAtIndexPath:indexPath.row];
    }
    return height;
}






- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"tableView:estimatedHeightForRowAtIndexPath:");
    return 200.0f;
}





#pragma mark - Cell height convenience methods


- (CGFloat)heightForRowAtIndexPath:(NSInteger)row
{
    TVTCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    [cell updateFonts];
    NSDictionary *dataSourceItem = [self.model.dataSource objectAtIndex:row];
    
    // Prep attributed body text
    NSMutableAttributedString *bodyText = [[dataSourceItem valueForKey:@"body"] mutableCopy];
    bodyFontAttributes = [UIFont fontWithName:@"HelveticaNeue-Light" size:[UIFont preferredFontForTextStyle:UIFontTextStyleHeadline].pointSize];
    [bodyText addAttribute:NSFontAttributeName value:bodyFontAttributes range:NSMakeRange(0, bodyText.length)];
    
    // Populate text for height calculation
    cell.bodyTextView.attributedText = bodyText;
    cell.fullNameLabel.text =  [dataSourceItem valueForKey:@"name"];
    
    CGSize size = [cell.bodyTextView sizeThatFits:CGSizeMake(275, FLT_MAX)];
    [cell.bodyHeightConstraint setConstant:size.height];
    
    [cell.contentView setNeedsLayout];
    [cell.contentView layoutIfNeeded];
    
    CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    return height;
    
    
}





#pragma mark - Precalculating cell heights

- (void)calculateHeightsForAllCells
{
    NSMutableArray *tempHeights = [[NSMutableArray alloc] init];
    for (NSInteger row = 0; row < [self.tableView numberOfRowsInSection:0]; row++) {

        NSNumber *cellHeight = [NSNumber numberWithInteger:[self heightForRowAtIndexPath:row]];
        [tempHeights addObject:cellHeight];
    }
    self.cellHeights = [NSArray arrayWithArray:tempHeights];
}


//- (void)calculateCellHeight
//{
//    TVTCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    
//    [cell updateFonts];
//    NSAttributedString
//    
//    // Prep attributed body text
//    NSMutableAttributedString *bodyText = [[dataSourceItem valueForKey:@"body"] mutableCopy];
//    bodyFontAttributes = [UIFont fontWithName:@"HelveticaNeue-Light" size:[UIFont preferredFontForTextStyle:UIFontTextStyleHeadline].pointSize];
//    [bodyText addAttribute:NSFontAttributeName value:bodyFontAttributes range:NSMakeRange(0, bodyText.length)];
//    
//    // Populate text for height calculation
//    cell.bodyTextView.attributedText = bodyText;
//    cell.fullNameLabel.attributedText =  [dataSourceItem valueForKey:@"name"];
//    
//    CGSize size = [cell.bodyTextView sizeThatFits:CGSizeMake(275, FLT_MAX)];
//    [cell.bodyHeightConstraint setConstant:size.height];
//    
//    [cell.contentView setNeedsLayout];
//    [cell.contentView layoutIfNeeded];
//    
//    CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
//}





#pragma mark - Interaction

- (void)tap:(UIGestureRecognizer *)gr
{
    //    NSLog(@"Tap: %d", gr.view.tag);
    CGPoint p = [gr locationInView:gr.view];
    //    NSLog(@"%f, %f", p.x, p.y);
    
    UILabel *tappedLabel = (UILabel *)gr.view;
    
    UITextView *mappingTextView = [[UITextView alloc] initWithFrame:tappedLabel.frame];
    mappingTextView.attributedText = tappedLabel.attributedText;
    mappingTextView.font = tappedLabel.font;
    mappingTextView.textContainerInset = UIEdgeInsetsMake(0, -8, 0, -8);
    
    NSLog(@"label.width:%f textView.width %f", tappedLabel.frame.size.width, mappingTextView.frame.size.width);
    UITextPosition *tapPosition = [mappingTextView closestPositionToPoint:p];
    if (tapPosition == nil) {
        NSLog(@"Tap Position fail");
        return;
    }
    
    UITextPosition *textPosition = tapPosition;
    
    UITextRange *rangeOfCharacter = [mappingTextView.tokenizer rangeEnclosingPosition:textPosition withGranularity:UITextGranularityCharacter inDirection:UITextWritingDirectionNatural];
    NSString *oneCharacter = [mappingTextView textInRange:rangeOfCharacter];
    NSLog(@"Character: %@, Position: %@", oneCharacter, rangeOfCharacter);
}



@end
