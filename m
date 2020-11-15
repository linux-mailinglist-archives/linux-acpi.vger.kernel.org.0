Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 184DA2B387A
	for <lists+linux-acpi@lfdr.de>; Sun, 15 Nov 2020 20:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbgKOTWA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 15 Nov 2020 14:22:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727704AbgKOTWA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 15 Nov 2020 14:22:00 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A57C0613CF;
        Sun, 15 Nov 2020 11:21:59 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id 19so21897213wmf.1;
        Sun, 15 Nov 2020 11:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wc51ToP9rIJLdE4S264aWwV+0F/rJ9b6GGconRzHNdc=;
        b=Yc+wgqVBueyUw7r8XNWRa2Z4anTRRsNIOTia306jrfJNSeM8fCt5F5QTqksZ8Q/MJ/
         7vLoZ7BcBSPBsuCXlGTJ7NZVCndBljuPqVqRQYet3OEUgrCgr3xyMnx4FRpB/7aPrjRI
         W6c0oPrN1faY/YRtbp9bNd2odBWRCbrCP1zmZjsNwiNzEZwnwwObxliHWT2baFlN5GYo
         Zq1ITr8tWwUS0o5tMtCcxIC/ymbX6VElf1P05DrUfWJaAQ5/b90jcY8s5j5u0TRGdxlV
         7AEB0k0CLk3V8XTuZmXiAkN7ONzemSzW2d2Mrqa9xwwCiATywHTCFUE13VfdSJG+jfxt
         W8Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wc51ToP9rIJLdE4S264aWwV+0F/rJ9b6GGconRzHNdc=;
        b=NjfTA2nqZ00IAFtv3m5pGCvZ6s53+AD9uIBIK5dFWIEchs2z15Yhv25ujHSVSy7ixj
         74mlbr4XfdqKKUscH6XtN4FYu99u0v2wuGjGUN0h4Pe6rszaCmli83iPohpoJXxINmrF
         u3KoMtdQWk5gPMkcHn/feJt3UF7OwT1Eqr6XOEJvCj+PIpULBZu6vaM3nqtfrb8AV7WY
         l2eep1EjWNeD5wWt9gu/0lFFRhzhyoXzG0kMgUGYHl7c5UKzPycsp4i5F7bSe71XPxuC
         K7QCUlo0UHd/lK6EgopWs4tRbrKYwI9sF7r+nZ/U1tlq0lmwPxqMto8wC+TwIq6mpwaf
         q8HA==
X-Gm-Message-State: AOAM531vPTjhWy8iKRq1q+aNW0OY5hRcVb6lRd54+8TqqRptyBnnIjvv
        wfPIp2PINUCCeFftBSPXX/Xwmd7xWiI=
X-Google-Smtp-Source: ABdhPJxVgS/7ba9gw4kOXX8JdVearoD6aRgcW5CelbZTgwpkkaIwTjCHNvY1xN1mBqiBN/A/eYWTog==
X-Received: by 2002:a05:600c:210:: with SMTP id 16mr11736650wmi.122.1605468117865;
        Sun, 15 Nov 2020 11:21:57 -0800 (PST)
Received: from xws.fritz.box (p5487b28b.dip0.t-ipconnect.de. [84.135.178.139])
        by smtp.gmail.com with ESMTPSA id u8sm17106600wmg.6.2020.11.15.11.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2020 11:21:57 -0800 (PST)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?q?Bla=C5=BE=20Hrastnik?= <blaz@mxxn.io>,
        Dorian Stoll <dorian.stoll@tmsp.io>,
        platform-driver-x86@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH 0/9] Add support for Microsoft Surface System Aggregator Module
Date:   Sun, 15 Nov 2020 20:21:34 +0100
Message-Id: <20201115192143.21571-1-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hello,

  N.B.: the following text is mostly a repeat of cover letter from the
  previous RFC for the uninitiated, which can be found at

  https://lore.kernel.org/linux-serial/20200923151511.3842150-1-luzmaximilian@gmail.com/

  See "Changes" below for an overview of differences between the RFC and
  this patchset. I hope I have addressed all comments from that in this
  version, thank you again for those.

