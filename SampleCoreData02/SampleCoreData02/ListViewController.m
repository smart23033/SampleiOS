#import "ListViewController.h"

@interface ListViewController (){
    NSManagedObjectContext *context;
    AppDelegate *ad;
}

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:true];
    
    ad = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    context = [[ad persistentContainer] viewContext];
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"AddressBook" inManagedObjectContext:context];
    NSFetchRequest *request = [NSFetchRequest new];
    request.entity = entityDescription;
    
    NSSortDescriptor *nameSort = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    [request setSortDescriptors:@[nameSort]];
    
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
    
    _fetchedResultsController.delegate = self;
    
    @try{
        NSError *error;
        [_fetchedResultsController performFetch:&error];
    }
    @catch(NSError *error){
        NSLog(@"Error : %@",[error localizedFailureReason]);
    }
    
//    [self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)configureCell:(id)cell atIndexPath:(NSIndexPath*)indexPath
{
    AddressBook *address = [_fetchedResultsController objectAtIndexPath:indexPath];
    
    // Populate cell from the NSManagedObject instance
    
    [cell textLabel].text = address.name;
    [cell detailTextLabel].text = address.address;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id cell = [tableView dequeueReusableCellWithIdentifier:@"AddressCell"];
    
    // Set up the cell
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id< NSFetchedResultsSectionInfo> sectionInfo = [[self fetchedResultsController] sections][section];
    return [sectionInfo numberOfObjects];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Touch Table Row at %ld", (long)indexPath.row);
    [self performSegueWithIdentifier:@"detailSegue" sender:self];
}

- (BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    NSManagedObject *selectedObject = [_fetchedResultsController objectAtIndexPath:indexPath];
    
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
//        [context deleteObject:selectedObject];
        [_fetchedResultsController.managedObjectContext deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        NSError *error = nil;
        if (![_fetchedResultsController.managedObjectContext save:&error]) {
            // handle error
        }
    }
    
    NSLog(@"Deleted Table Row at %ld",(long)indexPath.row);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    ListViewController *lvc = [segue destinationViewController];
    DetailViewController *dvc = [DetailViewController new];
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    
    if([lvc isKindOfClass:[DetailViewController class]]){
        AddressBook *selectedAddress = [_fetchedResultsController objectAtIndexPath:indexPath];
        dvc = (DetailViewController *)lvc;
        dvc.address = selectedAddress;
    }
}

- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.tableView;
    
    switch(type)
    {
        case NSFetchedResultsChangeInsert:
            [tableView
             insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView
             deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
             withRowAnimation:UITableViewRowAnimationFade];
            break;
     }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController*)controller
{
    [[self tableView] endUpdates];
}

- (void)controllerWillChangeContent:(NSFetchedResultsController*)controller
{
    [[self tableView] beginUpdates];
}

@end
