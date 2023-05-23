//
// BLContactsViewController.m
// Copyright (c) 2015, Hariton Batkov
// All rights reserved.
//

#import "BLContactsViewController.h"
NSString *const BLContactsDefaultCellIdentifier = @"BLContactsDefaultCellIdentifier";
@interface BLContactsViewController () <UISearchDisplayDelegate>
@property (nonatomic, strong) NSArray * sections;

/*
 The searchResults array contains the content filtered as a result of a search.
 */
@property (nonatomic) NSArray *searchResults;

@property (nonatomic, assign) BOOL isViewLoad;
@end

@implementation BLContactsViewController
+ (NSString *) storyboardName {
    return @"BLContactsViewController.bundle/BLContacts";
}
+ (UINavigationController *) navigationControllerWithContactsControllerWithDelegate:(id <BLContactsViewControllerDelegate>) delegate {
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:[self storyboardName]
                                                          bundle:[NSBundle bundleForClass:[BLContactsViewController class]]];
    UINavigationController * navController = [storyboard instantiateInitialViewController];
    BLContactsViewController * controller = (BLContactsViewController *) navController.viewControllers[0];
    controller.contactsDelegate = delegate;
    return navController;
}

+ (instancetype) contactsControllerWithDelegate:(id <BLContactsViewControllerDelegate>) delegate {
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:[self storyboardName]
                                                          bundle:[NSBundle bundleForClass:[BLContactsViewController class]]];
    BLContactsViewController * controller = (BLContactsViewController *) [storyboard instantiateViewControllerWithIdentifier:@"BLContactsViewController"];
    controller.contactsDelegate = delegate;
    return controller;
    
}
#pragma mark - View Lifecycle
-(void)viewDidLoad {
    self.isViewLoad = true;
    [self initLeftBarButton];
    [self initSearchBar];
    [self reloadData];
}

- (void) initLeftBarButton {
    if ([self.navigationController.viewControllers count] != 1)
        return;
    
    UIBarButtonItem * btn = nil;
    btn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                        target:self
                                                        action:@selector(dismissController)];
    self.navigationItem.leftBarButtonItem = btn;
}

-(void)viewWillDisappear:(BOOL)animated {
    if ([self.navigationController.viewControllers indexOfObject:self]==NSNotFound) {
        // back button was pressed.  We know this is true because self is no longer
        // in the navigation stack.
        [self userDidCancel];
    }
    [super viewWillDisappear:animated];
}

#pragma mark - Data Management
- (void) reloadData {
    self.sections = nil;
    if (!self.isViewLoad)
        return;
    if (!self.contactsDelegate)
        return;
    
    if ([self.contactsDelegate respondsToSelector:@selector(sectionsForContactsController:)]) {
        self.sections = [self.contactsDelegate sectionsForContactsController:self];
    } else if ([self.contactsDelegate respondsToSelector:@selector(titlesForContactsController:)]) {
        [self processTitles:[self.contactsDelegate titlesForContactsController:self]];
    } else {
        NSAssert(nil, @"contactsDelegate should implement sectionsForContactsController or titlesForContactsController");
    } 
    [self.tableView reloadData];
}

- (void) processTitles:(NSArray *) titles {
    if (!titles)
        return;
    NSMutableArray * newSections = [[NSMutableArray alloc] init];
    NSMutableDictionary *sectionsDict = [[NSMutableDictionary alloc] init];
    
    for (BLContactItem *item in titles)
    {
        NSNumber *key = [[NSNumber alloc] initWithInt:[item.title characterAtIndex:0]];
        BLContactSection *section = [sectionsDict objectForKey:key];
        if (section == nil)
        {
            section = [[BLContactSection alloc] init];
            section.items = [[NSMutableArray alloc] init];
            section.title = [item.title substringToIndex:1];
            [sectionsDict setObject:section forKey:key];
            
            [newSections addObject:section];
        }
        [section.items addObject:item];
    }
    
    [newSections sortUsingComparator:^NSComparisonResult(BLContactSection *section1, BLContactSection *section2)
     {
         return [section1.title compare:section2.title
                                options:NSDiacriticInsensitiveSearch | NSWidthInsensitiveSearch | NSForcedOrderingSearch];
     }];
    self.sections = newSections;
}

#pragma mark -

-(void)setContactsDelegate:(id<BLContactsViewControllerDelegate>)contactsDelegate {
    _contactsDelegate = contactsDelegate;
    [self initSearchBar];
    [self reloadData];
}

- (void) initSearchBar {
    if (!self.isViewLoad)
        return;
    
    if (![self searchEnabled]) {
        self.tableView.tableHeaderView = nil;
        return;
    }
}

- (BOOL) searchEnabled {
    BOOL searchBarEnabled = YES;
    if ([self.contactsDelegate respondsToSelector:@selector(searchEnabledForContactsController:)]) {
        searchBarEnabled = [self.contactsDelegate searchEnabledForContactsController:self];
    }
    return searchBarEnabled;
}

- (void) dismissController {
    [self dismissViewControllerAnimated:YES completion:nil];
    [self userDidCancel];
}

- (void) userDidCancel {
    [self.contactsDelegate contactsControllerDidCancel:self];
}

