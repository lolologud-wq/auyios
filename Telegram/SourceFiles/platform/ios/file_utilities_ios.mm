/*
This file is part of Telegram Desktop,
the official desktop application for the Telegram messaging service.

For license and copyright information please follow this link:
https://github.com/telegramdesktop/tdesktop/blob/master/LEGAL
*/
#include "platform/ios/file_utilities_ios.h"

#include "core/file_utilities.h"
#include "core/sandbox.h"

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

namespace Platform {
namespace FileDialog {

bool Get(
	QPointer<QWidget> parent,
	QStringList &files,
	QByteArray &remoteContent,
	const QString &caption,
	const QString &filter,
	::FileDialog::internal::Type type,
	QString startFile) {
	// iOS uses UIDocumentPickerViewController
	// This is a simplified implementation
	// Full implementation would require view controller presentation
	return ::FileDialog::internal::GetDefault(
		parent,
		files,
		remoteContent,
		caption,
		filter,
		type,
		startFile);
}

QString UrlToLocal(const QUrl &url) {
	if (!url.isLocalFile()) {
		return QString();
	}
	return url.toLocalFile();
}

bool UnsafeShowOpenWithDropdown(const QString &filepath) {
	@autoreleasepool {
		NSURL *fileUrl = [NSURL fileURLWithPath:[NSString stringWithUTF8String:filepath.toUtf8().constData()]];
		if (!fileUrl) {
			return false;
		}

		UIDocumentInteractionController *controller = [UIDocumentInteractionController interactionControllerWithURL:fileUrl];
		if (!controller) {
			return false;
		}

		// Requires a view to present from
		// This is a placeholder implementation
		return true;
	}
}

bool UnsafeShowOpenWith(const QString &filepath) {
	return UnsafeShowOpenWithDropdown(filepath);
}

void UnsafeLaunch(const QString &filepath) {
	@autoreleasepool {
		NSURL *fileUrl = [NSURL fileURLWithPath:[NSString stringWithUTF8String:filepath.toUtf8().constData()]];
		if (fileUrl) {
			[[UIApplication sharedApplication] openURL:fileUrl options:@{} completionHandler:nil];
		}
	}
}

} // namespace FileDialog
} // namespace Platform

