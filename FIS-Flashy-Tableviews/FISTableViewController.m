//
//  FISTableViewController.m
//  FIS-Flashy-Tableviews
//
//  Created by James Campagno on 9/11/15.
//  Copyright (c) 2015 James Campagno. All rights reserved.
//

#import "FISTableViewController.h"
#import "UIScrollView+APParallaxHeader.h"
#import "SWTableViewCell.h"

static NSString* const kVideoGameCellIdentifier = @"vgCell";

@interface FISTableViewController () <APParallaxViewDelegate, SWTableViewCellDelegate>

@property (nonatomic, strong) NSMutableArray *videoGames;

- (void)createVideoGamesArray;
- (void)createParalaxImageForTableView;

@end


@implementation FISTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createVideoGamesArray];
    [self createParalaxImageForTableView];
}

#pragma mark - Initializer Methods

- (void)createVideoGamesArray {
    self.videoGames = [@[@"Ocarina of Time",
                         @"Chrono Trigger",
                         @"Final Fantasy VII",
                         @"Super Mario 64",
                         @"Street Fighter II",
                         @"A Link to the Past",
                         @"Super Mario World",
                         @"Metal Gear Solid",
                         @"Super Metroid",
                         @"Resident Evil 4",
                         @"Super Mario Kart",
                         @"Castlevania",
                         @"Super Mario Bros.",
                         @"Super Mario Bros. 3",
                         @"Tetris",
                         @"Half-Life 2",
                         @"Final Fantasy VI",
                         @"Resident Evil",
                         @"Goldeneye 007",
                         @"SoulCalibur"] mutableCopy];
}

- (void)createParalaxImageForTableView {
    [self.tableView addParallaxWithImage:[UIImage imageNamed:@"coverimage"]
                               andHeight:160];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.videoGames count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SWTableViewCell *cell = (SWTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kVideoGameCellIdentifier];
    
    cell.leftUtilityButtons = [self leftButtons];
    cell.rightUtilityButtons = [self rightButtons];
    cell.delegate = self;
    
    cell.textLabel.text = self.videoGames[indexPath.row];
    
    return cell;
}

- (NSArray *)rightButtons {
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:0.78f green:0.78f blue:0.8f alpha:1.0]
                                                title:@"More"];
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0f]
                                                title:@"Delete"];
    
    return rightUtilityButtons;
}

- (NSArray *)leftButtons {
    NSMutableArray *leftUtilityButtons = [NSMutableArray new];
    
    [leftUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:0.07 green:0.75f blue:0.16f alpha:1.0]
                                                icon:[UIImage imageNamed:@"check"]];
    [leftUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:1.0f green:1.0f blue:0.35f alpha:1.0]
                                                icon:[UIImage imageNamed:@"clock"]];
    [leftUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:1.0f green:0.231f blue:0.188f alpha:1.0]
                                                icon:[UIImage imageNamed:@"cross"]];
    [leftUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:0.55f green:0.27f blue:0.07f alpha:1.0]
                                                icon:[UIImage imageNamed:@"list"]];
    
    return leftUtilityButtons;
}

#pragma mark - TableView Delegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!tableView.isEditing) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}



#pragma mark - SWTableViewDelegate

- (void)swipeableTableViewCell:(SWTableViewCell *)cell scrollingToState:(SWCellState)state {
    switch (state) {
        case 0:
            NSLog(@"utility buttons closed");
            break;
        case 1:
            NSLog(@"left utility buttons open");
            break;
        case 2:
            NSLog(@"right utility buttons open");
            break;
        default:
            break;
    }
}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerLeftUtilityButtonWithIndex:(NSInteger)index {
    switch (index) {
        case 0:
            NSLog(@"Check Mark was pressed");
            break;
        case 1:
            NSLog(@"Clock Mark was pressed");
            break;
        case 2:
            NSLog(@"X Mark was pressed");
            break;
        case 3:
            NSLog(@"Hamburger Mark was pressed");
        default:
            break;
    }
}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index {
    switch (index) {
        case 0: {
            NSLog(@"More button was pressed");
            break;
        }
        case 1: {
            NSLog(@"Delete button was pressed");
            NSIndexPath *cellIndexPath = [self.tableView indexPathForCell:cell];
            [self.videoGames removeObjectAtIndex:cellIndexPath.row];
            [self.tableView deleteRowsAtIndexPaths:@[cellIndexPath] withRowAnimation:UITableViewRowAnimationLeft];
            break;
        }
        default:
            break;
    }
}

- (BOOL)swipeableTableViewCellShouldHideUtilityButtonsOnSwipe:(SWTableViewCell *)cell {
    // allow just one cell's utility button to be open at once
    return YES;
}

- (BOOL)swipeableTableViewCell:(SWTableViewCell *)cell canSwipeToState:(SWCellState)state {
    switch (state) {
        case 1:
            // set to NO to disable all left utility buttons appearing
            return YES;
            break;
        case 2:
            // set to NO to disable all right utility buttons appearing
            return YES;
            break;
        default:
            break;
    }
    
    return YES;
}



@end
