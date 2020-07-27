//
// LTSavePhotoViewController.m
// CFCamer
//
//  Auther:    田高伟
//  email:     mailto:t@ltove.com
//  webSite:   https://www.ltove.com
//  GitHub:    https://github.com/LTOVEM/
//
// Created by LTOVE on 2020/7/26.
// Copyright © 2020 LTOVE. All rights reserved.
//


#import "LTSavePhotoViewController.h"
#import "LTSavePhotoTableViewCell.h"
#import "LTSavePhotoCellModel.h"
#import "UIImage+Luban_iOS_Extension_h.h"
#import "LTIMConfigDefine.h"


@interface LTSavePhotoViewController ()

@property (nonatomic,strong)NSArray *dataSource;

@property (nonatomic,strong)UIView *tooBarView;

@property (nonatomic,strong)UILabel *priceLabel;

@property (nonatomic,copy)NSString *reuseIdentify;

@end

@implementation LTSavePhotoViewController

- (void)initDatasource{
    
    
    if (self.photoType == ExportPageTypePhoto) {
        LTSavePhotoCellModel *read = [LTSavePhotoCellModel initWithPhoto:[UIImage coverImageWithImage:self.photo  color:[UIColor redColor]] price:3.00 photoType:PhotoColorTypeRead];
        read.isSelect = YES;
        LTSavePhotoCellModel *white = [LTSavePhotoCellModel initWithPhoto:[UIImage coverImageWithImage:self.photo  color:[UIColor whiteColor]] price:3.00 photoType:PhotoColorTypeWhite];
        LTSavePhotoCellModel *blue = [LTSavePhotoCellModel initWithPhoto:[UIImage coverImageWithImage:self.photo color:bluecolor] price:3.00 photoType:PhotoColorTypeBlue];
        self.dataSource = @[read,blue,white,];
        [self.tableView reloadData];
        [self updatePrice];
    }else if (self.photoType == ExportPageTypeTypingPhoto){
        
        
        dispatch_queue_t queue = dispatch_queue_create("com.ltove.typiing", DISPATCH_QUEUE_SERIAL);
        
        dispatch_group_t group = dispatch_group_create();
        NSMutableArray *array = [NSMutableArray array];
        dispatch_group_async(group, queue, ^{
            UIImage *image = [LTTypingPhoto typeingWithPhoto:[UIImage coverImageWithImage:self.photo  color:[UIColor redColor]] photoType:self.photoSizeType];
            LTSavePhotoCellModel *read = [LTSavePhotoCellModel initWithPhoto:image price:3.00 photoType:PhotoColorTypeRead];
            read.isSelect = YES;
            [array addObject:read];
        });
        dispatch_group_async(group, queue, ^{
            LTSavePhotoCellModel *white = [LTSavePhotoCellModel initWithPhoto:[LTTypingPhoto typeingWithPhoto:[UIImage coverImageWithImage:self.photo  color:[UIColor whiteColor]] photoType:self.photoSizeType] price:3.00 photoType:PhotoColorTypeWhite];
            [array addObject:white];
            //                dispatch_semaphore_signal(single);
            NSLog(@"======122222");
            
        });
        dispatch_group_async(group, queue, ^{
            LTSavePhotoCellModel *blue = [LTSavePhotoCellModel initWithPhoto:[LTTypingPhoto typeingWithPhoto:[UIImage coverImageWithImage:self.photo color:bluecolor] photoType:self.photoSizeType] price:3.00 photoType:PhotoColorTypeBlue];
            [array addObject:blue];
            NSLog(@"======333333");
            //                dispatch_semaphore_signal(single);
            
        });
        
        dispatch_group_notify(group, dispatch_get_main_queue(), ^{
            NSLog(@"======999999");
            self.dataSource = [array copy];
            [self.tableView reloadData];
            [self updatePrice];
        });
        
    }
    
    
    
}

