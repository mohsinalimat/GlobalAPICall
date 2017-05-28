# GlobalAPICall

Create global function for API calling of GET and POST method.
# JUST CALL THIS METHOD 
POST METHOD
```
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
```
GET METHOD

```
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
```
