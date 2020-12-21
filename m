Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC8C72E0010
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Dec 2020 19:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbgLUSkx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 21 Dec 2020 13:40:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbgLUSkx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Dec 2020 13:40:53 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90864C0613D6;
        Mon, 21 Dec 2020 10:40:12 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id y23so11929625wmi.1;
        Mon, 21 Dec 2020 10:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rlROzzTn5Mb2Qz9Q5wZHf9PvLJW5q9w0FyVoZJzVDho=;
        b=J32rAch4N3gRz3FV6ZvvuqsqrXhXTqU9wPweWWpTLXuX9ijkq7AuDaoR0cHDisOInU
         ECjspxRfSz4gjJWWwN9X6OCghrp9Nj9aY9GTIgxxcoP96tJ/0v9xsY2PX7AgTAxWlpmY
         VKvWwHe5kG1dA+lk479OJLtys5sPJIc0O9Zc60t1GbPBcKQ+3SNG+NnBMjqsN/6Li3oq
         5yG2g1AGa8EEPs2NrgozAy9AbMUWaZAP0XyJNOF6g6EKDt8IL0QxefmyVPAN7L1bW14k
         S6DHAMqdFhpUgWF1tn0XgrZyVPbHBP1d1xOqZwcja1CgxQXmJ9l7AtbIHgXDS30VzDaU
         Ki3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rlROzzTn5Mb2Qz9Q5wZHf9PvLJW5q9w0FyVoZJzVDho=;
        b=jpSCKRBssHtmnRIPNGEEuULYsdN3BJk6LPkXVxe6qQ5KelVp/LQTYUpy0JGOfifgKS
         WSdcadL+BKGhd9uXf3HtUkKhxRKHL3BsguDzOGkCaes/XKsd8GvctBq75O0uFZMTN1T+
         sHNuhAXFald6lx/64O+8Cd+EvoUX8zlMdfAqVgDTDokcVcR79X0RvvMthafNQG+Jlgn+
         9PZttRi9V4iyTOi5kKnBhp6dmENfgc2URb89nEIyx0bH0fs2sFfDJ79AsmIyDMliuIcU
         YCmV854qzWHFwQWsUuVyidIL52vF7wQm14YD1bhGQ6Orh1jjf0qu57lEVcbnTSOX9UJ4
         C/2w==
X-Gm-Message-State: AOAM5301hW61KcnIRNmg7KG8ZC2PB9Wjh7I5rwN5YjezKOh2+JJCfLcj
        qwbfqQnu9Mk19mHdxSbyu4jul3CPNTEflA==
X-Google-Smtp-Source: ABdhPJz09ZzSBPs5dRL6xrY3GvjsWzrtt8hJnqSW+J9XiUReQP6DxMxErjCkij4V772ap5AtJvffNA==
X-Received: by 2002:a1c:b407:: with SMTP id d7mr18196368wmf.34.1608576010844;
        Mon, 21 Dec 2020 10:40:10 -0800 (PST)
Received: from xws.fritz.box (pd9e5aae0.dip0.t-ipconnect.de. [217.229.170.224])
        by smtp.gmail.com with ESMTPSA id j7sm24528310wmb.40.2020.12.21.10.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 10:40:09 -0800 (PST)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        =?UTF-8?q?Barnab=C3=A1s=20P=C5=91cze?= <pobrn@protonmail.com>,
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
Subject: [PATCH v3 0/9] Add support for Microsoft Surface System Aggregator Module
Date:   Mon, 21 Dec 2020 19:39:50 +0100
Message-Id: <20201221183959.1186143-1-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hello,

Here is version three of the Surface System Aggregator Module (SAM/SSAM)
driver series, adding initial support for the embedded controller on 5th
and later generation Microsoft Surface devices. Initial support includes
the ACPI interface to the controller, via which battery and thermal
information is provided on some of these devices.

The first version and cover letter detailing what this series is about
can be found at

  https://lore.kernel.org/platform-driver-x86/20201115192143.21571-1-luzmaximilian@gmail.com/

the previous version (v2) at

  https://lore.kernel.org/platform-driver-x86/20201203212640.663931-1-luzmaximilian@gmail.com/

This patch-set can also be found at the following repository and
reference, if you prefer to look at a kernel tree instead of these
emails:

  https://github.com/linux-surface/kernel tags/s/surface-aggregator/v3

