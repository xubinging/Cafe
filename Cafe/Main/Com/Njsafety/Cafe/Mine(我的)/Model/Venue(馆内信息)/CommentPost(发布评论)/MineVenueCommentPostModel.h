//
//  MineVenueCommentPostModel.h
//  Cafe
//
//  Created by leo on 2020/1/8.
//  Copyright © 2020 leo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MineVenueCommentPostModel : NSObject

//定义属性
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, copy) NSString *logo;                 //头像
@property (nonatomic, copy) NSString *createTime;           //时间
@property (nonatomic, copy) NSString *title;                //标题
@property (nonatomic, copy) NSString *originTitle;          //副标题
@property (nonatomic, copy) NSString *content;              //内容

//工厂方法，需要传入字典。可以完成model的创建和属性的b批量赋值。
+(instancetype)modelWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END


//accountId = 1109;
//accountName = "\U4e2d\U56fd\U6d4b\U8bd5---\U4fee\U6539001";
//articleType = "<null>";
//commendId = "";
//content = "<p>\U7559\U5b66\U5fc3\U5206\U4eab\U6d4b\U8bd5kpi\U6570\U636e\U70b9\U51fb\U7edf\U8ba1</p>";
//createTime = "2020-05-06 22:38:24";
//delSign = 0;
//firstReplyType = "<null>";
//forumType = "<null>";
//id = 4592;
//insId = 2931;
//insType = hzbx;
//likeCount = "<null>";
//logo = "<null>";
//originAccountId = "<null>";
//originAccountName = "<null>";
//originInsId = "<null>";
//originInsType = "<null>";
//originLogo = "<null>";
//originReplyType = "<null>";
//originSource = "<null>";
//originTitle = "\U6d4b\U8bd5\U957f\U5ea6\U6d4b\U8bd5\U957f\U5ea6\U6d4b\U8bd5\U957f\U5ea6\U6d4b\U8bd5\U957f\U5ea6\U6d4b\U8bd5\U957f\U5ea6\U6d4b\U8bd5\U957f\U5ea6\U6d4b\U8bd5\U957f\U5ea6\U6d4b\U8bd5\U957f\U5ea6\U6d4b\U8bd5\U957f\U5ea6\U6d4b\U8bd5\U957f\U5ea6\U6d4b\U8bd5\U957f\U5ea6\U6d4b\U8bd5\U957f\U5ea6\U6d4b\U8bd5\U957f\U5ea6\U6d4b\U8bd5\U957f\U5ea6\U6d4b\U8bd5\U957f\U5ea6\U6d4b\U8bd5\U957f\U5ea6\U6d4b\U8bd5\U957f\U5ea6\U6d4b\U8bd5\U957f\U5ea6\U6d4b\U8bd5\U957f\U5ea6\U6d4b\U8bd5\U957f\U5ea6\U6d4b\U8bd5\U957f\U5ea6\U6d4b\U8bd5\U957f\U5ea6\U6d4b\U8bd5\U957f\U5ea6\U6d4b\U8bd5\U957f\U5ea6\U6d4b\U8bd5\U957f\U5ea6\U6d4b\U8bd5\U957f\U5ea6\U6d4b\U8bd5\U957f\U5ea6\U6d4b\U8bd5\U957f\U5ea6";
//parentId = 1624;
//popularityCount = "<null>";
//postId = 1624;
//postType = 6;
//publishType = "<null>";
//replyCount = "<null>";
//replyStatus = 1;
//replyType = 1;
//source = 2;
//title = "<null>";
