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

#import "TVTHeightCalculator.h"


static NSString *CellIdentifier = @"PostCell";

@interface TVTListViewController ()
@property (strong, nonatomic) RJModel *model;
@property (strong, nonatomic) NSArray *cellHeights;
@end

@implementation TVTListViewController
{
    UIFont *bodyFontAttributes;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        NSLog(@"initWithStyle");
        
        self.model = [[RJModel alloc] init];
        [self.model populateDataSource];
        
        self.title = @"Table View Test Controller";
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
        [self.tableView setSeparatorColor:[UIColor clearColor]];
        [self.tableView setRowHeight:400.0f];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[self tableView] registerClass:[TVTCell class] forCellReuseIdentifier:CellIdentifier];
    //    [self calculateHeightsForAllCells];
}




- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(contentSizeCategoryChanged:)
                                                 name:UIContentSizeCategoryDidChangeNotification
                                               object:nil];
    
//    NSArray *_visibleCells = [self.tableView visibleCells];
//    NSIndexPath *ip = [self.tableView indexPathForCell:[_visibleCells objectAtIndex:0]];
//    [[TVTHeightCalculator sharedStore] heightForIndexPath:ip];
    [[NSOperationQueue mainQueue] addOperationWithBlock:^void(void){
        [self calculateHeightsForAllCells];
        NSLog(@"\nfinished calculating cell heights\n");
    }];

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
    
    // Change Profile Image
    [cell.profileImg setImage:[UIImage imageNamed:@"profileImg-default.png"]];
    
    // Populate labels
    NSDictionary *dataSourceItem = [self.model.dataSource objectAtIndex:indexPath.row];
    cell.fullNameLabel.attributedText =  [dataSourceItem valueForKey:@"name"];
    cell.userNameLabel.attributedText =  [dataSourceItem valueForKey:@"user"];
    
    // Populate set style and text of textview
    NSMutableAttributedString *bodyText = [[dataSourceItem valueForKey:@"body"] mutableCopy];
    NSRange bodyStringLength = NSMakeRange(0, bodyText.length);
    [bodyText addAttribute:NSFontAttributeName value:bodyFontAttributes range:bodyStringLength];
    cell.bodyTextView.attributedText = bodyText;
    
//    NSLog(@"\n ---- cell.contentView | frame: %@ bounds: %@ \n\n\n\n", NSStringFromCGRect(cell.contentView.frame), NSStringFromCGSize(cell.contentView.bounds.size));
    
    [cell.bodyTextView setNeedsLayout];
    [cell.bodyTextView layoutIfNeeded];
    [cell.bodyTextView setNeedsUpdateConstraints];
    [cell.bodyTextView updateConstraintsIfNeeded];

    CGSize size = [cell.bodyTextView sizeThatFits:CGSizeMake(cell.bodyTextView.bounds.size.width, FLT_MAX)];
    [cell.bodyHeightConstraint setConstant:size.height];
    NSLog(@"Cell bodyText |00| frame: %@, bounds: %@", NSStringFromCGRect(cell.bodyTextView.frame), NSStringFromCGSize(cell.bodyTextView.contentSize));
    NSLog(@"Cell contentView |00| frame: %@, bounds: %@", NSStringFromCGRect(cell.contentView.frame), NSStringFromCGSize(cell.contentView.bounds.size));
    [cell.contentView setNeedsLayout];
    [cell.contentView layoutIfNeeded];
    [cell.contentView setNeedsUpdateConstraints];
    [cell.contentView updateConstraintsIfNeeded];
    NSLog(@"Cell bodyText |01| frame: %@, bounds: %@", NSStringFromCGRect(cell.bodyTextView.frame), NSStringFromCGSize(cell.bodyTextView.contentSize));
    NSLog(@"Cell contentView |00| frame: %@, bounds: %@", NSStringFromCGRect(cell.contentView.frame), NSStringFromCGSize(cell.contentView.bounds.size));

    return cell;
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = [[self.cellHeights objectAtIndex:indexPath.row] floatValue];
    if (height == 0) {
        height = [self heightForRowAtIndexPath:indexPath.row];
    }
    return height;
    
