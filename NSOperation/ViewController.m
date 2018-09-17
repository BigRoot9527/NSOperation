//
//  ViewController.m
//  NSOperation
//
//  Created by Tingwei Hsu on 2018/9/14.
//  Copyright © 2018年 Tingwei Hsu. All rights reserved.
//

#import "ViewController.h"
#import "HTTPClient.h"
#import "HTTPBinManager.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *httpImage;
@property (weak, nonatomic) IBOutlet UILabel *httpProgressLabel;
@property (weak, nonatomic) IBOutlet UILabel *responseInfoLabel;
@property (weak, nonatomic) IBOutlet UIButton *loadAllButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
//For HW1 only
@property (strong, nonatomic) HTTPClient *client;
//For HW2 only
@property (strong, nonatomic) HTTPBinManager *manager;
@end

@interface ViewController(HTTPBinManagerDelegate)<HTTPBinManagerDelegate>
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.client = [HTTPClient sharedInstance];
    self.manager = [HTTPBinManager sharedInstance];
    self.manager.delegate = self;
    [self.loadAllButton setEnabled:YES];
    [self.cancelButton setEnabled:NO];
}

- (IBAction)didTapLoadImageButton:(UIButton *)sender
{
    [self _resetLabelAndImage];
    [self.client fetchImageWithCallback:^(UIImage *image, NSError *error) {
        NSLog(@"ImageError: %@", [error localizedDescription]);
        [self.httpImage setImage:image];
    }];
}

- (IBAction)didTapPOSTButton:(UIButton *)sender
{
    [self _resetLabelAndImage];
    [self.client postCustomerName:@"BigRoot" callback:^(NSDictionary *dict, NSError *error) {
        NSLog(@"Dict: %@",dict);
        NSLog(@"POSTError: %@",error);
    }];
}

- (IBAction)didTapGETButton:(UIButton *)sender
{
    [self _resetLabelAndImage];
    [self.client fetchGetResponseWithCallback:^(NSDictionary *dict, NSError *error) {
        NSLog(@"Dict: %@",dict);
        NSLog(@"GETError: %@",error);
    }];
}

- (IBAction)didTapLoadAllButton:(UIButton *)sender
{
    [self _resetLabelAndImage];
    self.httpProgressLabel.text = @"Loading......";
    [self.manager executeOperation];
}

- (IBAction)didTapCancelButton:(UIButton *)sender
{
    [self.manager cancelOperation];
}

- (void)_resetLabelAndImage
{
    self.httpProgressLabel.text = nil;
    self.responseInfoLabel.text = nil;
    [self.httpImage setImage:nil];
}

@end

@implementation ViewController(HTTPBinManagerDelegate)

- (void)managerDidStartOperation:(HTTPBinManager *)manager {
    [self.loadAllButton setEnabled:NO];
    [self.cancelButton setEnabled:YES];
}

- (void)manager:(HTTPBinManager *)manager didEndCurrentOperationWithError:(NSError *)error {
    [self.loadAllButton setEnabled:YES];
    [self.cancelButton setEnabled:NO];
    self.responseInfoLabel.text = [error debugDescription];
    self.httpProgressLabel.text = @"Stop";
}


- (void)manager:(HTTPBinManager *)manager didFinishCurrentOperationWithGetDict:(NSDictionary *)getDict andPostDict:(NSDictionary *)postDict andImage:(UIImage *)image {
    [self.loadAllButton setEnabled:YES];
    [self.cancelButton setEnabled:NO];
    NSLog(@"PostResponse: %@",postDict);
    NSLog(@"GetResponse: %@",getDict);
    [self.httpImage setImage:image];
    self.httpProgressLabel.text = @"Done";
}


- (void)manager:(HTTPBinManager *)manager didUpdateCurrentLoadingProgressPercentage:(NSInteger)percentage {
    self.httpProgressLabel.text = [NSString stringWithFormat:@"Loading......%ld / 100", (long)percentage];
}


@end
