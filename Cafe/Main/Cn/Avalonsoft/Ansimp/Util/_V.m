#import <UIKit/UIKit.h>

//***** appStore中的Apple ID *****//
NSString * const APPLE_ID = @"1474930590";

//***** 正式数据库连接 *****//
NSString * const SERVER_PROTOCOL = @"";
NSString * const SERVER_IP = @"";
NSString * const SERVER_PORT = @"";
NSString * const SERVER_PRJ_NAME = @"";

const int SERVER_CONNECTION_TIMEOUT = 30;   //网络连接超时默认时间（秒）
const int SERVER_READ_TIMEOUT = 30;         //网络读取超时默认时间（秒）
const int SERVER_WRITE_TIMEOUT = 30;        //网络写入超时默认时间（秒）

//***** 接口名称 *****//
//*****【url分类】*****//
//登录注册模块接口地址
NSString * const USERCENTER_SERVER_URL = @"http://114.116.80.144:12030";  //测试地址
//NSString * const USERCENTER_SERVER_URL = @"http://139.159.254.13:12030";    //正式地址

//除了登录注册模块其余接口地址
NSString * const COMMON_SERVER_URL = @"http://49.235.59.81:7056";         //测试地址
//NSString * const COMMON_SERVER_URL = @"http://139.159.254.13:7056";         //正式地址

//图片，文件地址
NSString * const FILE_SERVER_URL = @"http://49.235.59.81:8888/";


//*****【引导页】*****//
//查询是否初次进入APP配置引导页
NSString * const WELCOME_GET_PAGEDATA = @"edu/eduguidepages/queryList";
//查询我要找预置数据
NSString * const WELCOME_GET_PAGEDATA_FIND = @"edu/eduguidepagespreset/queryList";
//查询我要就读预置数据
NSString * const WELCOME_GET_PAGEDATA_READ = @"edu/eduguidepagespreset/queryList";
//查询留学国家
NSString * const WELCOME_GET_PAGEDATA_COUNTRY = @"sys/area/sysareacode/queryListByCust";
//查询感兴趣的专业
NSString * const WELCOME_GET_PAGEDATA_MAJOR = @"eduInter/eduinterprogramfield/queryList";
//新增引导页配置数据
NSString * const WELCOME_ADD_PAGEDATA = @"edu/eduguidepages/add";


//*****【登录注册修改密码】*****//
//账号密码登陆
NSString * const LOGIN_PASSWORD_LOGIN = @"usercenter/login";
//快捷登录发送验证码
NSString * const LOGIN_SEND_SMS = @"edu/sms/basesmsinfo/sendSms";
//快捷登录
NSString * const LOGIN_TELEPHONE_LOGIN = @"usercenter/login/sms";
//注册账号检查手机号是否存在
NSString * const REGIST_CHECK_PHONENUM = @"edu/user/eduuserinfo/checkPhone";
//注册账号发送验证码
NSString * const REGIST_SEND_SMS = @"edu/sms/basesmsinfo/sendSms";
//注册账号
NSString * const REGIST_ACCOUNT = @"edu/user/eduuserinfo/add";
//忘记密码检查手机号是否存在
NSString * const FINDPSD_CHECK_PHONENUM = @"usercenter/resetPassword/checkPhoneNum?phonenumber=";
//忘记密码发送短信
NSString * const FINDPSD_SEND_SMS = @"usercenter/resetPassword/sendPhoneSms?phonenumber=";
//忘记密码检查手机号和验证码
NSString * const FINDPSD_CHECK_PHONENUMANDCODE = @"usercenter/resetPassword/checkPhoneSms";
//重置密码
NSString * const FINDPSD_RESET_PWD = @"usercenter/resetPassword/resetPasswordByPhone";


//*****【首页】*****//
//首页-查询学校
NSString * const HOME_MAIN_SEARCH_SCHOOL = @"cuser/globalsearch/school";
//首页-查询机构
NSString * const HOME_MAIN_SEARCH_INSTITUTION = @"cuser/globalsearch/institution";
//首页-查询文章
NSString * const HOME_MAIN_SEARCH_ARTICLE = @"cuser/globalsearch/article";

//首页-查询APP首页图片轮播图
NSString * const HOME_MAIN_GET_CAROUSE_PICTURE = @"edu/educarouselpicture/queryList";

