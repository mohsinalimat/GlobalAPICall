//
//  ViewController.m
//  GlobalAPICall
//
//  Created by Ravi Dhorajiya on 28/05/17.
//  Copyright © 2017 Ravi Dhorajiya. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    __weak IBOutlet UITextView *txtView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
#pragma mark - POST METHOD
- (IBAction)btnPostMethod:(id)sender
{
    NSDictionary *dict = @{};   //Pass Required Perameter. Exp : @{@"key":@"value",@"key1":@"value1"}
    NSString *strURL = @"";     //Add URL. Exp : @"http://..."
    
    [WebService callApiWithParameters:dict apiName:strURL type:POST_REQUEST loader:YES responseData:^(NSDictionary *response, NSError *error)
    {
        if (response != nil)
        {
            txtView.text = [NSString stringWithFormat:@"%@",response.description];
        }
        
        if (error != NULL)
        {
            txtView.text = [NSString stringWithFormat:@"%@",error.description];
        }
    }];
}

#pragma mark - GET METHOD
- (IBAction)btnGetMethod:(id)sender
{
    NSDictionary *dict = @{};   //Pass NIL perameter because API call in GET Method.
    NSString *strURL = @"";     //Add URL. Exp : @"http://..."
    
    [WebService callApiWithParameters:dict apiName:strURL type:GET_REQUEST loader:YES responseData:^(NSDictionary *response, NSError *error)
     {
         if (response != nil)
         {
             txtView.text = [NSString stringWithFormat:@"%@",response.description];
         }
         
         if (error != NULL)
         {
             txtView.text = [NSString stringWithFormat:@"%@",error.description];
         }
     }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
