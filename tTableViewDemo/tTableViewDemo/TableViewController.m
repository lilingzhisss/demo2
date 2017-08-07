//
//  TableViewController.m
//  learnMasonry
//
//  Created by huangyibiao on 15/11/28.
//  Copyright © 2015年 huangyibiao. All rights reserved.
//

#import "TableViewController.h"
#import "TestCell.h"
#import "Masonry.h"
@interface TableViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic,strong) NSMutableDictionary *cellDict;
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    for (NSUInteger i = 0; i < 20; ++i) {
        TestModel *model = [[TestModel alloc] init];
        model.title = @"测试标题，可能很长很长，反正随便写着先吧！";
        model.desc = @"描述内容通常都是很长很长的，描述内容通常都是很长很长的，描述内容通常都是很长很长的，描述内容通常都是很长很长的，描述内容通常都是很长很长的，描述内容通常都是很长很长的，描述内容通常都是很长很长的，描述内容通常都是很长很长的，描述内容通常都是很长很长的，描述内容通常都是很长很长的，描述内容通常都是很长很长的，";
        model.isNeedUpdate = YES;
        [self.dataSource addObject:model];
    }
    
    [self.tableView reloadData];
}
- (NSMutableDictionary *)cellDict {
    if (_cellDict == nil) {
        _cellDict = [[NSMutableDictionary alloc] init];
    }
    
    return _cellDict;
}
- (NSMutableArray *)dataSource {
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    
    return _dataSource;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        
    }
    NSLog(@"cellForRow--%zd",indexPath.row);
    static NSString *cellIdentifier = @"CellIdentifier";
    TestCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[TestCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.indexPath = indexPath;
    cell.block = ^(NSIndexPath *path) {
        [tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationFade];
    };
    cell.model = self.dataSource[indexPath.row];
    [self.cellDict setValue:cell forKey:[NSString stringWithFormat:@"%zd",indexPath.row]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    TestModel *model = [self.dataSource objectAtIndex:indexPath.row];
    NSLog(@"heightForRow--%zd",indexPath.row);
    TestCell *cell = (TestCell *)_cellDict[[NSString stringWithFormat:@"%zd",indexPath.row]];
    NSLog(@"--%@",cell);
//    如果是注册cell需要加上下边判断，因为会连续执行三次，同时前两次执行字典里存的cell是nil
//    if (model.height == 0) {
//        model.isNeedUpdate = YES;
//    }
    if (model.isNeedUpdate) {
        model.height = [cell getCellHeight];
        model.isNeedUpdate = NO;
    }
    NSLog(@"height--%f",model.height);
    return model.height;
}


@end
