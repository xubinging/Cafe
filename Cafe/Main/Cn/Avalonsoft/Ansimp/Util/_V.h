#import <UIKit/UIKit.h>

//常量定义类

//***** appStore中的Apple ID *****//
UIKIT_EXTERN NSString * const APPLE_ID;

//***** 数据库连接 *****//
UIKIT_EXTERN NSString * const SERVER_IP;
UIKIT_EXTERN NSString * const SERVER_PORT;
UIKIT_EXTERN NSString * const SERVER_PROTOCOL;
UIKIT_EXTERN NSString * const SERVER_PRJ_NAME;

UIKIT_EXTERN const int SERVER_CONNECTION_TIMEOUT;  //网络连接超时默认时间（秒）
UIKIT_EXTERN const int SERVER_READ_TIMEOUT;  //网络读取超时默认时间（秒）
UIKIT_EXTERN const int SERVER_WRITE_TIMEOUT;  //网络写入超时默认时间（秒）

//***** 接口名称 *****//
//【url分类】
UIKIT_EXTERN NSString * const USERCENTER_SERVER_URL;
UIKIT_EXTERN NSString * const COMMON_SERVER_URL;
UIKIT_EXTERN NSString * const FILE_SERVER_URL;


//【引导页】
UIKIT_EXTERN NSString * const WELCOME_GET_PAGEDATA;
UIKIT_EXTERN NSString * const WELCOME_GET_PAGEDATA_FIND;
UIKIT_EXTERN NSString * const WELCOME_GET_PAGEDATA_READ;
UIKIT_EXTERN NSString * const WELCOME_GET_PAGEDATA_COUNTRY;
UIKIT_EXTERN NSString * const WELCOME_GET_PAGEDATA_MAJOR;
UIKIT_EXTERN NSString * const WELCOME_ADD_PAGEDATA;


//【登录注册修改密码】
UIKIT_EXTERN NSString * const LOGIN_PASSWORD_LOGIN;
UIKIT_EXTERN NSString * const LOGIN_SEND_SMS;
UIKIT_EXTERN NSString * const LOGIN_TELEPHONE_LOGIN;
UIKIT_EXTERN NSString * const REGIST_CHECK_PHONENUM;
UIKIT_EXTERN NSString * const REGIST_SEND_SMS;
UIKIT_EXTERN NSString * const REGIST_ACCOUNT;
UIKIT_EXTERN NSString * const FINDPSD_CHECK_PHONENUM;
UIKIT_EXTERN NSString * const FINDPSD_SEND_SMS;
UIKIT_EXTERN NSString * const FINDPSD_CHECK_PHONENUMANDCODE;
UIKIT_EXTERN NSString * const FINDPSD_RESET_PWD;


//【首页】
UIKIT_EXTERN NSString * const HOME_MAIN_SEARCH_SCHOOL;
UIKIT_EXTERN NSString * const HOME_MAIN_SEARCH_INSTITUTION;
UIKIT_EXTERN NSString * const HOME_MAIN_SEARCH_ARTICLE;

UIKIT_EXTERN NSString * const HOME_MAIN_GET_CAROUSE_PICTURE;

UIKIT_EXTERN NSString * const HOME_MAIN_GET_FUNCTION_MODULE;
UIKIT_EXTERN NSString * const HOME_MAIN_BATCH_ADD_FUNCTION_MODULE;

UIKIT_EXTERN NSString * const HOME_MAIN_GET_INTEREST_MODULE;
UIKIT_EXTERN NSString * const HOME_MAIN_BATCH_ADD_INTEREST_MODULE;

