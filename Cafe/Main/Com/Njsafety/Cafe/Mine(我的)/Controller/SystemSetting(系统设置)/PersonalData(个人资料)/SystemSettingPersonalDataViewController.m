//
//  SystemSettingPersonalDataViewController.m
//  Cafe
//
//  Created by leo on 2020/1/1.
//  Copyright © 2020 leo. All rights reserved.
//
//  个人资料

#import "SystemSettingPersonalDataViewController.h"
#import "MineDetailCommonModel.h"

#import "AvalonsoftImagePicker.h"               //图片选择器

#import "PersonalDataModel.h"
#import "PersonalDataTableViewCell.h"

#import "PersonalDataModifyUserNameVC.h"            //修改用户名
#import "PersonalDataStudyAbroadCountryVC.h"        //留学国家
#import "PersonalDataPrepareCourseVC.h"             //国内预科
#import "PersonalDataModifyAboutMeVC.h"             //修改个性签名
#import "PersonalDataModifyNameCnVC.h"              //修改中文名字
#import "PersonalDataModifyNameEnVC.h"              //修改英文名字
#import "PersonalDataModifyPhoneNumberVC.h"         //修改手机号
#import "PersonalDataModifyEmailVC.h"               //修改邮箱



@interface SystemSettingPersonalDataViewController ()<UITableViewDelegate,UITableViewDataSource>

{
@private UIButton *backButton;                  //左上角返回按钮
@private UIView *navigationView;
    
@private NSDictionary *studyAbroadCountryDataDic;   //留学国家数据字典
@private NSDictionary *prepareCourseDataDic;        //国内预科数据字典
    
@private MineDetailCommonModel *detailInfo; // 个人详细信息
    
@private AvalonsoftUserDefaultsModel *userDefaultsModel;
    
}

@property (nonatomic,strong) UITableView *menuTableView;
@property (nonatomic,strong) NSMutableDictionary *menuDic;

@end

@implementation SystemSettingPersonalDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavigationView];
    
    
    [self initVars];
    [self initSharedPreferences];
    //    [self setTableViewData];
    
}

-(void)viewDidAppear:(BOOL)animated {
    [self initSharedPreferences];
}

#pragma mark - 初始化一些参数 -
-(void)initVars
{
    self.view.backgroundColor = RGBA_GGCOLOR(249, 249, 249, 1);
}

#pragma mark - 初始化数据 -
-(void)initSharedPreferences
{
    @try {
        userDefaultsModel = [AvalonsoftUserDefaultsModel userDefaultsModel];
        
        [self getUserExtInfo];
        
    } @catch (NSException *exception) {
        @throw exception;
        
    }
}

