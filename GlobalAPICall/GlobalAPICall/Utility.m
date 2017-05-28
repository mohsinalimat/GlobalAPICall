//
//  Utility.m
//  GlobalAPICall
//
//  Created by Ravi Dhorajiya on 28/05/17.
//  Copyright © 2017 Ravi Dhorajiya. All rights reserved.
//

#import "Utility.h"

@implementation Utility

//Show progress
+ (void)ShowProgress
{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD showWithStatus:@"Please wait.."];
}

//Hide progress
+ (void)hideProgress
{
    [SVProgressHUD dismiss];
}


@end
