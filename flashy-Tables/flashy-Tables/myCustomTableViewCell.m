//
//  myCustomTableViewCell.m
//  flashy-Tables
//
//  Created by Zain Nadeem on 6/29/16.
//  Copyright © 2016 Zain Nadeem. All rights reserved.
//

#import "myCustomTableViewCell.h"
#import <SWTableViewCell.h>

@interface MyCustomTableViewCell : SWTableViewCell

@property (weak, nonatomic) UILabel *customLabel;
@property (weak, nonatomic) UIImageView *customImageView;

@end

@implementation myCustomTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
