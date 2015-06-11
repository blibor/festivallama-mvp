//
//  FestivalTableViewCell.h
//  Festivalama
//
//  Created by Sztanyi Szabolcs on 01/06/15.
//  Copyright (c) 2015 Sztanyi Szabolcs. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface FestivalTableViewCell : BaseTableViewCell

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *nameLabelLeadingConstraint;

@property (nonatomic, weak) IBOutlet UILabel *locationLabel;
@property (nonatomic, weak) IBOutlet UILabel *timeLeftLabel;
@property (nonatomic, weak) IBOutlet UIButton *calendarButton;
@property (nonatomic, weak) IBOutlet UIImageView *calendarIcon;

@property (nonatomic, weak) IBOutlet UIView *popularityView;
@property (nonatomic, weak) IBOutlet UILabel *popularityLabel;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *popularityLabelWidthConstraint;

- (void)setPopularityValue:(NSNumber*)percentage;
- (void)hidePopularityView;

- (void)showSavedState:(BOOL)saved;

@end
