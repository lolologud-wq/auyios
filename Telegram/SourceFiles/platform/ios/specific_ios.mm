/*
This file is part of Telegram Desktop,
the official desktop application for the Telegram messaging service.

For license and copyright information please follow this link:
https://github.com/telegramdesktop/tdesktop/blob/master/LEGAL
*/
#include "platform/ios/specific_ios.h"

#include "lang/lang_keys.h"
#include "mainwidget.h"
#include "history/history_widget.h"
#include "core/crash_reports.h"
#include "core/sandbox.h"
#include "core/application.h"
#include "core/core_settings.h"
#include "storage/localstorage.h"
#include "window/window_controller.h"
#include "mainwindow.h"
#include "history/history_location_manager.h"
#include "base/platform/base_platform_info.h"
#include "main/main_session.h"
#include "window/window_session_controller.h"
#include "base/options.h"

#include <QtGui/QDesktopServices>
#include <QtWidgets/QApplication>

#include <cstdlib>

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

namespace {

[[nodiscard]] QImage ImageFromUI(UIImage *image) {
	if (!image) {
		return QImage();
	}

	CGImageRef cgImage = [image CGImage];
	if (!cgImage) {
		return QImage();
	}

	const int width = CGImageGetWidth(cgImage);
	const int height = CGImageGetHeight(cgImage);
	auto result = QImage(width, height, QImage::Format_ARGB32_Premultiplied);
	result.fill(Qt::transparent);

	CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
	CGBitmapInfo info = kCGBitmapByteOrder32Host | kCGImageAlphaPremultipliedFirst;
	CGContextRef context = CGBitmapContextCreate(
		result.bits(),
		width,
		height,
		8,
		result.bytesPerLine(),
		space,
		info);

	CGRect rect = CGRectMake(0, 0, width, height);
	CGContextDrawImage(context, rect, cgImage);

	CFRelease(space);
	CFRelease(context);

	return result;
}

[[nodiscard]] QImage ResolveAppIconDefault() {
	NSBundle *bundle = [NSBundle mainBundle];
	NSString *iconName = nil;
	NSArray *icons = [[bundle infoDictionary] objectForKey:@"CFBundleIconFiles"];
	if (icons && [icons count] > 0) {
		iconName = [icons objectAtIndex:0];
	} else {
		icons = [[bundle infoDictionary] objectForKey:@"CFBundleIcons"];
		if (icons) {
			NSDictionary *primaryIcon = [icons objectForKey:@"CFBundlePrimaryIcon"];
			if (primaryIcon) {
				NSArray *iconFiles = [primaryIcon objectForKey:@"CFBundleIconFiles"];
				if (iconFiles && [iconFiles count] > 0) {
					iconName = [iconFiles objectAtIndex:0];
				}
			}
		}
	}

	if (iconName) {
		UIImage *image = [UIImage imageNamed:iconName];
		if (image) {
			return ImageFromUI(image);
		}
	}

	return Window::Logo();
}

} // namespace

QString psAppDataPath() {
	@autoreleasepool {
		NSArray *paths = NSSearchPathForDirectoriesInDomains(
			NSDocumentDirectory,
			NSUserDomainMask,
			YES);
		if ([paths count] > 0) {
			NSString *documentsPath = [paths objectAtIndex:0];
			return QString::fromUtf8([documentsPath UTF8String]);
		}
	}
	return QString();
}

void psDoCleanup() {
	try {
		Platform::AutostartToggle(false);
		psSendToMenu(false, true);
	} catch (...) {
	}
}

int psCleanup() {
	psDoCleanup();
	return 0;
}

void psDoFixPrevious() {
}

int psFixPrevious() {
	psDoFixPrevious();
	return 0;
}

