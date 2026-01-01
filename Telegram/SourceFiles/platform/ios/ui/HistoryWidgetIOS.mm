/*
This file is part of Telegram Desktop,
the official desktop application for the Telegram messaging service.

For license and copyright information please follow this link:
https://github.com/telegramdesktop/tdesktop/blob/master/LEGAL
*/
#include "platform/ios/ui/HistoryWidgetIOS.h"
#include "platform/ios/ui/HistoryInnerWidgetIOS.h"
#include "history/history_widget.h"
#include "window/window_session_controller.h"
#include "dialogs/dialogs_key.h"

#import <UIKit/UIKit.h>

@implementation HistoryWidgetIOS {
    Window::SessionController *_controller;
    HistoryInnerWidgetIOS *_innerWidget;
    UITextField *_messageInput;
    UIButton *_sendButton;
    UIView *_inputContainer;
}

- (instancetype)initWithController:(Window::SessionController *)controller {
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
    
    // Create inner widget (handles message display)
    _innerWidget = [[HistoryInnerWidgetIOS alloc] initWithController:_controller];
    [self addChildViewController:_innerWidget];
    _innerWidget.view.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_innerWidget.view];
    [_innerWidget didMoveToParentViewController:self];
    
    // Create input area
    _inputContainer = [[UIView alloc] init];
    _inputContainer.backgroundColor = [UIColor secondarySystemBackgroundColor];
    _inputContainer.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_inputContainer];
    
    _messageInput = [[UITextField alloc] init];
    _messageInput.placeholder = @"Message";
    _messageInput.borderStyle = UITextBorderStyleRoundedRect;
    _messageInput.translatesAutoresizingMaskIntoConstraints = NO;
    [_inputContainer addSubview:_messageInput];
    
    _sendButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_sendButton setTitle:@"Send" forState:UIControlStateNormal];
    [_sendButton addTarget:self action:@selector(sendMessage) forControlEvents:UIControlEventTouchUpInside];
    _sendButton.translatesAutoresizingMaskIntoConstraints = NO;
    [_inputContainer addSubview:_sendButton];
    
    // Setup constraints
    [NSLayoutConstraint activateConstraints:@[
        // Inner widget (messages)
        [_innerWidget.view.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
        [_innerWidget.view.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [_innerWidget.view.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [_innerWidget.view.bottomAnchor constraintEqualToAnchor:_inputContainer.topAnchor],
        
        // Input container
        [_inputContainer.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [_inputContainer.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [_inputContainer.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor],
        [_inputContainer.heightAnchor constraintEqualToConstant:60],
        
        // Message input
        [_messageInput.leadingAnchor constraintEqualToAnchor:_inputContainer.leadingAnchor constant:8],
        [_messageInput.trailingAnchor constraintEqualToAnchor:_sendButton.leadingAnchor constant:-8],
        [_messageInput.centerYAnchor constraintEqualToAnchor:_inputContainer.centerYAnchor],
        [_messageInput.heightAnchor constraintEqualToConstant:40],
        
        // Send button
        [_sendButton.trailingAnchor constraintEqualToAnchor:_inputContainer.trailingAnchor constant:-8],
        [_sendButton.centerYAnchor constraintEqualToAnchor:_inputContainer.centerYAnchor],
        [_sendButton.widthAnchor constraintEqualToConstant:60]
    ]];
}

- (void)sendMessage {
    NSString *text = _messageInput.text;
    if (text.length > 0) {
        // Send message via C++ backend
        // _controller->sendMessage(text);
        _messageInput.text = @"";
    }
}

- (void)showHistory:(Dialogs::Key)key {
    // Load and display history for the given key
    // This requires integration with History::Widget C++ backend
}

@end

