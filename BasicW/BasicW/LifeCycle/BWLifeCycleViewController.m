//
//  BWLifeCycleViewController.m
//  BasicW
//
//  Created by 小李 on 2019/11/8.
//  Copyright © 2019 lyl. All rights reserved.
//

#import "BWLifeCycleViewController.h"
#import "BWBlockView.h"

@class Department;
@interface Person : NSObject
@property (nonatomic, weak) Department *department;
@end

@implementation Person
- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"Person alloc");
    }
    return self;
}

- (void)dealloc {
    NSLog(@"Person release");
}
@end


@interface Department : NSObject
@property (nonatomic, strong) Person *person;

@end

@implementation Department

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"department alloc");
    }
    return self;
}

- (void)dealloc {
    NSLog(@"department release");
}
@end


@protocol TaskDelegate <NSObject>
- (void)taskDone;
@end

@interface Task : NSObject
@property (nonatomic, weak) id<TaskDelegate> delegate;
@property (nonatomic, strong) NSTimer *timer;
- (void)doSth;
@end

@implementation Task

- (void)doSth {
    if ([self.delegate respondsToSelector:@selector(taskDone)]) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(run:) userInfo:nil repeats:YES];
        [self.timer fire];
        [self.delegate taskDone];
    }
    [self cleanup];
}

- (void)run:(NSTimer *)timer {
    NSLog(@"----run------");
}

- (void)cleanup {
    NSLog(@"----clean up----");
    [self.timer invalidate];
    self.timer = nil;
}

- (void)dealloc {
    NSLog(@"-----dealloc-----");
}

@end

@interface BWLifeCycleViewController ()<TaskDelegate>
@property (nonatomic, strong) Task *task;

@end

@implementation BWLifeCycleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
//    self.task = [[Task alloc] init];
//    self.task.delegate = self;
//    [self.task doSth];
//    NSLog(@"-------");
//
//    Person *p = [[Person alloc] init];
//    Department *d = [[Department alloc] init];
//    p.department = d;
//    d.person = p;
//
//    BWBlockView *bv = [[BWBlockView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
//    bv.backgroundColor = [UIColor darkGrayColor];
//    __weak typeof(bv) weakBv = bv;
//    bv.clickBlock = ^{
//        NSLog(@"bv 被点击");
//        __strong typeof(weakBv) strongBv = weakBv;
//        [strongBv removeFromSuperview];
//        [strongBv doSth];
//    };
//    [self.view addSubview:bv];
//
//
//    dispatch_queue_t queue = dispatch_get_main_queue();
//    dispatch_async(queue, ^{
//        NSLog(@"执行任务0");
//    });
//    NSLog(@"执行任务1");
//
//    NSLog(@"主线程---0");
//    dispatch_queue_t queue1 = dispatch_queue_create("myQueue", DISPATCH_QUEUE_SERIAL);
//    dispatch_async(queue1, ^{
//       NSLog(@"主线程---2");
//        dispatch_async(queue1, ^{
//            NSLog(@"主线程---4");
//        });
//        NSLog(@"主线程---3");
//    });
//    NSLog(@"主线程---1");
    
//    dispatch_queue_t queue2 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_async(queue2, ^{
//        NSLog(@"queue2----0");
//        [self performSelector:@selector(testQueue2) withObject:nil afterDelay:0];
////        [self performSelector:@selector(testQueue2) withObject:nil];
//        NSLog(@"queue2----2");
////        [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc] init] forMode:NSDefaultRunLoopMode];
//        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
//    });
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue3 = dispatch_queue_create("myQ3", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_async(group, queue3, ^{
        for (NSInteger i = 0; i < 5; i++) {
            NSLog(@"任务1");
        }
    });
    dispatch_group_async(group, queue3, ^{
        for (NSInteger i = 0; i < 15; i++) {
            NSLog(@"任务2");
        }
    });
    dispatch_group_notify(group, queue3, ^{
        for (NSInteger i = 0; i < 5; i++) {
            NSLog(@"任务3");
        }
    });
}

- (void)testQueue2 {
    NSLog(@"queue2----1");

}


- (void)taskDone {
    NSLog(@"----taskDone---");
    self.task = nil;
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