//    CGFloat preCalcHeight = [[self.cellHeights objectAtIndex:indexPath.row] floatValue];
//    CGFloat nowCalcHeight = [self heightForRowAtIndexPath:indexPath.row];
//    
//    NSLog(@"pre: %f | now: %f", preCalcHeight, nowCalcHeight);
//    return nowCalcHeight;
}






- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"tableView:estimatedHeightForRowAtIndexPath:");
    return 200.0f;
}



#pragma mark - Tap Gesture

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



#pragma mark - Cell height convenience methods

- (TVTCell *)configureCellAtRow:(NSInteger)row
{
    TVTCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    TVTCell *tempCell = [[TVTCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    [cell updateFonts];
    NSDictionary *dataSourceItem = [self.model.dataSource objectAtIndex:row];
    
    // Prep attributed body text
    NSMutableAttributedString *bodyText = [[dataSourceItem valueForKey:@"body"] mutableCopy];
    bodyFontAttributes = [UIFont fontWithName:@"HelveticaNeue-Light" size:[UIFont preferredFontForTextStyle:UIFontTextStyleHeadline].pointSize];
    [bodyText addAttribute:NSFontAttributeName value:bodyFontAttributes range:NSMakeRange(0, bodyText.length)];
    
    // Populate text for height calculation
    cell.bodyTextView.attributedText = bodyText;
    cell.fullNameLabel.attributedText =  [dataSourceItem valueForKey:@"name"];
    return cell;
}

- (CGFloat)heightForRowAtIndexPath:(NSInteger)row
{
    TVTCell *cell = [self configureCellAtRow:row];
//    TVTCell *tempCell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
////    TVTCell *tempCell = [[TVTCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//    
//    [tempCell updateFonts];
//    NSDictionary *dataSourceItem = [self.model.dataSource objectAtIndex:ip.row];
//    
//    // Prep attributed body text
//    NSMutableAttributedString *bodyText = [[dataSourceItem valueForKey:@"body"] mutableCopy];
//    bodyFontAttributes = [UIFont fontWithName:@"HelveticaNeue-Light" size:[UIFont preferredFontForTextStyle:UIFontTextStyleHeadline].pointSize];
//    [bodyText addAttribute:NSFontAttributeName value:bodyFontAttributes range:NSMakeRange(0, bodyText.length)];
//    
//    // Populate text for height calculation
//    tempCell.bodyTextView.attributedText = bodyText;
//    tempCell.fullNameLabel.attributedText =  [dataSourceItem valueForKey:@"name"];
    
    //    NSLog(@"---- (Custom) heightForRowAtIndexPath: --00-- cell.bodyTextView | frame: %@ bounds: %@ contentSize: %@\n\n", NSStringFromCGRect(cell.bodyTextView.frame), NSStringFromCGSize(cell.bodyTextView.bounds.size), NSStringFromCGSize(cell.bodyTextView.contentSize));
    
    CGSize size = [cell.bodyTextView sizeThatFits:CGSizeMake(275, FLT_MAX)];
    [cell.bodyHeightConstraint setConstant:size.height];
    
    [cell.contentView setNeedsLayout];
    [cell.contentView layoutIfNeeded];
    
    CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    //    NSLog(@"contentView size: %@ (height: %f)",NSStringFromCGSize([cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize]), height);
    //    [cell.cellHeightConstraint setConstant:height];
    NSLog(@"contentView calculated height: %f", height);
    return height;
}






//- (void)calculateHeightsForCells {
//    NSMutableArray *sections = [[NSMutableArray alloc] init];
//    
//    for (NSInteger section = 0; section <= [self.tableView numberOfSections]; section++) {
//        NSMutableArray *tempSection = [[NSMutableArray alloc] init];
//        for (NSInteger row = 0; row <= [self.tableView numberOfRowsInSection:section]; row++) {
//            // Calc height
//            CGFloat *cellHeight =
//            tempSection addObject:[]
//        }
//        
//    }
//

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


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