#pragma mark - 设置表格数据 -
-(void)setTableViewData
{
    //设置列表数据
    _menuDic = [NSMutableDictionary dictionary];
    
    studyAbroadCountryDataDic = [NSDictionary dictionary];
    prepareCourseDataDic = [NSDictionary dictionary];
    
    //section 1 中数据
    NSMutableArray *sectionOneArr = [NSMutableArray array];
    
    NSDictionary *dicOne1 = @{
        @"cellType":@"image",
        @"sectionType":@"userinfo",
        @"cellTitle":@"头像",
        @"cellImage":[UIImage imageNamed:@"home_foreign_school_icon"]
    };
    PersonalDataModel *modelOne1 = [PersonalDataModel modelWithDict:dicOne1];
    [sectionOneArr addObject:modelOne1];
    
    NSString *url = [[NSString alloc] init];
    url = [FILE_SERVER_URL stringByAppendingFormat:@"/%@",[detailInfo headportrait]];
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    
    NSLog(@"headurl=%@",url);
    [manager loadImageWithURL:url options:SDWebImageContinueInBackground progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        
    } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
        modelOne1.cellImage = image;
        //        [self->_menuTableView reloadData];
    }];

    
    NSDictionary *dicOne2 = @{
        @"cellType":@"char",
        @"sectionType":@"userinfo",
        @"cellTitle":@"用户名",
        @"cellContent":[detailInfo username]
    };
    PersonalDataModel *modelOne2 = [PersonalDataModel modelWithDict:dicOne2];
    [sectionOneArr addObject:modelOne2];
    
    NSDictionary *dicOne3 = @{
        @"cellType":@"char",
        @"sectionType":@"userinfo",
        @"cellTitle":@"性别",
        @"cellContent":[detailInfo sex]
    };
    PersonalDataModel *modelOne3 = [PersonalDataModel modelWithDict:dicOne3];
    [sectionOneArr addObject:modelOne3];
    
    NSDictionary *dicOne4 = @{
        @"cellType":@"char",
        @"sectionType":@"userinfo",
        @"cellTitle":@"身份",
        @"cellContent":[detailInfo identify]
    };
    PersonalDataModel *modelOne4 = [PersonalDataModel modelWithDict:dicOne4];
    [sectionOneArr addObject:modelOne4];
    
    NSDictionary *dicOne5;
    if ([detailInfo aboutme] == NULL) {
        dicOne5 = @{
            @"cellType":@"char",
            @"sectionType":@"userinfo",
            @"cellTitle":@"个性签名",
            @"cellContent":@""
        };
    } else {
        dicOne5 = @{
            @"cellType":@"char",
            @"sectionType":@"userinfo",
            @"cellTitle":@"个性签名",
            @"cellContent":[detailInfo aboutme]
        };
    }
    
    PersonalDataModel *modelOne5 = [PersonalDataModel modelWithDict:dicOne5];
    [sectionOneArr addObject:modelOne5];
    
    [_menuDic setValue:[sectionOneArr copy] forKey:@"0"];
    
    
    //section 2 中数据
    NSMutableArray *sectionTwoArr = [NSMutableArray array];
    
    NSDictionary *dicTwo1 = @{
        @"cellType":@"char",
        @"sectionType":@"userinfo",
        @"cellTitle":@"中文名",
        @"cellContent":[detailInfo nameCn]
    };
    PersonalDataModel *modelTwo1 = [PersonalDataModel modelWithDict:dicTwo1];
    [sectionTwoArr addObject:modelTwo1];
    
    NSDictionary *dicTwo2 = @{
        @"cellType":@"char",
        @"sectionType":@"userinfo",
        @"cellTitle":@"英文名",
        @"cellContent":[detailInfo nameEn]
    };
    PersonalDataModel *modelTwo2 = [PersonalDataModel modelWithDict:dicTwo2];
    [sectionTwoArr addObject:modelTwo2];
    
    NSDictionary *dicTwo3 = @{
        @"cellType":@"char",
        @"sectionType":@"userinfo",
        @"cellTitle":@"出生日期",
        @"cellContent":[detailInfo birthdate]
    };
    PersonalDataModel *modelTwo3 = [PersonalDataModel modelWithDict:dicTwo3];
    [sectionTwoArr addObject:modelTwo3];
    
    NSDictionary *dicTwo4 = @{
        @"cellType":@"char",
        @"sectionType":@"userinfo",
        @"cellTitle":@"目前居住城市",
        @"cellContent":[detailInfo city]
    };
    PersonalDataModel *modelTwo4 = [PersonalDataModel modelWithDict:dicTwo4];
    [sectionTwoArr addObject:modelTwo4];
    
    [_menuDic setValue:[sectionTwoArr copy] forKey:@"1"];
    
    //section 3 中数据
    NSMutableArray *sectionThreeArr = [NSMutableArray array];
    
    NSDictionary *dicThree1 = @{
        @"cellType":@"char",
        @"sectionType":@"iwant",
        @"cellTitle":@"游学国家",
        @"cellContent":[detailInfo tourStudyCountry]
    };
    PersonalDataModel *modelThree1 = [PersonalDataModel modelWithDict:dicThree1];
    [sectionThreeArr addObject:modelThree1];
    
    NSDictionary *dicThree2 = @{
        @"cellType":@"char",
        @"sectionType":@"iwant",
        @"cellTitle":@"留学国家",
        @"cellContent":[detailInfo country]
    };
    PersonalDataModel *modelThree2 = [PersonalDataModel modelWithDict:dicThree2];
    [sectionThreeArr addObject:modelThree2];
    
    NSDictionary *dicThree3;
    if ([detailInfo internationalSchool] == NULL) {
        dicThree3 = @{
            @"cellType":@"char",
            @"sectionType":@"iwant",
            @"cellTitle":@"国际学校",
            @"cellContent":@""
        };
    } else {
        dicThree3 = @{
            @"cellType":@"char",
            @"sectionType":@"iwant",
            @"cellTitle":@"国际学校",
            @"cellContent":[detailInfo internationalSchool]
        };
    }
    
    PersonalDataModel *modelThree3 = [PersonalDataModel modelWithDict:dicThree3];
    [sectionThreeArr addObject:modelThree3];
    
    NSDictionary *dicThree4 = @{
        @"cellType":@"char",
        @"sectionType":@"iwant",
        @"cellTitle":@"合作办学",
        @"cellContent":[detailInfo cooperativeSchoolType]
    };
    PersonalDataModel *modelThree4 = [PersonalDataModel modelWithDict:dicThree4];
    [sectionThreeArr addObject:modelThree4];
    
    NSDictionary *dicThree5 = @{
        @"cellType":@"char",
        @"sectionType":@"iwant",
        @"cellTitle":@"国内预科",
        @"cellContent":[detailInfo domesticPreparatoryType]
    };
    PersonalDataModel *modelThree5 = [PersonalDataModel modelWithDict:dicThree5];
    [sectionThreeArr addObject:modelThree5];
    
    [_menuDic setValue:[sectionThreeArr copy] forKey:@"2"];
    
    //section 4 中数据
    NSMutableArray *sectionFourArr = [NSMutableArray array];
    
    NSDictionary *dicFour1 = @{
        @"cellType":@"char",
        @"sectionType":@"iwant",
        @"cellTitle":@"Tel",
        @"cellContent":[detailInfo phonenumber]
    };
    PersonalDataModel *modelFour1 = [PersonalDataModel modelWithDict:dicFour1];
    [sectionFourArr addObject:modelFour1];
    
    NSDictionary *dicFour2 = @{
        @"cellType":@"char",
        @"sectionType":@"iwant",
        @"cellTitle":@"Email",
        @"cellContent":[detailInfo email]
    };
    PersonalDataModel *modelFour2 = [PersonalDataModel modelWithDict:dicFour2];
    [sectionFourArr addObject:modelFour2];
    
    [_menuDic setValue:[sectionFourArr copy] forKey:@"3"];
}

