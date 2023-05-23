//
// BLContactsViewController.h
// Copyright (c) 2015, Hariton Batkov
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
// * Redistributions of source code must retain the above copyright notice, this
//   list of conditions and the following disclaimer.
//
// * Redistributions in binary form must reproduce the above copyright notice,
//   this list of conditions and the following disclaimer in the documentation
//   and/or other materials provided with the distribution.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
// FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
// DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
// OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
// CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
// OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
// OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import <UIKit/UIKit.h>
@protocol BLContactsViewControllerDelegate;
@class BLContactItem;

extern NSString * const BLContactsDefaultCellIdentifier;

/*
 * Controller used to show list of items sectioned by Alphabet and show Collation View.
 * 
 */
@interface BLContactsViewController : UITableViewController <UISearchBarDelegate>
@property (nonatomic, assign) id <BLContactsViewControllerDelegate> contactsDelegate;
/**
 * @return 'UINavigationController' with 'TAContactsViewController' as root.
 */
+ (UINavigationController *) navigationControllerWithContactsControllerWithDelegate:(id <BLContactsViewControllerDelegate>) delegate;

/**
 * @return 'TAContactsViewController' instance.
 */
+ (instancetype) contactsControllerWithDelegate:(id <BLContactsViewControllerDelegate>) delegate;

@end

@protocol BLContactsViewControllerDelegate <NSObject>

@optional
/**
 * Delegate method called when user tapped Cancel button.
 */
- (void) contactsControllerDidCancel:(BLContactsViewController *) controller;

/**
 * Delegate method called when user selected some item (in search results or from full list).
 */
- (void) contactsController:(BLContactsViewController *) controller didSelectItem:(BLContactItem *)item;


/**
 * Delegate method asks for array of 'TAContactSection' to display.
 */
- (NSArray *) sectionsForContactsController:(BLContactsViewController *) controller;

/**
 * Delegate method asks for array of 'TAContactItem' to display in the list. 
 * Will be called if 'sectionsForContactsController:' not implemnted.
 */
- (NSArray *) titlesForContactsController:(BLContactsViewController *) controller;

/**
 * Delegate method asks whether controller should show collationt view or not.
 * By default collation view is shown.
 */
- (BOOL) shouldShowCollationForContactsController:(BLContactsViewController *) controller;

/**
 * Delegate method asks whether controller should show 'UISearchBar'.
 * By default search is enabled.
 */
- (BOOL) searchEnabledForContactsController:(BLContactsViewController *) controller;

/**
 * Delegate method asks for titles to display with search condition.
 * If this method not implemented we will search through title.
 */
- (NSArray *) contactsController:(BLContactsViewController *) controller searchResultsFor:(NSString *) searchString;

#pragma mark - UITableViewCell customization

/**
 * Delegate method asks for cell identifier for 'UITableViewCell' for 'TAContactItem'
 * Will use 'TAContactsDefaultCellIdentifier' if this method not implemented.
 * @param controller An instance of 'TAContactsViewController'
 * @param item An instance of 'TAContactItem' for which identifier is asked
 * @param search This flag shows whether this identifier will be used for search results or not
 */
- (NSString *) contactsController:(BLContactsViewController *) controller
            cellIdentifierForItem:(BLContactItem *) item
                           search:(BOOL)search;

/**
 * Delegate method asks for instance of 'UITableViewCell' for given cell identifier.
 * Uses value returned from 'contactsController:cellIdentifierForItem:search:' or 'TAContactsDefaultCellIdentifier'.
 * Will create instance of 'UITableViewCell' with style 'UITableViewCellStyleDefault' if this
 * method not implemented or received nil.
 * @param controller An instance of 'TAContactsViewController'
 * @param cellIdentifier String provided by 'contactsController:cellIdentifierForItem:search:' or 'TAContactsDefaultCellIdentifier'
 * @param search This flag shows whether this cell will be used for search results or not
 */
- (UITableViewCell *) contactsController:(BLContactsViewController *) controller
                   cellForCellIdentifier:(NSString *) cellIdentifier
                                  search:(BOOL)search;
/**
 * Delegate method allow to customize cell before displaying.
 * Sends cell received from 'contactsController:cellForCellIdentifier:search:' or cell with style 'UITableViewCellStyleDefault'
 * @param controller An instance of 'TAContactsViewController'
 * @param cell an instance of 'UITableViewCell' provided by 'contactsController:cellForCellIdentifier:search:' or 'UITableViewCellStyleDefault'
 * @param item An instance of 'TAContactItem' for which cell will display
 * @param search This flag shows whether this cell will be used for search results or not
 */
- (void) contactsController:(BLContactsViewController *) controller
            willDisplayCell:(UITableViewCell *) cell
                    forItem:(BLContactItem *)item
                     search:(BOOL)search;

@end

@interface BLContactSection : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSMutableArray *items;

@end

@interface BLContactItem : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) id context;

+ (instancetype) itemWithTitle:(NSString *)title context:(id) context;

@end