Thank you all for the feedback to and reviews of the previous versions,
I hope I have addressed all comments.

Regards,
Max


Note: In v3, I have dropped the explicit dependency of the core module
and driver on CONFIG_ACPI due to the incoming

  [PATCH] platform/surface: SURFACE_PLATFORMS should depend on ACPI

Thus, this series depends on said patch. This patch can be found at

  https://www.spinics.net/lists/platform-driver-x86/msg23929.html


Changes in v1 (from RFC, overview):
 - move to platform/surface
 - add copyright lines
 - change SPDX identifier to GPL-2.0+ (was GPL-2.0-or-later)
 - change user-space interface from debugfs to misc-device
 - address issues in user-space interface
 - fix typos in commit messages and documentation
 - fix some bugs, address other issues

Changes in v2 (overview):
 - simplify some code, mostly with regards to concurrency
 - add architectural overview to documentation
 - improve comments for documentation
 - use printk specifier for hex prefix instead of hard-coding it
 - spell check comments and strings, fix typos
 - unify comment style
 - run checkpatch --strict, fix these and other style issues

Changes in v3 (overview):
 - remove explicit dependency on ACPI as this is going to be covered by
   CONFIG_SURFACE_PLATFORMS
 - simplify locking requirements
 - help enforce locking requirements via lockdep assertions
 - fix false-positive lockdep warning
 - warn on event enablement reference counter exhaustion
 - don't warn about unhandled event if event handling failed
 - validate flags on request initialization
 - improve documentation/add comments
 - replace 'iff' with 'if' in documentation and comments

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
 .../driver-api/surface_aggregator/client.rst  |  393 +++
 .../surface_aggregator/clients/cdev.rst       |   87 +
 .../surface_aggregator/clients/index.rst      |   21 +
 .../surface_aggregator/clients/san.rst        |   44 +
 .../driver-api/surface_aggregator/index.rst   |   21 +
 .../surface_aggregator/internal-api.rst       |   67 +
 .../surface_aggregator/internal.rst           |  577 ++++
 .../surface_aggregator/overview.rst           |   77 +
 .../driver-api/surface_aggregator/ssh.rst     |  344 +++
 .../userspace-api/ioctl/ioctl-number.rst      |    2 +
 MAINTAINERS                                   |   13 +
 drivers/platform/surface/Kconfig              |   38 +
 drivers/platform/surface/Makefile             |    3 +
 drivers/platform/surface/aggregator/Kconfig   |   68 +
 drivers/platform/surface/aggregator/Makefile  |   17 +
 drivers/platform/surface/aggregator/bus.c     |  415 +++
 drivers/platform/surface/aggregator/bus.h     |   27 +
 .../platform/surface/aggregator/controller.c  | 2579 +++++++++++++++++
 .../platform/surface/aggregator/controller.h  |  285 ++
 drivers/platform/surface/aggregator/core.c    |  839 ++++++
 .../platform/surface/aggregator/ssh_msgb.h    |  205 ++
 .../surface/aggregator/ssh_packet_layer.c     | 2057 +++++++++++++
 .../surface/aggregator/ssh_packet_layer.h     |  190 ++
 .../platform/surface/aggregator/ssh_parser.c  |  228 ++
 .../platform/surface/aggregator/ssh_parser.h  |  154 +
 .../surface/aggregator/ssh_request_layer.c    | 1264 ++++++++
 .../surface/aggregator/ssh_request_layer.h    |  143 +
 drivers/platform/surface/aggregator/trace.h   |  632 ++++
 .../platform/surface/surface_acpi_notify.c    |  886 ++++++
 .../surface/surface_aggregator_cdev.c         |  303 ++
 include/linux/mod_devicetable.h               |   18 +
 include/linux/surface_acpi_notify.h           |   39 +
 include/linux/surface_aggregator/controller.h |  824 ++++++
 include/linux/surface_aggregator/device.h     |  423 +++
 include/linux/surface_aggregator/serial_hub.h |  672 +++++
 include/uapi/linux/surface_aggregator/cdev.h  |   78 +
 scripts/mod/devicetable-offsets.c             |    8 +
 scripts/mod/file2alias.c                      |   23 +
 40 files changed, 14103 insertions(+)
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

