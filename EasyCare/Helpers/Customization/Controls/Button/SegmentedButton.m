/*============================================================================
 PROJECT: EasyCare
 FILE:    SegmentedButton.m
 AUTHOR:  Vien Tran
 DATE:    12/14/14
 =============================================================================*/

/*============================================================================
 IMPORT
 =============================================================================*/
#import "SegmentedButton.h"

/*============================================================================
 PRIVATE MACRO
 =============================================================================*/
/*============================================================================
 PRIVATE INTERFACE
 =============================================================================*/
@interface SegmentedButton()

@property (nonatomic) UIView *selectedView;

@end

@implementation SegmentedButton

- (void)awakeFromNib{
    [super awakeFromNib];
    
    
    [self setTitleColor:UIColorFromHexaRGB(0x4c4c4c) forState:UIControlStateNormal];
    [self setTitleColor:UIColorFromHexaRGB(0x1865ac) forState:UIControlStateSelected];
    [[self titleLabel] setFont:FontRobotoBoldWithSize(12)];
    
    CGRect selectedViewFrame = self.bounds;
    selectedViewFrame.size.height = 2;
    selectedViewFrame.origin.y = self.bounds.size.height - 2;
    self.selectedView = [[UIView alloc] initWithFrame:selectedViewFrame];
    self.selectedView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self addSubview:self.selectedView];
    
    self.selected = self.selected;
}

- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    
    if (selected) {
        [self.selectedView setBackgroundColor:UIColorFromHexaRGB(0x3694EB)];
    }else{
        [self.selectedView setBackgroundColor:[UIColor clearColor]];
    }
}

@end
