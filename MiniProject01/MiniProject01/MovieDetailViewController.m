//
//  MovieDetailViewController.m
//  MiniProject01
//
//  Created by 김성준 on 2016. 11. 16..
//  Copyright © 2016년 poppay. All rights reserved.
//

#import "MovieDetailViewController.h"

@interface MovieDetailViewController ()

@end

@implementation MovieDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _mvo.genres = [NSMutableArray new];
    _mvo.directors = [NSMutableArray new];
    _mvo.actors = [NSMutableArray new];
    
    _genreLabel.text = @"";
    _actorLabel.text = @"";
    _directorLabel.text = @"";

    
    [self callMovieDetailAPI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)callMovieDetailAPI{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    NSString *url = @"http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json";
    
    //    apiKey = dd511a8aba40b8ffdfef0fd2ef9f4a1c
    //    Example of API call:
    //    http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?key=430156241533f1d058c603178cc3ca0e&movieCd=20124079
    
    
    [manager GET:url
      parameters:@{
                   @"key":@"dd511a8aba40b8ffdfef0fd2ef9f4a1c",
                   @"movieCd":_mvo.code
                   }
        progress:nil
         success:^(NSURLSessionTask *task, id responseObject) {
             
             NSString *receivedDataString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
             NSLog(@"API result : %@",receivedDataString);
             
             NSError *error;
             NSDictionary *apiDictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:&error];
             NSDictionary *movieInfoResult = [apiDictionary valueForKey:@"movieInfoResult"];
             NSDictionary *movieInfo = [movieInfoResult valueForKey:@"movieInfo"];
             NSMutableArray *genres = [movieInfo valueForKey:@"genres"];
             NSMutableArray *directors = [movieInfo valueForKey:@"directors"];
             NSMutableArray *actors = [movieInfo valueForKey:@"actors"];
             NSMutableArray *audits = [movieInfo valueForKey:@"audits"];
             
             
             _mvo.titleEn = [movieInfo valueForKey:@"movieNmEn"];
             for(NSString *row in genres){
                [_mvo.genres addObject:(NSString *)[row valueForKey:@"genreNm"]];
             }
             for(NSString *row in directors){
                 [_mvo.directors addObject:(NSString *)[row valueForKey:@"peopleNm"]];
             }
             for(NSString *row in actors){
                 [_mvo.actors addObject:(NSString *)[row valueForKey:@"peopleNm"]];
             }
             _mvo.watchGrade = [audits[0] valueForKey:@"watchGradeNm"];
             
             _titleNavigationItem.title = _mvo.title;
             _titleLabel.text = _mvo.title;
             _titleEnLabel.text = _mvo.titleEn;
             
             for(NSString *row in _mvo.genres){
                 _genreLabel.text = [_genreLabel.text stringByAppendingString:[NSString stringWithFormat:@"%@ ",row]];
             }
             _audiAccLabel.text = _mvo.audiAcc;
             _watchGradeLabel.text = _mvo.watchGrade;
             
             for(NSString *row in _mvo.directors){
                 _directorLabel.text = [_directorLabel.text stringByAppendingString:[NSString stringWithFormat:@"%@ ",row]];
             }
             for(NSString *row in _mvo.actors){
                 _actorLabel.text = [_actorLabel.text stringByAppendingString:[NSString stringWithFormat:@"%@ ",row]];
             }
             
             
         } failure:^(NSURLSessionTask *operation, NSError *error) {
             NSLog(@"%@", error);
         }
     ];
    
}

@end