- (BLContactItem *) itemAtIndexPath:(NSIndexPath *) indexPath tableView:(UITableView *)tableView {
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return self.searchResults[indexPath.row];
    } else {
        BLContactSection * section = self.sections[indexPath.section];
        return section.items[indexPath.row];
    }
}

#pragma mark - UITableView handling
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return nil;
    }
    BLContactSection * sectionObj = self.sections[section];
    return sectionObj.title;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return 1;
    }
    return [self.sections count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [self.searchResults count];
    }
    BLContactSection * sectionObj = self.sections[section];
    return [sectionObj.items count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * cellIdentifier = [self cellIdentifierForTableView:tableView forIndexPath:indexPath];
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [self cellForTableView:tableView withCellIdentifier:cellIdentifier];
    }
    return cell;
}

-(void) tableView:(UITableView *)tableView
  willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.textLabel.text = [self itemAtIndexPath:indexPath tableView:tableView].title;
    if ([self.contactsDelegate respondsToSelector:@selector(contactsController:willDisplayCell:forItem:search:)]) {
        BOOL search = tableView == self.searchDisplayController.searchResultsTableView;
        [self.contactsDelegate contactsController:self
                                  willDisplayCell:cell
                                          forItem:[self itemAtIndexPath:indexPath tableView:tableView]
                                           search:search];
    }
}

- (NSString *) cellIdentifierForTableView:(UITableView *)tableView forIndexPath:(NSIndexPath *)indexPath {
    BOOL search = tableView == self.searchDisplayController.searchResultsTableView;
    NSString * identifier = nil;
    if ([self.contactsDelegate respondsToSelector:@selector(contactsController:cellIdentifierForItem:search:)]) {
        identifier = [self.contactsDelegate contactsController:self
                                         cellIdentifierForItem:[self itemAtIndexPath:indexPath tableView:tableView]
                                                        search:search];
    }
    return identifier ? identifier : BLContactsDefaultCellIdentifier;
}

- (UITableViewCell *) cellForTableView:(UITableView *)tableView
                    withCellIdentifier:(NSString *) cellIdentifier{
    BOOL search = tableView == self.searchDisplayController.searchResultsTableView;
    UITableViewCell * cell = nil;
    if ([self.contactsDelegate respondsToSelector:@selector(contactsController:cellForCellIdentifier:search:)]) {
        cell = [self.contactsDelegate contactsController:self cellForCellIdentifier:cellIdentifier search:search];
    }
    if (!cell) {
        return [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    BLContactItem * item = [self itemAtIndexPath:indexPath tableView:tableView];
    [self.contactsDelegate contactsController:self didSelectItem:item];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return nil;
    }
    
    BOOL showCollationView = YES;
    if ([self.contactsDelegate respondsToSelector:@selector(shouldShowCollationForContactsController:)]) {
        showCollationView = [self.contactsDelegate shouldShowCollationForContactsController:self];
    }
    if (showCollationView) {
        NSMutableArray * array = [NSMutableArray array];
        if ([self searchEnabled])
            [array addObject:UITableViewIndexSearch];
        for (BLContactSection * section in self.sections) {
            [array addObject:section.title];
        }
        return array;
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)__unused title
               atIndex:(NSInteger)index
{
    if (![self searchEnabled])
        return index;
    if (index == 0) {
        [tableView scrollRectToVisible:tableView.tableHeaderView.frame animated:false];
        
        return -1;
    } else {
        return index - 1;
    }
    
    return 0;
}

#pragma mark - Search
- (void)updateFilteredContentForProductName:(NSString *)searchString
{
    /*
     Update the filtered array based on the search text and scope.
     */
    if ((searchString == nil) || [searchString length] == 0)
    {
        NSMutableArray * array = [NSMutableArray array];
        for (BLContactSection * section in self.sections) {
            [array addObjectsFromArray:section.items];
        }
        self.searchResults = array;
        return;
    }
    if ([self.contactsDelegate respondsToSelector:@selector(contactsController:searchResultsFor:)]) {
        self.searchResults = [self.contactsDelegate contactsController:self searchResultsFor:searchString];
        return;
    }
    /*
     Search the main list titles matches searchText; add items that match to the filtered array.
     */
    NSMutableArray * array = [NSMutableArray array];
    for (BLContactSection * section in self.sections) {
        for (BLContactItem * item in section.items) {
            NSUInteger searchOptions = NSCaseInsensitiveSearch | NSDiacriticInsensitiveSearch;
            NSRange range = NSMakeRange(0, item.title.length);
            NSRange foundRange = [item.title rangeOfString:searchString options:searchOptions range:range];
            if (foundRange.length > 0)
            {
                [array addObject:item];
            }
        }        
    }
    self.searchResults = array;
}


#pragma mark - UISearchDisplayController Delegate Methods

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    [self updateFilteredContentForProductName:searchString];
    return YES;
}

@end

@implementation BLContactSection

@end

@implementation BLContactItem

+ (instancetype) itemWithTitle:(NSString *)title context:(id) context {
    BLContactItem * item = [BLContactItem new];
    item.title = title;
    item.context = context;
    return item;
}

@end
