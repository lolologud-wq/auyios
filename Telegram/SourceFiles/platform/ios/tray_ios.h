/*
This file is part of Telegram Desktop,
the official desktop application for the Telegram messaging service.

For license and copyright information please follow this link:
https://github.com/telegramdesktop/tdesktop/blob/master/LEGAL
*/
#pragma once

#include "platform/platform_tray.h"

namespace Platform {

inline bool HasMonochromeSetting() {
	return false; // iOS doesn't have tray icon
}

class Tray final {
public:
	Tray();
	~Tray();

	[[nodiscard]] rpl::producer<> aboutToShowRequests() const;
	[[nodiscard]] rpl::producer<> showFromTrayRequests() const;
	[[nodiscard]] rpl::producer<> hideToTrayRequests() const;
	[[nodiscard]] rpl::producer<> iconClicks() const;

	[[nodiscard]] bool hasIcon() const;

	void createIcon();
	void destroyIcon();

	void updateIcon();

	void createMenu();
	void destroyMenu();

	void addAction(rpl::producer<QString> text, Fn<void()> &&callback);

	void showTrayMessage() const;
	[[nodiscard]] bool hasTrayMessageSupport() const;

	[[nodiscard]] rpl::lifetime &lifetime();

private:
	rpl::lifetime _lifetime;
	rpl::event_stream<> _aboutToShowRequests;
	rpl::event_stream<> _showFromTrayRequests;
	rpl::event_stream<> _hideToTrayRequests;
	rpl::event_stream<> _iconClicks;

};

} // namespace Platform

