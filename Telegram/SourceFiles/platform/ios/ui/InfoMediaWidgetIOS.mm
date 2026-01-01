/*
This file is part of Telegram Desktop,
the official desktop application for the Telegram messaging service.

For license and copyright information please follow this link:
https://github.com/telegramdesktop/tdesktop/blob/master/LEGAL
*/
#include "platform/ios/ui/InfoMediaWidgetIOS.h"
#include "info/media/info_media_widget.h"
#include "info/info_controller.h"

#import <UIKit/UIKit.h>

// Custom cell for media item
@interface MediaCell : UICollectionViewCell
@property (strong, nonatomic) UIImageView *imageView;
@end

@implementation MediaCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
        _imageView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:_imageView];
        
        [NSLayoutConstraint activateConstraints:@[
            [_imageView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor],
            [_imageView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor],
            [_imageView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor],
            [_imageView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor]
        ]];
    }
    return self;
}

@end

@implementation InfoMediaWidgetIOS {
    Info::Controller *_controller;
    UICollectionView *_collectionView;
}

- (instancetype)initWithController:(Info::Controller *)controller {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _controller = controller;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor systemBackgroundColor];
    self.title = @"Media";
    
    // Create collection view layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumLineSpacing = 2;
    layout.minimumInteritemSpacing = 2;
    CGFloat itemSize = (self.view.bounds.size.width - 6) / 3;
    layout.itemSize = CGSizeMake(itemSize, itemSize);
    
    // Create collection view
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    _collectionView.backgroundColor = [UIColor systemBackgroundColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [_collectionView registerClass:[MediaCell class] forCellWithReuseIdentifier:@"MediaCell"];
    [self.view addSubview:_collectionView];
    
    // Setup constraints
    [NSLayoutConstraint activateConstraints:@[
        [_collectionView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
        [_collectionView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [_collectionView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [_collectionView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor]
    ]];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    // Placeholder - needs integration with media provider
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MediaCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MediaCell" forIndexPath:indexPath];
    
    // Configure cell with media item
    // This requires integration with Info::Media::Provider
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // Open media viewer
}

@end

