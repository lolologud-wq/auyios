/*
This file is part of Telegram Desktop,
the official desktop application for the Telegram messaging service.

For license and copyright information please follow this link:
https://github.com/telegramdesktop/tdesktop/blob/master/LEGAL
*/
#include "platform/ios/notifications_manager_ios.h"

#include "window/notifications_manager.h"
#include "base/platform/base_platform_info.h"

#import <UIKit/UIKit.h>
#import <UserNotifications/UserNotifications.h>

namespace Platform {
namespace Notifications {
namespace {

class Private {
public:
	Private(not_null<Manager*> manager);

private:
	not_null<Manager*> _manager;

};

Private::Private(not_null<Manager*> manager)
: _manager(manager) {
}

} // namespace

Manager::Manager(Window::Notifications::System *system)
: Window::Notifications::NativeManager(system)
, _private(std::make_unique<Private>(this)) {
}

Manager::~Manager() = default;

void Manager::doShowNativeNotification(
	NotificationInfo &&info,
	Ui::PeerUserpicView &userpicView) {
	// iOS uses UNUserNotificationCenter
	// Implementation would use UNUserNotificationCenter API
}

void Manager::doClearAllFast() {
	@autoreleasepool {
		if (@available(iOS 10.0, *)) {
			UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
			[center removeAllPendingNotificationRequests];
			[center removeAllDeliveredNotifications];
		}
	}
}

void Manager::doClearFromItem(not_null<HistoryItem*> item) {
	// Clear notifications for specific item
	doClearAllFast();
}

void Manager::doClearFromTopic(not_null<Data::ForumTopic*> topic) {
	// Clear notifications for topic
	doClearAllFast();
}

void Manager::doClearFromSublist(not_null<Data::SavedSublist*> sublist) {
	// Clear notifications for sublist
	doClearAllFast();
}

void Manager::doClearFromHistory(not_null<History*> history) {
	// Clear notifications for history
	doClearAllFast();
}

void Manager::doClearFromSession(not_null<Main::Session*> session) {
	// Clear notifications for session
	doClearAllFast();
}

QString Manager::accountNameSeparator() {
	return u" | "_q;
}

bool Manager::doSkipToast() const {
	return false;
}

void Manager::doMaybePlaySound(Fn<void()> playSound) {
	if (playSound) {
		playSound();
	}
}

void Manager::doMaybeFlashBounce(Fn<void()> flashBounce) {
	// iOS doesn't support flash/bounce
}

} // namespace Notifications
} // namespace Platform

namespace Platform {
namespace Notifications {

bool Supported() {
	if (@available(iOS 10.0, *)) {
		return true;
	}
	return false;
}

bool Enforced() {
	return false;
}

bool ByDefault() {
	return true;
}

bool VolumeSupported() {
	return true;
}

void Create(Window::Notifications::System *system) {
	system->setManager(std::make_unique<Manager>(system));
}

bool SkipToastForCustom() {
	return false;
}

void MaybePlaySoundForCustom(Fn<void()> playSound) {
	if (playSound) {
		playSound();
	}
}

void MaybeFlashBounceForCustom(Fn<void()> flashBounce) {
	// iOS doesn't support flash/bounce
}

bool WaitForInputForCustom() {
	return false;
}

} // namespace Notifications
} // namespace Platform

