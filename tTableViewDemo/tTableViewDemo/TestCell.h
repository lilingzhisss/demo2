//
//  TestCell.h
//  learnMasonry
//
//  Created by huangyibiao on 15/11/28.
//  Copyright © 2015年 huangyibiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, assign) BOOL isExpanded;
@property (nonatomic,assign) CGFloat height;
@property (nonatomic,assign) BOOL isNeedUpdate;

@end

typedef void (^TestBlock)(NSIndexPath *indexPath);

@interface TestCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) TestModel *model;
@property (nonatomic, copy) TestBlock block;


- (CGFloat)getCellHeight;
@end