#pragma mark - 初始化导航视图 -
-(void)initNavigationView
{
    //***** 顶部导航视图 *****//
    navigationView = [UIView new];
    [self.view addSubview:navigationView];
    [navigationView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.view).offset(StatusBarSafeTopMargin);
        make.left.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 64));
    }];
    [navigationView setBackgroundColor:[UIColor clearColor]];
    
    //左上角返回按钮
    backButton = [UIButton new];
    [navigationView addSubview:backButton];
    [backButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(navigationView).offset(10);
        make.bottom.equalTo(navigationView).offset(-11);
        make.size.mas_equalTo(CGSizeMake(22, 22));
    }];
    //设置点击不变色
    backButton.adjustsImageWhenHighlighted = NO;
    [backButton setBackgroundImage:[UIImage imageNamed:@"home_foreign_back"] forState:UIControlStateNormal];
    
    //标题
    UILabel *titleLabel = [UILabel new];
    [navigationView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(navigationView).offset((SCREEN_WIDTH-120)/2);
        make.bottom.equalTo(navigationView).offset(-10);
        make.size.mas_equalTo(CGSizeMake(120, 24));
    }];
    titleLabel.numberOfLines = 0;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.alpha = 1.0;
    NSMutableAttributedString *titleLabelString = [[NSMutableAttributedString alloc] initWithString:@"个人资料" attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Medium" size: 17],NSForegroundColorAttributeName: [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0]}];
    titleLabel.attributedText = titleLabelString;
}

#pragma mark - 初始化视图 -
-(void)initView
{
    //按钮列表
    _menuTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, StatusBarSafeTopMargin+64, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBarSafeTopMargin-64-TabbarSafeBottomMargin) style:UITableViewStyleGrouped];
    [self.view addSubview:_menuTableView];
    
    [_menuTableView setBackgroundColor:[UIColor whiteColor]];
    _menuTableView.bounces = YES;
    _menuTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_menuTableView registerClass:[PersonalDataTableViewCell class] forCellReuseIdentifier:@"PersonalDataTableViewCell"];
    _menuTableView.delegate = self;
    _menuTableView.dataSource = self;
    //这句话可以设置tableview没有数据时不显示横线
    _menuTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    _menuTableView.showsVerticalScrollIndicator = NO;
}

#pragma mark - 设置控件监听事件 -
-(void)setListener
{
    //左上角退出按钮
    [backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark - 返回按钮点击 -
-(void)backButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

//**********    tableView代理 begin   **********//
#pragma mark - 设置section数量 -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_menuDic allKeys].count;
}

#pragma mark - 设置行数 -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *menuArr = [_menuDic objectForKey:[NSString stringWithFormat:@"%ld",(long)section]];
    
    return menuArr.count;
}

