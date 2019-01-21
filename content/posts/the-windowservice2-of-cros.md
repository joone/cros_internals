---
title: "The WindowService2(?) of CrOS"
date: 2018-08-29T17:31:00-08:00
---

Recently, WS was replaced with WS2:

* [window-service: removes mus_demo, test_wm, and some unnecessary deps](https://chromium-review.googlesource.com/c/chromium/src/+/1144255)
* [Issue 865689  Remove window-service](https://bugs.chromium.org/p/chromium/issues/detail?id=865689)

I've run mus_demo to test ozone-gbm, but now it's gone. :-( So, I need
to figure it out what is the difference between WS1 and WS2.

What is the Window Service of ChromeOS? Window Service is a kind of Window
Compositor like Weston. It is a separate process from the browser process in CrOS.
Some of CrOS features are part of the browser process, but those features will
be a separate process using the WindowService.

For more details, see [https://cs.chromium.org/chromium/src/services/ws/README.md](https://cs.chromium.org/chromium/src/services/ws/README.md)

"Clients establish a connection to the WindowService by configuring Aura with a
mode of MUS. See aura::Env::Mode for details.

The WindowService provides a way for one client to embed another client in a
specific window (application composition). Embedding establishes a connection
to a new client and provides the embedded client with a window to use. See the
mojom for more details.

For example, on Chrome OS, Ash uses the WindowService to enable separate
processes, such as the tap_visualizer, to connect to the WindowService. The
tap_visualizer is a client of the WindowService. The tap_visualizer uses the
WindowService to create and manage windows, receive events, and ultimately
draw to the screen (using Viz). This is mostly seamless to the tap_visualizer.
The tap_visualizer configures Views to use Mus, which results in Views and Aura,
using the WindowService."

CrOS is now becoming more like a regular desktop. I'm not sure this is a good decision.
