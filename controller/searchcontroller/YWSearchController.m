//
//  YWSearchController.m
//  YQSearch
//
//  Created by yunqi on 16/8/13.
//  Copyright © 2016年 yunqi. All rights reserved.
//

#import "YWSearchController.h"
#import "YWSearchTitleModel.h"
#import "YWSearchCell.h"
#import "YWBaseModel.h"
#import "YWSearchNewModel.h"
#import "YWSearchFindModel.h"
#import "YWWebController.h"
@interface YWSearchController ()<UITableViewDelegate,UITableViewDataSource,YWSearchCellDelegate>
{
    YWSearchTitleModel *newModel;
    YWSearchTitleModel *findModel;
    NSString *searchCount;
    NSMutableArray *fencis;
    //ddd
    //cccc
}
PROPERTY_STRONG UITableView *mtableView;
PROPERTY_STRONG NSMutableArray *list;
@end

@implementation YWSearchController

- (void)viewDidLoad {
    self.title=@"搜索结果";
    fencis=[[NSMutableArray alloc]init];
    self.list=[[NSMutableArray alloc]init];
    _mtableView=[[UITableView alloc]init];
    _mtableView.backgroundColor=[UIColor clearColor];
    

    _mtableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _mtableView.contentInset=UIEdgeInsetsMake(0, 0, 0, 0);
    _mtableView.delegate=self;
    _mtableView.dataSource=self;
    [self.view addSubview:_mtableView];
    [super viewDidLoad];
//    self.keyWorld=@"日本";
    [self.mtableView addHeaderWithTarget:self action:@selector(loadData)];
    [self.mtableView addFooterWithTarget:self action:@selector(loadMore)];
    self.mtableView.footerHidden=YES;
//    [self.mtableView headerBeginRefreshing];
    newModel=[[YWSearchTitleModel alloc]init];
    findModel=[[YWSearchTitleModel alloc]init];
    newModel.list=[[NSMutableArray alloc]init];
    findModel.list=[[NSMutableArray alloc]init];
    newModel.searchType=YWSearchType_new;
    findModel.searchType=YWSearchType_find;
    newModel.title=@"最新消息:";
    findModel.title=@"您是不是想找:";
    [self.view showAcition];
    [self loadSearchKey:self.keyWorld page:1 loadOther:YES];
    // Do any additional setup after loading the view.
}
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    _mtableView.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}
-(void)loadAllOther
{
    [newModel.list removeAllObjects];
    [findModel.list removeAllObjects];
    [fencis removeAllObjects];
    [self loadOther];
    [self loadFind];
    [self loadFenCi];
}
-(void)loadMore
{
    [self loadSearchKey:self.keyWorld page:[self pageNumber] loadOther:NO];
}
-(void)loadData
{
        [self loadSearchKey:self.keyWorld page:1 loadOther:NO];
}
-(YWSearchTitleModel *)titleModelWithIndex:(NSInteger)index
{
    if (self.list.count>index) {
        return [self.list objectAtIndex:index];
    }
    return nil;
}
-(YWBaseModel *)modelVithIndex:(YWSearchTitleModel *)titleModel index:(NSInteger)index
{
    if (titleModel.list.count>index) {
        return [titleModel.list objectAtIndex:index];
    }
    return nil;
}
-(NSInteger)pageNumber
{
    NSInteger number=0;
    for (YWSearchTitleModel *model in self.list) {
        if (model.searchType==YWSearchType_search) {
            number+=model.list.count;
        }
    }
    return (number/10+1);
}

