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
    NSTextStorage *textStorage;
    NSTextContainer *textContainer;
    NSLayoutManager *layoutManager;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
        layoutManager = [[NSLayoutManager alloc] init];
        textContainer = [[NSTextContainer alloc] init];
        textStorage = [[NSTextStorage alloc] init];
        
        [layoutManager setTextStorage:textStorage];
        [layoutManager addTextContainer:textContainer];
        
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
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    TVTCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    [cell updateFonts];
    
    [cell.profileImg setImage:[UIImage imageNamed:@"profileImg-default.png"]];
    
    // Populate labels
    NSDictionary *dataSourceItem = [self.model.dataSource objectAtIndex:indexPath.row];
    
    cell.fullNameLabel.attributedText =  [dataSourceItem valueForKey:@"name"];
    cell.userNameLabel.attributedText =  [dataSourceItem valueForKey:@"user"];
    cell.bodyLabel.attributedText = [dataSourceItem valueForKey:@"body"];
        
    cell.bodyLabel.userInteractionEnabled = YES;
    cell.fullNameLabel.userInteractionEnabled = YES;
    
    for(UIView *view in cell.contentView.subviews) {
        if(view.tag <= TappedName) {
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
            tap.view.tag = indexPath.row;
            [tap setNumberOfTapsRequired:1];
            [view addGestureRecognizer:tap];
        }
    }
    
    // Make sure the constraints have been added to this cell, since it may have just been created from scratch
    [cell setNeedsUpdateConstraints];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TVTCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    [cell updateFonts];
    
    [cell.profileImg setImage:[UIImage imageNamed:@"profileImg-default.png"]];
    
    // Populate labels
    NSDictionary *dataSourceItem = [self.model.dataSource objectAtIndex:indexPath.row];
    cell.fullNameLabel.attributedText =  [dataSourceItem valueForKey:@"name"];
    cell.userNameLabel.attributedText =  [dataSourceItem valueForKey:@"user"];
    cell.bodyLabel.attributedText = [dataSourceItem valueForKey:@"body"];
    
    cell.bodyLabel.preferredMaxLayoutWidth = tableView.bounds.size.width - (kBodyHorizontalInsetLeft + kInsetRight);
    
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    [cell.contentView setNeedsLayout];
    [cell.contentView layoutIfNeeded];
    
    CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    
    return height;
}


- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
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
