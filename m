Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D438B388FFE
	for <lists+linux-acpi@lfdr.de>; Wed, 19 May 2021 16:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242155AbhESOOD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 19 May 2021 10:14:03 -0400
Received: from mga14.intel.com ([192.55.52.115]:32007 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242353AbhESOOC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 19 May 2021 10:14:02 -0400
IronPort-SDR: emFKytHPwMNQFeCgsMs8epM5z/QkTgjeWPnflwS+Bkr1cOQM5zyb7BPIPV3FwAKB+Mm1amVtfV
 uS7gg3+OKgfg==
X-IronPort-AV: E=McAfee;i="6200,9189,9988"; a="200677105"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="200677105"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 07:12:40 -0700
IronPort-SDR: ykCQ+OQYxfEczkOdcPc9tN/6j6YYP6OVLB5o10p53bh2Y48Lv8niEq+TbrNbO6HRUJFUKAPhQ0
 vtM1+79dH3Xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="461260309"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 19 May 2021 07:12:37 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 5534315B; Wed, 19 May 2021 17:12:59 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-usb@vger.kernel.org
Cc:     Yehezkel Bernat <YehezkelShB@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org,
        Casey G Bowman <casey.g.bowman@intel.com>,
        Rajmohan Mani <rajmohan.mani@intel.com>,
        Christian Kellner <ckellner@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 0/9] thunderbolt: Offline on-board retimer NVM upgrade support
Date:   Wed, 19 May 2021 17:12:50 +0300
Message-Id: <20210519141259.84839-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi all,

USB4 retimers are only accessible when the USB4 is up. However, sometimes
it may be useful to be able to upgrade on-board retimers even if the link
is not up. For instance if the user simply does not have any USB4 devices.

Making retimers accessible in "offline" mode requires some help from the
platform firmware (ACPI in our case) to turn on power to the retimers and
cycle them through different modes to get the sideband link up. This may
also involve other firmwares such as Embedded Controller (as it is the case
with recent Chromebooks).

This series adds support for "offline" retimer NVM upgrade so that it first
exposes each USB4 port to the userspace. If the platform firmware provides
a special _DSM-method (Device Specific Method) under the USB4 port ACPI
description, we expose two attributes under the port that the userspace can
use to put the port to offline mode and rescan for the retimers. Otherwise
the NVM upgrade works the same way than with the online mode. We also add
documentation to the admin-guide how this can be done.

In addition to this, at least Intel USB4 devices (and retimers) allow
running NVM authenticate (upgrade) separately from write so we make it
possible for the userspace to run the write and authenticate in two steps.
This allows userspace to trigger the authentication at later time, like
when the user logs out.

Mika Westerberg (4):
  thunderbolt: Log the link as TBT instead of TBT3
  thunderbolt: Add USB4 port devices
  thunderbolt: Allow router NVM authenticate separately
  thunderbolt: Check for NVM authentication status after the operation started

Rajmohan Mani (5):
  thunderbolt: Add support for ACPI _DSM to power on/off retimers
  thunderbolt: Add additional USB4 port operations for retimer access
  thunderbolt: Add support for retimer NVM upgrade when there is no link
  thunderbolt: Move nvm_write_ops to tb.h
  thunderbolt: Add WRITE_ONLY and AUTHENTICATE_ONLY NVM operations for retimers

 .../ABI/testing/sysfs-bus-thunderbolt         |  38 ++-
 Documentation/admin-guide/thunderbolt.rst     |  29 ++
 drivers/thunderbolt/Makefile                  |   2 +-
 drivers/thunderbolt/acpi.c                    | 206 +++++++++++++
 drivers/thunderbolt/domain.c                  |   9 +-
 drivers/thunderbolt/retimer.c                 | 108 +++++--
 drivers/thunderbolt/sb_regs.h                 |   2 +
 drivers/thunderbolt/switch.c                  | 120 +++++---
 drivers/thunderbolt/tb.c                      |   4 +-
 drivers/thunderbolt/tb.h                      |  60 +++-
 drivers/thunderbolt/usb4.c                    | 153 +++++++++-
 drivers/thunderbolt/usb4_port.c               | 281 ++++++++++++++++++
 12 files changed, 930 insertions(+), 82 deletions(-)
 create mode 100644 drivers/thunderbolt/usb4_port.c

-- 
2.30.2

