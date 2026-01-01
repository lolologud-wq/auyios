/*
This file is part of Telegram Desktop,
the official desktop application for the Telegram messaging service.

For license and copyright information please follow this link:
https://github.com/telegramdesktop/tdesktop/blob/master/LEGAL
*/
#include "platform/ios/ui/HistoryInnerWidgetIOS.h"
#include "history/history_inner_widget.h"
#include "window/window_session_controller.h"
#include "history/history.h"
#include "history/history_item.h"

#import <UIKit/UIKit.h>

// Custom cell for message display
@interface MessageCell : UICollectionViewCell
@property (strong, nonatomic) UILabel *textLabel;
@property (strong, Nonatomic) UIImageView *avatarView;
@property (strong, nonatomic) UILabel *timeLabel;
@property (strong, nonatomic) UIView *bubbleView;
- (void)configureWithMessage:(HistoryItem *)message;
@end

@implementation MessageCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Create bubble view
        _bubbleView = [[UIView alloc] init];
        _bubbleView.backgroundColor = [UIColor systemBlueColor];
        _bubbleView.layer.cornerRadius = 18;
        _bubbleView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:_bubbleView];
        
        // Create text label
        _textLabel = [[UILabel alloc] init];
        _textLabel.numberOfLines = 0;
        _textLabel.textColor = [UIColor whiteColor];
        _textLabel.font = [UIFont systemFontOfSize:16];
        _textLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [_bubbleView addSubview:_textLabel];
        
        // Create time label
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textColor = [UIColor whiteColor];
        _timeLabel.font = [UIFont systemFontOfSize:12];
        _timeLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [_bubbleView addSubview:_timeLabel];
        
        // Create avatar view
        _avatarView = [[UIImageView alloc] init];
        _avatarView.layer.cornerRadius = 20;
        _avatarView.clipsToBounds = YES;
        _avatarView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:_avatarView];
        
        // Setup constraints
        [NSLayoutConstraint activateConstraints:@[
            [_bubbleView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:60],
            [_bubbleView.trailingAnchor constraintLessThanOrEqualToAnchor:self.contentView.trailingAnchor constant:-60],
            [_bubbleView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:4],
            [_bubbleView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-4],
            
            [_textLabel.topAnchor constraintEqualToAnchor:_bubbleView.topAnchor constant:8],
            [_textLabel.leadingAnchor constraintEqualToAnchor:_bubbleView.leadingAnchor constant:12],
            [_textLabel.trailingAnchor constraintEqualToAnchor:_bubbleView.trailingAnchor constant:-12],
            
            [_timeLabel.topAnchor constraintEqualToAnchor:_textLabel.bottomAnchor constant:4],
            [_timeLabel.trailingAnchor constraintEqualToAnchor:_bubbleView.trailingAnchor constant:-8],
            [_timeLabel.bottomAnchor constraintEqualToAnchor:_bubbleView.bottomAnchor constant:-8],
            
            [_avatarView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:8],
            [_avatarView.topAnchor constraintEqualToAnchor:_bubbleView.topAnchor],
            [_avatarView.widthAnchor constraintEqualToConstant:40],
            [_avatarView.heightAnchor constraintEqualToConstant:40]
        ]];
    }
    return self;
}

- (void)configureWithMessage:(HistoryItem *)message {
    // Configure cell with message data
    // This requires integration with HistoryItem C++ structure
    _textLabel.text = @"Message text"; // Placeholder
    _timeLabel.text = @"12:00"; // Placeholder
}

@end

@implementation HistoryInnerWidgetIOS {
    Window::SessionController *_controller;
    UICollectionView *_collectionView;
    NSMutableArray *_messages; // Will hold HistoryItem pointers
}

- (instancetype)initWithController:(Window::SessionController *)controller {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _controller = controller;
        _messages = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor systemBackgroundColor];
    
    // Create collection view layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumLineSpacing = 4;
    layout.minimumInteritemSpacing = 0;
    layout.estimatedItemSize = CGSizeMake(self.view.bounds.size.width, 60);
    
    // Create collection view
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    _collectionView.backgroundColor = [UIColor systemBackgroundColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [_collectionView registerClass:[MessageCell class] forCellWithReuseIdentifier:@"MessageCell"];
    [self.view addSubview:_collectionView];
    
    // Setup constraints
    [NSLayoutConstraint activateConstraints:@[
        [_collectionView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
        [_collectionView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [_collectionView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [_collectionView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor]
    ]];
}

- (void)updateMessages {
    // Reload messages from History
    // This requires integration with History C++ class
    dispatch_async(dispatch_get_main_queue(), ^{
        [self->_collectionView reloadData];
    });
}

- (void)scrollToMessage:(MsgId)msgId {
    // Find and scroll to specific message
    // This requires integration with message indexing
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _messages.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MessageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MessageCell" forIndexPath:indexPath];
    
    // Configure cell with message
    // HistoryItem *message = _messages[indexPath.item];
    // [cell configureWithMessage:message];
    
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    // Calculate size based on message content
    return CGSizeMake(collectionView.bounds.size.width, 60);
}

@end

