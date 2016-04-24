//
//  DetailViewController.m
//  CoreDataUse
//
//  Created by 夏桂峰 on 16/4/24.
//  Copyright © 2016年 夏桂峰. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"更新";
    self.view.backgroundColor=[UIColor whiteColor];
    _uidLabel.text=[NSString stringWithFormat:@"学号：%@",self.model.uid];
    _nameField.text=self.model.name;
    _ageField.text=self.model.age.stringValue;
    _sexField.text=self.model.sex;
}


- (IBAction)updateData:(UIButton *)sender {
    if(!_nameField.text)
        return;
    if(!_sexField.text)
        return;
    if(!_ageField.text)
        return;
    [[DBManager shared] updatePeople:self.model name:_nameField.text age:@(_ageField.text.intValue) sex:_sexField.text];
    [self.navigationController popViewControllerAnimated:YES];
}


@end
