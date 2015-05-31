//
//  FilterPostcodeViewController.m
//  Festivalama
//
//  Created by Sztanyi Szabolcs on 01/06/15.
//  Copyright (c) 2015 Sztanyi Szabolcs. All rights reserved.
//

#import "FilterPostcodeViewController.h"
#import "FilterTableViewCell.h"

@interface FilterPostcodeViewController ()
@property (nonatomic, strong) NSArray *allPostcodesArray;
@property (nonatomic, strong) NSMutableArray *selectedPostCodesArray;
@end

@implementation FilterPostcodeViewController

- (void)trashButtonPressed:(id)sender
{
    [self.selectedPostCodesArray removeAllObjects];
    [self.tableView reloadData];
}

- (NSMutableArray *)selectedPostCodesArray
{
    [self setTrashIconVisible:_selectedPostCodesArray.count > 0];
    return _selectedPostCodesArray;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.allPostcodesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FilterTableViewCell *cell = (FilterTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = self.allPostcodesArray[indexPath.row];

    if ([self.selectedPostCodesArray containsObject:self.allPostcodesArray[indexPath.row]]) {
        cell.selected = YES;
        UIImageView *accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"checkMarkIcon"]];
        cell.accessoryView = accessoryView;
        cell.textLabel.textColor = [UIColor whiteColor];
    } else {
        cell.selected = NO;
        cell.accessoryView = nil;
        cell.textLabel.textColor = [UIColor colorWithWhite:1.0 alpha:0.5];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (!self.selectedPostCodesArray) {
        self.selectedPostCodesArray = [NSMutableArray array];
    }
    NSString *selectedPostcode = self.allPostcodesArray[indexPath.row];
    if ([self.selectedPostCodesArray containsObject:selectedPostcode]) {
        [self.selectedPostCodesArray removeObject:selectedPostcode];
        self.filterModel.selectedPostCode = nil;
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else {
        if (self.selectedPostCodesArray.count == 0) {
            [self.selectedPostCodesArray addObject:selectedPostcode];
            self.filterModel.selectedPostCode = selectedPostcode;
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
    }
}

#pragma mark - view methods
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Postleitzahl";

    self.allPostcodesArray = @[@"1...", @"2...", @"3...", @"4...", @"5...", @"6...", @"7...", @"8...", @"9..."];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
