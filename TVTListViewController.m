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
@property CGFloat otherHeight;
@property CGFloat bodyWidth;
@end

@implementation TVTListViewController
@synthesize bodyWidth, otherHeight;

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
    [self calculateHeightVariables];
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
    [self calculateHeightVariables];
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

//    return 1; // For testing
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TVTCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.contentView.frame = CGRectMake(0,0, cell.frame.size.width,kDefaultCellHeight);
    
    [cell updateFonts];
    
    // Change Profile Image
    [cell.profileImg setImage:[UIImage imageNamed:@"profileImg-default.png"]];
    
    // Populate labels
    NSDictionary *dataSourceItem = [self.model.dataSource objectAtIndex:indexPath.row];
    cell.fullNameLabel.text =  [dataSourceItem valueForKey:@"name"];
    cell.userNameLabel.text =  [dataSourceItem valueForKey:@"user"];
    cell.bodyTextView.attributedText = [self prepBodyTextView:[[dataSourceItem valueForKey:@"body"] mutableCopy]];
    
    // find a suitable bodyTextView height
    CGSize size = [cell.bodyTextView sizeThatFits:CGSizeMake(275, FLT_MAX)];
    
    // update constraints
    [cell.bodyHeightConstraint setConstant:size.height];
    [cell.profileHeightConstraint setConstant:cell.fullNameLabel.font.capHeight];
    [cell.profileWidthConstraint setConstant:cell.fullNameLabel.font.capHeight];

    
    [cell.contentView setNeedsLayout];
    [cell.contentView layoutIfNeeded];
    [cell.contentView setNeedsUpdateConstraints];
    [cell.contentView updateConstraintsIfNeeded];

    return cell;
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self heightForRowAtIndexPath:indexPath.row];
}






- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 240.0f;
}





#pragma mark - Cell height convenience methods


- (CGFloat)heightForRowAtIndexPath:(NSInteger)row
{
    // Setup dataSource
    NSDictionary *dataSourceItem = [self.model.dataSource objectAtIndex:row];

    // Prep attributed body text
    NSMutableAttributedString *bodyText = [self prepBodyTextView:[[dataSourceItem valueForKey:@"body"] mutableCopy]];

    // Get height
    UITextView *tempTextField = [[UITextView alloc] init];
    tempTextField.textContainerInset = bodyTextEdgeInsets // in this case: UIEdgeInsetsMake(-2, -4, 0, -4); // (t, l, b, r)
    tempTextField.attributedText = bodyText;
    CGFloat height = [tempTextField sizeThatFits:CGSizeMake(275, FLT_MAX)].height;
    tempTextField = nil;
        
    return height + otherHeight;
}



- (NSMutableAttributedString *)prepBodyTextView:(NSMutableAttributedString *)string
{
    // setup styles
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineHeightMultiple = 1.1f;
    
    UIColor *color = bodyColor;
    UIFont *font = kBodyFont;
    
    // add styles
    [string addAttributes:@{NSParagraphStyleAttributeName: paragraphStyle,
                            NSFontAttributeName : font,
                            NSForegroundColorAttributeName : color}
                    range:NSMakeRange(0, string.length)];
    return string;
}





#pragma mark - Precalculating cell heights


- (void)calculateHeightVariables;
{
    TVTCell *cell = [[TVTCell alloc] init];
    [cell updateFonts];
    
    // Setup dummy text
    NSString *nameText = @"Tyler Durden";
    NSMutableAttributedString *bodyText = [self prepBodyTextView:[[NSAttributedString alloc] initWithString:@"Testing 1, 2, 3"].mutableCopy];
    
    // Populate text for height calculation
    cell.bodyTextView.attributedText = bodyText;
    cell.fullNameLabel.text =  nameText;
    
    // Calculate height required to accomodate bodyText
    CGSize bodySize = [cell.bodyTextView sizeThatFits:CGSizeMake(275, FLT_MAX)];
    [cell.bodyHeightConstraint setConstant:bodySize.height];
    
    [cell.contentView setNeedsLayout];
    [cell.contentView layoutIfNeeded];

    CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    otherHeight = height - bodySize.height;
}





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
