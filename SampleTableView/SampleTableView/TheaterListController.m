
#import "TheaterListController.h"

@implementation TheaterListController

@synthesize list;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    startPoint = 0;
    
    self.list = [NSMutableArray<NSDictionary *> new];
    
    [self callTheaterAPI];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)callTheaterAPI{
    NSString *apiURL = @"http://115.68.183.178:2029/theater/list";
//    NSString *serverKy = @"";
    int sList = 100;
    NSString *type = @"json";
    
    NSURL *urlObj = [NSURL URLWithString:[NSString stringWithFormat:@"%@?s_page=%d&s_list=%d&type=%@",apiURL,startPoint,sList,type]];
    
    @try{
//        스트링형태로 데이터를 읽어온다. EUC-KR은 데이터를 읽어올때 인코딩을 해야한다.
        NSString *stringData = [NSString stringWithContentsOfURL:urlObj encoding:0x80000422 error:nil];
        
        NSData *encData = [stringData dataUsingEncoding:NSUTF8StringEncoding];
    
        NSError *error;
        
        
        @try{
            NSArray * apiArray = (NSArray *)[NSJSONSerialization JSONObjectWithData:encData options:kNilOptions error:&error];
            
            if(error)
            {
                NSLog(@"error incurred");
            }
            
            for(NSObject *obj in apiArray){
                [self.list addObject:(NSDictionary *)obj];
            }
            
        }
        @catch(NSException *e){
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"실패" message:@"데이터 분석 실패" preferredStyle:UIAlertControllerStyleAlert];
            
            [alert addAction:[UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleCancel handler:nil]];
            [self presentViewController:alert animated:false completion:nil];
        }
        
        startPoint += sList;
    }
    @catch(NSException *e){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"실패" message:@"데이터 불러오기 실패" preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alert animated:false completion:nil];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.list count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *obj = self.list[indexPath.row];
    TheaterCell *cell = (TheaterCell *)[tableView dequeueReusableCellWithIdentifier:@"tCell"];
    
    if(cell == nil){
        NSLog(@"cell is nill");
        cell = [[TheaterCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"tCell"];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.name.text = (NSString *)[obj objectForKey:@"상영관명"];
    cell.tel.text = (NSString *)[obj objectForKey:@"연락처"];
    cell.addr.text = (NSString *)[obj objectForKey:@"소재지도로명주소"];
    
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"segue_map"]){
        NSIndexPath *path = [self.theaterTable indexPathForCell:sender];
        
        NSDictionary *data = self.list[path.row];
        
        TheaterViewController *dvc = (TheaterViewController *)[segue destinationViewController];
        
        dvc.param = data;
   
    }
}


@end
