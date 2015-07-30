//
//  CategoryVC.m
//  RenewalReminder
//
//  Created by Mac Book on 31/07/15.
//  Copyright (c) 2015 MonuRathor. All rights reserved.
//

#import "CategoryVC.h"
#import "Renewal30DaysCell.h"

@interface CategoryVC ()

@end

@implementation CategoryVC
@synthesize delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [AppDelegate sharedAppDelegate].typeCatgory.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Renewal30DaysCell *cell = (Renewal30DaysCell*)[tableView dequeueReusableCellWithIdentifier:@"category_type" forIndexPath:indexPath];
    NSDictionary *param = [[AppDelegate sharedAppDelegate].typeCatgory objectAtIndex:indexPath.row];
    cell.lblTitle.text = [param valueForKey:@"type"];
    cell.imgFirst.image = nil;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[[AppDelegate sharedAppDelegate] getTypeImageLogoName:[param valueForKey:@"image"]]]];
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.imgFirst.image = [UIImage imageWithData:imgData];
        });
    });
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *param = [[AppDelegate sharedAppDelegate].typeCatgory objectAtIndex:indexPath.row];
    if ([self.delegate respondsToSelector:@selector(selectedCategory:Index:)]) {
        [self.delegate selectedCategory:param Index:indexPath.row];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)clickedBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
