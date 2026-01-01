/*
This file is part of Telegram Desktop,
the official desktop application for the Telegram messaging service.

For license and copyright information please follow this link:
https://github.com/telegramdesktop/tdesktop/blob/master/LEGAL
*/
#pragma once

#include "window/main_window.h"

namespace Platform {

class MainWindow;

} // namespace Platform

// Platform dependent implementations.

#ifdef Q_OS_WIN
#include "platform/win/main_window_win.h"
#elif defined Q_OS_IOS || (defined Q_OS_MAC && defined TARGET_OS_IPHONE && TARGET_OS_IPHONE) // Q_OS_WIN
#include "platform/ios/main_window_ios.h"
#elif defined Q_OS_MAC // Q_OS_WIN || Q_OS_IOS
#include "platform/mac/main_window_mac.h"
#else // Q_OS_WIN || Q_OS_MAC || Q_OS_IOS
#include "platform/linux/main_window_linux.h"
#endif // else Q_OS_WIN || Q_OS_MAC || Q_OS_IOS
