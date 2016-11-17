//
//  ViewController.m
//  SampleTableView
//
//  Created by 김성준 on 2016. 10. 18..
//  Copyright © 2016년 poppay. All rights reserved.
//

#import "ListViewController.h"

@interface ListViewController ()

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    page = 1;
    
    self.list = [NSMutableArray<MovieVO *> new];
   
    
    [self callMovieAPI];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.list count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MovieVO *row = self.list[indexPath.row];
    MovieCell *cell = (MovieCell *)[tableView dequeueReusableCellWithIdentifier:@"ListCell"];
    
    if(cell == nil){
        NSLog(@"cell is nill");
        cell = [[MovieCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ListCell"];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.lblTitle.text = row.title;
    cell.lblDescription.text = row.description;
    cell.lblOpenDate.text = row.opendate;
    cell.lblRating.text = [NSString stringWithFormat:@"%.2f",row.rating];
    
//    cell.ivThumbnail.image = row.thumbnailImage;

    // 수정) 비동기 방식으로 썸네일 이미지를 읽어옴
    dispatch_async(dispatch_get_main_queue(), ^{
        cell.ivThumbnail.image = [self getThumbnailImage:(int)indexPath.row];
    });
    
    NSLog(@"thumbnail image : %@",cell.ivThumbnail.image);
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Touch Table Row at %ld", (long)indexPath.row);
}

- (IBAction)touchUpMore:(id)sender {
    page++;
    
    [self callMovieAPI];
    
    [self.movieTable reloadData];
}

- (void)callMovieAPI{
    
    NSString *url = [NSString stringWithFormat:@"http://115.68.183.178:2029/hoppin/movies?order=releasedateasc&count=10&page=%d&version=1&genreId=",page];
    NSURL *apiURI = [NSURL URLWithString:url];
    
    NSData *apiData = [NSData dataWithContentsOfURL:apiURI];
    
    //    NSString *receivedDataString = [[NSString alloc] initWithData:apiData encoding:NSUTF8StringEncoding];
    //    NSLog(@"API result : %@",receivedDataString);
   
    NSError *error;
    
    
    NSDictionary *apiDictionary = [NSJSONSerialization JSONObjectWithData:apiData options:kNilOptions error:&error];
    
    if(error)
    {
        NSLog(@"error incurred");
    }
    
    NSDictionary *hoppin = (NSDictionary *)[apiDictionary objectForKey:@"hoppin"];
    NSDictionary *movies = (NSDictionary *)[hoppin objectForKey:@"movies"];
    NSArray *movie = (NSArray *)[movies mutableArrayValueForKey:@"movie"];
    
    for(NSString *row in movie){
        mvo = [MovieVO new];
        
        // ⑦-1 웹 상에 있는 이미지를 읽어와 UIImage 객체로 생성
        mvo.title = (NSString *)[row valueForKey:@"title"];
        mvo.description = (NSString *)[row valueForKey:@"genreNames"];
        mvo.thumbnail = (NSString *)[row valueForKey:@"thumbnailImage"];
        mvo.detail = (NSString *)[row valueForKey:@"linkUrl"];
        mvo.rating = [(NSString *)[row valueForKey:@"ratingAverage"] floatValue];
        
        NSURL *thumnailURL = [NSURL URLWithString:mvo.thumbnail];
        NSData *imageData = [NSData dataWithContentsOfURL:thumnailURL];
        mvo.thumbnailImage = [UIImage imageWithData:imageData];
        
        [self.list addObject:mvo];
        
    }
    
    int totalCount = [(NSString *)[hoppin valueForKey:@"totalCount"] intValue];
    
    if([self.list count] >= totalCount){
        [self.moreBtn setHidden:true];
    }
}

- (UIImage *) getThumbnailImage:(int) index{
    mvo = [self.list objectAtIndex:index];
    
    UIImage *savedImage;
    
     // 메모이제이션 처리 : 저장된 이미지가 있을 경우 이를 리턴하고, 없을 경우 다운로드받아 저장한 후 리턴함
    if([savedImage isEqual:mvo.thumbnailImage]){
        return savedImage;
    }else{
        NSURL *thumnailURL = [NSURL URLWithString:mvo.thumbnail];
        NSData *imageData = [NSData dataWithContentsOfURL:thumnailURL];
        mvo.thumbnailImage = [UIImage imageWithData:imageData];
        
        return mvo.thumbnailImage;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"segue_detail"]){
        MovieCell *cell = (MovieCell *)sender;
        
        NSIndexPath *path = [self.movieTable indexPathForCell:cell];
        
        MovieVO *param = self.list[path.row];
        
        DetailViewController *dvc = (DetailViewController *)[segue destinationViewController];
        
        dvc.mvo = param;
        
    }
}


@end
