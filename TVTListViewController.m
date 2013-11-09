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
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"viewDidLoad");
    
    [[self tableView] registerClass:[TVTCell class] forCellReuseIdentifier:CellIdentifier];
}




- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"viewDidAppear");
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(contentSizeCategoryChanged:)
                                                 name:UIContentSizeCategoryDidChangeNotification
                                               object:nil];
}


- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    NSLog(@"viewDidDisappear");
    
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
    NSLog(@"numberOfSectionsInTableView");
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"tableView:numberOfRowsInSection:");
//    return self.model.dataSource.count;

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"------ tableView:cellForRowAtIndexPath ------");
    TVTCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
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
    
    NSLog(@"\n ---- cell.contentView | frame: %@ bounds: %@ \n\n\n\n", NSStringFromCGRect(cell.contentView.frame), NSStringFromCGSize(cell.contentView.bounds.size));
    
    [cell.bodyTextView setNeedsLayout];
    [cell.bodyTextView layoutIfNeeded];

    NSLog(@"\n---- tableView:cellForRowAtIndexPath --00-- cell.bodyTextView | frame: %@ bounds: %@ contentSize: %@\n\n", NSStringFromCGRect(cell.bodyTextView.frame), NSStringFromCGSize(cell.bodyTextView.bounds.size), NSStringFromCGSize(cell.bodyTextView.contentSize));

    
//    NSLog(@"-- cell.bodyTextView -- 00 -- | frame: %@ bounds: %@ contentSize: %@", NSStringFromCGRect(cell.bodyTextView.frame), NSStringFromCGSize(cell.bodyTextView.bounds.size), NSStringFromCGSize(cell.bodyTextView.contentSize));
//    
//    [cell.contentView setNeedsLayout];
//    [cell.contentView layoutIfNeeded];
//    
//    [cell setNeedsUpdateConstraints];
//    
//    CGFloat height = [cell.bodyTextView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
//    [[cell bodyHeightConstraint] setConstant:height];
//    NSLog(@"bodyHeightConstraint constant set to: %f", height);
//    
//    NSLog(@"-- cell.bodyTextView -- 01 -- | frame: %@ bounds: %@ contentSize: %@", NSStringFromCGRect(cell.bodyTextView.frame), NSStringFromCGSize(cell.bodyTextView.bounds.size), NSStringFromCGSize(cell.bodyTextView.contentSize));
//    CGSize size = [cell.bodyTextView sizeThatFits:CGSizeMake(275, FLT_MAX)];
//    NSLog(@"%@: %@", cell.userNameLabel.text, NSStringFromCGSize(size));
//    [cell.bodyTextView setFrame:CGRectMake(0, 0, size.width, size.height)];
//    [cell.bodyTextView sizeToFit];
//    
//    NSLog(@"After  contentSize: %f, %f", cell.bodyTextView.frame.size.width, cell.bodyTextView.frame.size.height);
//    
//    CGSize size = [cell.bodyTextView sizeThatFits:CGSizeMake(cell.bodyTextView.bounds.size.width, FLT_MAX)];
//    [cell.bodyTextView setFrame:CGRectMake(0, 0, size.width, size.height)];
//    
//    NSLog(@"After  contentSize: %f, %f", cell.bodyTextView.contentSize.height, cell.bodyTextView.contentSize.width);
//    
////    cell.bodyLabel.userInteractionEnabled = YES;
//    cell.fullNameLabel.userInteractionEnabled = YES;
//    
//    for(UIView *view in cell.contentView.subviews) {
//        if(view.tag <= TappedName) {
//            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
//            tap.view.tag = indexPath.row;
//            [tap setNumberOfTapsRequired:1];
//            [view addGestureRecognizer:tap];
//        }
//    }
//
//    
//    NSLog(@"%@ \nCell Frame: %@\nTextView Frame: %@\nTextView ContentSize: %@",cell.fullNameLabel.text, NSStringFromCGRect(cell.frame), NSStringFromCGRect(cell.bodyTextView.frame), NSStringFromCGSize(cell.bodyTextView.contentSize));
    // Make sure the constraints have been added to this cell, since it may have just been created from scratch
//    [cell setNeedsUpdateConstraints];
//    NSLog(@"setNeedsUpdateConstraints");
//    
//    NSLog(@"-- cell.bodyTextView -- 02 -- | frame: %@ bounds: %@ contentSize: %@", NSStringFromCGRect(cell.bodyTextView.frame), NSStringFromCGSize(cell.bodyTextView.bounds.size), NSStringFromCGSize(cell.bodyTextView.contentSize));
 
    return cell;
}






- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"------ tableView:heightForRowAtIndexPath ------");
    TVTCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    [cell updateFonts];
    
    bodyFontAttributes = [UIFont fontWithName:@"HelveticaNeue-Light" size:[UIFont preferredFontForTextStyle:UIFontTextStyleHeadline].pointSize];
    
    [cell.profileImg setImage:[UIImage imageNamed:@"profileImg-default.png"]];
    
    // Populate labels
    NSDictionary *dataSourceItem = [self.model.dataSource objectAtIndex:indexPath.row];
    cell.fullNameLabel.attributedText =  [dataSourceItem valueForKey:@"name"];
    cell.userNameLabel.attributedText =  [dataSourceItem valueForKey:@"user"];
    
    NSMutableAttributedString *bodyText = [[dataSourceItem valueForKey:@"body"] mutableCopy];
//    NSRange bodyStringLength = NSMakeRange(0, bodyText.length);
    [bodyText addAttribute:NSFontAttributeName value:bodyFontAttributes range:NSMakeRange(0, bodyText.length)];
    cell.bodyTextView.attributedText = bodyText;
    
    NSLog(@"---- tableView:heightForRowAtIndexPath --00-- cell.bodyTextView | frame: %@ bounds: %@ contentSize: %@\n\n", NSStringFromCGRect(cell.bodyTextView.frame), NSStringFromCGSize(cell.bodyTextView.bounds.size), NSStringFromCGSize(cell.bodyTextView.contentSize));
    
    
    
    [cell.contentView setNeedsLayout];
    [cell.contentView layoutIfNeeded];
    
    NSLog(@"\n---- tableView:heightForRowAtIndexPath --01-- cell.bodyTextView | frame: %@ bounds: %@ contentSize: %@\n\n", NSStringFromCGRect(cell.bodyTextView.frame), NSStringFromCGSize(cell.bodyTextView.bounds.size), NSStringFromCGSize(cell.bodyTextView.contentSize));
    
    
    
    NSLog(@"\nbodyTextView Actual Contents: %@\n\n", cell.bodyTextView.text);
    
    
    
    
    CGSize size = [cell.bodyTextView sizeThatFits:CGSizeMake(cell.bodyTextView.bounds.size.width, FLT_MAX)];
    [cell.bodyHeightConstraint setConstant:size.height];
    
    NSLog(@"\n---- cell.bodyTextView sizeThatFits: %@\n\n", NSStringFromCGSize(size));
    
    
    
//    [cell setNeedsUpdateConstraints];
//    [cell updateConstraintsIfNeeded];
    [cell.contentView setNeedsLayout];
    [cell.contentView layoutIfNeeded];
    
    NSLog(@"\n---- tableView:heightForRowAtIndexPath --02-- cell.bodyTextView | frame: %@ bounds: %@ contentSize: %@\n\n", NSStringFromCGRect(cell.bodyTextView.frame), NSStringFromCGSize(cell.bodyTextView.bounds.size), NSStringFromCGSize(cell.bodyTextView.contentSize));
    
    
    
    
    CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    NSLog(@"contentView size: %@ (height: %f)",NSStringFromCGSize([cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize]), height);
    
    return height;
}






- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"tableView:estimatedHeightForRowAtIndexPath:");
    return 200.0f;
}


//- (CGFloat)textViewHeightForAttributedText: (NSAttributedString*)text andWidth: (CGFloat)width {
//    UITextView *calculationView = [[UITextView alloc] init];
//    [calculationView setAttributedText:text];
//    CGSize size = [calculationView sizeThatFits:CGSizeMake(width, FLT_MAX)];
//    return size.height;
//}
//
//- (CGFloat)textViewHeightForRowAtIndexPath: (NSIndexPath*)indexPath {
//    UITextView *calculationView = [self.tableView objectForKey: indexPath];
//    CGFloat textViewWidth = calculationView.frame.size.width;
//    if (!calculationView.attributedText) {
//        // This will be needed on load, when the text view is not inited yet
//        
//        calculationView = [[UITextView alloc] init];
//        calculationView.attributedText = // get the text from your datasource add attributes and insert here
//        CGFloat textViewWidth = 290.0; // Insert the width of your UITextViews or include calculations to set it accordingly
//    }
//    CGSize size = [calculationView sizeThatFits:CGSizeMake(textViewWidth, FLT_MAX)];
//    return size.height;
//}



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