#pragma mark - 初始化cell -
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //搜索历史
    PersonalDataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PersonalDataTableViewCell"];
    
    //更新cell
    NSArray *menuArr = [_menuDic objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.section]];
    
    [cell updateCellWithModel:menuArr[indexPath.row]];
    
    return cell;
    
}

#pragma mark - 设置cell行高 -
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 48;
}

#pragma mark - 设置header高度，需要同时实现 viewForHeaderInSection 方法，不然高度设置无效-
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
        
    }else if (section == 1){
        return 10;
        
    }else if (section == 2){
        return 38;
        
    }else if (section == 3){
        return 10;
    }
    
    return 0;
    
}

#pragma mark - 设置fotter高度，需要同时实现 viewForFooterInSection 方法，不然高度设置无效-
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

#pragma mark - 设置header样式 -
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 2) {
        UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 38)];
        [headerView setBackgroundColor:[UIColor clearColor]];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 50, 18)];
        label.numberOfLines = 0;
        label.textAlignment = NSTextAlignmentLeft;
        label.alpha = 1.0;
        
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"我想要"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 14],NSForegroundColorAttributeName: [UIColor colorWithRed:203/255.0 green:207/255.0 blue:217/255.0 alpha:1.0]}];
        label.attributedText = string;
        
        [headerView addSubview:label];
        
        return headerView;
    }
    
    return nil;
    
}

#pragma mark - 设置fotter样式 -
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

