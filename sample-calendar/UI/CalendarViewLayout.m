//
//  CalendarViewLayout.m
//  sample-calendar
//
//  Created by Simon de Carufel on 2015-05-05.
//  Copyright (c) 2015 Simon de Carufel. All rights reserved.
//

#import "CalendarViewLayout.h"

static const CGFloat CalendarViewLayoutHourViewHeight = 60.0f;
static const CGFloat CalendarViewLayoutLeftPadding = 30.0f;
static const CGFloat CalendarViewLayoutRightPadding = 10.0f;
static const CGFloat CalendarViewLayoutTimeLinePadding = 6.0f;

@interface CalendarViewLayout()
@property (nonatomic) NSMutableArray *cellAttributes;
@property (nonatomic) NSMutableArray *hourAttributes;
@end

@implementation CalendarViewLayout

- (instancetype)init
{
    if (self = [super init]) {
        self.cellAttributes = [NSMutableArray new];
        self.hourAttributes = [NSMutableArray new];
    }
    return self;
}

- (CGSize)collectionViewContentSize
{
    // We need to add a padding since the last few pixels of every hour block are displayed in the next block (all but the last hour block, hence the padding)
    return CGSizeMake(self.collectionView.bounds.size.width, CalendarViewLayoutHourViewHeight * 24 + CalendarViewLayoutTimeLinePadding);
}

- (void)prepareLayout
{
    [self.cellAttributes removeAllObjects];
    [self.hourAttributes removeAllObjects];
    
    if ([self.collectionView.delegate conformsToProtocol:@protocol(CalendarViewLayoutDelegate)]) {
        id <CalendarViewLayoutDelegate> calendarViewLayoutDelegate = (id <CalendarViewLayoutDelegate>)self.collectionView.delegate;
        
        // Compute every events layoutAttributes
        for (NSInteger i = 0; i < [self.collectionView numberOfSections]; i++) {
            for (NSInteger j = 0; j < [self.collectionView numberOfItemsInSection:i]; j++) {
                NSIndexPath *cellIndexPath = [NSIndexPath indexPathForItem:j inSection:i];
                NSRange timespan = [calendarViewLayoutDelegate calendarViewLayout:self timespanForCellAtIndexPath:cellIndexPath];
                // Since the actual "line" in every hour block start a few pixels below the cell's top border,  give that same padding to every event time.
                CGFloat posY = timespan.location / 60.0f + CalendarViewLayoutTimeLinePadding;
                CGFloat height = timespan.length / 60.0f;
                
                UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:cellIndexPath];
                CGRect attributesFrame = attributes.frame;
                attributesFrame.origin = CGPointMake(CalendarViewLayoutLeftPadding, posY);
                attributesFrame.size = CGSizeMake(self.collectionView.bounds.size.width - CalendarViewLayoutLeftPadding - CalendarViewLayoutRightPadding, height);
                attributes.frame = attributesFrame;
                [self.cellAttributes addObject:attributes];
            }
        }
    }
    
    // Compute every 'hour block' layoutAttributes
    for (NSInteger i = 0; i < 24; i++) {
        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:@"hour" withIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        CGRect attributesFrame = CGRectZero;
        attributesFrame.size = CGSizeMake(self.collectionView.bounds.size.width, CalendarViewLayoutHourViewHeight);
        if (i == 23) {
            // Since it is the last hour block, we need to add the padding that was in every other block's beginning (before the line).
            attributesFrame.size.height += CalendarViewLayoutTimeLinePadding;
        }
        attributesFrame.origin = CGPointMake(0, i * CalendarViewLayoutHourViewHeight);
        attributes.frame = attributesFrame;
        [self.hourAttributes addObject:attributes];
    }
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *allAttributes = [NSMutableArray new];
    
    for (UICollectionViewLayoutAttributes *attributes in self.cellAttributes) {
        if (CGRectIntersectsRect(rect, attributes.frame)) {
            [allAttributes addObject:attributes];
        }
    }
    
    for (UICollectionViewLayoutAttributes *attributes in self.hourAttributes) {
        if (CGRectIntersectsRect(rect, attributes.frame)) {
            [allAttributes addObject:attributes];
        }
    }
    
    return allAttributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attributes = nil;
    NSInteger index = [self.cellAttributes indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        UICollectionViewLayoutAttributes *attributes = obj;
        *stop = [attributes.indexPath isEqual:indexPath];
        return *stop;
    }];
    
    if (index != NSNotFound) {
        attributes = [self.cellAttributes objectAtIndex:index];
    }
    return attributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attributes = nil;
    NSInteger index = [self.hourAttributes indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        UICollectionViewLayoutAttributes *attributes = obj;
        *stop = [attributes.indexPath isEqual:indexPath];
        return *stop;
    }];
    
    if (index != NSNotFound) {
        attributes = [self.hourAttributes objectAtIndex:index];
    }
    return attributes;
}

@end
