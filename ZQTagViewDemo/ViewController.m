//
//  ViewController.m
//  ZQTagViewDemo
//
//  Created by zhiqing on 2019/2/27.
//  Copyright © 2019 zhiqing. All rights reserved.
//

#import "ViewController.h"
#import "ZQBaseTagView.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) ZQBaseTagView *tagView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.tableview];
    [self.view addSubview:self.tagView];
}


- (void)showTagViewWith:(NSInteger )index{
    if (index == 0) {
        _tagView.itemColunm = 2;
        _tagView.isAverage = YES;
        _tagView.tagArray = [self getNoImageData];
    }else if (index == 1){
        _tagView.isMultiSelect = YES;
        _tagView.itemColunm = 3;
        _tagView.isAverage = YES;
        _tagView.tagArray = [self getNoImageData];
    }else if (index == 2){
        _tagView.itemColunm = 3;
        _tagView.isAverage = YES;
        _tagView.borderColor = [UIColor redColor];
        _tagView.tagArray = [self getNoImageData];
   
    }else if (index == 3){
        _tagView.itemColunm = 3;
        _tagView.isAverage = YES;
        _tagView.borderColor = [UIColor redColor];
        _tagView.buttonType = ZQCustomButtonImageLeft;
        _tagView.titleImageSpae = 10;
        _tagView.tagArray = [self getImageData];
    }else if (index == 4){
        _tagView.isAverage = NO;
        _tagView.itemMinWidth = 0;
        _tagView.borderColor = [UIColor redColor];
        _tagView.tagArray = [self getIrregularityData];
        
    }else if (index == 5){
        _tagView.isAverage = NO;
        _tagView.itemMinWidth = _tagView.frame.size.width / 4;
        _tagView.borderColor = [UIColor redColor];
        _tagView.tagArray = [self getIrregularityData];
        
    }
}
- (NSArray *)getImageData{
    NSMutableArray * array = [[NSMutableArray alloc]init];
    ZQBaseTagViewModel * model = [[ZQBaseTagViewModel alloc]init];
    model.title = @"测试1";
    model.titleImage = [UIImage imageNamed:@"duigou"];
    model.selectedTitleImage = [UIImage imageNamed:@"tabbar_home_un"];
    
    ZQBaseTagViewModel * model2 = [[ZQBaseTagViewModel alloc]init];
    model2.title = @"测试2";
    model2.titleImage = [UIImage imageNamed:@"duigou"];
    model2.selectedTitleImage = [UIImage imageNamed:@"tabbar_home_un"];

    ZQBaseTagViewModel * model3 = [[ZQBaseTagViewModel alloc]init];
    model3.title = @"测试3";
    model3.titleImage = [UIImage imageNamed:@"duigou"];
    model3.selectedTitleImage = [UIImage imageNamed:@"tabbar_home_un"];


    ZQBaseTagViewModel * model4 = [[ZQBaseTagViewModel alloc]init];
    model4.title = @"测试4";
    model4.titleImage = [UIImage imageNamed:@"duigou"];
    model4.selectedTitleImage = [UIImage imageNamed:@"tabbar_home_un"];


    ZQBaseTagViewModel * model5 = [[ZQBaseTagViewModel alloc]init];
    model5.title = @"测试5";
    model5.titleImage = [UIImage imageNamed:@"duigou"];
    model5.selectedTitleImage = [UIImage imageNamed:@"tabbar_home_un"];


    ZQBaseTagViewModel * model6 = [[ZQBaseTagViewModel alloc]init];
    model6.title = @"测试6";
    model6.titleImage = [UIImage imageNamed:@"duigou"];
    model6.selectedTitleImage = [UIImage imageNamed:@"tabbar_home_un"];


    
    [array addObject:model];
    [array addObject:model2];
    [array addObject:model3];
    [array addObject:model4];
    [array addObject:model5];
    [array addObject:model6];
    return array;
}