//首页-查询首页功能区 我的应用+更多应用
NSString * const HOME_MAIN_GET_FUNCTION_MODULE = @"edu/edumyfunctionmodule/queryModuleList";
//首页-保存功能区编辑
NSString * const HOME_MAIN_BATCH_ADD_FUNCTION_MODULE = @"edu/edumyfunctionmodule/batchAdd";

//首页-查询首页我感兴趣的模块
NSString * const HOME_MAIN_GET_INTEREST_MODULE = @"edu/edumyinterestmodule/queryInterestList";
//首页-保存我感兴趣的编辑
NSString * const HOME_MAIN_BATCH_ADD_INTEREST_MODULE = @"edu/edumyinterestmodule/batchAdd";

//国外院校-查询普通本科
NSString * const HOME_FOREIGN_GET_PTBK_LIST = @"eduInstitution/eduinstitution/queryPageListForptbk";
//国外院校-查询普通研究生
NSString * const HOME_FOREIGN_GET_PTYJS_LIST = @"eduInstitution/eduinstitution/queryPageListForptyjs";
//国外院校-查询艺术本科
NSString * const HOME_FOREIGN_GET_YSBK_LIST = @"eduInstitution/eduinstitution/queryPageListForysbk";
//国外院校-查询艺术研究生
NSString * const HOME_FOREIGN_GET_YSYJS_LIST = @"eduInstitution/eduinstitution/queryPageListForysyjs";
//国外院校-查询中学
NSString * const HOME_FOREIGN_GET_ZX_LIST = @"eduInstitution/eduinstitution/queryPageListForzx";
//国外院校-查询语言预科
NSString * const HOME_FOREIGN_GET_YYYK_LIST = @"eduInstitution/eduinstitution/queryPageListForyyyk";
//国外院校-查询国家
NSString * const HOME_FOREIGN_GET_COUNTRY_LIST = @"sys/area/sysareacode/queryListByCust";
//国外院校-查询专业
NSString * const HOME_FOREIGN_GET_MAJOR_LIST = @"eduInter/eduinterprogramfield/queryList";

//国外院校-添加关注
NSString * const HOME_FOREIGN_SCHOOL_ADD_CONCERN = @"eduInstitution/eduinstcconcern/add";
//国外院校-查询关注id
NSString * const HOME_FOREIGN_SCHOOL_QUERY_CONCERN = @"eduInstitution/eduinstcconcern/queryList";
//国外院校-取消关注
NSString * const HOME_FOREIGN_SCHOOL_DELETE_CONCERN = @"eduInstitution/eduinstcconcern/delete?id=";

//国外院校-查询详情
NSString * const HOME_FOREIGN_SCHOOL_GET_DETAIL = @"eduInstitution/eduinstitution/detailAbroadSchool?";
//国外院校-查询轮播图
NSString * const HOME_FOREIGN_SCHOOL_GET_BANNERPIC = @"eduInstitution/eduinstitution/queryShowForInstHomeList";
//国外院校-查询院系信息
NSString * const HOME_FOREIGN_SCHOOL_GET_DEPART_LIST = @"eduInter/eduinterdepart/queryCList";
//国外院校-查询研究生专业/研究方向
NSString * const HOME_FOREIGN_SCHOOL_GET_GRADUATE_LIST = @"eduInstitution/eduinterpostgraduate/queryPageList";
//国外院校-查询语言与预科
NSString * const HOME_FOREIGN_SCHOOL_GET_PREPARECOURSE_LIST = @"eduInstitution/eduinterlanguage/queryPageList";
//国外院校-查询慕课
NSString * const HOME_FOREIGN_SCHOOL_GET_MOOC_LIST = @"eduInst/eduintermoctable/queryPageList";
//国外院校-查询公立学校
NSString * const HOME_FOREIGN_SCHOOL_GET_PUBLICSCHOOL_LIST = @"eduInstitution/eduinterhighschool/queryPageList";
//国外院校-查询最新信息及活动通告
NSString * const HOME_FOREIGN_SCHOOL_GET_NOTICE_LIST = @"edu/school/eduschoolnewsnotice/queryPageList";
//国外院校-查询其他事
NSString * const HOME_FOREIGN_SCHOOL_GET_OTHERTHING_LIST = @"eduInter/eduinstuniversitynews/queryPageList";


