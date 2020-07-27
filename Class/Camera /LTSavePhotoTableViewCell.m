//
// LTSavePhotoTableViewCell.m
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


#import "LTSavePhotoTableViewCell.h"
#import "LTSavePhotoCellModel.h"

@interface LTSavePhotoTableViewCell ()

@property (nonatomic,strong)UIImageView *photoview;
@property (nonatomic,strong)UILabel *title;
@property (nonatomic,strong)UILabel *subTitle;
@property (nonatomic,strong)UIView *content;

@property (nonatomic,strong)QMUIButton *selbtn;

@property (nonatomic,strong)NSNumber *photoHeight;
@property (nonatomic,assign)CGFloat bili;

@end

@implementation LTSavePhotoTableViewCell


- (NSNumber *)photoHeight{
    return @120;
}
- (CGFloat)bili{
    return 1.4;
}
- (void)setModel:(LTSavePhotoCellModel *)Model{
    _Model = Model;
    self.photoview.image = Model.photo;
    self.title.text = Model.title;
    self.subTitle.text = Model.subtitle;
    _selbtn.selected = Model.isSelect;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        NSLog(@"23456789");
        [self setUI];
    }
    return self;
    
}

- (void)setUI{
    self.content = [UIView new];
    self.photoview = [UIImageView new];
    self.title = [UILabel new];
    self.subTitle = [UILabel new];
    self.selbtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
    
    [_selbtn setBackgroundImage:[UIImage imageNamed:@"xuanze"] forState:UIControlStateNormal];
    [_selbtn setBackgroundImage:[UIImage imageNamed:@"xuanzhe_sel"] forState:UIControlStateSelected];
    
//    _selbtn.selected = YES;
    _selbtn.userInteractionEnabled = NO;
    
    UILabel *desc = [UILabel new];
    
    self.title.text = @"蓝底高清";
    self.subTitle.text = @"价格 : 3元";
    desc.text = @"规格 : 1179x1205px";
    
    self.title.textColor = UIColor.qd_titleTextColor;
    self.subTitle.textColor = UIColor.qd_descriptionTextColor;
    desc.textColor = UIColor.qd_descriptionTextColor;
    
    
    [_content addSubview:_photoview];
    [_content addSubview:_title];
    [_content addSubview:_subTitle];
    [_content addSubview:_selbtn];
    
    [_content addSubview:desc];
    _content.backgroundColor = [UIColor whiteColor];
    _content.layer.cornerRadius = 10;
    _photoview.layer.cornerRadius = 5;
    _photoview.layer.masksToBounds = YES;
    [self.contentView addSubview:_content];
    
    self.contentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [_content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(5, 10, 5, 10));
    }];
    [self.photoview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.equalTo(self.content).offset(10);
        make.bottom.equalTo(self.content).offset(-10);
        make.height.equalTo(self.photoHeight);
        make.height.mas_equalTo(self.photoview.mas_width).multipliedBy(self.bili);
        
    }];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@[self.photoview.mas_right]).offset(10);
        make.left.equalTo(@[self.subTitle,desc]);
        make.top.equalTo(self.content).offset(20);
        make.right.equalTo(@[self.content,self.subTitle,desc]).offset(-20);
    }];
    [self.subTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.content);
        
    }];
    [desc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTitle.mas_bottom).offset(10);
    }];
    [_selbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.content);
        make.width.and.height.equalTo(@40);
        make.right.equalTo(self.content).offset(-20);
    }];
    
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

@implementation LTSavePhotoTypingTableViewCell

- (NSNumber *)photoHeight{
    return @90;
}
- (CGFloat)bili{
    return 0.7;
}

@end
