/*
This file is part of Telegram Desktop,
the official desktop application for the Telegram messaging service.

For license and copyright information please follow this link:
https://github.com/telegramdesktop/tdesktop/blob/master/LEGAL
*/
#include "platform/ios/main_window_ios.h"

#include "data/data_session.h"
#include "core/application.h"
#include "core/sandbox.h"
#include "main/main_session.h"
#include "history/history_widget.h"
#include "history/history_inner_widget.h"
#include "main/main_account.h"
#include "main/main_domain.h"
#include "media/player/media_player_instance.h"
#include "media/audio/media_audio.h"
#include "storage/localstorage.h"
#include "ui/text/text_utilities.h"
#include "window/window_controller.h"
#include "window/window_session_controller.h"
#include "platform/platform_specific.h"
#include "platform/platform_notifications_manager.h"
#include "base/platform/base_platform_info.h"
#include "base/options.h"
#include "lang/lang_keys.h"

#include <QtWidgets/QApplication>

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface MainWindowObserver : NSObject {
}

- (id) init:(Platform::MainWindow::Private*)window;
- (void) applicationDidBecomeActive:(NSNotification *)aNotification;
- (void) applicationWillResignActive:(NSNotification *)aNotification;
- (void) applicationDidEnterBackground:(NSNotification *)aNotification;
- (void) applicationWillEnterForeground:(NSNotification *)aNotification;

@end // @interface MainWindowObserver

namespace Platform {
namespace {

} // namespace

class MainWindow::Private {
public:
	explicit Private(not_null<MainWindow*> window);

	void setNativeWindow(UIWindow *window, UIView *view);
	void setWindowBadge(const QString &str);

	~Private();

private:
	not_null<MainWindow*> _public;
	friend class MainWindow;

	UIWindow * __weak _nativeWindow = nil;
	UIView * __weak _nativeView = nil;

	MainWindowObserver *_observer = nullptr;

};

} // namespace Platform

@implementation MainWindowObserver {
	Platform::MainWindow::Private *_private;

}

- (id) init:(Platform::MainWindow::Private*)window {
	if (self = [super init]) {
		_private = window;
		NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
		[center addObserver:self
			selector:@selector(applicationDidBecomeActive:)
			name:UIApplicationDidBecomeActiveNotification
			object:nil];
		[center addObserver:self
			selector:@selector(applicationWillResignActive:)
			name:UIApplicationWillResignActiveNotification
			object:nil];
		[center addObserver:self
			selector:@selector(applicationDidEnterBackground:)
			name:UIApplicationDidEnterBackgroundNotification
			object:nil];
		[center addObserver:self
			selector:@selector(applicationWillEnterForeground:)
			name:UIApplicationWillEnterForegroundNotification
			object:nil];
	}
	return self;
}

- (void) applicationDidBecomeActive:(NSNotification *)aNotification {
	Core::Sandbox::Instance().customEnterFromEventLoop([&] {
		Core::App().updateIsActive();
	});
}

- (void) applicationWillResignActive:(NSNotification *)aNotification {
	Core::Sandbox::Instance().customEnterFromEventLoop([&] {
		Core::App().updateIsActive();
	});
}

- (void) applicationDidEnterBackground:(NSNotification *)aNotification {
	Core::Sandbox::Instance().customEnterFromEventLoop([&] {
		Core::App().updateIsActive();
	});
}

- (void) applicationWillEnterForeground:(NSNotification *)aNotification {
	Core::Sandbox::Instance().customEnterFromEventLoop([&] {
		Core::App().updateIsActive();
	});
}

- (void) dealloc {
	NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
	[center removeObserver:self];
	[super dealloc];
}

@end // @implementation MainWindowObserver

namespace Platform {

MainWindow::Private::Private(not_null<MainWindow*> window)
: _public(window)
, _observer([[MainWindowObserver alloc] init:this]) {
}

MainWindow::Private::~Private() {
	[_observer release];
}

void MainWindow::Private::setNativeWindow(UIWindow *window, UIView *view) {
	_nativeWindow = window;
	_nativeView = view;
}

void MainWindow::Private::setWindowBadge(const QString &str) {
	@autoreleasepool {
		UIApplication *app = [UIApplication sharedApplication];
		if (str.isEmpty()) {
			app.applicationIconBadgeNumber = 0;
		} else {
			bool ok = false;
			int count = str.toInt(&ok);
			if (ok && count > 0) {
				app.applicationIconBadgeNumber = count;
			}
		}
	}
}

MainWindow::MainWindow(not_null<Window::Controller*> controller)
: Window::MainWindow(controller)
, _private(std::make_unique<Private>(this))
, psIdle(false) {
}

MainWindow::~MainWindow() {
}

void MainWindow::updateWindowIcon() {
	// iOS uses app icon from Info.plist
}

bool MainWindow::eventFilter(QObject *obj, QEvent *evt) {
	return Window::MainWindow::eventFilter(obj, evt);
}

void MainWindow::stateChangedHook(Qt::WindowState state) {
	Window::MainWindow::stateChangedHook(state);
}

void MainWindow::initHook() {
	Window::MainWindow::initHook();
}

void MainWindow::unreadCounterChangedHook() {
	Window::MainWindow::unreadCounterChangedHook();
	
	// Update badge
	const auto session = sessionController();
	if (session) {
		const auto count = session->data().unreadBadge();
		_private->setWindowBadge(count > 0 ? QString::number(count) : QString());
	}
}

void MainWindow::updateGlobalMenuHook() {
	// iOS doesn't have global menu
}

void MainWindow::closeWithoutDestroy() {
	Window::MainWindow::closeWithoutDestroy();
}

void MainWindow::createGlobalMenu() {
	// iOS doesn't have global menu
}

bool MainWindow::nativeEvent(
	const QByteArray &eventType,
	void *message,
	qintptr *result) {
	return Window::MainWindow::nativeEvent(eventType, message, result);
}

} // namespace Platform

