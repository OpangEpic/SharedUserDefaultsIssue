//
//  ViewController.m
//  SharedUserDefaultsIssue
//
//  Created by Oliver Pang on 9/27/22.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

NSString* const StoredTextKey = @"StoredTextKey";
NSString* const StoredNumKey = @"StoredNumKey";
NSString* const StoredDictKey = @"StoredDictKey";

long currNumberVal;

- (void)viewDidLoad {
    [super viewDidLoad];
    // do any additional setup after loading the view.
    _persistedTextField.delegate = self;
        
    // fetch shared user defaults
    @synchronized([NSUserDefaults class]) {
        NSString *groupName = @"group.opang.SharedUserDefaultsIssue";  // app group identifier
        _sharedUserDefaults = [[NSUserDefaults alloc] initWithSuiteName:groupName];
    }
    
    // fetch previous vals from shared user defaults
    currNumberVal = [_sharedUserDefaults integerForKey:StoredNumKey];
    _numberLabel.text = [NSString stringWithFormat:@"%ld", currNumberVal];
    
    _persistedTextField.text = [_sharedUserDefaults objectForKey:StoredTextKey];
    
    // dump large amounts of garbage data into shared user defaults, if not already there.
    if ([_sharedUserDefaults objectForKey:StoredDictKey] == nil) {
        [self createMassiveObjSavedToUserDefaults];
    }
}

- (void)createMassiveObjSavedToUserDefaults {
    int const dictSize = 333333; // arbitrary big number. Sits at ~6MB of storage
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:dictSize];
    for (int i = 0; i <= dictSize; i++ ) {
        [dict setObject: @"Garbage data" forKey: [NSString stringWithFormat:@"%d", i]];
    }
    [_sharedUserDefaults setObject:dict forKey:StoredDictKey];
}

- (IBAction)incrementButtonPressed:(id)sender {
    // increment & save to shared user defaults
    currNumberVal++;
    _numberLabel.text = [NSString stringWithFormat:@"%ld", currNumberVal];

    [_sharedUserDefaults setInteger:currNumberVal forKey:StoredNumKey];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    // save to shared user defaults
    [_sharedUserDefaults setObject:textField.text forKey:StoredTextKey];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

@end