//【首页 - 国外院校】
UIKIT_EXTERN NSString * const HOME_FOREIGN_GET_PTBK_LIST;
UIKIT_EXTERN NSString * const HOME_FOREIGN_GET_PTYJS_LIST;
UIKIT_EXTERN NSString * const HOME_FOREIGN_GET_YSBK_LIST;
UIKIT_EXTERN NSString * const HOME_FOREIGN_GET_YSYJS_LIST;
UIKIT_EXTERN NSString * const HOME_FOREIGN_GET_ZX_LIST;
UIKIT_EXTERN NSString * const HOME_FOREIGN_GET_YYYK_LIST;
UIKIT_EXTERN NSString * const HOME_FOREIGN_GET_COUNTRY_LIST;
UIKIT_EXTERN NSString * const HOME_FOREIGN_GET_MAJOR_LIST;

UIKIT_EXTERN NSString * const HOME_FOREIGN_SCHOOL_ADD_CONCERN;
UIKIT_EXTERN NSString * const HOME_FOREIGN_SCHOOL_QUERY_CONCERN;
UIKIT_EXTERN NSString * const HOME_FOREIGN_SCHOOL_DELETE_CONCERN;

UIKIT_EXTERN NSString * const HOME_FOREIGN_SCHOOL_GET_DETAIL;
UIKIT_EXTERN NSString * const HOME_FOREIGN_SCHOOL_GET_BANNERPIC;
UIKIT_EXTERN NSString * const HOME_FOREIGN_SCHOOL_GET_DEPART_LIST;
UIKIT_EXTERN NSString * const HOME_FOREIGN_SCHOOL_GET_GRADUATE_LIST;
UIKIT_EXTERN NSString * const HOME_FOREIGN_SCHOOL_GET_PREPARECOURSE_LIST;
UIKIT_EXTERN NSString * const HOME_FOREIGN_SCHOOL_GET_MOOC_LIST;
UIKIT_EXTERN NSString * const HOME_FOREIGN_SCHOOL_GET_PUBLICSCHOOL_LIST;
UIKIT_EXTERN NSString * const HOME_FOREIGN_SCHOOL_GET_NOTICE_LIST;
UIKIT_EXTERN NSString * const HOME_FOREIGN_SCHOOL_GET_OTHERTHING_LIST;


//【我的】
UIKIT_EXTERN NSString * const MINE_GET_MY_LIKE_SCHOOL_LIST;
UIKIT_EXTERN NSString * const MINE_GET_MY_LIKE_INST_LIST;
UIKIT_EXTERN NSString * const MINE_GET_MY_LIKE_HZBX_LIST;
UIKIT_EXTERN NSString * const MINE_GET_MY_LIKE_CLASS_LIST;
UIKIT_EXTERN NSString * const MINE_DELETE_MY_LIKE;
UIKIT_EXTERN NSString * const MINE_GET_TIEZI_LIST;
UIKIT_EXTERN NSString * const MINE_GET_YKXM_LIST;
UIKIT_EXTERN NSString * const MINE_MAIN_GET_USER_EXTINFO;
UIKIT_EXTERN NSString * const MINE_SYSTEMSETTING_UPDATE_USER_EXTINFO;
UIKIT_EXTERN NSString * const MINE_MY_POST_LIST;
UIKIT_EXTERN NSString * const MINE_MY_LIKED_COUNT;