- (NSArray *)getNoImageData{
    NSMutableArray * array = [[NSMutableArray alloc]init];
    ZQBaseTagViewModel * model = [[ZQBaseTagViewModel alloc]init];
    model.title = @"测试1";
    ZQBaseTagViewModel * model2 = [[ZQBaseTagViewModel alloc]init];
    model2.title = @"测试2";
    ZQBaseTagViewModel * model3 = [[ZQBaseTagViewModel alloc]init];
    model3.title = @"测试3";
    ZQBaseTagViewModel * model4 = [[ZQBaseTagViewModel alloc]init];
    model4.title = @"测试4";
    ZQBaseTagViewModel * model5 = [[ZQBaseTagViewModel alloc]init];
    model5.title = @"测试5";
    ZQBaseTagViewModel * model6 = [[ZQBaseTagViewModel alloc]init];
    model6.title = @"测试6";
    
    [array addObject:model];
    [array addObject:model2];
    [array addObject:model3];
    [array addObject:model4];
    [array addObject:model5];
    [array addObject:model6];
    return array;
}

- (NSArray *)getIrregularityData{
    NSMutableArray * array = [[NSMutableArray alloc]init];
    ZQBaseTagViewModel * model = [[ZQBaseTagViewModel alloc]init];
    model.title = @"测试不规则折行显示1";
    ZQBaseTagViewModel * model2 = [[ZQBaseTagViewModel alloc]init];
    model2.title = @"测试不规则折行显示1测试2";
    ZQBaseTagViewModel * model3 = [[ZQBaseTagViewModel alloc]init];
    model3.title = @"测试不规则折行显示1测试不规则折行显示1测试3";
    ZQBaseTagViewModel * model4 = [[ZQBaseTagViewModel alloc]init];
    model4.title = @"不规则折行显";
    ZQBaseTagViewModel * model5 = [[ZQBaseTagViewModel alloc]init];
    model5.title = @"测试5";
    ZQBaseTagViewModel * model6 = [[ZQBaseTagViewModel alloc]init];
    model6.title = @"不规则折行显";
    
    [array addObject:model];
    [array addObject:model2];
    [array addObject:model3];
    [array addObject:model4];
    [array addObject:model5];
    [array addObject:model6];
    return array;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * reuseId = @"UITableViewCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:reuseId];
    }
    
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self showTagViewWith:indexPath.row];
}

- (UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, self.dataSource.count * 40) style:(UITableViewStylePlain)];
        _tableview.delegate = self;
        _tableview.dataSource = self;
    }
    return _tableview;
}

- (NSArray *)dataSource{
    if (!_dataSource) {
        _dataSource = @[@"单选两列均分",@"多选三列均分",@"边框圆角",@"带图片",@"不规则显示",@"不规则显示单个item可设置最小宽度等"];
    }
    return _dataSource;
}

- (ZQBaseTagView *)tagView{
    if (!_tagView) {
        _tagView = [[ZQBaseTagView alloc]initWithFrame:CGRectMake(20, self.view.frame.size.height - self.dataSource.count * 40 , self.view.frame.size.width - 40, self.view.frame.size.height - self.dataSource.count * 40 )];
        _tagView.itemSpace = 12;
        _tagView.rowSpace = 12;
        _tagView.itemHeight = 40;
        _tagView.contentInset = 8;
        _tagView.bgColor = [UIColor lightGrayColor];
        _tagView.textColor = [UIColor blueColor];
        _tagView.selectedTextColor = [UIColor greenColor];
        _tagView.textFont = [UIFont systemFontOfSize:12];
        _tagView.cornerRadius = 4;
        _tagView.buttonType = ZQCustomButtonNoHaveImageLabel;
        _tagView.selectedBgColor = [UIColor yellowColor];
        _tagView.selectedBorderColor = [UIColor blueColor];
    }
    return _tagView;
}
@end
