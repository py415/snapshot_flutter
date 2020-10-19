# Snapshot

## Table of Contents
1. [Overview](#Overview)
2. [Product Specs](#Product-Specs)
3. [App Walkthrough](#App-Walkthrough)
4. [APIs](#APIs)
5. [Libraries](#Libraries)
6. [Credits](#Credits)

## Overview
### Description

Snapshot is a photo memorabilia app that allows users to take memorable photos of places and store them on the device locally.

## Product Specs
### User Stories

- [x] User shall be able to see a list of places that the user has previously taken a snapshot of.
- [x] User shall be able to tap on a row of the list of places and see more details of that place.
- [x] User shall be able to add new places to their list of places.
- [x] User taken and selected photos shall persist across app restarts.
- [x] User shall be able to see a Google Map preview of the selected place.

## App Walkthrough

Here's a GIF of how the app works:

<img src="https://github.com/py415/app-resources/blob/master/flutter/ios/flutter-ios-snapshot.gif" width=250>

<img src="https://github.com/py415/app-resources/blob/master/flutter/android/flutter-android-snapshot.gif" width=250>

## APIs

- [Google Maps API](https://developers.google.com/maps/documentation) - Add maps based on Google maps data to your application.

## Libraries

- [cupertino_icons](https://github.com/flutter/cupertino_icons) - This is an asset repo containing the default set of icon assets used by Flutter's [Cupertino widgets](https://github.com/flutter/flutter/tree/master/packages/flutter/lib/src/cupertino).
- [pedantic](https://github.com/dart-lang/pedantic) - Most of the recommended lints directly implement the guidelines set out in [Effective Dart](https://dart.dev/guides/language/effective-dart).
- [provider](https://github.com/rrousselGit/provider) - A wrapper around InheritedWidget to make them easier to use and more reusable.
- [image_picker](https://github.com/flutter/plugins/tree/master/packages/image_picker/image_picker) - A Flutter plugin for iOS and Android for picking images from the image library, and taking new pictures with the camera.
- [path_provider](https://github.com/flutter/plugins/tree/master/packages/path_provider/path_provider) - A Flutter plugin for finding commonly used locations on the filesystem. Supports iOS, Android, Linux and MacOS. Not all methods are supported on all platforms.
- [path](https://github.com/dart-lang/path) - The path package provides common operations for manipulating paths: joining, splitting, normalizing, etc.
- [sqflite](https://github.com/tekartik/sqflite) - SQLite plugin for Flutter. Supports iOS, Android and MacOS.
- [location](https://github.com/Lyokone/flutterlocation) - This plugin for Flutter handles getting location on Android and iOS. It also provides callbacks when location is changed.
- [google_maps_flutter](https://github.com/flutter/plugins/tree/master/packages/google_maps_flutter/google_maps_flutter) - A Flutter plugin that provides a [Google Maps](https://cloud.google.com/maps-platform/) widget.
- [http](https://github.com/dart-lang/http) - A composable, Future-based library for making HTTP requests.

## Credits

>This is a companion project to Flutter & Dart - The Complete Guide, check out the full course at [www.academind.com](https://academind.com/).