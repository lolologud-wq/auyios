/*
This file is part of Telegram Desktop,
the official desktop application for the Telegram messaging service.

For license and copyright information please follow this link:
https://github.com/telegramdesktop/tdesktop/blob/master/LEGAL
*/
#pragma once

#include "platform/platform_main_window.h"

namespace Platform {

class MainWindow : public Window::MainWindow {
public:
	explicit MainWindow(not_null<Window::Controller*> controller);

	~MainWindow();

	void updateWindowIcon() override;

	rpl::producer<QPoint> globalForceClicks() override {
		return _forceClicks.events();
	}

	class Private;

protected:
	bool eventFilter(QObject *obj, QEvent *evt) override;

	void stateChangedHook(Qt::WindowState state) override;
	void initHook() override;
	void unreadCounterChangedHook() override;

	void updateGlobalMenuHook() override;

	void closeWithoutDestroy() override;
	void createGlobalMenu() override;

private:
	bool nativeEvent(
		const QByteArray &eventType,
		void *message,
		qintptr *result) override;

	std::unique_ptr<Private> _private;

	mutable bool psIdle;
	mutable QTimer psIdleTimer;

	rpl::event_stream<QPoint> _forceClicks;

};

} // namespace Platform

