---
title: "Linux Container for ChromeOS"
date: 2018-07-12T18:25:45-08:00
---
Recently, ChromeOS started to support Linux applications on ChomeOS.
Google hasn't allowed ChromeOS to run native applications due to security reason.
Finally, they found a way to support Linux application through the container technology.

It is worth to read a discussion on CrOSVM on Hacker News because the original
author joined the discussion. Here is the article about ChromeOS Linux container.
https://www.zdnet.com/article/chrome-os-could-be-getting-containers-for-running-linux-vms/

There is a Youtube video:
https://www.youtube.com/watch?v=s9mrR2tqVbQ

Here is [the readme](https://chromium.googlesource.com/chromiumos/platform/crosvm/+/837b59f2d97b005ef84ac36efa97530c1bbf2a79/README.md) about CrOSVM:

The interesting thing is that it is implemented with Rust. Google now seriously
uses Rust for their products, which is a good news for the Rust community.

