//
//  MenuViewController.m
//  Festivalama
//
//  Created by Sztanyi Szabolcs on 31/05/15.
//  Copyright (c) 2015 Sztanyi Szabolcs. All rights reserved.
//

#import "MenuViewController.h"
#import "MenuButton.h"
#import "FestivalsViewController.h"
#import "FestivalTransitionManager.h"
#import "FestivalNavigationController.h"
#import "PopularFestivalsViewController.h"
#import "MainContainerViewController.h"
#import "CalendarViewController.h"
#import "CoreDataHandler.h"
#import "TrackingManager.h"

@interface MenuViewController ()
@property (nonatomic, strong) UITapGestureRecognizer *tapRecognizer;
@property (nonatomic, weak) UIViewController *sourceViewController;
@property (nonatomic, strong) FestivalTransitionManager *transitionManager;
@end

@implementation MenuViewController

- (void)updateCalendarButton
{
    NSInteger savedFestivals = [[CoreDataHandler sharedHandler] numberOfSavedFestivals];
    [self.calendarButton setBadgeCounterValue:savedFestivals];
}

- (void)saveSourceViewController:(UIViewController*)sourceViewController
{
    self.sourceViewController = sourceViewController;
}

- (MainContainerViewController*)mainContainerViewController
{
    if ([self.sourceViewController.parentViewController isKindOfClass:[MainContainerViewController class]]) {
        return (MainContainerViewController*)self.sourceViewController.parentViewController;
    }
    return nil;
}

- (BOOL)isSourceViewControllerFestivalsView
{
    return [self.sourceViewController isMemberOfClass:[FestivalsViewController class]];
}

- (IBAction)festivalButtonPressed:(id)sender
{
    [[TrackingManager sharedManager] trackUserSelectedFestivals];

    if ([self isSourceViewControllerFestivalsView])
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        [self switchCurrentSourceWithMenuItem:MenuItemFestivals];
    }
}

- (IBAction)favoriteButtonPressed:(id)sender
{
    [[TrackingManager sharedManager] trackUserSelectedPopularFestivals];

    if ([self.sourceViewController isMemberOfClass:[PopularFestivalsViewController class]]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self switchCurrentSourceWithMenuItem:MenuItemFavoriteFestivals];
    }
}

- (IBAction)calendarButtonPressed:(id)sender
{
    [[TrackingManager sharedManager] trackUserSelectedCalender];

    if ([self.sourceViewController isMemberOfClass:[CalendarViewController class]]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self switchCurrentSourceWithMenuItem:MenuItemFestivalsCalendar];
    }
}

- (void)switchCurrentSourceWithMenuItem:(MenuItem)menuItem
{
    MainContainerViewController *mainContainerViewController = [self mainContainerViewController];
    if (!mainContainerViewController) {
        return;
    }

    [mainContainerViewController changeToMenuItem:menuItem];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"openInfoView"])
    {
        [[TrackingManager sharedManager] trackUserSelectedInfo];
        self.transitionManager = [[FestivalTransitionManager alloc] init];
        FestivalNavigationController *destinationViewController = segue.destinationViewController;
        destinationViewController.transitioningDelegate = self.transitionManager;
    }
}

#pragma mark - tapRecognizer
- (void)addRecognizer
{
    self.tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    self.tapRecognizer.numberOfTapsRequired = 1.0;
    [self.view addGestureRecognizer:self.tapRecognizer];
}

- (void)viewTapped:(UITapGestureRecognizer*)taprecognizer
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - view methods
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addRecognizer];

    if ([self isSourceViewControllerFestivalsView])
    {
        [UIView animateWithDuration:0.2 animations:^{
            [self.festivalButton setActive:YES];
            [self.favoriteFestivalButton setActive:NO];
            [self.calendarButton setActive:NO];
        }];
    }
    else if ([self.sourceViewController isKindOfClass:[PopularFestivalsViewController class]])
    {
        [UIView animateWithDuration:0.2 animations:^{
            [self.festivalButton setActive:NO];
            [self.favoriteFestivalButton setActive:YES];
            [self.calendarButton setActive:NO];
        }];
    }
    else
    {
        [UIView animateWithDuration:0.2 animations:^{
            [self.festivalButton setActive:NO];
            [self.favoriteFestivalButton setActive:NO];
            [self.calendarButton setActive:YES];
        }];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self updateCalendarButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
