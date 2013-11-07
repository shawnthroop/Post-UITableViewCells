//
//  TVTListViewController.m
//  TableViewTest
//
//  Created by Shawn Throop on 2013-09-23.
//  Copyright (c) 2013 Silent H Design. All rights reserved.
//

#import "TVTListViewController.h"
#import "TVTCell.h"


static NSString *CellIdentifier = @"PostCell";

@interface TVTListViewController ()

@end

@implementation TVTListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        dataArray = [NSArray arrayWithObjects:
                     @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent non quam ac massa viverra semper. Maecenas mattis justo ac augue volutpat congue. Maecenas laoreet, nulla eu faucibus gravida,",
                     @"Vestibulum ut est id mauris ultrices gravida. Nulla malesuada metus ut erat malesuada, vitae ornare neque semper. Aenean a commodo justo, vel placerat odio. Curabitur vitae consequat tortor. Aenean eu magna ante.",
//                     @"Now it’s Oscar the Grouch and some of his lady friends singing “Grouch Girls Don’t Wanna Have Fun.” This station is beyond great.",
//                     @"Something tells me this won’t be the last Ballmer public self humiliation we’ll be seeing.",
//                     @"Time-shifted TV watching has turned us into feral knowledge-repulsed animals who would shiv our own grandmothers.",
//                     @"Like savvy companies, @marcoarment wants to own every part of the supply chain to ensure the best @atpfm experience. Next up: a phone and OS",
//                     @"USAir’s flight attendants are using the loudspeaker to advertise a “special offer” to sign up for their credit card.",
//                     @"anytime you want to get @mattsinger to smile from here on out, just go up to him & say 'Hello, Mr. Ninja' in a British accent",
//                     @"Uptime Calendar for iPhone - http://loopu.in/18PZnj2",
//                     @"Velocity for iPhone - http://bpxl.me/14AmGKk",
//                     @"Just ordered my shiny new 15-inch MacBook Pro with Retina Display. So excited! Can't wait for daddy to come back from the US!",
                     nil];
        nameArray = [NSArray arrayWithObjects:
                     @"Random User",
                     @"Billy Bob",
//                     @"Jesse James Herlitz",
//                     @"Mike Monteiro",
//                     @"David Deller",
//                     @"Marco Arment",
//                     @"ErikDavis",
//                     @"The Loop",
//                     @"Beautiful Pixels",
//                     @"Lele Buonerba",
                     nil];
        userNameArray = [NSArray arrayWithObjects:
                         @"@username",
                         @"@horton",
//                         @"@strike",
//                         @"@Mike_FTW",
//                         @"@dmdeller",
//                         @"@marcoarment",
//                         @"@ErikDavis",
//                         @"@theloop",
//                         @"@beautifulpixels",
//                         @"@lele",
                         nil];
        
        
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
    
    // Populate labels
    [cell.fullNameLabel setText:[nameArray objectAtIndex:indexPath.row]];
    [cell.userNameLabel setText:[userNameArray objectAtIndex:indexPath.row]];
    [cell.profileImg setImage:[UIImage imageNamed:@"profileImg-default.png"]];
    
    // Populate the Text Field
    [cell.bodyTextView setText:[dataArray objectAtIndex:indexPath.row]];
    
    // Set the frame of bodyTextView
    CGRect bodyFrame = cell.bodyTextView.frame;
    bodyFrame.size.width = tableView.bounds.size.width - (kBodyHorizontalInsetLeft + kInsetRight);
    bodyFrame.size.height = cell.bodyTextView.contentSize.height;
    cell.bodyTextView.frame = bodyFrame;
    
    // Make sure the constraints have been added to this cell, since it may have just been created from scratch
    [cell setNeedsUpdateConstraints];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TVTCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    [cell updateFonts];
    
    // Populate labels
    [cell.fullNameLabel setText:[nameArray objectAtIndex:indexPath.row]];
    [cell.userNameLabel setText:[userNameArray objectAtIndex:indexPath.row]];
    [cell.profileImg setImage:[UIImage imageNamed:@"profileImg-default.png"]];
    
    // Populate the Text Field
    [cell.bodyTextView setText:[dataArray objectAtIndex:indexPath.row]];
    
    // Set the frame of bodyTextView
    CGRect bodyFrame = cell.bodyTextView.frame;
    bodyFrame.size.width = tableView.bounds.size.width - (kBodyHorizontalInsetLeft + kInsetRight);
    bodyFrame.size.height = cell.bodyTextView.contentSize.height;
    cell.bodyTextView.frame = bodyFrame;
    
    NSLog(@"Body Text Content Height: %f", bodyFrame.size.height);
    
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    [cell.contentView setNeedsLayout];
    [cell.contentView layoutIfNeeded];
    
    CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;

    NSLog(@"bodyTextView.frame: %f,%f", cell.bodyTextView.frame.size.width, cell.bodyTextView.frame.size.height);
    NSLog(@"contentView.frame: %f,%f", cell.contentView.frame.size.width, cell.contentView.frame.size.height);
    
    return height;
//    return 200.0f;
}


- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200.0f;
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