#pragma mark - 点击列表中的行 -
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    NSArray *menuArr = [_menuDic objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.section]];
    PersonalDataModel *model = menuArr[indexPath.row];
    
    if(section == 0){
        //section one
        if(row == 0){
            //头像
            [AvalonsoftImagePicker showImagePickerFromViewController:self allowsEditing:YES finishAction:^(UIImage *image) {
                if (image) {
                    model.cellImage = image;
                    [self->_menuTableView reloadData];
                }
            }];
            
        }else if(row == 1){
            //用户名
            
            [AvalonsoftToast showWithMessage:@"用户名不可更改"];
            //通过字典将值传到后台
            //            NSDictionary *sendDataDic = @{@"userName":model.cellContent};
            //
            //            PersonalDataModifyUserNameVC *modifyUserNameVC = [[PersonalDataModifyUserNameVC alloc] init];
            //            //设置block回调
            //            [modifyUserNameVC setSendValueBlock:^(NSDictionary *valueDict){
            //                //回调函数
            //                NSString *userName = valueDict[@"userName"];
            //                [self updateUserInfo:@"username" value:userName];
            //
            //                [model setCellContent:userName];
            //                [self->_menuTableView reloadData];
            //            }];
            //
            //            modifyUserNameVC.dataDic = sendDataDic;
            //            [self.navigationController pushViewController:modifyUserNameVC animated:YES];
            
        }else if(row == 2){
            //性别
            AvalonsoftActionSheet *actionSheet = [[AvalonsoftActionSheet alloc] initSheetWithTitle:@"" style:AvalonsoftSheetStyleDefault itemTitles:@[@"男",@"女"]];
            actionSheet.itemTextColor = RGBA_GGCOLOR(102, 102, 102, 1);
            
            [actionSheet didFinishSelectIndex:^(NSInteger index, NSString *title) {
                [self updateUserInfo:@"sex" value:title];
                
                model.cellContent = title;
                [self->_menuTableView reloadData];
            }];
            
        }else if(row == 3){
            //身份
            AvalonsoftActionSheet *actionSheet = [[AvalonsoftActionSheet alloc] initSheetWithTitle:@"" style:AvalonsoftSheetStyleDefault itemTitles:@[@"学生",@"校友",@"家长&亲友",@"其他"]];
            actionSheet.itemTextColor = RGBA_GGCOLOR(102, 102, 102, 1);
            
            [actionSheet didFinishSelectIndex:^(NSInteger index, NSString *title) {
                [self updateUserInfo:@"identify" value:title];
                
                model.cellContent = title;
                [self->_menuTableView reloadData];
            }];
            
        }else if(row == 4){
            //个性签名
            //            [AvalonsoftToast showWithMessage:@"个性签名"];
            NSDictionary *sendDataDic = @{@"aboutme":model.cellContent};
            
            PersonalDataModifyAboutMeVC *modifyAboutMeVC = [[PersonalDataModifyAboutMeVC alloc] init];
            //设置block回调
            [modifyAboutMeVC setSendValueBlock:^(NSDictionary *valueDict){
                //回调函数
                NSString *aboutme = valueDict[@"aboutme"];
                [self updateUserInfo:@"aboutme" value:aboutme];
                
                [model setCellContent:aboutme];
                [self->_menuTableView reloadData];
            }];
            
            modifyAboutMeVC.dataDic = sendDataDic;
            [self.navigationController pushViewController:modifyAboutMeVC animated:YES];
            
        }
        
    }else if(section == 1){
        //section two
        if(row == 0){
            //中文名
            //            [AvalonsoftToast showWithMessage:@"中文名"];
            NSDictionary *sendDataDic = @{@"nameCn":model.cellContent};
            
            PersonalDataModifyNameCnVC *modifyNameCnVC = [[PersonalDataModifyNameCnVC alloc] init];
            //设置block回调
            [modifyNameCnVC setSendValueBlock:^(NSDictionary *valueDict){
                //回调函数
                NSString *nameCn = valueDict[@"nameCn"];
                [self updateUserInfo:@"nameCn" value:nameCn];
                
                [model setCellContent:nameCn];
                [self->_menuTableView reloadData];
            }];
            
            modifyNameCnVC.dataDic = sendDataDic;
            [self.navigationController pushViewController:modifyNameCnVC animated:YES];
            
        }else if(row == 1){
            //英文名
            //            [AvalonsoftToast showWithMessage:@"英文名"];
            NSDictionary *sendDataDic = @{@"nameEn":model.cellContent};
            
            PersonalDataModifyNameEnVC *modifyNameEnVC = [[PersonalDataModifyNameEnVC alloc] init];
            //设置block回调
            [modifyNameEnVC setSendValueBlock:^(NSDictionary *valueDict){
                //回调函数
                NSString *nameEn = valueDict[@"nameEn"];
                [self updateUserInfo:@"nameEn" value:nameEn];
                
                [model setCellContent:nameEn];
                [self->_menuTableView reloadData];
            }];
            
            modifyNameEnVC.dataDic = sendDataDic;
            [self.navigationController pushViewController:modifyNameEnVC animated:YES];
            
        }else if(row == 2){
            //出生日期
            NSDate *now = [NSDate date];
            NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
            fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
            NSString *nowStr = [fmt stringFromDate:now];
            
            [AvalonsoftPickerView showDatePickerWithTitle:@"" DateType:UIDatePickerModeDate DefaultSelValue:@"" MinDateStr:@"1900-01-01 00:00:00" MaxDateStr:nowStr IsAutoSelect:NO Manager:nil ResultBlock:^(NSString *selectValue){
                
                [self updateUserInfo:@"birthdate" value:selectValue];
                model.cellContent = selectValue;
                [self->_menuTableView reloadData];
                
            }];
            
        }else if(row == 3){
            //目前居住城市
            [AvalonsoftPickerView showAddressPickerWithTitle:@"" DefaultSelected:@[@4, @0, @0] IsAutoSelect:NO Manager:nil ResultBlock:^(NSArray *selectAddressArr, NSArray *selectAddressRow){
                
                model.cellContent = [NSString stringWithFormat:@"%@ %@ %@", selectAddressArr[0], selectAddressArr[1],selectAddressArr[2]];
                
                NSMutableDictionary *root = [NSMutableDictionary dictionary];
                [root setValue:selectAddressArr[0] forKey:@"province"];
                [root setValue:[NSString stringWithFormat:@"%@ %@",selectAddressArr[1],selectAddressArr[2]] forKey:@"city"];
                [self updateUserInfo:@"city" value:model.cellContent];
                
                [self->_menuTableView reloadData];
            }];
            
        }
        
    }else if(section == 2){
        //section three
        if(row == 0){
            //游学国家
            [AvalonsoftPickerView showStringPickerWithTitle:@"" DataSource:@[@"加拿大 Canada", @"美国 United States", @"澳洲 Australia", @"新西兰 New Zealand", @"英国 United Kingdom"] DefaultSelValue:@"美国 United States" IsAutoSelect:NO ResultBlock:^(id selectValue, id selectRow){
                [self updateUserInfo:@"tourStudyCountry" value:selectValue];
                //回调
                model.cellContent = selectValue;
                [self->_menuTableView reloadData];
                
            }];
            
        }else if(row == 1){
            //留学国家
            PersonalDataStudyAbroadCountryVC *studyAbroadCountryVC = [[PersonalDataStudyAbroadCountryVC alloc] init];
            
            if (![[studyAbroadCountryDataDic allKeys] containsObject:@"country"]) {
                NSMutableDictionary *data = [NSMutableDictionary dictionary];
                [data setValue:detailInfo.country forKey:@"country"];
                [data setValue:detailInfo.category forKey:@"category"];
                [data setValue:detailInfo.admissiondate forKey:@"admissiondate"];
                [data setValue:detailInfo.classes forKey:@"classes"];
                [data setValue:[NSNumber numberWithBool:detailInfo.studyflag] forKey:@"studyflag"];
                
                studyAbroadCountryDataDic = data;
            }
            
            //设置block回调
            [studyAbroadCountryVC setSendValueBlock:^(NSDictionary *valueDict){
                //回调函数
                
                self->studyAbroadCountryDataDic = valueDict;
                
                NSString *country;
                NSString *category;
                NSString *time;
                NSString *class;
                Boolean reading;
                
                if(self->studyAbroadCountryDataDic[@"country"]){
                    country = self->studyAbroadCountryDataDic[@"country"];
                }else{
                    country = @"";
                }
                
                if(self->studyAbroadCountryDataDic[@"category"]){
                    category = self->studyAbroadCountryDataDic[@"category"];
                }else{
                    category = @"";
                }
                
                if(self->studyAbroadCountryDataDic[@"admissiondate"]){
                    time = self->studyAbroadCountryDataDic[@"admissiondate"];
                }else{
                    time = @"";
                }
                
                if(self->studyAbroadCountryDataDic[@"classes"]){
                    class = self->studyAbroadCountryDataDic[@"classes"];
                }else{
                    class = @"";
                }
                
                if(self->studyAbroadCountryDataDic[@"studyflag"]){
                    reading = [self->studyAbroadCountryDataDic[@"studyflag"] boolValue];
                }else{
                    reading = false;
                }
                
                //                NSMutableDictionary *root = [NSMutableDictionary dictionary];
                //                [root setValue:[_UserInfo accountId] forKey:@"accountId"];
                //                [root setValue:country forKey:@"country"];
                //                [root setValue:category forKey:@"category"];
                //                [root setValue:time forKey:@"admissiondate"];
                //                [root setValue:class forKey:@"classes"];
                //                [root setValue:[NSNumber numberWithBool:reading] forKey:@"studyflag"];
                
                //                [self updateUserInfo:root];
                
                //拼接留学国家字符串
                //                NSString *studyAbroadCountryDataStr = [NSString stringWithFormat:@"%@ %@ %@ %@",country,category,time,class];
                
                [model setCellContent:country];
                [self->_menuTableView reloadData];
            }];
            
            studyAbroadCountryVC.dataDic = studyAbroadCountryDataDic;
            [self.navigationController pushViewController:studyAbroadCountryVC animated:YES];
            
        }else if(row == 2){
            //国际学校
            NSArray *dataSources = @[@[@"国际小学", @"国际初中", @"国际高中"], @[@"IB体系", @"英国体系", @"美国体系", @"加拿大体系"]];
            //这里默认项目中，要包含数据源中数组数量的字符串数量
            NSArray *defaultSelValueArr = @[@"国际小学",@"IB体系"];
            
            [AvalonsoftPickerView showStringPickerWithTitle:@"" DataSource:dataSources DefaultSelValue:defaultSelValueArr IsAutoSelect:NO ResultBlock:^(id selectValue, id selectRow){
                //回调
                model.cellContent = [NSString stringWithFormat:@"%@ %@",selectValue[0],selectValue[1]];
                
                NSMutableDictionary *root = [NSMutableDictionary dictionary];
                [root setValue:[NSString stringWithFormat:@"%@ %@",selectValue[0],selectValue[1]] forKey:@"internationalSchool"];
                [root setValue:selectValue[0] forKey:@"internationalSchoolType"];
                [root setValue:selectValue[1] forKey:@"internationalSchoolsystem"];
                [self updateUserInfo:root];
                
                [self->_menuTableView reloadData];
            }];
            
        }else if(row == 3){
            //合作办学
            AvalonsoftActionSheet *actionSheet = [[AvalonsoftActionSheet alloc] initSheetWithTitle:@"" style:AvalonsoftSheetStyleDefault itemTitles:@[@"本科",@"研究生"]];
            actionSheet.itemTextColor = RGBA_GGCOLOR(102, 102, 102, 1);
            
            [actionSheet didFinishSelectIndex:^(NSInteger index, NSString *title) {
                model.cellContent = title;
                
                [self updateUserInfo:@"cooperativeSchoolType" value:title];
                
                [self->_menuTableView reloadData];
            }];
            
        }else if(row == 4){
            //国内预科
            PersonalDataPrepareCourseVC *prepareCourseVC = [[PersonalDataPrepareCourseVC alloc] init];
            
            if (![[prepareCourseDataDic allKeys] containsObject:@"country"]) {
                NSMutableDictionary *data = [NSMutableDictionary dictionary];
                [data setValue:detailInfo.country forKey:@"country"];
                [data setValue:detailInfo.domesticPreparatoryType forKey:@"domesticPreparatoryType"];
                
                prepareCourseDataDic = data;
            }
            
            //设置block回调
            [prepareCourseVC setSendValueBlock:^(NSDictionary *valueDict){
                //回调函数
                
                self->prepareCourseDataDic = valueDict;
                
                NSString *domesticPreparatoryType;
                NSString *country;
                
                if(self->prepareCourseDataDic[@"domesticPreparatoryType"]){
                    domesticPreparatoryType = self->prepareCourseDataDic[@"domesticPreparatoryType"];
                }else{
                    domesticPreparatoryType = @"";
                }
                
                if(self->prepareCourseDataDic[@"country"]){
                    country = self->prepareCourseDataDic[@"country"];
                }else{
                    country = @"";
                }
                
                [model setCellContent:domesticPreparatoryType];
                [self->_menuTableView reloadData];
            }];
            
            prepareCourseVC.dataDic = prepareCourseDataDic;
            [self.navigationController pushViewController:prepareCourseVC animated:YES];
            
        }
        
    }else if(section == 3){
        //section four
        if(row == 0){
            //Tel
            //            [AvalonsoftToast showWithMessage:@"Tel"];
            NSDictionary *sendDataDic = @{@"phonenumber":model.cellContent};
            
            PersonalDataModifyPhoneNumberVC *modifyPhoneNumberVC = [[PersonalDataModifyPhoneNumberVC alloc] init];
            //设置block回调
            [modifyPhoneNumberVC setSendValueBlock:^(NSDictionary *valueDict){
                //回调函数
                NSString *phonenumber = valueDict[@"phonenumber"];
                [self updateUserInfo:@"phonenumber" value:phonenumber];
                
                [model setCellContent:phonenumber];
                [self->_menuTableView reloadData];
            }];
            
            modifyPhoneNumberVC.dataDic = sendDataDic;
            [self.navigationController pushViewController:modifyPhoneNumberVC animated:YES];
            
        }else if(row == 1){
            //Email
            //            [AvalonsoftToast showWithMessage:@"Email"];
            NSDictionary *sendDataDic = @{@"email":model.cellContent};
            
            PersonalDataModifyEmailVC *modifyEmailVC = [[PersonalDataModifyEmailVC alloc] init];
            //设置block回调
            [modifyEmailVC setSendValueBlock:^(NSDictionary *valueDict){
                //回调函数
                NSString *email = valueDict[@"email"];
                [self updateUserInfo:@"email" value:email];
                
                [model setCellContent:email];
                [self->_menuTableView reloadData];
            }];
            
            modifyEmailVC.dataDic = sendDataDic;
            [self.navigationController pushViewController:modifyEmailVC animated:YES];
        }
    }
    
}
//**********    tableView代理 end   **********//