- (void)initSubviews{
    [super initSubviews];
    self.tooBarView = [UIView new];
    self.priceLabel = [UILabel new];
    UILabel *desc = [UILabel new];
    
    
    
    _priceLabel.text = @"合计金额: ¥3.00";
    desc.text = @"成为VIP可免费导出哦";
    
    desc.font = [UIFont qmui_lightSystemFontOfSize:13];
    
    
    _tooBarView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:_tooBarView];
    [self.view addSubview:_priceLabel];
    [self.view addSubview:desc];
    QMUIButton *payButtion = [QDUIHelper generateDarkFilledButton];
    [payButtion addTarget:self action:@selector(payaction:) forControlEvents:UIControlEventTouchUpInside];
    [payButtion setTitle:@"立即下单" forState:UIControlStateNormal];
    payButtion.titleLabel.font = [UIFont systemFontOfSize:18 weight:UIFontWeightBold];
    [_tooBarView addSubview:payButtion];
    
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    UILabel *desction = [UILabel new];
    desction.text = @"电子照片支付后不可退款哦";
    desction.font = [UIFont qmui_lightSystemFontOfSize:13];
    desction.textColor = UIColor.qd_gridItemTintColor;
    
    [footView addSubview:desction];
    
    [desction sizeToFit];
    desction.center = footView.center;
    self.tableView.tableFooterView = footView;
    
    [payButtion mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.right.and.bottom.equalTo(self.tooBarView);
        make.width.equalTo(@140);
    }];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.tooBarView).offset(10);
        make.bottom.equalTo(self.tooBarView.mas_centerY).offset(-5);
        make.right.equalTo(payButtion.mas_left).offset(-10);
    }];
    [desc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.priceLabel);
        make.top.equalTo(self.tooBarView.mas_centerY).offset(5);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.photoType == ExportPageTypePhoto ? @"高清照片" :@"排版照片";
    // Do any additional setup after loading the view.
    [self.tableView registerClass:[LTSavePhotoTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerClass:[LTSavePhotoTypingTableViewCell class] forCellReuseIdentifier:@"tycell"];
    
    self.reuseIdentify = self.photoType == ExportPageTypePhoto ? @"cell" : @"tycell";
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = UIColor.groupTableViewBackgroundColor;
    //    self.tableView.estimatedRowHeight = 100;
    [self initDatasource];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LTSavePhotoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.reuseIdentify];
    LTSavePhotoCellModel *model = self.dataSource[indexPath.row];
    cell.Model = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"dsadasda");
    LTSavePhotoCellModel *model = self.dataSource[indexPath.row];
    model.isSelect = !model.isSelect;
    [self updatePrice];
    [self.tableView reloadData];
}

- (void)updatePrice{
    __block CGFloat price = 0.0;
    [self.dataSource enumerateObjectsUsingBlock:^(LTSavePhotoCellModel*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.isSelect) {
            price += obj.price;
        }
    }];
    _priceLabel.text = [NSString stringWithFormat:@"合计金额: ¥%.2f",price];
}

- (void)layoutTableView{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view);
        make.top.equalTo(self.view);
        make.right.equalTo(self.view);
        
    }];
    [_tooBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        make.right.equalTo(self.view);
        make.top.equalTo(self.tableView.mas_bottom);
        make.height.equalTo(@70);
    }];
}

- (void)payaction:(UIButton *)btn{
    UIImage *image = [UIImage imageNamed:@"timg11"];
    
    //    LTSavePhotoCellModel *model = self.dataSource.firstObject;
    //    UIImage *iiiiiii = [UIImage coverImageWithImage:model.photo color:[UIColor yellowColor]];
    //    NSData *data = UIImageJPEGRepresentation(iiiiiii, 2);
    //    if ([data writeToFile:@"/Users/ltove/Desktop/123.jpg" atomically:YES]) {
    //        NSLog(@"写入成功");
    //    }else{
    //        NSLog(@"写入失败");
    //    }
    [self.tableView reloadData];
    
}
@end
