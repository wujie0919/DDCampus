//
//  DDNoSubmitInfoView.h
//  DDCampus
//
//  Created by wu on 16/8/27.
//  Copyright © 2016年 campus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CallStudentPhoneBlock)(NSDictionary *data);

@interface DDNoSubmitInfoView : UIView<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *unSubmitCollectionView;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (nonatomic, copy) NSArray *array;
@property (nonatomic, assign) CGFloat height;
@property (weak, nonatomic) IBOutlet UILabel *lineLabel;
@property (nonatomic, copy) CallStudentPhoneBlock callBlock;
@end
