//
//  UIView+YWShowAction.m
//  YQSearch
//
//  Created by yunqi on 16/8/13.
//  Copyright © 2016年 yunqi. All rights reserved.
//

#import "UIView+YWShowAction.h"
@implementation UIView (YWShowAction)
-(void)showAcition
{
    [self showActionInView:self message:nil image:nil];
}
-(void)hidenAction
{
    [MBProgressHUD hideHUDForView:self animated:YES];
}
-(void)showActionInView:(UIView *)view message:(NSString *)message image:(NSString *)image
{
    [view hidenAction];
    MBProgressHUD  *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = message;
    hud.removeFromSuperViewOnHide = YES;
    hud.dimBackground = NO;
}

-(void)showMessage:(NSString *)message
{
    [self show:message icon:nil view:nil image:nil during:1];
}


- (void)show:(NSString*)text icon:(NSString*)icon view:(UIView*)view image:(NSString*)image during:(float)during
{
    if (view == nil)
        view = [[UIApplication sharedApplication].windows lastObject];
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = text;
    
    if (icon) {
        hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    }
    else if (image) {
        hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:image ? image : @"mark"]];
    }
    hud.mode = MBProgressHUDModeCustomView;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:during];
}

@end
