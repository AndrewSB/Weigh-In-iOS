//
//  ViewController.m
//  Dice
//
//  Created by Damien Laughton on 30/10/2014.
//  Copyright (c) 2014 Damien Laughton. All rights reserved.
//

#import "ViewController.h"
#import "DiceTableViewCell.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (assign, nonatomic) CGPoint lastContentOffset;
@property (strong, nonatomic) NSArray *dates;
@property (strong, nonatomic) NSArray *scores;
@property (strong, nonatomic) UITableViewController *lb;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.tableView registerNib:[UINib nibWithNibName:@"DiceTableViewCell" bundle:nil] forCellReuseIdentifier:@"DiceTableViewCell"];
    
    self.lb = [[LeaderboardViewController alloc] init];
    
    self.dates = @[@"12/9", @"12/9", @"12/7", @"12/2", @"11/29", @"11/15"];
    self.scores = @[@"95", @"100", @"94", @"98", @"62", @"5"];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    CGFloat heightForRowAtIndexPath = 80.0f;
    
    return heightForRowAtIndexPath;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    NSInteger numberOfRowsInSection = 6;
    
    return numberOfRowsInSection;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    DiceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DiceTableViewCell" forIndexPath:indexPath];
    
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"Album%ld", (long)indexPath.row]];
    
    cell.imageViewBackground.image = image;
    cell.dateLabel.text = self.dates[indexPath.row];
    cell.scoreLabel.text = self.scores[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Open leaderboard");
    [self presentViewController:self.lb animated:YES completion:nil];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
{
    DiceTableViewCellScrollDirection scrollDirection = ScrollDirectionNone;
    
    if (self.lastContentOffset.x > scrollView.contentOffset.x)
    {
        scrollDirection = ScrollDirectionRight;
    }
    else if (self.lastContentOffset.x < scrollView.contentOffset.x)
    {
        scrollDirection = ScrollDirectionLeft;
    }
    else if (self.lastContentOffset.y > scrollView.contentOffset.y)
    {
        scrollDirection = ScrollDirectionDown;
//        NSLog(@"DOWN");
    }
    else if (self.lastContentOffset.y < scrollView.contentOffset.y)
    {
        scrollDirection = ScrollDirectionUp;
//        NSLog(@"UP");
    }
    else
    {
        scrollDirection = ScrollDirectionCrazy;
    }
    
    self.lastContentOffset = scrollView.contentOffset;
    
    id notificationObject = [NSNumber numberWithInteger:scrollDirection];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:DiceTableViewCellDirectionNotification object:notificationObject];


}

@end