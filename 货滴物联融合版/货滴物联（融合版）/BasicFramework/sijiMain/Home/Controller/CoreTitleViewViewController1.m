//
//  CoreTitleViewViewController1.m
//  BasicFramework
//
//  Created by LONG on 2018/3/3.
//  Copyright © 2018年 Rainy. All rights reserved.
//

#import "CoreTitleViewViewController1.h"
#import "BasicMainTBVC1.h"
@interface CoreTitleViewViewController1 ()

@end

@implementation CoreTitleViewViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.titleVIew.text = self.strl;
}
- (IBAction)guanbi:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    kKeyWindow.rootViewController = nil;
    kKeyWindow.rootViewController =[[BasicMainTBVC1 alloc]init];
    [kKeyWindow makeKeyAndVisible];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