-(void)changeDataList
{
    if (![self.list containsObject:findModel]&&findModel.list.count) {
        [self.list insertObject:findModel atIndex:0];
    }
    NSInteger index=NSNotFound;
    if (![self.list containsObject:newModel]&&newModel.list.count) {
        for (YWSearchTitleModel *model in self.list) {
            if (model.searchType==YWSearchType_search) {
                index=[self.list indexOfObject:model];
            }
        }
        if (index!=NSNotFound) {
            [self.list insertObject:newModel atIndex:index];
        }
    }
    [self.mtableView reloadData];
}
-(void)changeDataWithNew:(NSArray *)resposeL
{
//    YWSearchNewModel
    for (NSDictionary *dic in resposeL) {
        YWSearchNewModel *model=[[YWSearchNewModel alloc]initWithDataDic:dic];
        [newModel.list addObject:model];
    }
    [self changeDataList];
}
-(void)changeDataWithFine:(NSArray *)resposel
{
    NSMutableArray *strings=[NSMutableArray array];
    for (NSString *str in resposel) {
        [strings addObject:str];
    }
    YWSearchFindModel *model=[[YWSearchFindModel alloc]init];
    model.title=[strings componentsJoinedByString:@"^"];
    [findModel.list addObject:model];
    [self changeDataList];
}
-(void)changeDataWithFenci:(NSArray *)resposel
{
    if (resposel.count) {
        [fencis addObjectsFromArray:resposel];
        [self.mtableView reloadData];
    }
    
}
-(void)loadOther
{
    YWWeak(self,weakSelf);
    [[YWSubHttp share]loadSerchNew:self.keyWorld CompletionHandle:^(id responseDic) {
        if (responseDic&&[responseDic isKindOfClass:[NSArray class]]) {
            [weakSelf changeDataWithNew:responseDic];
        }
        [weakSelf.view hidenAction];
    }];
}
-(void)loadFind
{
    YWWeak(self,weakSelf);
    [[YWSubHttp share]loadSearchFind:self.keyWorld CompletionHandle:^(id responseDic) {
        if (responseDic&&[responseDic isKindOfClass:[NSArray class]]) {
            [weakSelf changeDataWithFine:responseDic];
        }
//        [weakSelf.view hidenAction];
    }];
}
-(void)loadFenCi
{
    YWWeak(self, weakself);
    [[YWSubHttp share]loadFenCi:self.keyWorld CompletionHandle:^(id responseDic) {
        if ([responseDic isKindOfClass:[NSDictionary class]]) {
            NSArray *fenciddd=[responseDic objectForKey:@"data"];
            if (fenciddd&&[fenciddd isKindOfClass:[NSArray class]]) {
                [weakself changeDataWithFenci:fenciddd];
            }
        }
    }];
}
-(YWSearchTitleModel *)lastTitlModel
{
    YWSearchTitleModel *model=self.list.lastObject;
    if ([model isKindOfClass:[YWSearchTitleModel class]]&&model.searchType==YWSearchType_search) {
    
        return self.list.lastObject;
    }
    return nil;
}
-(void)requestData:(id)responseD
{
    if (responseD&&[responseD isKindOfClass:[NSDictionary class]]&&[responseD objectForKey:@"data"]) {
        NSArray *datas=[responseD objectForKey:@"data"];
        NSString *total=[responseD objectForKey:@"total"];
        if ([total isKindOfClass:[NSNull class]]) {
            total=nil;
        }
        if ([datas isKindOfClass:[NSArray class]]&&datas.count) {
            
            NSMutableArray *listvalue=[[NSMutableArray alloc]init];
            for (NSDictionary *dic in datas) {
                YWSearchModel *model=[[YWSearchModel alloc]initWithDataDic:dic];
                [listvalue addObject:model];
            }
            if ([self lastTitlModel]) {
                [[self lastTitlModel].list addObjectsFromArray:listvalue];
            }else
            {
                YWSearchTitleModel *titleModel=[[YWSearchTitleModel alloc]init];
                titleModel.title=total.length?[NSString stringWithFormat:@"搜索结果: %@ 条",total]:@"搜索结果";
                searchCount=total;
                titleModel.list=[NSMutableArray arrayWithObject:listvalue.firstObject];
                titleModel.searchType=YWSearchType_search;
                [self.list addObject:titleModel];
                [listvalue removeObjectAtIndex:0];
                
                YWSearchTitleModel *titleModel1=[[YWSearchTitleModel alloc]init];
                titleModel1.list=listvalue;
//                titleModel1.title=@"其他";
                titleModel1.searchType=YWSearchType_search;
                [self.list addObject:titleModel1];
            }
            self.mtableView.footerHidden=datas.count<10?YES:NO;
        }
        [self.mtableView reloadData];
    }else
    {
        self.mtableView.footerHidden=YES;
        [self.view showMessage:@"请求失败"];
    }
}
-(void)loadSearchKey:(NSString *)key page:(NSInteger)page loadOther:(BOOL)loadOther
{
    if (loadOther) {
        [self loadAllOther];
    }
    YWWeak(self,weakSelf);
    [[YWSubHttp share]loadSerch:key page:page CompletionHandle:^(id  responseDic) {
        [self.view hidenAction];
        if (page==1) {
            [weakSelf.list removeAllObjects];
        }
        [weakSelf requestData:responseDic];
        if (loadOther) {
            [self changeDataList];
        }
        [weakSelf endReFreshing];
    }];
}
-(void)loadWebUrl:(NSString *)url title:(NSString *)title
{
    YWWebController *webController=[[YWWebController alloc]init];
    webController.urlString=url;
    [self.navigationController pushViewController:webController animated:YES];
}
-(void)endReFreshing
{
    [self.mtableView headerEndRefreshing];
    [self.mtableView footerEndRefreshing];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self titleModelWithIndex:section].list.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.list.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return ([self titleModelWithIndex:section].title.length?34:1);
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [YWSearchCell heightWithModel:[self modelVithIndex:[self titleModelWithIndex:indexPath.section] index:indexPath.row]];
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    YWSearchTitleModel *Model=[self titleModelWithIndex:section];
    if (Model.title.length==0) {
        return [[UIView alloc]init];
    }
    UIView *view=[[UIView alloc]init];
    view.backgroundColor=UIColorFromRGB(243, 243, 243);
    view.frame=CGRectMake(0, 0, self.view.frame.size.width, 35);
    
    NSMutableAttributedString *att=[Model.title attributedStringFromStingWithFont:[UIFont boldSystemFontOfSize:15] withLineSpacing:2];
    [att setTextColorWithAttName:[UIColor blueColor] range:NSMakeRange(0, att.string.length)];
    if (searchCount.length&&[att.string rangeOfString:searchCount].length!=0) {
        [att setTextColorWithAttName:[UIColor greenColor] range:[att.string rangeOfString:searchCount]];
    }
    UILabel *label=[[UILabel alloc]init];
    label.font=[UIFont boldSystemFontOfSize:15];
    label.attributedText=att;
