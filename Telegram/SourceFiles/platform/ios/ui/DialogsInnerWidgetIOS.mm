/*
This file is part of Telegram Desktop,
the official desktop application for the Telegram messaging service.

For license and copyright information please follow this link:
https://github.com/telegramdesktop/tdesktop/blob/master/LEGAL
*/
#include "platform/ios/ui/DialogsInnerWidgetIOS.h"
#include "dialogs/dialogs_inner_widget.h"
#include "window/window_session_controller.h"
#include "dialogs/dialogs_row.h"

#import <UIKit/UIKit.h>

// Custom cell for dialog display
@interface DialogCell : UITableViewCell
@property (strong, nonatomic) UIImageView *avatarView;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *messageLabel;
@property (strong, nonatomic) UILabel *timeLabel;
@property (strong, nonatomic) UILabel *unreadBadge;
- (void)configureWithRow:(Dialogs::Row *)row;
@end

@implementation DialogCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Create avatar view
        _avatarView = [[UIImageView alloc] init];
        _avatarView.layer.cornerRadius = 25;
        _avatarView.clipsToBounds = YES;
        _avatarView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:_avatarView];
        
        // Create name label
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont boldSystemFontOfSize:16];
        _nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:_nameLabel];
        
        // Create message label
        _messageLabel = [[UILabel alloc] init];
        _messageLabel.font = [UIFont systemFontOfSize:14];
        _messageLabel.textColor = [UIColor secondaryLabelColor];
        _messageLabel.numberOfLines = 1;
        _messageLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:_messageLabel];
        
        // Create time label
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont systemFontOfSize:12];
        _timeLabel.textColor = [UIColor secondaryLabelColor];
        _timeLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:_timeLabel];
        
        // Create unread badge
        _unreadBadge = [[UILabel alloc] init];
        _unreadBadge.backgroundColor = [UIColor systemBlueColor];
        _unreadBadge.textColor = [UIColor whiteColor];
        _unreadBadge.font = [UIFont boldSystemFontOfSize:12];
        _unreadBadge.textAlignment = NSTextAlignmentCenter;
        _unreadBadge.layer.cornerRadius = 10;
        _unreadBadge.clipsToBounds = YES;
        _unreadBadge.translatesAutoresizingMaskIntoConstraints = NO;
        _unreadBadge.hidden = YES;
        [self.contentView addSubview:_unreadBadge];
        
        // Setup constraints
        [NSLayoutConstraint activateConstraints:@[
            [_avatarView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:12],
            [_avatarView.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor],
            [_avatarView.widthAnchor constraintEqualToConstant:50],
            [_avatarView.heightAnchor constraintEqualToConstant:50],
            
            [_nameLabel.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:12],
            [_nameLabel.leadingAnchor constraintEqualToAnchor:_avatarView.trailingAnchor constant:12],
            [_nameLabel.trailingAnchor constraintLessThanOrEqualToAnchor:_timeLabel.leadingAnchor constant:-8],
            
            [_timeLabel.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:12],
            [_timeLabel.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-12],
            
            [_messageLabel.topAnchor constraintEqualToAnchor:_nameLabel.bottomAnchor constant:4],
            [_messageLabel.leadingAnchor constraintEqualToAnchor:_avatarView.trailingAnchor constant:12],
            [_messageLabel.trailingAnchor constraintLessThanOrEqualToAnchor:_unreadBadge.leadingAnchor constant:-8],
            [_messageLabel.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-12],
            
            [_unreadBadge.centerYAnchor constraintEqualToAnchor:_messageLabel.centerYAnchor],
            [_unreadBadge.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-12],
            [_unreadBadge.widthAnchor constraintGreaterThanOrEqualToConstant:20],
            [_unreadBadge.heightAnchor constraintEqualToConstant:20]
        ]];
    }
    return self;
}

- (void)configureWithRow:(Dialogs::Row *)row {
    // Configure cell with dialog row data
    // This requires integration with Dialogs::Row C++ structure
    _nameLabel.text = @"Dialog Name"; // Placeholder
    _messageLabel.text = @"Last message"; // Placeholder
    _timeLabel.text = @"12:00"; // Placeholder
    
    // Show/hide unread badge
    // int unreadCount = row->unreadCount();
    // _unreadBadge.hidden = (unreadCount == 0);
    // _unreadBadge.text = [NSString stringWithFormat:@"%d", unreadCount];
}

@end

@implementation DialogsInnerWidgetIOS {
    Window::SessionController *_controller;
    UITableView *_tableView;
    NSMutableArray *_dialogs; // Will hold Dialogs::Row pointers
}

- (instancetype)initWithController:(Window::SessionController *)controller {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _controller = controller;
        _dialogs = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor systemBackgroundColor];
    
    // Create table view
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.translatesAutoresizingMaskIntoConstraints = NO;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = 70;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [_tableView registerClass:[DialogCell class] forCellReuseIdentifier:@"DialogCell"];
    [self.view addSubview:_tableView];
    
    // Setup constraints
    [NSLayoutConstraint activateConstraints:@[
        [_tableView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
        [_tableView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [_tableView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [_tableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor]
    ]];
}

- (void)updateDialogs {
    // Reload dialogs from Dialogs::List
    // This requires integration with Dialogs C++ class
    dispatch_async(dispatch_get_main_queue(), ^{
        [self->_tableView reloadData];
    });
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dialogs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DialogCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DialogCell" forIndexPath:indexPath];
    
    // Configure cell with dialog
    // Dialogs::Row *dialog = _dialogs[indexPath.row];
    // [cell configureWithRow:dialog];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // Open dialog
    // Dialogs::Row *row = _dialogs[indexPath.row];
    // _controller->showThread(row->key());
}

@end

