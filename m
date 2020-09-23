Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32825275B3B
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Sep 2020 17:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgIWPP0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 23 Sep 2020 11:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbgIWPPZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Sep 2020 11:15:25 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BC5C0613CE;
        Wed, 23 Sep 2020 08:15:25 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id l17so117124edq.12;
        Wed, 23 Sep 2020 08:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9dP5lUZE+NTxhokfFgxADz6m44hApljiY/zV1HT8Dz8=;
        b=S/zefZAX5fA3BqXs03wExudvsyqn8uzrGyAUagm7GucV1CyLntmUV/C8cHc6oh+tV0
         Vf++SHNR+5H5M9U5goYXF2nNj9dKuRIyZ8UABTsJ/vLYNvQ2Yc27W7gBNtQiacpI0hQS
         Lzw7mVRu4pB9eZ9/wDoygF8Ogc8WxuAYy0lnO9ABa0n+yUf0GUwloXxx2BCxwVJB64OO
         0gCtZdToLFkbJLsrNj7mPSPGTqUJgkd5iy3ltUZCQLLrqM/h59B7zTrqKajq/wykaPS2
         BDRIAqEKCR/9pjebgJuTjs60Bp/b5rHsejE8G0jIF9MehsLBxLspFp1EqIj2SRWqi9gR
         zs3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9dP5lUZE+NTxhokfFgxADz6m44hApljiY/zV1HT8Dz8=;
        b=BDYnWWvgO2D2EM2M/dA77bwe9s6C286o6cSPLMiZnIj4D7p3CWwyPUf3QRN2aeo2cD
         e2jDzOmcQzhuRMRxv1HavUM2i3cCCRi1pHAV9Nz3mFARZGhEtE4vNZgC1WVbJCM/XZdd
         ihTC15U4gZ5BzM7vkkK2wM9bz4k+F2cOlIlgZbGXH9ptdOSEllo0MqL/zaRcohMfVE7h
         sKvNJv2+/iH+olfF1C/WTKn3k9th+NxZf80TZuJP9F7TyPKMHqXZKI1MbRMjF2Snuiar
         MfqFTJRw8Wgubo9CTJorUIW2Fu4hpa+uX27um+kG3hWsy/dqnpzMPnGkbiLFo6wFznVe
         YueQ==
X-Gm-Message-State: AOAM53197X2vVf96HJAEESF3frLjnqh3km5w66qdH2a1v2PIiCUywO8S
        FqTsUHMw/mkEoYPpcCamHKuENcYrFcY=
X-Google-Smtp-Source: ABdhPJwK1OT5f5fQDNiVP3tWCQi7UB26uamxUdac4iOtyvCJM37kqbW6aU47AvbT3OYb1VH6YuVurQ==
X-Received: by 2002:a50:9b19:: with SMTP id o25mr9838498edi.340.1600874123432;
        Wed, 23 Sep 2020 08:15:23 -0700 (PDT)
Received: from xws.fritz.box (pd9e5a9df.dip0.t-ipconnect.de. [217.229.169.223])
        by smtp.gmail.com with ESMTPSA id ch29sm160707edb.74.2020.09.23.08.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 08:15:22 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        =?UTF-8?q?Bla=C5=BE=20Hrastnik?= <blaz@mxxn.io>,
        Dorian Stoll <dorian.stoll@tmsp.io>
Subject: [RFC PATCH 0/9] Add support for Microsoft Surface System Aggregator Module
Date:   Wed, 23 Sep 2020 17:15:02 +0200
Message-Id: <20200923151511.3842150-1-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hello,

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
optional DebugFS interface, and, lastly, also support for the
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
pseudo-device and driver exposing a DebugFS interface that can be used
to communicate with the EC from user-space, intended for debugging,
testing, and prototyping, as well as a driver for the Surface ACPI
Notify (SAN) device, i.e. the interface between ACPI and EC. Some more
details on those can be found on the individual commit messages.

This series, apart from the SAN and DebugFS drivers, does not add any
client drivers. This will be handled via future patches once the core
has been accepted (and the other client drivers have been cleaned up a
bit).

On the top level, EC communication via the SSH driver can be broken down
into requests (sent from host to EC), corresponding responses (sent from
EC to host, associated with and triggered by a request), and events
(sent from EC to host without association ot a request). The SSH driver
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
names, some field, vairable, and concept names have been chosen to align
with ACPI code (or at least with what I think some of the more cryptic
names could mean and make sense in the respective context, e.g. IID ->
Instance ID, TC -> Target Category).

While I consider this submission complete, I've decided to submit this
as RFC first, mainly due to its size and it being my first submission on
this scale. Any feedback, review, comment, question, etc. is much
appreciated.

This patch-set can also be found at the following respository and
reference, if you prefer to look at a kernel tree instead of these
emails:

  https://github.com/linux-surface/kernel tags/s/surface-aggregator/rfc-v1

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