The Surface System Aggregator Module (we'll refer to it as Surface
Aggregator or SAM below) is an embedded controller (EC) found on various
Microsoft Surface devices. Specifically, all 4th and later generation
Surface devices, i.e. Surface Pro 4, Surface Book 1 and later, with the
exception of the Surface Go series and the Surface Duo. Notably, it
seems like this EC can also be found on the ARM-based Surface Pro X [1].

Functionality provided by this EC depends on the Surface model and can
(roughly) be broken down by their generations: Starting with 5th
generation devices (Surface Pro 2017/5, Surface Book 2, Surface Laptop
1, and later), the EC provides battery and thermal readings, as well as
access to the real-time clock. On 5th and 6th generations, these
features, specifically, are provided via the ACPI interface of the EC,
referred to as Surface ACPI Notify (SAN), i.e. they act as standard ACPI
devices of that type, but require a driver translating requests written
to an ACPI operation region to requests to the EC. On 7th generation
devices, the ACPI interface is (largely) gone, and has been replaced
with custom battery and thermal drivers, directly querying the EC.

Additionally, HID keyboard and touchpad input for Surface models with
these devices built in can be handled via the EC: On the Surface Laptops
1 and 2, this includes only the keyboard, while on the Surface Laptop 3
and Book 3, this includes both touchpad and keyboard. In this case,
actual input is provided as HID data and the EC connection acts as HID
transport, thus requiring a special transport driver for those devices
to work.

Further, all known devices (5th and later generations) also support
changing of performance/cooling modes, which can influence cooling
capabilities of the device (e.g. prefer silent operation over
performance), and may influence power limits (e.g. of the discrete GPU
found on Surface Books).

While this constitutes all major functionality, some more device
specific functionality is also handled by the EC. For example, on the
Surface Books, the EC handles detaching of the clipboard (i.e. the upper
part with screen and CPU) from the base (the lower part with keyboard
and optional discrete GPU) and can influence its behavior (i.e. it
provides an interface via which detachment can be requested, aborted, or
confirmed). It can also be used to detect if there has been a base
attached to the clipboard, and if so what type.

This patch-series adds the basis for supporting this EC and the features
provided by it, by, first, implementing a communication driver providing
a fundamental API for client drivers, handling specific aspects of the
EC. Additionally, it builds on top of that to provide a dedicated bus
and device type to better manage EC clients (and break it down pseudo-
device-wise), especially in the case when these client devices are not
described in ACPI, i.e. cannot be discovered by conventional means.
Furthermore, it provides support for debugging and prototyping via an
optional user-space interface, and, lastly, also support for the
aforementioned ACPI interface, allowing ACPI to communicate with the EC
directly.

This series only addresses 5th and later generation Surface models as
the communication interface has changed substantially from 4th to 5th
generation, and the 4th generation interface has not been reverse-
engineered yet. Specifically, the underlying transport has been changed
from HID feature and input-/output-reports to serial communication via
an UART and a custom protocol. Support for 4th generation devices may be
added in the future, but as currently not much is known about 4th
generation SAM, it yet remains to be seen if this can happen as addition
to this subsystem, or if it will be easier to implement this as separate
platform driver. Especially as the 4th generation EC does not seem to
provide much of the functionality found on 5th and later generations
(e.g. no battery status reporting, no thermal reporting, ..., we assume
it's just clipboard detachment on the Surface Book 1 and performance
mode setting).

In more detail, this series adds a driver for the Surface Serial Hub
(SSH), the 5th- and later-generation communication channel to the EC, a
pseudo-device and driver exposing a misc-device that can be used to
communicate with the EC from user-space, intended for debugging,
testing, and prototyping, as well as a driver for the Surface ACPI
Notify (SAN) device, i.e. the interface between ACPI and EC. Some more
details on those can be found on the individual commit messages.

This series, apart from the SAN and user-space drivers, does not add any
client drivers. This will be handled via future patches once the core
has been accepted (and the other client drivers have been cleaned up a
bit).

