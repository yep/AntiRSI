/*
 * author: Onne Gorter <o.gorter@gmail.com>
 * package: antirsi-macosx
 * license: GPL
 */

#import "AntiRSIView.h"

@implementation AntiRSIView

- (instancetype)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.blendingMode = NSVisualEffectBlendingModeBehindWindow;
        self.material = NSVisualEffectMaterialPopover;
        self.state = NSVisualEffectStateActive;
        
        [self setMaskImage:[self maskImageWithBounds:self.bounds]];
    }
    return self;
}

// based on https://stackoverflow.com/a/28256073
- (NSImage *)maskImageWithBounds:(NSRect)bounds
{
    return [NSImage imageWithSize:bounds.size flipped:YES drawingHandler:^BOOL(NSRect dstRect) {
        NSBezierPath *path = [NSBezierPath bezierPathWithRoundedRect:bounds xRadius:25.0 yRadius:25.0];
        
        [path setLineJoinStyle:NSRoundLineJoinStyle];
        [path fill];
        
        return YES;
    }];
}

@end

// MARK: - AntiRSIButton

@implementation AntiRSIButton

// prevents AntiRSI activation on mouse down
- (BOOL)shouldDelayWindowOrderingForEvent:(NSEvent *)e {
    return YES;
}

- (void)mouseDown:(NSEvent *)e {
    [NSApp preventWindowOrdering];
    [super mouseDown:e];
}

@end

