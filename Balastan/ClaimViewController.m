//
//  RequestViewController.m
//  Balastan
//
//  Created by Avaz on 19.08.16.
//  Copyright © 2016 Balastan. All rights reserved.
//

#import "ClaimViewController.h"
#import "APIClient.h"
#import <KVNProgress.h>

@interface ClaimViewController ()<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextField *numberTextField;
@property (strong, nonatomic) APIClient* apiInteractor;
@end

@implementation ClaimViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_nameTextField becomeFirstResponder];

    self.apiInteractor = [APIClient new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sendClaim:(id)sender {
    [self.view endEditing:YES];

    if ([_nameTextField.text length] > 0 && [_numberTextField.text length] > 8 ) {

        [KVNProgress showWithStatus:@"Жиберүү"];
        
        [self.apiInteractor postClaimWithName:_nameTextField.text
                                  phoneNumber:_numberTextField.text
                                   complition:^(NSArray *result) {
                                        KVNProgressConfiguration *configuration =
                                       [[KVNProgressConfiguration alloc] init];
                                       [configuration setMinimumSuccessDisplayTime:10];
                                       [KVNProgress setConfiguration: configuration];
                                       [KVNProgress showSuccessWithStatus:@"Сиз “Баластан” балдар журналына абонент болдуңуз. Журналдын кызматкерлери сиз менен байланышат. Ыраазычылык билдиребиз."
                                                               completion:^{
                                                                   [self.navigationController popViewControllerAnimated:YES];

                                                               }];
                                       
                                       
                                   } error:^(NSError *error) {
                                       [KVNProgress showError];
                                       [KVNProgress dismiss];
                                       
                                   }];


    } else {
        if ([_nameTextField.text length] < 1) {
            [KVNProgress showErrorWithStatus:@"Бош уячалалар калды"
                                  completion:^{
                                      [_nameTextField becomeFirstResponder];
                                  }];
            
        } else if ([_numberTextField.text length] < 9){
            [KVNProgress showErrorWithStatus:@"Номериңизди толук жазыңыз"
                                  completion:^{
                                      [_numberTextField becomeFirstResponder];
                                  }];
        }     }
    
    
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField{
   // [textField resignFirstResponder];
    [_numberTextField becomeFirstResponder];

    return YES;
}

@end