#pragma mark - 所有网络请求处理都在这里进行 -
-(void)getUserExtInfo
{
    [AvalonsoftHasNetwork avalonsoft_hasNetwork:^(bool has) {
        if (has) {
            NSMutableDictionary *root = [NSMutableDictionary dictionary];
            NSString *url = [[NSString alloc] init];
            url = [COMMON_SERVER_URL stringByAppendingFormat:@"/%@\%@",MINE_MAIN_GET_USER_EXTINFO, [_UserInfo accountId]];
            //            url = [url stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
            NSLog(@"getUserExtInfo url=%@",url);//requestWithActionUrlAndParam
            
            [[AvalonsoftHttpClient avalonsoftHttpClient] requestWithActionUrlAndParam:url method:HttpRequestPost paramenters:root prepareExecute:^{
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                //处理网络请求结果
                [self handleNetworkRequestWithResponseObject:responseObject eventType:MINE_MAIN_GET_USER_EXTINFO];
            } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
                //请求失败
                NSLog(@"%@",error);
            }];
            
        } else {
            //没网
            //            [AvalonsoftMsgAlertView showWithTitle:@"信息" content:@"请检查网络" buttonTitles:@[@"关闭"] buttonClickedBlock:nil];
        }
    }];
}

-(void)updateUserInfo:(NSMutableDictionary *) root {
    [AvalonsoftHasNetwork avalonsoft_hasNetwork:^(bool has) {
        if (has) {
            [root setValue:[_UserInfo accountId] forKey:@"accountId"];
            
            [[AvalonsoftHttpClient avalonsoftHttpClient] requestWithAction:COMMON_SERVER_URL actionName:MINE_SYSTEMSETTING_UPDATE_USER_EXTINFO method:HttpRequestPost paramenters:root prepareExecute:^{
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                [self handleNetworkRequestWithResponseObject:responseObject eventType:MINE_SYSTEMSETTING_UPDATE_USER_EXTINFO];
            } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
                //请求失败
                NSLog(@"%@",error);
                
                [AvalonsoftLoadingHUD showFailureWithStatus:@"请求失败"];
            }];
            
        } else {
            //没网
            //            [AvalonsoftMsgAlertView showWithTitle:@"信息" content:@"请检查网络" buttonTitles:@[@"关闭"] buttonClickedBlock:nil];
        }
    }];
}

