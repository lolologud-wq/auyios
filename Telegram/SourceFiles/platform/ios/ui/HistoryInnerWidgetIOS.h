/*
This file is part of Telegram Desktop,
the official desktop application for the Telegram messaging service.

For license and copyright information please follow this link:
https://github.com/telegramdesktop/tdesktop/blob/master/LEGAL
*/
#pragma once

#import <UIKit/UIKit.h>
#include "history/history_inner_widget.h"
#include "window/window_session_controller.h"

// iOS version of HistoryInnerWidget using UICollectionView
@interface HistoryInnerWidgetIOS : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

- (instancetype)initWithController:(Window::SessionController *)controller;
- (void)setupUI;
- (void)updateMessages;
- (void)scrollToMessage:(MsgId)msgId;

@end

