//
//  FilterPlacesViewController.m
//  Festivalama
//
//  Created by Sztanyi Szabolcs on 31/05/15.
//  Copyright (c) 2015 Sztanyi Szabolcs. All rights reserved.
//

#import "FilterPlacesViewController.h"
#import "FilterTableViewCell.h"
#import "TrackingManager.h"

@implementation FilterPlacesViewController

- (void)trashButtonPressed:(id)sender
{
    [[TrackingManager sharedManager] trackFilterTapsTrashIconDetail];
    [FilterModel sharedModel].selectedPostCode = nil;
    [FilterModel sharedModel].selectedCountry = nil;
    [super setFilteringEnabled:NO];
}

#pragma mark - tableView methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FilterTableViewCell *cell = (FilterTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"cell"];

    UIImageView *accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"disclosureIcon"]];
    cell.accessoryView = accessoryView;

    if (indexPath.row == 0) {
        cell.textLabel.text = @"Innerhalb Deutschlands";
        return cell;
    } else {
        cell.textLabel.text = @"Ganz Europa";
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        [self performSegueWithIdentifier:@"openPostcode" sender:nil];
        [[TrackingManager sharedManager] trackFilterSelectsPostcodeView];
    } else {
        [self performSegueWithIdentifier:@"openCountry" sender:nil];
        [[TrackingManager sharedManager] trackFilterSelectsCountryView];
    }
}

#pragma mark - view methods
- (void)viewDidLoad
{
    [super addGradientBackground];
    [self setupTableView];
    self.title = @"Ort";

    if (FilterModel.sharedModel.selectedCountry || FilterModel.sharedModel.selectedPostCode) {
        [self setTrashIconVisible:YES];
    } else {
        [self setTrashIconVisible:NO];
    }
    [self.tableView hideLoadingIndicator];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self adjustButtonToFilterModel];
}

@end