Maximilian Luz (9):
  misc: Add Surface Aggregator subsystem
  surface_aggregator: Add control packet allocation chaching
  surface_aggregator: Add event item allocation chaching
  surface_aggregator: Add trace points
  surface_aggregator: Add error injection capabilities
  surface_aggregator: Add dedicated bus and device type
  docs: driver-api: Add Surface Aggregator subsystem documentation
  surface_aggregator: Add DebugFS interface
  surface_aggregator: Add Surface ACPI Notify client driver

 Documentation/driver-api/index.rst            |    1 +
 .../surface_aggregator/client-api.rst         |   38 +
 .../driver-api/surface_aggregator/client.rst  |  394 +++
 .../surface_aggregator/clients/dbgdev.rst     |  130 +
 .../surface_aggregator/clients/index.rst      |   21 +
 .../surface_aggregator/clients/san.rst        |   44 +
 .../driver-api/surface_aggregator/index.rst   |   21 +
 .../surface_aggregator/internal-api.rst       |   67 +
 .../surface_aggregator/internal.rst           |   50 +
 .../surface_aggregator/overview.rst           |   76 +
 .../driver-api/surface_aggregator/ssh.rst     |  343 +++
 MAINTAINERS                                   |   10 +
 drivers/misc/Kconfig                          |    1 +
 drivers/misc/Makefile                         |    1 +
 drivers/misc/surface_aggregator/Kconfig       |   65 +
 drivers/misc/surface_aggregator/Makefile      |   17 +
 drivers/misc/surface_aggregator/bus.c         |  419 +++
 drivers/misc/surface_aggregator/bus.h         |   22 +
 .../misc/surface_aggregator/clients/Kconfig   |   38 +
 .../misc/surface_aggregator/clients/Makefile  |    4 +
 .../clients/surface_acpi_notify.c             |  882 ++++++
 .../clients/surface_aggregator_debugfs.c      |  281 ++
 drivers/misc/surface_aggregator/controller.c  | 2505 +++++++++++++++++
 drivers/misc/surface_aggregator/controller.h  |  283 ++
 drivers/misc/surface_aggregator/core.c        |  821 ++++++
 drivers/misc/surface_aggregator/ssh_msgb.h    |  196 ++
 .../surface_aggregator/ssh_packet_layer.c     | 2002 +++++++++++++
 .../surface_aggregator/ssh_packet_layer.h     |  170 ++
 drivers/misc/surface_aggregator/ssh_parser.c  |  224 ++
 drivers/misc/surface_aggregator/ssh_parser.h  |  152 +
 .../surface_aggregator/ssh_request_layer.c    | 1249 ++++++++
 .../surface_aggregator/ssh_request_layer.h    |  137 +
 drivers/misc/surface_aggregator/trace.h       |  621 ++++
 include/linux/mod_devicetable.h               |   18 +
 include/linux/surface_acpi_notify.h           |   37 +
 include/linux/surface_aggregator/controller.h |  812 ++++++
 include/linux/surface_aggregator/device.h     |  408 +++
 include/linux/surface_aggregator/serial_hub.h |  657 +++++
 scripts/mod/devicetable-offsets.c             |    8 +
 scripts/mod/file2alias.c                      |   23 +
 40 files changed, 13248 insertions(+)
 create mode 100644 Documentation/driver-api/surface_aggregator/client-api.rst
 create mode 100644 Documentation/driver-api/surface_aggregator/client.rst
 create mode 100644 Documentation/driver-api/surface_aggregator/clients/dbgdev.rst
 create mode 100644 Documentation/driver-api/surface_aggregator/clients/index.rst
 create mode 100644 Documentation/driver-api/surface_aggregator/clients/san.rst
 create mode 100644 Documentation/driver-api/surface_aggregator/index.rst
 create mode 100644 Documentation/driver-api/surface_aggregator/internal-api.rst
 create mode 100644 Documentation/driver-api/surface_aggregator/internal.rst
 create mode 100644 Documentation/driver-api/surface_aggregator/overview.rst
 create mode 100644 Documentation/driver-api/surface_aggregator/ssh.rst
 create mode 100644 drivers/misc/surface_aggregator/Kconfig
 create mode 100644 drivers/misc/surface_aggregator/Makefile
 create mode 100644 drivers/misc/surface_aggregator/bus.c
 create mode 100644 drivers/misc/surface_aggregator/bus.h
 create mode 100644 drivers/misc/surface_aggregator/clients/Kconfig
 create mode 100644 drivers/misc/surface_aggregator/clients/Makefile
 create mode 100644 drivers/misc/surface_aggregator/clients/surface_acpi_notify.c
 create mode 100644 drivers/misc/surface_aggregator/clients/surface_aggregator_debugfs.c
 create mode 100644 drivers/misc/surface_aggregator/controller.c
 create mode 100644 drivers/misc/surface_aggregator/controller.h
 create mode 100644 drivers/misc/surface_aggregator/core.c
 create mode 100644 drivers/misc/surface_aggregator/ssh_msgb.h
 create mode 100644 drivers/misc/surface_aggregator/ssh_packet_layer.c
 create mode 100644 drivers/misc/surface_aggregator/ssh_packet_layer.h
 create mode 100644 drivers/misc/surface_aggregator/ssh_parser.c
 create mode 100644 drivers/misc/surface_aggregator/ssh_parser.h
 create mode 100644 drivers/misc/surface_aggregator/ssh_request_layer.c
 create mode 100644 drivers/misc/surface_aggregator/ssh_request_layer.h
 create mode 100644 drivers/misc/surface_aggregator/trace.h
 create mode 100644 include/linux/surface_acpi_notify.h
 create mode 100644 include/linux/surface_aggregator/controller.h
 create mode 100644 include/linux/surface_aggregator/device.h
 create mode 100644 include/linux/surface_aggregator/serial_hub.h

-- 
2.28.0