//*****【我的】*****//
//查询我的关注学校列表
NSString * const MINE_GET_MY_LIKE_SCHOOL_LIST = @"eduInstitution/eduinstcconcern/queryUniversityList";
//查询我的关注留学公司、留学培训列表
NSString * const MINE_GET_MY_LIKE_INST_LIST = @"eduInstitution/eduinstcconcern/queryInstList";
//查询合作办学列表
NSString * const MINE_GET_MY_LIKE_HZBX_LIST = @"eduInstitution/eduinstcconcern/queryHZBXList";
//查询预科国际版列表
NSString * const MINE_GET_MY_LIKE_CLASS_LIST = @"eduInstitution/eduinstcconcern/queryProgramList";
//删除我的关注
NSString * const MINE_DELETE_MY_LIKE = @"eduInstitution/eduinstcconcern/delete?id=";
//我的收藏 帖子列表
NSString * const MINE_GET_TIEZI_LIST = @"edu/forum/eduforumpost/queryCollectPageListbyAccount";
//我的收藏 预科项目
NSString * const MINE_GET_YKXM_LIST = @"eduUser/eduuserccollect/queryLanguageList";
//个人信息
NSString * const MINE_MAIN_GET_USER_EXTINFO = @"edu/user/eduuserextinfo/query?accountId=";
//修改个人信息
NSString * const MINE_SYSTEMSETTING_UPDATE_USER_EXTINFO = @"edu/user/eduuserextinfo/update";
//文章
NSString * const MINE_MY_POST_LIST = @"edu/forum/eduforumpost/queryMyPostListByAccountId";
//被点赞数
NSString * const MINE_MY_LIKED_COUNT = @"edu/eduuserlikes/queryAllLikedCount";
//考试成绩列表
NSString * const MINE_MY_EXAM_SCORE_LIST = @"edu/exam/eduexamscore/queryList";
//考试成绩详情
NSString * const MINE_MY_EXAM_SCORE_DETAILS = @"edu/exam/eduexamscore/query?id=";
//考试成绩删除
NSString * const MINE_MY_EXAM_SCORE_DELETE = @"edu/exam/eduexamscore/delete?id=";
//考试成绩添加
NSString * const MINE_MY_EXAM_SCORE_ADD = @"edu/exam/eduexamscore/add";
//考试成绩编辑
NSString * const MINE_MY_EXAM_SCORE_UPDATE = @"edu/exam/eduexamscore/update";
//奖项
NSString * const MINE_MY_EDU_AWARD = @"eduUser/eduusercaward/queryPageList";
//技能
NSString * const MINE_MY_EDU_SKILL = @"eduUser/eduusercskill/queryPageList";
//奖项详情
NSString * const MINE_MY_EDU_AWARD_DETAILS = @"eduUser/eduusercaward/query?id";
//技能详情
NSString * const MINE_MY_EDU_SKILL_DETAILS = @"eduUser/eduusercskill/query?id";
//奖项新增
NSString * const MINE_MY_EDU_AWARD_ADD = @"eduUser/eduusercaward/add";
//技能新增
NSString * const MINE_MY_EDU_SKILL_ADD = @"eduUser/eduusercskill/add";
//奖项编辑
NSString * const MINE_MY_EDU_AWARD_UPDATE = @"eduUser/eduusercaward/update";
//技能编辑
NSString * const MINE_MY_EDU_SKILL_UPDATE = @"eduUser/eduusercskill/update";
//课外活动列表
NSString * const MINE_MY_ACTIVITY_LIST = @"eduUser/eduuserclife/queryPageList";
//课外活动详情
NSString * const MINE_MY_ACTIVITY_DETAILS = @"eduUser/eduuserclife/query?id";
//课外活动新增
NSString * const MINE_MY_ACTIVITY_ADD = @"eduUser/eduuserclife/add";
//课外活动编辑
NSString * const MINE_MY_ACTIVITY_UPDATE = @"eduUser/eduuserclife/update";
//工作经历列表
NSString * const MINE_MY_WORK_LIST = @"eduUser/eduusercwork/queryPageList";
//工作经历详情
NSString * const MINE_MY_WORK_DETAILS = @"eduUser/eduusercwork/query?id";
//工作经历新增
NSString * const MINE_MY_WORK_ADD = @"eduUser/eduusercwork/add";
//工作经历编辑
NSString * const MINE_MY_WORK_UPDATE = @"eduUser/eduusercwork/update";
//offer列表
NSString * const MINE_MY_OFFER_LIST = @"cuser/eduuseroffer/queryPageList";
//offer详情
NSString * const MINE_MY_OFFER_DETAILS = @"cuser/eduuseroffer/query?id";
//offer新增
NSString * const MINE_MY_OFFER_ADD = @"cuser/eduuseroffer/add";
//offer编辑
NSString * const MINE_MY_OFFER_UPDATE = @"cuser/eduuseroffer/update";
//offer删除
NSString * const MINE_MY_OFFER_DELETE = @"cuser/eduuseroffer/softDeleteById";
//学术经历列表
NSString * const MINE_MY_LEARNING_LIST = @"eduUser/eduusercextracurricular/queryPageList";
//学术经历详情
NSString * const MINE_MY_LEARNING_DETAILS = @"eduUser/eduusercextracurricular/query?id=";
//学术经历新增
NSString * const MINE_MY_LEARNING_ADD = @"eduUser/eduusercextracurricular/add";
//学术经历编辑
NSString * const MINE_MY_LEARNING_UPDATE = @"eduUser/eduusercextracurricular/update";
//学术经历删除
NSString * const MINE_MY_LEARNING_DELETE = @"eduUser/eduusercextracurricular/delete";
//教育背景列表
NSString * const MINE_MY_EDUCATION_LIST = @"cuser/eduuserceducation/queryPageList";
//教育背景详情
NSString * const MINE_MY_EDUCATION_DETAILS = @"cuser/eduuserceducation/query?id=";
//教育背景新增
NSString * const MINE_MY_EDUCATION_ADD = @"cuser/eduuserceducation/add";
//教育背景编辑
NSString * const MINE_MY_EDUCATION_UPDATE = @"cuser/eduuserceducation/update";
//教育背景删除
NSString * const MINE_MY_EDUCATION_DELETE = @"/cuser/eduuserceducation/delete";