On the top level, EC communication via the SSH driver can be broken down
into requests (sent from host to EC), corresponding responses (sent from
EC to host, associated with and triggered by a request), and events
(sent from EC to host without association to a request). The SSH driver
manages all communication (i.e. matches responses to requests, enables
and disables events, and manages event handlers/notifiers installed by
client drivers). On the lower levels, SSH communication is packet-based,
and described in more detail in the documentation added in this series
(specifically ssh.rst).

This set of modules and drivers has been developed out of tree at [2]
and used/tested in the kernel we provide at [3] pretty much since its
beginnings. It has been developed by reverse-engineering the SSH
protocol, mostly through the ACPI interface, communication dumps
obtained from listening in on Windows, and deduction. So things may be
wrong. There have been some attempts at reverse-engineering existing
drivers, which also gave a bit of insight for development, however, I
haven't gotten very far on that front beyond some more higher-level
concepts and detecting a couple of new EC commands/confirming the
functionality of already known commands.

Driver and module names have been chosen to align with Windows driver
names, some field, variable, and concept names have been chosen to align
with ACPI code (or at least with what I think some of the more cryptic
names could mean and make sense in the respective context, e.g. IID ->
Instance ID, TC -> Target Category).

This patch-set can also be found at the following repository and
reference, if you prefer to look at a kernel tree instead of these
emails:

  https://github.com/linux-surface/kernel tags/s/surface-aggregator/v1

Thanks,
Max

[1]: The Surface Pro X is, however, currently considered unsupported due
     to a lack of test candidates and, as it seems, general lack of
     Linux support on other parts. AFAIK there is an issue preventing
     serial devices from being registered, on which the core driver in
     this series is build on, thus there is no way to even test that at
     this point. I'd be happy to work out any issues regarding SAM on
     the Pro X at some point in the future, provided someone can/wants
     to actually test it.

[2]: https://github.com/linux-surface/surface-aggregator-module
[3]: https://github.com/linux-surface/linux-surface


Note: This patch depends on

  [PATCH v4] platform/surface: Create a platform subdirectory for
             Microsoft Surface devices

which can be found at

  https://lore.kernel.org/platform-driver-x86/20201009141128.683254-1-luzmaximilian@gmail.com/

and is currently in platform-drivers-x86/for-next.


Changes from the previous RFC (overview):
 - move to platform/surface
 - add copyright lines
 - change SPDX identifier to GPL-2.0+ (was GPL-2.0-or-later)
 - change user-space interface from debugfs to misc-device
 - address issues in user-space interface
 - fix typos in commit messages and documentation
 - fix some bugs, address other issues

Changes regarding specific patches (and more details) can be found on
the individual patch.