//    label.textColor=[UIColor blueColor];
    label.frame=CGRectMake(15, 0, self.view.frame.size.width-30, view.frame.size.height);
    [view addSubview:label];
    return view;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YWSearchCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell=[[YWSearchCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.backgroundColor=UIColorFromRGB(243, 243, 243);
        cell.delegate=self;
    }

    [cell resetValue:[self modelVithIndex:[self titleModelWithIndex:indexPath.section] index:indexPath.row] key:self.keyWorld fenci:fencis] ;
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YWBaseModel*model= [self modelVithIndex:[self titleModelWithIndex:indexPath.section] index:indexPath.row];
    if ([model isKindOfClass:[YWSearchModel class]]) {
        YWSearchModel *searchModel=(YWSearchModel *)model;
        [self loadWebUrl:searchModel.url title:nil];
    }
    if ([model isMemberOfClass:[YWSearchNewModel class]]) {
        YWSearchNewModel *nModel=(YWSearchNewModel *)model;
        [self loadWebUrl:nModel.link title:nil];
    }
}
-(void)YWSearchCellFindClickIndex:(NSInteger)index cell:(YWSearchCell *)cell
{
    NSIndexPath *indexPath=[self.mtableView indexPathForCell:cell];
    YWSearchTitleModel *model=[self titleModelWithIndex:indexPath.section];
    if (model.searchType==YWSearchType_find) {
        YWSearchFindModel *findM=[model.list objectAtIndex:indexPath.row];
        NSString *str =[[findM.title componentsSeparatedByString:@"^"]objectAtIndex:index];
        [self.view showAcition];
        self.keyWorld=str;
        [self loadSearchKey:self.keyWorld page:1 loadOther:YES];
    }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