//*****【社区】*****//
//查询APP首页用户定制我感兴趣模块数据列表(点击更多查看可订阅模块)
NSString * const GET_MORE_INTEREST_MODULE = @"edu/edumyinterestmodule/queryInterestList";
//获取社区贴子信息的通用接口
//（各国制度;学习技巧；留学新鲜人 ;海外生活常识 ;留学非常道;留学参考） 列表接口
NSString * const GET_ARTICLE_INFO = @"edu/eduarticleinfo/queryPageList";
//学习技巧字典表查询
NSString * const GET_LEARN_THEME = @"baseRepo/baserepoinfo/queryListForLearnTheme";
//海外生活常识字典表查询
NSString * const GET_LIFE_THEME = @"baseRepo/baserepoinfo/queryListForLifeTheme";
//用户收藏贴子
NSString * const USER_COLLECT_ADD = @"eduUser/eduuserccollect/add";
//用户取消收藏贴子
NSString * const USER_COLLECT_DELETE = @"eduUser/eduuserccollect/delete?id=";

// 社区 - 留学把把脉
//查询留学把把脉列表数据接口 (点击学校印象中的某一印象获取列表时的接口)
NSString *  const COMMUNITY_PULSE_HOME_LIST = @"edu/forum/eduforumpost/queryListDetails";
//文章详情的数据接口
NSString *  const COMMUNITY_PULSE_DETAIL = @"edu/forum/eduforumpost/queryDetail";
//猜你喜欢接口
NSString *  const COMMUNITY_PULSE_GUESS_LIKE = @"cuser/guessLike/queryList";
//评论列表接口
NSString *  const COMMUNITY_PULSE_COMMENT_LIST = @"edu/forum/eduforumreply/queryListDetails";
//各国制度文章详情
NSString *  const COMMUNITY_NATIONAL_DETAIL = @"edu/eduarticleinfo/queryDetail";
//百科词条列表查询
NSString *  const COMMUNITY_ENTRY_LIST = @"edu/eduitemsinfo/queryPageListJSFItem";
//百科词条详情查询
NSString *  const COMMUNITY_ENTRY_DETAIL = @"edu/eduitemsinfo/queryDetail";
//学校印象 (校园八卦）查询主题 列表查询
NSString *  const COMMUNITY_IMPRESSION = @"edu/forum/eduforumtopic/queryPageList";
//签证新动态列表
NSString *  const COMMUNITY_VISATREND = @"edu/edunoticevisa/queryPageList";
//签证新动态详情
NSString *  const COMMUNITY_VISATREND_DETAIL =@"edu/edunoticevisa/queryDetail";
//签证法规 列表
NSString *  const COMMUNITY_VISARULE = @"cuser/edutypevisa/queryList";
//获取签证法规国家列表
NSString *  const COMMUNITY_VIVARULE_COUNTRY = @"cuser/edutypevisa/queryCountryList";