//【社区】
UIKIT_EXTERN NSString * const GET_MORE_INTEREST_MODULE;
UIKIT_EXTERN NSString * const GET_ARTICLE_INFO;
UIKIT_EXTERN NSString * const GET_LEARN_THEME;
UIKIT_EXTERN NSString * const GET_LIFE_THEME;
UIKIT_EXTERN NSString * const USER_COLLECT_ADD;
UIKIT_EXTERN NSString * const USER_COLLECT_DELETE;
//社区-留学把把脉
UIKIT_EXTERN NSString * const COMMUNITY_PULSE_HOME_LIST;
//文章详情的数据接口
UIKIT_EXTERN NSString * const COMMUNITY_PULSE_DETAIL;
//猜你喜欢接口
UIKIT_EXTERN NSString * const COMMUNITY_PULSE_GUESS_LIKE;
//评论列表接口
UIKIT_EXTERN NSString * const COMMUNITY_PULSE_COMMENT_LIST;
//各国制度文章详情
UIKIT_EXTERN NSString * const COMMUNITY_NATIONAL_DETAIL;
//百科词条列表查询
UIKIT_EXTERN NSString * const COMMUNITY_ENTRY_LIST;
//百科词条详情查询
UIKIT_EXTERN NSString * const COMMUNITY_ENTRY_DETAIL;
//学校印象 列表查询
UIKIT_EXTERN NSString * const COMMUNITY_IMPRESSION;
//签证新动态列表
UIKIT_EXTERN NSString *  const COMMUNITY_VISATREND;
//签证新动态详情
UIKIT_EXTERN NSString *  const COMMUNITY_VISATREND_DETAIL;
//签证法规 列表
UIKIT_EXTERN NSString *  const COMMUNITY_VISARULE;
//获取签证法规国家列表
UIKIT_EXTERN NSString *  const COMMUNITY_VIVARULE_COUNTRY;


//【首页 - 服务机构】
//留学公司筛选条件
UIKIT_EXTERN NSString * const HOME_SERVICE_GET_COMPANY_CONDITION;
//留学公司列表
UIKIT_EXTERN NSString * const HOME_SERVICE_GET_COMPANY_LIST;
//留学公司详情
UIKIT_EXTERN NSString * const HOME_SERVICE_GET_COMPANY_DETAIL;
//留学公司驻地顾问点列表
UIKIT_EXTERN NSString * const HOME_SERVICE_GET_ADVISER_LIST;
//留学培训筛选条件
UIKIT_EXTERN NSString * const HOME_SERVICE_GET_TRAINING_CONDITION;
//留学培训列表
UIKIT_EXTERN NSString * const HOME_SERVICE_GET_TRAINING_LIST;
//留学培训详情
UIKIT_EXTERN NSString * const HOME_SERVICE_GET_TRAINING_DETAIL;
//查询关注的机构
UIKIT_EXTERN NSString * const HOME_SERVICE_GET_IS_LICK;
//关注机构
UIKIT_EXTERN NSString * const HOME_SERVICE_ADD_CONCERN;
//取消关注机构
UIKIT_EXTERN NSString * const HOME_SERVICE_DELETE_CONCERN;
//查询机构评星
UIKIT_EXTERN NSString * const HOME_SERVICE_GET_TRAINING_STAR;
//机构评星
UIKIT_EXTERN NSString * const HOME_SERVICE_ADD_TRAINING_STAR;
//选课程列表
UIKIT_EXTERN NSString * const HOME_SERVICE_GET_COURSE_LIST;
//选课程老师信息
UIKIT_EXTERN NSString * const HOME_SERVICE_GET_TEACHER_INFO;
//查询收藏的课程
UIKIT_EXTERN NSString * const HOME_SERVICE_GET_COURSE_IS_LIKE;
//收藏课程
UIKIT_EXTERN NSString * const HOME_SERVICE_COURSE_ADD_CONCERN;
//取消收藏课程
UIKIT_EXTERN NSString * const HOME_SERVICE_COURSE_DELETE_CONCERN;
//抢购课程
UIKIT_EXTERN NSString * const HOME_SERVICE_COURSE_SCRAMBLE;
//轮播图
UIKIT_EXTERN NSString * const HOME_SERVICE_GET_BANNER_IMAGE_LIST;
//最新消息及通告
UIKIT_EXTERN NSString * const HOME_SERVICE_GET_NEWS_NOTICE_LIST;
//海外院校录取榜
UIKIT_EXTERN NSString * const HOME_SERVICE_GET_LEADER_BOARD_OFFER_LIST;
//学员考试成绩榜
UIKIT_EXTERN NSString * const HOME_SERVICE_GET_EXAM_SCORE_LIST;

