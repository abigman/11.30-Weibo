//
//  YCLStatus.h
//  11.30-Weibo
//
//  Created by Chenglin Yu on 14/12/11.
//  Copyright (c) 2014年 yclzone. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YCLUser;

/*
 返回字段说明
 
 返回值字段                  字段类型    字段说明
 created_at                 string  微博创建时间
 id                         int64   微博ID
 mid                        int64   微博MID
 idstr                      string  字符串型的微博ID
 text                       string  微博信息内容
 source                     string  微博来源
 favorited                  boolean 是否已收藏，true：是，false：否
 truncated                  boolean 是否被截断，true：是，false：否
 in_reply_to_status_id      string  （暂未支持）回复ID
 in_reply_to_user_id        string  （暂未支持）回复人UID
 in_reply_to_screen_name    string  （暂未支持）回复人昵称
 thumbnail_pic              string  缩略图片地址，没有时不返回此字段
 bmiddle_pic                string  中等尺寸图片地址，没有时不返回此字段
 original_pic               string  原始图片地址，没有时不返回此字段
 geo                        object  地理信息字段 详细
 user                       object  微博作者的用户信息字段 详细
 retweeted_status           object  被转发的原微博信息字段，当该微博为转发微博时返回 详细
 reposts_count              int 转发数
 comments_count             int 评论数
 attitudes_count            int 表态数
 mlevel                     int 暂未支持
 visible                    object  微博的可见性及指定可见分组信息。
                                    type取值，0：普通微博，1：私密微博，3：指定分组微博，4：密友微博；
                                    list_id为分组的组号
 pic_ids                    object  微博配图ID。多图时返回多图ID，用来拼接图片url。
                                    用返回字段thumbnail_pic的地址配上该返回字段的图片ID，即可得到多个图片url。
 ad                         object array    微博流内的推广微博ID
 
 */

