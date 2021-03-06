//
//  DDTag.h
//  DDCampus
//
//  Created by wu on 16/8/12.
//  Copyright © 2016年 campus. All rights reserved.
//

#ifndef DDTag_h
#define DDTag_h

static NSInteger const Login_Tag = 1001;
static NSInteger const Advise_Tag = 1002;
static NSInteger const EditPass_Tag = 1003;
static NSInteger const EditNickName_Tag = 1004;

static NSInteger const Getmyhomework_Tag = 2001;
static NSInteger const Do_homeworkdone_Tag = 2002;
static NSInteger const Gethomeworkdetail_Tag = 2003;
static NSInteger const Gethomeworkdone_Tag = 2004;

static NSInteger const Getinfo_Tag = 3001;

static NSInteger const Index_Tag = 4001;
static NSInteger const Do_notice_Tag= 4002;
static NSInteger const Do_homework_Tag = 4003;
static NSInteger const Do_forumreply_Tag = 4004;
static NSInteger const Do_forumpostlike_Tag = 4005;
static NSInteger const Getnotice_Tag= 4006;
static NSInteger const Getindexreddot_Tag= 4007;

//事务
static NSInteger const Getdutyday_Tag = 5001;
static NSInteger const Getclassweekpoint_Tag = 5002;
static NSInteger const Showdutyday_Tag = 5003;
static NSInteger const Do_savedutyday_Tag = 5004;
static NSInteger const Getteacherclass_Tag = 5005;
static NSInteger const Getdutyweekset_tag = 5006;
static NSInteger const Getdutyweek_Tag = 5007;
static NSInteger const Getstudent_Tag = 5008;
static NSInteger const Getdutyweekcutset_Tag = 5009;
static NSInteger const Getgradeweekpoint_Tag = 5010;
static NSInteger const Do_dutyweek_Tag = 5011;
static NSInteger const Do_dutyweekcut_Tag = 5012;
//社区
static NSInteger const Getforumpost_Tag = 6001;
static NSInteger const Do_forumpost_Tag = 6002;
static NSInteger const Do_savegroup_Tag = 6003;
static NSInteger const Getreviewgroupuser_Tag = 6004;
static NSInteger const Do_reviewgroupuser_Tag = 6005;
static NSInteger const Getgrouplist_Tag = 6006;
static NSInteger const Do_groupnotice_Tag = 6007;
static NSInteger const Do_joingroup_Tag = 6008;
static NSInteger const Getgroupdata_Tag = 6009;
static NSInteger const Do_delgroupuser_Tag = 6010;
static NSInteger const Getgroupuserlist_Tag = 6011;
static NSInteger const Do_admingroup_Tag = 6012;
static NSInteger const Do_grouplogout_Tag = 6013;
static NSInteger const Do_transfergroup_Tag = 6014;

//成绩
static NSInteger const Getscore_Tag = 7001;
static NSInteger const Getscoretrend_Tag = 7002;
static NSInteger const Getscoredetail_Tag = 7003;
static NSInteger const Getclassscore_Tag=7004;
static NSInteger const Getsubjecttrend_Tag = 7005;
static NSInteger const Getclassscoretrend_tag = 7006;
static NSInteger const Getteachermulti_Tag = 7009;
static NSInteger const Do_scoretheme_Tag = 7010;
static NSInteger const Do_score_Tag = 7011;
static NSInteger const Getclasssubjecttrend_Tag = 7012;

//个人中心
static NSInteger const Logout_Tag = 8001;
static NSInteger const Do_saveheadpic_Tag = 8002;
static NSInteger const Getagreement_Tag = 8003;
static NSInteger const Gethelplist_Tag = 8004;
static NSInteger const Getversionupgrade_Tag = 8005;
#endif /* DDTag_h */
