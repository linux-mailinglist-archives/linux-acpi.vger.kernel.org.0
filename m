Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA6830434C
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Jan 2021 17:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404356AbhAZQA6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 26 Jan 2021 11:00:58 -0500
Received: from mga09.intel.com ([134.134.136.24]:33515 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404792AbhAZQAl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 26 Jan 2021 11:00:41 -0500
IronPort-SDR: 9Xb53wp9cNk/HYkvpQG6BVDPI2jqG6EbRMpYc0+iJhgifB71/K9DAx5u3M1nG1b20OEaKCmSLU
 nGBTkH10ydGA==
X-IronPort-AV: E=McAfee;i="6000,8403,9876"; a="180066867"
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="180066867"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 07:57:27 -0800
IronPort-SDR: fRw0Moly20z8UaIiPzKtSYnq/G9Lrkhjm7aFztMRfbBALs6B2Vt29D0xS0R+Uy/1ggJJXq70Y4
 Hqi8SbP2liTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="402785430"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 26 Jan 2021 07:57:24 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 0E07C15C; Tue, 26 Jan 2021 17:57:23 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-usb@vger.kernel.org
Cc:     Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Mario Limonciello <mario.limonciello@dell.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Christian Kellner <christian@kellner.me>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org
Subject: [PATCH 0/6] thunderbolt / ACPI: Add support for USB4 _OSC
Date:   Tue, 26 Jan 2021 18:57:17 +0300
Message-Id: <20210126155723.9388-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi all,

The just released ACPI 6.4 spec [1] adds a new _OSC method that is used to
negotiate OS support for native USB4 features such as PCIe tunneling. This
patch series adds Linux support for the new _OSC and modifies the
Thunderbolt/USB4 driver accordingly to enable/disable tunneling of
different protocols.

There is an additional setting in the firmware connection manager that
allows the BIOS to disable PCIe tunneling, so we add support for this and
also make the software connection manager to switch to this "nopcie"
security level when the _OSC does not allow PCIe tunneling.

This applies on top of thunderbolt.git/next.

[1] https://uefi.org/sites/default/files/resources/ACPI_Spec_6_4_Jan22.pdf

Mario Limonciello (2):
  thunderbolt: Fix possible NULL pointer dereference in tb_acpi_add_link()
  ACPI: Execute platform _OSC also with query bit clear

Mika Westerberg (4):
  thunderbolt: Add support for PCIe tunneling disabled (SL5)
  thunderbolt: Allow disabling XDomain protocol
  ACPI: Add support for native USB4 control _OSC
  thunderbolt: Add support for native USB4 _OSC

 .../ABI/testing/sysfs-bus-thunderbolt         |   2 +
 Documentation/admin-guide/thunderbolt.rst     |   7 ++
 drivers/acpi/bus.c                            | 119 ++++++++++++++++--
 drivers/thunderbolt/acpi.c                    |  67 +++++++++-
 drivers/thunderbolt/domain.c                  |  16 ++-
 drivers/thunderbolt/icm.c                     |   6 +-
 drivers/thunderbolt/nhi.c                     |  27 +++-
 drivers/thunderbolt/switch.c                  |   6 +-
 drivers/thunderbolt/tb.c                      |  22 +++-
 drivers/thunderbolt/tb.h                      |  13 ++
 drivers/thunderbolt/tunnel.c                  |  10 +-
 drivers/thunderbolt/usb4.c                    |  11 +-
 drivers/thunderbolt/xdomain.c                 |   9 ++
 include/linux/acpi.h                          |  10 ++
 include/linux/thunderbolt.h                   |   3 +
 15 files changed, 299 insertions(+), 29 deletions(-)

-- 
2.29.2

