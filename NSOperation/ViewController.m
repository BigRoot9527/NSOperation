//
//  ViewController.m
//  NSOperation
//
//  Created by Tingwei Hsu on 2018/9/14.
//  Copyright © 2018年 Tingwei Hsu. All rights reserved.
//

#import "ViewController.h"
#import "HTTPClient.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *httpImage;
@property (weak, nonatomic) IBOutlet UILabel *httpProgressLabel;

@property (strong, nonatomic) HTTPClient *client;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.client = [HTTPClient sharedInstance];
}

- (IBAction)didTapLoadImageButton:(UIButton *)sender
{
    [self.client fetchImageWithCallback:^(UIImage *image, NSError *error) {
        NSLog(@"ImageError: %@", [error localizedDescription]);
        [self.httpImage setImage:image];
    }];
}

- (IBAction)didTapPOSTButton:(UIButton *)sender
{
    [self.client postCustomerName:@"BigRoot" callback:^(NSDictionary *dict, NSError *error) {
        NSLog(@"Dict: %@",dict);
        NSLog(@"POSTError: %@",error);
    }];
}
- (IBAction)didTapGETButton:(UIButton *)sender
{
    [self.client fetchGetResponseWithCallback:^(NSDictionary *dict, NSError *error) {
        NSLog(@"Dict: %@",dict);
        NSLog(@"GETError: %@",error);
    }];
}

- (IBAction)didTapLoadAllButton:(UIButton *)sender
{
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