-(void)updateUserInfo:(NSString *) key value:(NSString *) value {
    [AvalonsoftHasNetwork avalonsoft_hasNetwork:^(bool has) {
        if (has) {
            NSMutableDictionary *root = [NSMutableDictionary dictionary];
            [root setValue:[_UserInfo accountId] forKey:@"accountId"];
            [root setValue:value forKey:key];
            
            [[AvalonsoftHttpClient avalonsoftHttpClient] requestWithAction:COMMON_SERVER_URL actionName:MINE_SYSTEMSETTING_UPDATE_USER_EXTINFO method:HttpRequestPost paramenters:root prepareExecute:^{
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                [self handleNetworkRequestWithResponseObject:responseObject eventType:MINE_SYSTEMSETTING_UPDATE_USER_EXTINFO];
            } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
                //请求失败
                NSLog(@"%@",error);
                
                [AvalonsoftLoadingHUD showFailureWithStatus:@"请求失败"];
            }];
            
        } else {
            //没网
            //            [AvalonsoftMsgAlertView showWithTitle:@"信息" content:@"请检查网络" buttonTitles:@[@"关闭"] buttonClickedBlock:nil];
        }
    }];
}

-(void)handleNetworkRequestWithResponseObject:(id)responseObject eventType:(NSString *)eventType
{
    NSLog(@"handleNetworkRequestWithResponseObject responseObject=%@",responseObject);
    //使用responseObject对_M进行MVC赋值
    _M *responseModel = [_M createResponseJsonObj:responseObject];
    
    NSLog(@"handleNetworkRequestWithResponseObject %ld %@",responseModel.rescode,responseModel.msg);
    
    @try {
        if([eventType isEqualToString:MINE_MAIN_GET_USER_EXTINFO]){
            if(responseModel.rescode == 200){
                detailInfo = [MineDetailCommonModel modelWithDict:responseModel.data];
                
                userDefaultsModel.phoneNumber = detailInfo.phonenumber;
                userDefaultsModel.email = detailInfo.email;
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self initView];
                    [self setListener];
                    [self setTableViewData];
                });
            }else{
                
            }
        } else if ([eventType isEqualToString:MINE_SYSTEMSETTING_UPDATE_USER_EXTINFO]) {
            if(responseModel.rescode == 200){
                [AvalonsoftToast showWithMessage:@"更新成功"];
            }else{
                [AvalonsoftToast showWithMessage:@"更新失败"];
            }
        }
    } @catch (NSException *exception) {
        @throw exception;
        //给出提示信息
        [AvalonsoftMsgAlertView showWithTitle:@"信息" content:@"系统发生错误，请与平台管理员联系解决。"  buttonTitles:@[@"关闭"] buttonClickedBlock:nil];
    }
}
@end