/**  微博实例
 
 {
    "attitudes_count" = 474;
    "comments_count" = 78;
    "created_at" = "Thu Jan 22 23:20:47 +0800 2015";
    "darwin_tags" = ();
    favorited = 0;
    geo = "<null>";
    id = 3801954477825524;
    idstr = 3801954477825524;
    "in_reply_to_screen_name" = "";
    "in_reply_to_status_id" = "";
    "in_reply_to_user_id" = "";
    mid = 3801954477825524;
    mlevel = 0;
    "pic_urls" = ();
    "reposts_count" = 395;
    rid = "19_0_2666864929206744896";
    source = "<a href=\"http://weibo.com/\" rel=\"nofollow\">微博 weibo.com</a>";
    "source_allowclick" = 0;
    "source_type" = 1;
    text = "[可爱]";
    truncated = 0;
    user = { 
        "allow_all_act_msg" = 0;
        "allow_all_comment" = 1;
        "avatar_hd" = "http://ww4.sinaimg.cn/crop.0.0.179.179.1024/71021e17tw1efz48pe49rj20500513ym.jpg";
        "avatar_large" = "http://tp4.sinaimg.cn/1895964183/180/22873788984/1";
        "bi_followers_count" = 127;
        "block_app" = 1;
        "block_word" = 1;
        city = 1;
        class = 1;
        "created_at" = "Fri Dec 17 20:45:05 +0800 2010";
        "credit_score" = 80;
        description = "这里是神回复、高级黑、内涵淫才聚集地，请自觉投入你的节操。";
        domain = "";
        "favourites_count" = 20;
        "follow_me" = 0;
        "followers_count" = 6212872;
        following = 1;
        "friends_count" = 141;
        gender = m;
        "geo_enabled" = 0;
        id = 1895964183;
        idstr = 1895964183;
        lang = "zh-cn";
        location = "北京 东城区";
        mbrank = 6;
        mbtype = 12;
        name = "一起神回复";
        "online_status" = 0;
        "pagefriends_count" = 0;
        "profile_image_url" = "http://tp4.sinaimg.cn/1895964183/50/22873788984/1";
        "profile_url" = "u/1895964183";
        province = 11;
        ptype = 0;
        remark = "";
        "screen_name" = "一起神回复";
        star = 0;
        "statuses_count" = 7707;
        urank = 24;
        url = "";
        verified = 1;
        "verified_contact_email" = "";
        "verified_contact_mobile" = "";
        "verified_contact_name" = "";
        "verified_level" = 3;
        "verified_reason" = "微博知名博主";
        "verified_reason_modified" = "";
        "verified_reason_url" = "";
        "verified_source" = "";
        "verified_source_url" = "";
        "verified_state" = 0;
        "verified_trade" = 3370;
        "verified_type" = 0;
        weihao = "";
    };
    visible = { 
        "list_id" = 0;
        type = 0;
    };
    "retweeted_status" = { 
        "attitudes_count" = 2561;
        "bmiddle_pic" = "http://ww1.sinaimg.cn/bmiddle/b8b73ba1jw1eoiomi7fzgg20a7053qqy.gif";
        "comments_count" = 523;
        "created_at" = "Thu Jan 22 23:01:03 +0800 2015";
        "darwin_tags" = ( );
        favorited = 0;
        geo = "<null>";
        id = 3801949512136813;
        idstr = 3801949512136813;
        "in_reply_to_screen_name" = "";
        "in_reply_to_status_id" = "";
        "in_reply_to_user_id" = "";
        mid = 3801949512136813;
        mlevel = 0;
        "original_pic" = "http://ww1.sinaimg.cn/large/b8b73ba1jw1eoiomi7fzgg20a7053qqy.gif";
        "pic_urls" = (
            { "thumbnail_pic" = "http://ww1.sinaimg.cn/thumbnail/b8b73ba1jw1eoiomi7fzgg20a7053qqy.gif"; },
            { "thumbnail_pic" = "http://ww4.sinaimg.cn/thumbnail/b8b73ba1jw1eoiomz2vblg20a7053x69.gif"; },
            { "thumbnail_pic" = "http://ww2.sinaimg.cn/thumbnail/b8b73ba1jw1eoionz27sug20a70521ky.gif"; },
            { "thumbnail_pic" = "http://ww2.sinaimg.cn/thumbnail/b8b73ba1jw1eoioola77kg20a7052hdt.gif"; } 
        );
        "reposts_count" = 3681;
        source = "<a href=\"http://weibo.com/\" rel=\"nofollow\">微博 weibo.com</a>";
        "source_allowclick" = 0;
        "source_type" = 1;
        text = "为了配合小女孩，大叔也是拼尽了演技，最后获得安抚么么一个，有点萌";
        "thumbnail_pic" = "http://ww1.sinaimg.cn/thumbnail/b8b73ba1jw1eoiomi7fzgg20a7053qqy.gif";
        truncated = 0;
        user = { 
            "allow_all_act_msg" = 0;
            "allow_all_comment" = 1;
            "avatar_hd" = "http://ww1.sinaimg.cn/crop.0.0.440.440.1024/b8b73ba1jw8envijyrwfqj20c80c8wf8.jpg";
            "avatar_large" = "http://tp2.sinaimg.cn/3099016097/180/5715173937/0";
            "bi_followers_count" = 442;
            "block_app" = 1;
            "block_word" = 0;
            city = 2;
            class = 1;
            "cover_image" = "http://ww2.sinaimg.cn/crop.0.0.920.300/b8b73ba1gw1emojzqqug0j20pk08cgoy.jpg";
            "cover_image_phone" = "http://ww3.sinaimg.cn/crop.0.0.0.0/b8b73ba1jw1emojcngmjlj20e80e8q49.jpg";
            "created_at" = "Sat Nov 10 14:28:36 +0800 2012";
            "credit_score" = 80;
            description = "我是个人不是报纸，国外各种好玩哒，我啥都发~【注：玻璃心，喜释梗，广告狗";
            domain = uktimes;
            "favourites_count" = 82;
            "follow_me" = 0;
            "followers_count" = 4799584;
            following = 0;
            "friends_count" = 451;
            gender = f;
            "geo_enabled" = 1;
            id = 3099016097;
            idstr = 3099016097;
            lang = "zh-tw";
            location = "海外 英国";
            mbrank = 5;
            mbtype = 12;
            name = "英国报姐";
            "online_status" = 0;
            "pagefriends_count" = 0;
            "profile_image_url" = "http://tp2.sinaimg.cn/3099016097/50/5715173937/0";
            "profile_url" = uktimes;
            province = 400;
            ptype = 0;
            remark = "";
            "screen_name" = "英国报姐";
            star = 0;
            "statuses_count" = 3678;
            urank = 22;
            url = "";
            verified = 1;
            "verified_contact_email" = "";
            "verified_contact_mobile" = "";
            "verified_contact_name" = "";
            "verified_level" = 3;
            "verified_reason" = "微博知名中英文化自由撰稿人";
            "verified_reason_modified" = "";
            "verified_reason_url" = "";
            "verified_source" = "";
            "verified_source_url" = "";
            "verified_state" = 0;
            "verified_trade" = 3370;
            "verified_type" = 0;
            weihao = "";
        };
        visible = {
            "list_id" = 0;
            type = 0;
        };
    };
}
 
 */

@interface YCLStatus : NSObject
/** 微博创建时间 */
@property (copy, nonatomic) NSString *created_at;
/** 字符串型的微博ID */
@property (copy, nonatomic) NSString *idstr;
/** 微博信息内容 */
@property (copy, nonatomic) NSString *text;
/** 微博来源 */
@property (copy, nonatomic) NSString *source;
/** 缩略图片地址 */
@property (copy, nonatomic) NSString *thumbnail_pic;
/** 微博作者 */
@property (strong, nonatomic) YCLUser *user;
/** 被转发的原微博 */
@property (strong, nonatomic) YCLStatus *retweeted_status;
/** 转发数 */
@property (assign, nonatomic) int reposts_count;
/** 评论数 */
@property (assign, nonatomic) int comments_count;
/** 表态数 */
@property (assign, nonatomic) int attitudes_count;
/** 微博配图ID  保存 YCLPicture 对象 */
@property (strong, nonatomic) NSArray *pic_urls;


//+ (instancetype)statusWithDictionary:(NSDictionary *)dict;
@end
