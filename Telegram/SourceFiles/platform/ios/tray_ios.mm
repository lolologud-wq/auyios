/*
This file is part of Telegram Desktop,
the official desktop application for the Telegram messaging service.

For license and copyright information please follow this link:
https://github.com/telegramdesktop/tdesktop/blob/master/LEGAL
*/
#include "platform/ios/tray_ios.h"

namespace Platform {

Tray::Tray() = default;

Tray::~Tray() = default;

rpl::producer<> Tray::aboutToShowRequests() const {
	return _aboutToShowRequests.events();
}

rpl::producer<> Tray::showFromTrayRequests() const {
	return _showFromTrayRequests.events();
}

rpl::producer<> Tray::hideToTrayRequests() const {
	return _hideToTrayRequests.events();
}

rpl::producer<> Tray::iconClicks() const {
	return _iconClicks.events();
}

bool Tray::hasIcon() const {
	return false; // iOS doesn't have tray icon
}

void Tray::createIcon() {
	// iOS doesn't have tray icon
}

void Tray::destroyIcon() {
	// iOS doesn't have tray icon
}

void Tray::updateIcon() {
	// iOS doesn't have tray icon
}

void Tray::createMenu() {
	// iOS doesn't have tray menu
}

void Tray::destroyMenu() {
	// iOS doesn't have tray menu
}

void Tray::addAction(rpl::producer<QString> text, Fn<void()> &&callback) {
	// iOS doesn't have tray menu
}

void Tray::showTrayMessage() const {
	// iOS doesn't have tray messages
}

bool Tray::hasTrayMessageSupport() const {
	return false;
}

rpl::lifetime &Tray::lifetime() {
	return _lifetime;
}

} // namespace Platform

