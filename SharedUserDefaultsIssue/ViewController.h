//
//  ViewController.h
//  SharedUserDefaultsIssue
//
//  Created by Oliver Pang on 9/27/22.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate>

extern NSString * const StoredTextKey;
extern NSString * const StoredNumKey;

@property (strong, nonatomic) NSUserDefaults *sharedUserDefaults;

@property (weak, nonatomic) IBOutlet UIButton *incrementButton;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UITextField *persistedTextField;

- (IBAction)incrementButtonPressed:(id)sender;

@end

