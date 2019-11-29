//
//  BWGCDViewController.m
//  BasicW
//
//  Created by 小李 on 2019/11/14.
//  Copyright © 2019 lyl. All rights reserved.
//

#import "BWGCDViewController.h"

@interface BWGCDViewController ()
@property (nonatomic, strong) NSMutableArray *products;

@end

@implementation BWGCDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.products = [NSMutableArray array];
//    dispatch_queue_t queue = dispatch_queue_create("testQ", NULL);
//    dispatch_semaphore_t sema = dispatch_semaphore_create(1);
//    dispatch_async(queue, ^{
//        for (NSInteger i = 0; i < 50; i++) {
//            [self.products addObject:[NSString stringWithFormat:@"async-%zd",i]];
//        }
//        dispatch_semaphore_signal(sema);
//    });
//    dispatch_async(queue, ^{
//        dispatch_semaphore_wait(sema, DISPATCH_TIME_NOW);
//        for (NSInteger i = 0; i < 50; i++) {
//            [self.products addObject:[NSString stringWithFormat:@"async1-%zd",i]];
//        }
//        dispatch_semaphore_signal(sema);
//    });
//
//    for (NSInteger i = 0; i < 50; i++) {
//        [self.products addObject:[NSString stringWithFormat:@"async2-%zd",i]];
//    }
//    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self.products enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            NSLog(@"%@",obj);
//        }];
//    });
//    
    
    NSMutableArray *localFileMemoArray = [NSMutableArray arrayWithObjects:@"1", @"2", @"3", nil];
    for (NSString *str in [localFileMemoArray copy]) {
        if ([str isEqualToString:@"2"]) {
            [localFileMemoArray removeObject:str];
        }
    }
    NSLog(@"---%zd",localFileMemoArray.count);


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
