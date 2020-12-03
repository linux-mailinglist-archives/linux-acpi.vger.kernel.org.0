Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA7A52CE0A8
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Dec 2020 22:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbgLCV1o (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 3 Dec 2020 16:27:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728767AbgLCV1o (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Dec 2020 16:27:44 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F18FC061A51;
        Thu,  3 Dec 2020 13:26:57 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id jx16so5615850ejb.10;
        Thu, 03 Dec 2020 13:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VuGLh7U0uSdywPtVi07Zk5pbRysGH18zHpeGASY3Hyw=;
        b=nPTDMwDC5MuBhK0fWY+4SuQAyVDtEiZPVcUXpd4Yq41uQQ7xcvZ/+msz9kYyHf6iki
         dru+Lp6qOifBkE4LSPfpK7HCkvpst+t/xmpt7jCcpL26aKlXSFDilzJQsGbTxizyhYhG
         sHX3GfEXNVtfyqiP6VE5zVfsBRmg/qDSFnTKgUGxmu/WaFzci2TvMJk2ikgVWrcDAreM
         oG30km/zLJTZ4LKkYo8AcrEH2eB/Fuzh0YWYDn0GI2WbrSC7v2c1VXlIE0VbmCDH7WGC
         9pLgUoqdBEcOXMAOL2gXYcVwsPXvFtz0VwrJsd/JyppUiF883XwqrMINF8pp2jEu3mPt
         Ctew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VuGLh7U0uSdywPtVi07Zk5pbRysGH18zHpeGASY3Hyw=;
        b=d9qmlIIg+fXsrPhMVgyczZbGkEfVBn2L3cGPRGEgMzbnR2WTSJHK6Osg0Vjf0D9Tis
         gspIC3PIXtXmoGZWG2JTPb2l2yjrlRvQ4dQD/foGZQEUtWzFbCAcWcrhEvBrhZh/6/8T
         HSKGRQQLZHZtZgrcRdscC5ot2M7c2GdlQ8FdclAy9XGbngcwkd53Z6+ZhDVXZzIKQe/P
         d/DKy3pQqS2Ert+9MY4Yk7J8Gcit+SwPJQYr3uedW7O1u7QkRAxaCJufdH9Auf3c2VKg
         OcaRly+yj+VxNg5t7bk+XrTKDre+z1n/xY6N/LOV0uBLtjC0zmY0Cd2E7DTisYSA9Q4m
         Bhqw==
X-Gm-Message-State: AOAM5303UwwxA9mPXxXSQnd+cTmul2Kdrus6hScntWWpiKjcse9qdWH3
        VWFDWOZs7Tg9cEqIy6bv7hsMVDv0hD4=
X-Google-Smtp-Source: ABdhPJzU3ASiaTPo1zehmUcrdxbnGrAy3T2GPhoYGUGwK0BkPFAf4GBlg6EAGCn1EpON7JVEDMDPRQ==
X-Received: by 2002:a17:906:d87:: with SMTP id m7mr4268430eji.108.1607030815544;
        Thu, 03 Dec 2020 13:26:55 -0800 (PST)
Received: from xws.fritz.box (pd9e5a6ef.dip0.t-ipconnect.de. [217.229.166.239])
        by smtp.gmail.com with ESMTPSA id e3sm1656169ejq.96.2020.12.03.13.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 13:26:54 -0800 (PST)
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
Subject: [PATCH v2 0/9] Add support for Microsoft Surface System Aggregator Module
Date:   Thu,  3 Dec 2020 22:26:31 +0100
Message-Id: <20201203212640.663931-1-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hello,

Here is version two of the Surface System Aggregator Module (SAM/SSAM)
driver series, adding initial support for the embedded controller on 5th
and later generation Microsoft Surface devices. Initial support includes
the ACPI interface to the controller, via which battery and thermal
information is provided on some of these devices.

The previous version and cover letter detailing what this series is
about can be found at

  https://lore.kernel.org/platform-driver-x86/20201115192143.21571-1-luzmaximilian@gmail.com/

This patch-set can also be found at the following repository and
reference, if you prefer to look at a kernel tree instead of these
emails:

  https://github.com/linux-surface/kernel tags/s/surface-aggregator/v2

Thank you all for the feedback to v1, I hope I have addressed all
comments.

Regards,
Max


Note: This patch depends on

  [PATCH v4] platform/surface: Create a platform subdirectory for
             Microsoft Surface devices

which can be found at

  https://lore.kernel.org/platform-driver-x86/20201009141128.683254-1-luzmaximilian@gmail.com/

and is currently in platform-drivers-x86/for-next.


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
 .../surface_aggregator/clients/cdev.rst       |   85 +
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
 drivers/platform/surface/aggregator/Kconfig   |   69 +
 drivers/platform/surface/aggregator/Makefile  |   17 +
 drivers/platform/surface/aggregator/bus.c     |  415 +++
 drivers/platform/surface/aggregator/bus.h     |   27 +
 .../platform/surface/aggregator/controller.c  | 2543 +++++++++++++++++
 .../platform/surface/aggregator/controller.h  |  285 ++
 drivers/platform/surface/aggregator/core.c    |  833 ++++++
 .../platform/surface/aggregator/ssh_msgb.h    |  205 ++
 .../surface/aggregator/ssh_packet_layer.c     | 2046 +++++++++++++
 .../surface/aggregator/ssh_packet_layer.h     |  190 ++
 .../platform/surface/aggregator/ssh_parser.c  |  228 ++
 .../platform/surface/aggregator/ssh_parser.h  |  154 +
 .../surface/aggregator/ssh_request_layer.c    | 1256 ++++++++
 .../surface/aggregator/ssh_request_layer.h    |  143 +
 drivers/platform/surface/aggregator/trace.h   |  632 ++++
 .../platform/surface/surface_acpi_notify.c    |  886 ++++++
 .../surface/surface_aggregator_cdev.c         |  299 ++
 include/linux/mod_devicetable.h               |   18 +
 include/linux/surface_acpi_notify.h           |   39 +
 include/linux/surface_aggregator/controller.h |  824 ++++++
 include/linux/surface_aggregator/device.h     |  423 +++
 include/linux/surface_aggregator/serial_hub.h |  672 +++++
 include/uapi/linux/surface_aggregator/cdev.h  |   58 +
 scripts/mod/devicetable-offsets.c             |    8 +
 scripts/mod/file2alias.c                      |   23 +
 40 files changed, 14017 insertions(+)
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

