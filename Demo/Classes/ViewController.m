//
//  ViewController.m
//  SVProgressHUD, https://github.com/SVProgressHUD/SVProgressHUD
//
//  Copyright (c) 2011-2019 Sam Vermette and contributors. All rights reserved.
//

#import "ViewController.h"
#import "SVProgressHUD.h"

@interface ViewController()

@property (nonatomic, readwrite) NSUInteger activityCount;
@property (weak, nonatomic) IBOutlet UIButton *popActivityButton;

@end

@implementation ViewController


#pragma mark - ViewController lifecycle

- (void)viewDidLoad{
    [super viewDidLoad];
    self.activityCount = 0;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleNotification:)
                                                 name:SVProgressHUDWillAppearNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleNotification:)
                                                 name:SVProgressHUDDidAppearNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleNotification:)
                                                 name:SVProgressHUDWillDisappearNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleNotification:)
                                                 name:SVProgressHUDDidDisappearNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleNotification:)
                                                 name:SVProgressHUDDidReceiveTouchEventNotification
                                               object:nil];
    
    [self addObserver:self forKeyPath:@"activityCount" options:NSKeyValueObservingOptionNew context:nil];
}


#pragma mark - Notification handling

- (void)handleNotification:(NSNotification *)notification {
    NSLog(@"Notification received: %@", notification.name);
    NSLog(@"Status user info key: %@", notification.userInfo[SVProgressHUDStatusUserInfoKey]);
    
    if([notification.name isEqualToString:SVProgressHUDDidReceiveTouchEventNotification]){
        [self dismiss];
    }
}


#pragma mark - Show Methods Sample

- (void)show {
    [SVProgressHUD show];
    self.activityCount++;
}

- (void)showWithStatus {
	[SVProgressHUD showWithStatus:@"Doing Stuff"];
    self.activityCount++;
}

- (IBAction)showWithProgress:(id)sender {
}

#pragma mark - Dismiss Methods Sample

- (void)dismiss {
	[SVProgressHUD dismiss];
    self.activityCount = 0;
}

- (IBAction)popActivity {
    [SVProgressHUD popActivity];
    
    if (self.activityCount != 0) {
        self.activityCount--;
    }
}

- (IBAction)showInfoWithStatus {
    [SVProgressHUD showInfoWithStatus:@"Useful Information."];
    self.activityCount++;
}

- (void)showSuccessWithStatus {
	[SVProgressHUD showSuccessWithStatus:@"Great Success!"];
    self.activityCount++;
}

- (void)showErrorWithStatus {
	[SVProgressHUD showErrorWithStatus:@"Failed with Error"];
    self.activityCount++;
}


#pragma mark - Styling

- (IBAction)changeStyle:(id)sender {
}

- (IBAction)changeAnimationType:(id)sender {
}

- (IBAction)changeMaskType:(id)sender {
}


#pragma mark - Helper

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if([keyPath isEqualToString:@"activityCount"]){
        unsigned long activityCount = [[change objectForKey:NSKeyValueChangeNewKey] unsignedLongValue];
        [self.popActivityButton setTitle:[NSString stringWithFormat:@"popActivity - %lu", activityCount] forState:UIControlStateNormal];
    }
}

@end