// 首页 - 服务机构
//留学公司筛选条件
NSString * const HOME_SERVICE_GET_COMPANY_CONDITION = @"sys/area/sysareacode/queryListByCust";
//留学公司列表
NSString * const HOME_SERVICE_GET_COMPANY_LIST = @"eduInstitution/eduinstitution/queryPageList";
//留学公司详情
NSString * const HOME_SERVICE_GET_COMPANY_DETAIL = @"eduInstitution/eduinstitution/detailCompany";
//留学公司驻地顾问点列表
NSString * const HOME_SERVICE_GET_ADVISER_LIST = @"edu/adviser/queryPageList";
//留学培训筛选条件
NSString * const HOME_SERVICE_GET_TRAINING_CONDITION = @"eduCategory/educategoryinfo/queryList";
//留学培训列表
NSString * const HOME_SERVICE_GET_TRAINING_LIST = @"eduInstitution/eduinstitution/queryPageListForlxpx";
//留学培训详情
NSString * const HOME_SERVICE_GET_TRAINING_DETAIL = @"eduInstitution/eduinstitution/detailTrainingAgency";
//查询关注的机构
NSString * const HOME_SERVICE_GET_IS_LICK = @"eduInstitution/eduinstcconcern/queryList";
//关注机构
NSString * const HOME_SERVICE_ADD_CONCERN = @"eduInstitution/eduinstcconcern/add";
//取消关注机构
NSString * const HOME_SERVICE_DELETE_CONCERN = @"eduInstitution/eduinstcconcern/delete";
//查询机构评星
NSString * const HOME_SERVICE_GET_TRAINING_STAR = @"edu/forum/eduforumcomment/queryStar";
//机构评星
NSString * const HOME_SERVICE_ADD_TRAINING_STAR = @"edu/forum/eduforumcomment/add";
//选课程列表
NSString * const HOME_SERVICE_GET_COURSE_LIST = @"edu/school/eduschoolcourseinfo/queryPageList";
//选课程老师信息
NSString * const HOME_SERVICE_GET_TEACHER_INFO = @"ebm/teacher/eduSchoolTeacherInfo/queryList";
//查询收藏的课程
NSString * const HOME_SERVICE_GET_COURSE_IS_LIKE = @"eduUser/eduuserccollect/queryList";
//收藏课程
NSString * const HOME_SERVICE_COURSE_ADD_CONCERN = @"eduUser/eduuserccollect/add";
//取消收藏课程
NSString * const HOME_SERVICE_COURSE_DELETE_CONCERN = @"eduUser/eduuserccollect/delete";
//抢购课程
NSString * const HOME_SERVICE_COURSE_SCRAMBLE = @"edu/course/usercoursesignup/add";
//轮播图
NSString * const HOME_SERVICE_GET_BANNER_IMAGE_LIST = @"eduInstitution/eduinstitution/queryShowForInstHomeList";
//最新消息及通告
NSString * const HOME_SERVICE_GET_NEWS_NOTICE_LIST = @"edu/school/eduschoolnewsnotice/queryPageList";
//海外院校录取榜
NSString * const HOME_SERVICE_GET_LEADER_BOARD_OFFER_LIST = @"cuser/eduuseroffer/queryLeaderBoardOffers";
//学员考试成绩榜
NSString * const HOME_SERVICE_GET_EXAM_SCORE_LIST = @"edu/exam/eduexamscore/queryPageList";