namespace Platform {

void start() {
	// iOS-specific initialization
}

void finish() {
	// iOS-specific cleanup
}

QString SingleInstanceLocalServerName(const QString &hash) {
	@autoreleasepool {
		NSString *tmpDir = NSTemporaryDirectory();
		QString tmpPath = QString::fromUtf8([tmpDir UTF8String]);
		return tmpPath + hash + '-' + cGUIDStr();
	}
}

#if QT_VERSION < QT_VERSION_CHECK(6, 5, 0)
std::optional<bool> IsDarkMode() {
	@autoreleasepool {
		if (@available(iOS 13.0, *)) {
			UIUserInterfaceStyle style = [UIScreen mainScreen].traitCollection.userInterfaceStyle;
			return style == UIUserInterfaceStyleDark;
		}
	}
	return std::nullopt;
}
#endif // Qt < 6.5.0

void SetApplicationIcon(const QIcon &icon) {
	// iOS uses app icon from Info.plist, not runtime setting
}

PermissionStatus GetPermissionStatus(PermissionType type) {
	@autoreleasepool {
		switch (type) {
			case PermissionType::Microphone: {
				AVAudioSessionRecordPermission permission = [[AVAudioSession sharedInstance] recordPermission];
				switch (permission) {
					case AVAudioSessionRecordPermissionGranted:
						return PermissionStatus::Granted;
					case AVAudioSessionRecordPermissionDenied:
						return PermissionStatus::Denied;
					case AVAudioSessionRecordPermissionUndetermined:
						return PermissionStatus::CanRequest;
				}
				break;
			}
			case PermissionType::Camera: {
				AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
				if (device) {
					AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
					switch (status) {
						case AVAuthorizationStatusAuthorized:
							return PermissionStatus::Granted;
						case AVAuthorizationStatusDenied:
						case AVAuthorizationStatusRestricted:
							return PermissionStatus::Denied;
						case AVAuthorizationStatusNotDetermined:
							return PermissionStatus::CanRequest;
					}
				}
				break;
			}
		}
	}
	return PermissionStatus::Denied;
}

void RequestPermission(PermissionType type, Fn<void(PermissionStatus)> resultCallback) {
	@autoreleasepool {
		switch (type) {
			case PermissionType::Microphone: {
				[[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted) {
					resultCallback(granted ? PermissionStatus::Granted : PermissionStatus::Denied);
				}];
				break;
			}
			case PermissionType::Camera: {
				[AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
					resultCallback(granted ? PermissionStatus::Granted : PermissionStatus::Denied);
				}];
				break;
			}
		}
	}
}

void OpenSystemSettingsForPermission(PermissionType type) {
	NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
	if (url && [[UIApplication sharedApplication] canOpenURL:url]) {
		[[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
	}
}

bool OpenSystemSettings(SystemSettingsType type) {
	NSURL *url = nil;
	switch (type) {
		case SystemSettingsType::Audio: {
			url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
			break;
		}
	}
	if (url && [[UIApplication sharedApplication] canOpenURL:url]) {
		[[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
		return true;
	}
	return false;
}

void IgnoreApplicationActivationRightNow() {
	// Not applicable on iOS
}

void WriteCrashDumpDetails() {
	// iOS handles crash reports through system mechanisms
}

void NewVersionLaunched(int oldVersion) {
	// iOS version handling
}

QImage DefaultApplicationIcon() {
	return ResolveAppIconDefault();
}

bool PreventsQuit(Core::QuitReason reason) {
	return false; // iOS manages app lifecycle
}

void LaunchMaps(const Data::LocationPoint &point, Fn<void()> fail) {
	@autoreleasepool {
		NSString *urlString = [NSString stringWithFormat:@"http://maps.apple.com/?q=%f,%f",
			point.lat,
			point.lon];
		NSURL *url = [NSURL URLWithString:urlString];
		if (url && [[UIApplication sharedApplication] canOpenURL:url]) {
			[[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
				if (!success && fail) {
					fail();
				}
			}];
		} else if (fail) {
			fail();
		}
	}
}

void psDownloadPathEnableAccess() {
	// iOS handles file access through system document picker
}

QByteArray psDownloadPathBookmark(const QString &path) {
	// iOS uses security-scoped bookmarks
	return QByteArray();
}

QByteArray psPathBookmark(const QString &path) {
	// iOS uses security-scoped bookmarks
	return QByteArray();
}

void psSendToMenu(bool send, bool silent) {
	// Not applicable on iOS
}

void ActivateThisProcess() {
	// iOS manages app activation
}

} // namespace Platform

