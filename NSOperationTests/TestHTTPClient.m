//
//  TestHTTPClient.m
//  NSOperationTests
//
//  Created by Tingwei Hsu on 2018/9/17.
//  Copyright © 2018年 Tingwei Hsu. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "HTTPClient.h"

@interface TestHTTPClient : XCTestCase
@property (nonatomic,strong) HTTPClient *client;
@end

@implementation TestHTTPClient

- (void)setUp
{
    [super setUp];
    self.client = [HTTPClient sharedInstance];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    self.client = nil;
}

- (void)testServerGetEndpoint
{
    XCTestExpectation *expectation = [self expectationWithDescription:@"Response Expectation"];
    [self.client fetchGetResponseWithCallback:^(NSDictionary *dict, NSError *error) {
        XCTAssertNotNil(dict);
        XCTAssertNil(error);
        XCTAssertTrue([[dict valueForKey:@"url"] isEqualToString:@"https://httpbin.org/get"]);
        
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:30.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];

}

- (void)testServerPostEndpoint
{
    NSString *stubCustName = @"BigRootTest";
    XCTestExpectation *expectation = [self expectationWithDescription:@"Response Expectation"];
    [self.client postCustomerName:stubCustName callback:^(NSDictionary *dict, NSError *error) {
        XCTAssertNotNil(dict);
        XCTAssertNil(error);
        NSDictionary *formDict = [dict valueForKey:@"form"];
        XCTAssertNotNil(formDict);
        XCTAssertEqual([formDict valueForKey:@"custname"], stubCustName);
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:30.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
}

- (void)testServerImageEndpoint
{
    XCTestExpectation *expectation = [self expectationWithDescription:@"Response Expectation"];
    [self.client fetchImageWithCallback:^(UIImage *image, NSError *error) {
        XCTAssertNotNil(image);
        XCTAssertTrue([image isKindOfClass:[UIImage class]]);
        XCTAssertNil(error);
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:30.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
}

@end
