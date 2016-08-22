//
//  YWSearchCell.m
//  YQSearch
//
//  Created by yunqi on 16/8/14.
//  Copyright © 2016年 yunqi. All rights reserved.
//

#import "YWSearchCell.h"
#import "YWSearchModel.h"
#import "YWSearchNewModel.h"
#import "YWSearchFindModel.h"
@interface YWSearchCell()
{
    UILabel *titileLabel;
    UILabel *descLabel;
    NSString *keyV;
    UIView *btnViews;
}
PROPERTY_STRONG UIView *lineView;
@end
@implementation YWSearchCell
- (instancetype)init
{
    self = [super init];
    if (self) {
    
    }
    return self;
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.lineView=[[UIView alloc]init];
        self.lineView.backgroundColor=UIColorFromRGB(170, 170, 170);
        [self.contentView addSubview:self.lineView];
        titileLabel=[[UILabel alloc]init];
        titileLabel.font=[UIFont systemFontOfSize:17];
        titileLabel.backgroundColor=[UIColor clearColor];
        titileLabel.textColor=[UIColor blueColor];
        titileLabel.numberOfLines=1;
        [self.contentView addSubview:titileLabel];
        
        descLabel=[[UILabel alloc]init];
        descLabel.backgroundColor=[UIColor clearColor];
        descLabel.font=[UIFont systemFontOfSize:14];
        descLabel.numberOfLines=0;
        [self.contentView addSubview:descLabel];
        
        btnViews=[[UIView alloc]init];
        btnViews.backgroundColor=[UIColor clearColor];
        [self.contentView addSubview:btnViews];
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.lineView.frame=CGRectMake(0, self.frame.size.height-0.5, self.frame.size.width, 0.5);
}
-(void)resetFenci:(NSArray *)list att:(NSMutableAttributedString *)att
{
    if (list&&list.count) {
        for (NSString *str in list) {
            if ([att.string rangeOfString:str].length!=0) {
                [att setTextColorWithAttName:[UIColor redColor] range:[att.string rangeOfString:str]];
            }
        }
    }
}
-(void)resetValue:(YWBaseModel *)model key:(NSString *)key fenci:(NSMutableArray *)listfenci;
{
    for (UIView *view in btnViews.subviews) {
        [view removeFromSuperview];
    }
    keyV=key;
    titileLabel.attributedText=nil;
    descLabel.attributedText=nil;
    descLabel.text=nil;
    titileLabel.text=nil;
    descLabel.textAlignment=NSTextAlignmentLeft;
    titileLabel.textAlignment=NSTextAlignmentLeft;
    if ([model isMemberOfClass:[YWSearchModel class]]) {
        YWSearchModel *searchModel=(YWSearchModel *)model;
        NSMutableAttributedString *attTitle=[searchModel.title attributedStringFromStingWithFont:[UIFont systemFontOfSize:17] withLineSpacing:2];
        [attTitle setTextColor:[UIColor blueColor]];
        [attTitle setTextColorWithAttName:[UIColor redColor] range:[searchModel.title rangeOfString:key]];
        [attTitle setUnderlineStyle:kCTUnderlineStyleSingle modifier:kCTUnderlinePatternSolid];
        [self resetFenci:listfenci att:attTitle];
        titileLabel.frame=CGRectMake(15, 0, APP_SCREEN_WIDTH-30, 40);
        titileLabel.attributedText=attTitle;
//        titileLabel.text=searchModel.title;
        if (searchModel.des.length) {
            NSMutableAttributedString *attDes=[searchModel.des attributedStringFromStingWithFont:[UIFont systemFontOfSize:14] withLineSpacing:2];
            [attDes setTextColor:[UIColor blueColor]];
            [self resetFenci:listfenci att:attDes];
            CGSize size=[searchModel.des boundingRectWithSize:CGSizeMake(APP_SCREEN_WIDTH-30, MAXFLOAT) withTextFont:[UIFont systemFontOfSize:14 ] withLineSpacing:2];
            descLabel.attributedText=attDes;
//            descLabel.text=searchModel.des;
            descLabel.frame=CGRectMake(titileLabel.frame.origin.x, titileLabel.frame.size.height+titileLabel.frame.origin.y, titileLabel.frame.size.width, size.height);
        }
    }
    if ([model isMemberOfClass:[YWSearchFindModel class]]) {
//        YWSearchFindModel* findModel=(YWSearchFindModel *)model;
//            NSMutableAttributedString *attTitle=[findModel.title attributedStringFromStingWithFont:[UIFont systemFontOfSize:15] withLineSpacing:2];
//        [attTitle setTextColorWithAttName:[UIColor redColor] range:NSMakeRange(0, findModel.title.length)];
//        titileLabel.attributedText=attTitle;
//        titileLabel.frame=CGRectMake(15, 0, APP_SCREEN_WIDTH-30, 30);
        YWSearchFindModel *findModel=(YWSearchFindModel *)model;
        NSArray *list=[findModel.title componentsSeparatedByString:@"^"];
        float maxWidth=APP_SCREEN_WIDTH-30;
        float margin=20;
        float leftMargin=0;
        float Btnheigth=30;
        float x=leftMargin;
        float y=0;
        for (NSString *str in list) {
            CGSize size=[str boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) withTextFont:[UIFont systemFontOfSize:14] withLineSpacing:2];
            if (x+margin+leftMargin+size.width<maxWidth) {
                
            }else
            {
                x=leftMargin;
                y+=Btnheigth;
            }
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitle:str forState:UIControlStateNormal];
//            btn.backgroundColor=[UIColor yellowColor];
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            btn.titleLabel.font=[UIFont systemFontOfSize:14];
            [btn addTarget:self action:@selector(clickTagIndex:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag=100+[list indexOfObject:str];
            btn.frame=CGRectMake(x, y, size.width, Btnheigth);
            [btnViews addSubview:btn];
            x=(btn.frame.size.width+btn.frame.origin.x+margin);
            btnViews.frame=CGRectMake(15, 0, maxWidth, btn.frame.size.height+btn.frame.origin.y);
        }
    }
    if ([model isMemberOfClass:[YWSearchNewModel class]]) {
        YWSearchNewModel *newModel=(YWSearchNewModel *)model;
        descLabel.textAlignment=NSTextAlignmentRight;
        NSMutableAttributedString *attTitle=[newModel.title attributedStringFromStingWithFont:[UIFont systemFontOfSize:17] withLineSpacing:2];
        [attTitle setTextColor:[UIColor blueColor]];
        [attTitle setTextColorWithAttName:[UIColor redColor] range:[newModel.title rangeOfString:key]];
        [self resetFenci:listfenci att:attTitle];
        titileLabel.attributedText=attTitle;
        titileLabel.frame=CGRectMake(15, 0, APP_SCREEN_WIDTH-30, 40);
        
        CGSize sizeDes=[newModel.source boundingRectWithSize:CGSizeMake(1000, 1000) withTextFont:descLabel.font withLineSpacing:1];
        NSMutableAttributedString *attDes=[newModel.source attributedStringFromStingWithFont:descLabel.font withLineSpacing:1];
        [self resetFenci:listfenci att:attDes];
        descLabel.frame=CGRectMake(APP_SCREEN_WIDTH-15-sizeDes.width, titileLabel.frame.origin.y, sizeDes.width, titileLabel.frame.size.height);
        descLabel.attributedText=attDes;
        titileLabel.frame=CGRectMake(titileLabel.frame.origin.x, titileLabel.frame.origin.y, descLabel.frame.origin.x-titileLabel.frame.origin.x-15, titileLabel.frame.size.height);
    }
}
-(void)clickTagIndex:(UIButton *)btn
{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(YWSearchCellFindClickIndex:cell:)]) {
        [self.delegate YWSearchCellFindClickIndex:btn.tag-100 cell:self];
    }
}
+(float)heightWithModel:(YWBaseModel *)model
{
    float heigth=0;
    if ([model isMemberOfClass:[YWSearchModel class]])
    {
        YWSearchModel *searchModel=(YWSearchModel *)model;
        heigth=40;
        if (searchModel.des.length) {
            CGSize size=[searchModel.des boundingRectWithSize:CGSizeMake(APP_SCREEN_WIDTH-30, MAXFLOAT) withTextFont:[UIFont systemFontOfSize:14 ] withLineSpacing:2];
            heigth+=(size.height+10);

        }
    }
    if ([model isMemberOfClass:[YWSearchFindModel class]]) {
        YWSearchFindModel *findModel=(YWSearchFindModel *)model;
        NSArray *list=[findModel.title componentsSeparatedByString:@"^"];
        float maxWidth=APP_SCREEN_WIDTH-30;
        float margin=20;
        float leftMargin=0;
        float Btnheigth=30;
        float x=leftMargin;
        heigth=Btnheigth;
        for (NSString *str in list) {
            CGSize size=[str boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) withTextFont:[UIFont systemFontOfSize:14] withLineSpacing:2];
            if (x+margin+leftMargin+size.width<maxWidth) {
                
            }else
            {
                x=leftMargin;
                heigth+=Btnheigth;;
            }
            x+=(margin+size.width);
        }
    }
    if ([model isMemberOfClass:[YWSearchNewModel class]]) {
        heigth=40;
    }
    return heigth;
}
@end
