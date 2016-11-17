//
//  MovieTableViewController.m
//  MiniProject01
//
//  Created by 김성준 on 2016. 11. 15..
//  Copyright © 2016년 poppay. All rights reserved.
//

#import "MovieTableViewController.h"
#import "MovieDetailViewController.h"
#import "SWRevealViewController.h"
#import "MovieCell.h"
#import "MovieVO.h"

@interface MovieTableViewController ()

@end

@implementation MovieTableViewController{
    MovieVO *mvo;
    NSMutableArray<MovieVO *> *list;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    list = [NSMutableArray<MovieVO *> new];
    
    [self callMovieAPI];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
    MovieVO *row =  list[indexPath.row];
    MovieCell *cell = (MovieCell *)[tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
    
    if(cell == nil){
        NSLog(@"cell is nill");
        cell = [[MovieCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"MovieCell"];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
        
    cell.titleLabel.text = row.title;
    cell.audiAccLabel.text = row.audiAcc;
    cell.openDateLabel.text = row.openDate;
    
    NSLog(@"title : %@",cell.titleLabel.text);
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Touch Table Row at %ld", (long)indexPath.row);
}

- (void)callMovieAPI{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    NSString *url = @"http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json";
    
    //    apiKey = dd511a8aba40b8ffdfef0fd2ef9f4a1c
    //    Example of API call:
    //     http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=430156241533f1d058c603178cc3ca0e&targetDt=20120101
    
    //    어제 날짜기준. 오늘로 하면 집계가 안되서 에러남.
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMdd"];
    NSString *today = [formatter stringFromDate:[[NSDate date] dateByAddingTimeInterval:-86400.0]];
    
    [manager GET:url
      parameters:@{
                   @"key":@"dd511a8aba40b8ffdfef0fd2ef9f4a1c",
                   @"targetDt":today
                   }
        progress:nil
         success:^(NSURLSessionTask *task, id responseObject) {
             
             NSString *receivedDataString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
             NSLog(@"API result : %@",receivedDataString);
             
             NSError *error;
             NSDictionary *apiDictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:&error];
             
             
             NSDictionary *boxOfficeResult = (NSDictionary *)[apiDictionary valueForKey:@"boxOfficeResult"];
             NSMutableArray *dailyBoxOfficeList = (NSMutableArray *)[boxOfficeResult valueForKey:@"dailyBoxOfficeList"];
             
             for(NSString *row in dailyBoxOfficeList){
                 mvo = [MovieVO new];
                 
                 mvo.code = (NSString *)[row valueForKey:@"movieCd"];
                 mvo.title = (NSString *)[row valueForKey:@"movieNm"];
                 mvo.audiAcc = [NSString stringWithFormat:@"%@명",(NSString *)[row valueForKey:@"audiAcc"]];
                 mvo.openDate = (NSString *)[row valueForKey:@"openDt"];
                 
                 [list addObject:mvo];
                 
                 [_movieTable reloadData];
             }
             
             
             
         } failure:^(NSURLSessionTask *operation, NSError *error) {
             NSLog(@"%@", error);
         }
     ];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"segue_movie_detail"]){
        MovieCell *cell = (MovieCell *)sender;
        
        NSIndexPath *path = [self.movieTable indexPathForCell:cell];
        
        MovieVO *param = list[path.row];
        
        MovieDetailViewController *dvc = (MovieDetailViewController *)[segue destinationViewController];
        
        dvc.mvo = param;
        
        
    }
}

@end
