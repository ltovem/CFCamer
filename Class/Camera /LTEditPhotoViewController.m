//
// LTEditPhotoViewController.m
// CFCamer
//
//  Auther:    田高伟
//  email:     mailto:t@ltove.com
//  webSite:   https://www.ltove.com
//  GitHub:    https://github.com/LTOVEM/
//
// Created by LTOVE on 2020/7/25.
// Copyright © 2020 LTOVE. All rights reserved.
//
    
#define photoMargin 50

#import "LTEditPhotoViewController.h"
#import "QMUITips+LTShow.h"
#import "LTAddListViewController.h"

#import "LTProcessPhoto.h"
#import "UIImage+Luban_iOS_Extension_h.h"

@interface LTEditPhotoViewController ()

@property(nonatomic,strong)UIView *contentView;
@property (nonatomic,strong)UIView *toolBarView;
@property (nonatomic,strong)UIImageView *photoImageView;

@property (nonatomic,strong)UIButton *exportButtion;
@property (nonatomic,strong)UIButton *nextButtion;

@property (nonatomic,strong)UIColor *backColor;
@property (nonatomic,strong)UIImage *clpedImage;

@end

@implementation LTEditPhotoViewController


- (UIView *)toolBarView{
    if (!_toolBarView) {
        _toolBarView = [UIView new];
        
        QMUIButton *exportBtn = [QDUIHelper generateDarkFilledButton];
        QMUIButton *nextButtiom = [QDUIHelper generateDarkFilledButton];
        self.exportButtion = exportBtn;
        self.nextButtion = nextButtiom;
        [self.exportButtion setTitle:@"导出照片" forState:UIControlStateNormal];
        [nextButtiom setTitle:@"打印订单" forState:UIControlStateNormal];
//        exportBtn.backgroundColor = [UIColor greenColor];?
        
        //add action
        [exportBtn addTarget:self action:@selector(exportButtionClick:) forControlEvents:UIControlEventTouchUpInside];
        [nextButtiom addTarget:self action:@selector(nextButtionClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [_toolBarView addSubview:exportBtn];
        [_toolBarView addSubview:nextButtiom];
        
        [exportBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.toolBarView);
            make.centerX.equalTo(self.toolBarView.mas_centerX).multipliedBy(0.5);
            make.width.equalTo(self.toolBarView.mas_width).multipliedBy(0.4);
            make.height.equalTo(@54);
//            make.left.equalTo(self.toolBarView);
        }];
        [nextButtiom mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(self.toolBarView);
                    make.centerX.equalTo(self.toolBarView.mas_centerX).multipliedBy(1.5);
                    make.width.equalTo(self.toolBarView.mas_width).multipliedBy(0.4);
                    make.height.equalTo(@54);
        //            make.left.equalTo(self.toolBarView);
                }];
    }
    return _toolBarView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.photoImageView.image = [UIImage imageNamed:@"timg1"];
    self.backColor = [UIColor qmui_randomColor];
    self.title = @"编辑照片";
}


- (void)initSubviews{
    [super initSubviews];
    [self setUI];
    
}

- (void)setUI{
    self.contentView = [UIView new];
//    self.toolBarView = [UIView new];
    
    [self.view addSubview:_contentView];
    [self.view addSubview:self.toolBarView];
//    _contentView.backgroundColor = [UIColor purpleColor];
    _toolBarView.backgroundColor = UIColorForBackground;
    
    self.photoImageView = [UIImageView new];
    _photoImageView.layer.cornerRadius = 5;
    _photoImageView.layer.masksToBounds = YES;
    [_contentView addSubview:_photoImageView];
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.and.right.and.top.equalTo(self.view);
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
        make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);
        make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);
//        make.bottom.equalTo(self.toolBarView.mas_top);
    }];
    [_toolBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);
        make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);
//        make.edges.equalTo(self.view.mas_safeAreaLayoutGuide);
        make.height.equalTo(@80);
        make.top.equalTo(self.contentView.mas_bottom);
    }];
    
    [_photoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(photoMargin);
        make.right.equalTo(self.contentView).offset(-photoMargin);
        make.center.equalTo(self.contentView);
        make.height.equalTo(self.photoImageView.mas_width).multipliedBy(1.4);
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma --process

-(void)procressPhotoWithClpedPhoto:(NSData *)clpedPhoto{
    NSString *name = [NSString stringWithFormat:@"%ld.jpg",random()];
    [LTProcessPhoto getClearImageWithData:clpedPhoto fileName:name failure:^(NSError * _Nullable error) {
        [QMUITips showCustomVieWithTitle:@"哪里出错啦" info:@"换个姿势重新试一下" preview:self.view];
    } success:^(UIImage * _Nullable image, NSError * _Nullable error) {
        if (image == nil) {
            [QMUITips showCustomVieWithTitle:@"哪里出错啦" info:@"换个姿势重新试一下" preview:self.view];
        }else{
            self.clpedImage = image;
            [self renderImageWithColor:self.backColor];
        }
    }];
}

- (void)renderImageWithColor:(UIColor *)color{
    UIImage *image = [UIImage coverImageWithImage:self.clpedImage color:color];
    self.photoImageView.image = image;
}

#pragma -- actions
//导出照片
- (void)exportButtionClick:(UIButton *)btn{
    NSLog(@"export");
    
    [self renderImageWithColor:[UIColor qmui_randomColor]];
//    return;
    
    switch ([QMUIAssetsManager authorizationStatus]) {
        case QMUIAssetAuthorizationStatusNotDetermined:
            //未获授权
        {
            QMUILog(@"album",@"未获授权");
            
            [QMUIAssetsManager requestAuthorization:^(QMUIAssetAuthorizationStatus status) {
                switch (status) {
                    case QMUIAssetAuthorizationStatusAuthorized:
                        //已经授权
                    {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [self.photoImageView.image saveToAlbumWithCompletionBlock:^(NSURL * _Nullable assetURL, NSError * _Nullable error) {
                                [QMUITips showSucceed:@"照片已保存到相册"];
                            }];
                        });
                        
                    }
                        break;
                    case QMUIAssetAuthorizationStatusNotAuthorized:
                        //禁止授权
                    {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [QMUITips showCustomVieWithTitle:@"为获取相机访问权限" info:@"请在iPhone的”设置-隐私-照片“选项中，运行访问你的手机相册哦" preview:self.view];
                        });
                    }
                    break;
                        
                    default:
                        break;
                }
            }];
        }
            break;
        case QMUIAssetAuthorizationStatusAuthorized:
            //已经授权
            QMUILog(@"album",@"已经授权");
            [self.photoImageView.image saveToAlbumWithCompletionBlock:^(NSURL * _Nullable assetURL, NSError * _Nullable error) {
                [QMUITips showSucceed:@"照片已保存到相册"];
            }];
        break;
        case QMUIAssetAuthorizationStatusNotAuthorized:
            //手动禁止授权
            [QMUITips showCustomVieWithTitle:@"导出失败" info:@"请在iPhone的”设置-隐私-照片“选项中，运行访问你的手机相册哦" preview:self.view];
        break;
            
        default:
            break;
    }
    
}
//打印订单
- (void)nextButtionClick:(UIButton *)btn{
    NSLog(@"next btn click");
    LTAddListViewController *addvc = [LTAddListViewController new];
    
//    [self.navigationController pushViewController:addvc animated:YES];
    [self procressPhotoWithClpedPhoto:UIImageJPEGRepresentation(self.photoImageView.image, 0.7)];
    
}

- (void)dealloc{
//    NSLog(@"delloc");
    QMUILog(@"delloc",@"delloc");
}
@end
