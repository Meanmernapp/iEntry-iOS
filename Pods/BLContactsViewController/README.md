# BLContactsViewController

![alt tag](https://github.com/batkov/BLContactsViewController/blob/master/Screenshots/BLContactsViewController.gif)

Are you bored writing UITableViewControllers that looks like standard iOS Contacts page?
Write one delegate method for BLContactsViewController like:

```-(NSArray *)titlesForContactsController:(BLContactsViewController *)controller```
                      
and present it like

```[self.navigationController pushViewController:[BLContactsViewController contactsControllerWithDelegate:self] animated:YES];```

More customization inside.

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

BLContactsViewController is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

    pod "BLContactsViewController"

## Author

Hariton Batkov, batkov@i.ua

## License

BLContactsViewController is available under the MIT license. See the LICENSE file for more info.