Maximilian Luz (9):
  platform/surface: Add Surface Aggregator subsystem
  platform/surface: aggregator: Add control packet allocation caching
  platform/surface: aggregator: Add event item allocation caching
  platform/surface: aggregator: Add trace points
  platform/surface: aggregator: Add error injection capabilities
  platform/surface: aggregator: Add dedicated bus and device type
  docs: driver-api: Add Surface Aggregator subsystem documentation
  platform/surface: Add Surface Aggregator user-space interface
  platform/surface: Add Surface ACPI Notify driver

 Documentation/driver-api/index.rst            |    1 +
 .../surface_aggregator/client-api.rst         |   38 +
 .../driver-api/surface_aggregator/client.rst  |  394 +++
 .../surface_aggregator/clients/cdev.rst       |   85 +
 .../surface_aggregator/clients/index.rst      |   21 +
 .../surface_aggregator/clients/san.rst        |   44 +
 .../driver-api/surface_aggregator/index.rst   |   21 +
 .../surface_aggregator/internal-api.rst       |   67 +
 .../surface_aggregator/internal.rst           |   50 +
 .../surface_aggregator/overview.rst           |   76 +
 .../driver-api/surface_aggregator/ssh.rst     |  343 +++
 MAINTAINERS                                   |   13 +
 drivers/platform/surface/Kconfig              |   39 +
 drivers/platform/surface/Makefile             |    3 +
 drivers/platform/surface/aggregator/Kconfig   |   65 +
 drivers/platform/surface/aggregator/Makefile  |   17 +
 drivers/platform/surface/aggregator/bus.c     |  424 +++
 drivers/platform/surface/aggregator/bus.h     |   27 +
 .../platform/surface/aggregator/controller.c  | 2557 +++++++++++++++++
 .../platform/surface/aggregator/controller.h  |  288 ++
 drivers/platform/surface/aggregator/core.c    |  831 ++++++
 .../platform/surface/aggregator/ssh_msgb.h    |  201 ++
 .../surface/aggregator/ssh_packet_layer.c     | 2009 +++++++++++++
 .../surface/aggregator/ssh_packet_layer.h     |  175 ++
 .../platform/surface/aggregator/ssh_parser.c  |  229 ++
 .../platform/surface/aggregator/ssh_parser.h  |  157 +
 .../surface/aggregator/ssh_request_layer.c    | 1254 ++++++++
 .../surface/aggregator/ssh_request_layer.h    |  142 +
 drivers/platform/surface/aggregator/trace.h   |  625 ++++
 .../platform/surface/surface_acpi_notify.c    |  884 ++++++
 .../surface/surface_aggregator_cdev.c         |  299 ++
 include/linux/mod_devicetable.h               |   18 +
 include/linux/surface_acpi_notify.h           |   39 +
 include/linux/surface_aggregator/controller.h |  832 ++++++
 include/linux/surface_aggregator/device.h     |  430 +++
 include/linux/surface_aggregator/serial_hub.h |  659 +++++
 include/uapi/linux/surface_aggregator/cdev.h  |   58 +
 scripts/mod/devicetable-offsets.c             |    8 +
 scripts/mod/file2alias.c                      |   23 +
 39 files changed, 13446 insertions(+)
 create mode 100644 Documentation/driver-api/surface_aggregator/client-api.rst
 create mode 100644 Documentation/driver-api/surface_aggregator/client.rst
 create mode 100644 Documentation/driver-api/surface_aggregator/clients/cdev.rst
 create mode 100644 Documentation/driver-api/surface_aggregator/clients/index.rst
 create mode 100644 Documentation/driver-api/surface_aggregator/clients/san.rst
 create mode 100644 Documentation/driver-api/surface_aggregator/index.rst
 create mode 100644 Documentation/driver-api/surface_aggregator/internal-api.rst
 create mode 100644 Documentation/driver-api/surface_aggregator/internal.rst
 create mode 100644 Documentation/driver-api/surface_aggregator/overview.rst
 create mode 100644 Documentation/driver-api/surface_aggregator/ssh.rst
 create mode 100644 drivers/platform/surface/aggregator/Kconfig
 create mode 100644 drivers/platform/surface/aggregator/Makefile
 create mode 100644 drivers/platform/surface/aggregator/bus.c
 create mode 100644 drivers/platform/surface/aggregator/bus.h
 create mode 100644 drivers/platform/surface/aggregator/controller.c
 create mode 100644 drivers/platform/surface/aggregator/controller.h
 create mode 100644 drivers/platform/surface/aggregator/core.c
 create mode 100644 drivers/platform/surface/aggregator/ssh_msgb.h
 create mode 100644 drivers/platform/surface/aggregator/ssh_packet_layer.c
 create mode 100644 drivers/platform/surface/aggregator/ssh_packet_layer.h
 create mode 100644 drivers/platform/surface/aggregator/ssh_parser.c
 create mode 100644 drivers/platform/surface/aggregator/ssh_parser.h
 create mode 100644 drivers/platform/surface/aggregator/ssh_request_layer.c
 create mode 100644 drivers/platform/surface/aggregator/ssh_request_layer.h
 create mode 100644 drivers/platform/surface/aggregator/trace.h
 create mode 100644 drivers/platform/surface/surface_acpi_notify.c
 create mode 100644 drivers/platform/surface/surface_aggregator_cdev.c
 create mode 100644 include/linux/surface_acpi_notify.h
 create mode 100644 include/linux/surface_aggregator/controller.h
 create mode 100644 include/linux/surface_aggregator/device.h
 create mode 100644 include/linux/surface_aggregator/serial_hub.h
 create mode 100644 include/uapi/linux/surface_aggregator/cdev.h

-- 
2.29.2

