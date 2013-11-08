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

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
//        UIFont *nameFont= [UIFont fontWithName:@"HelveticaNeue-Light" size:[UIFont preferredFontForTextStyle:UIFontTextStyleHeadline].pointSize + 6];
//        UIFont *userFont= [UIFont fontWithName:@"HelveticaNeue-Light" size:[UIFont preferredFontForTextStyle:UIFontTextStyleHeadline].pointSize - 3];
//        UIFont *bodyFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:[UIFont preferredFontForTextStyle:UIFontTextStyleHeadline].pointSize];
//        
//        NSAttributedString *attrStringBody = [[NSAttributedString alloc] initWithString:@"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent non quam ac massa viverra semper. Maecenas mattis justo ac augue volutpat congue. Maecenas laoreet, nulla eu faucibus" attributes:@{NSFontAttributeName: bodyFont}];
//        NSAttributedString *attrStringName = [[NSAttributedString alloc] initWithString:@"Random User" attributes:@{NSFontAttributeName: nameFont}];
//        NSAttributedString *attrStringUser = [[NSAttributedString alloc] initWithString:@"username" attributes:@{NSFontAttributeName: userFont}];
        
//        dataArray = [NSArray arrayWithObjects:
//                     attrStringBody,
//                     @"Now it’s Oscar the Grouch and some of his lady friends singing “Grouch Girls Don’t Wanna Have Fun.” This station is beyond great.",
//                     @"Something tells me this won’t be the last Ballmer public self humiliation we’ll be seeing.",
//                     @"Time-shifted TV watching has turned us into feral knowledge-repulsed animals who would shiv our own grandmothers.",
//                     @"Like savvy companies, @marcoarment wants to own every part of the supply chain to ensure the best @atpfm experience. Next up: a phone and OS",
//                     @"USAir’s flight attendants are using the loudspeaker to advertise a “special offer” to sign up for their credit card.",
//                     @"anytime you want to get @mattsinger to smile from here on out, just go up to him & say 'Hello, Mr. Ninja' in a British accent",
//                     @"Uptime Calendar for iPhone - http://loopu.in/18PZnj2",
//                     @"Velocity for iPhone - http://bpxl.me/14AmGKk",
//                     @"Just ordered my shiny new 15-inch MacBook Pro with Retina Display. So excited! Can't wait for daddy to come back from the US!",
//                     nil];
//        nameArray = [NSArray arrayWithObjects:
//                     attrStringName,
//                     @"Jesse James Herlitz",
//                     @"Mike Monteiro",
//                     @"David Deller",
//                     @"Marco Arment",
//                     @"ErikDavis",
//                     @"The Loop",
//                     @"Beautiful Pixels",
//                     @"Lele Buonerba",
//                     nil];
//        userNameArray = [NSArray arrayWithObjects:
//                         attrStringUser,
//                         @"@strike",
//                         @"@Mike_FTW",
//                         @"@dmdeller",
//                         @"@marcoarment",
//                         @"@ErikDavis",
//                         @"@theloop",
//                         @"@beautifulpixels",
//                         @"@lele",
//                         nil];
//        
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
    return nameArray.count;
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
    
//    NSLog(@"data: %@ | %@", [dataSourceItem valueForKey:@"title"], [dataSourceItem valueForKey:@"body"]);
    
    
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
    NSLog(@"Tap: %d", gr.view.tag);
    CGPoint p = [gr locationInView:gr.view];
//    NSLog(@"%f, %f", p.x, p.y);
    
    UILabel *tappedLabel = (UILabel *)gr.view;
    
    
    NSLayoutManager *layoutManager = [[NSLayoutManager alloc] init];
    NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize:gr.view.bounds.size];
    
//    NSLog(@"label size: %f, %f", gr.view.bounds.size.width, gr.view.bounds.size.height);
//    NSLog(@"textContainer size: %f, %f", textContainer.size.width, textContainer.size.height);
    
    NSTextStorage *textStorage = [[NSTextStorage alloc] initWithAttributedString:tappedLabel.attributedText];
    
//    NSLog(@"Attributed String: %@", tappedLabel.attributedText);
    
    [layoutManager setTextStorage:textStorage];
    [layoutManager addTextContainer:textContainer];
    
    NSUInteger charIndex = [layoutManager characterIndexForPoint:p inTextContainer:textContainer fractionOfDistanceBetweenInsertionPoints:NULL];
//    NSLog(@"%ul", charIndex);
    
    unichar uChar = [textStorage.string characterAtIndex:charIndex];
    NSString *s = [NSString stringWithCharacters:&uChar length:1];
    NSLog(@"Character Index: %d, Character: %@", charIndex, s);

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
