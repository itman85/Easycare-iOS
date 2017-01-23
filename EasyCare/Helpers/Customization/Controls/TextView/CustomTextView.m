/*============================================================================
 PROJECT: EasyCare
 FILE:    CustomTextView.m
 AUTHOR:  Vien Tran
 DATE:    12/20/14
 =============================================================================*/

/*============================================================================
 IMPORT
 =============================================================================*/
#import "CustomTextView.h"

/*============================================================================
 PRIVATE MACRO
 =============================================================================*/
/*============================================================================
 PRIVATE INTERFACE
 =============================================================================*/


@implementation CustomTextView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.font = FontRobotoWithSize(12);
    [self setTextColor:[UIColor textFieldTextColor]];
    [self setBackgroundColor:[UIColor textFieldBackgroundColor]];

    
    self.layer.cornerRadius = 1;
    
    if (!hideToolbar) {
        UIToolbar* toolbar = [[UIToolbar alloc] init];
        toolbar.barStyle = UIBarStyleDefault;
        [toolbar sizeToFit];
        
        NSDictionary *fontAttribute = @{NSFontAttributeName: FontRobotoWithSize(13)};
        
        UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Done", nil)
                                                                       style:UIBarButtonItemStyleDone target:self
                                                                      action:@selector(resignFirstResponder)];
        [doneButton setTitleTextAttributes:fontAttribute forState:UIControlStateNormal];
        
        //to make the done button aligned to the right
        UIBarButtonItem *flexibleSpaceLeft = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
        if (!hideNextButton) {
            UISegmentedControl *preNextSegmentControl = [[UISegmentedControl alloc] initWithItems:@[NSLocalizedString(@"Previous", nil), NSLocalizedString(@"Next", nil)]];
            [preNextSegmentControl setTitleTextAttributes:fontAttribute forState:UIControlStateNormal];
            //            [preNextSegmentControl setSegmentedControlStyle:UISegmentedControlStyleBar];
            [preNextSegmentControl setMomentary:YES];
            preNextSegmentControl.frame = CGRectMake(0, 0, 120, 29);
            [preNextSegmentControl addTarget:self action:@selector(prevNextSegmentValueChange:) forControlEvents:UIControlEventValueChanged];
            UIBarButtonItem *preNextBarButton = [[UIBarButtonItem alloc] initWithCustomView:preNextSegmentControl];
            
            [toolbar setItems:[NSArray arrayWithObjects:preNextBarButton, flexibleSpaceLeft, doneButton, nil]];
        }else{
            [toolbar setItems:[NSArray arrayWithObjects:flexibleSpaceLeft, doneButton, nil]];
        }
        
        self.inputAccessoryView = toolbar;
    }
    
}


- (void)prevNextSegmentValueChange:(UISegmentedControl*)sender{
    if (sender.selectedSegmentIndex == 0) { //Touch on prev
        [self changeFirstResponderToTextFieldWithTag:self.tag - 1];
        
        //        if (self.delegate && [self.delegate respondsToSelector:@selector(textFieldDidSelectPrevButton:)]) {
        //            [(id<BDCustomTextFieldDelegate>)self.delegate textFieldDidSelectPrevButton:self];
        //        }
    }else{ //Touch on next
        [self changeFirstResponderToTextFieldWithTag:self.tag + 1];
        
        //        if (self.delegate && [self.delegate respondsToSelector:@selector(textFieldDidSelectNextButton:)]) {
        //            [(id<BDCustomTextFieldDelegate>)self.delegate textFieldDidSelectNextButton:self];
        //        }
    }
}

- (void)changeFirstResponderToNextTextField{
    [self changeFirstResponderToTextFieldWithTag:self.tag + 1];
}

#pragma mark - Private Method
- (void)changeFirstResponderToTextFieldWithTag:(NSInteger)tag{
    id neighborTextField = [self.superview viewWithTag:tag];
    if (neighborTextField && ([neighborTextField isKindOfClass:[UITextField class]] || [neighborTextField isKindOfClass:[UITextView class]])) {
        [(UITextField*)neighborTextField becomeFirstResponder];
    }else{
        [self resignFirstResponder];
    }
}


@end
