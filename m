Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0404C92230
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Aug 2019 13:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbfHSLXF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 19 Aug 2019 07:23:05 -0400
Received: from mga18.intel.com ([134.134.136.126]:16980 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727458AbfHSLW2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 19 Aug 2019 07:22:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Aug 2019 04:22:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,403,1559545200"; 
   d="scan'208";a="179395013"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 19 Aug 2019 04:22:24 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 90405FC; Mon, 19 Aug 2019 14:22:23 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Mario.Limonciello@dell.com,
        Anthony Wong <anthony.wong@canonical.com>,
        Rajmohan Mani <rajmohan.mani@intel.com>,
        Raanan Avargil <raanan.avargil@intel.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org
Subject: [PATCH v3 0/8] thunderbolt: Intel Ice Lake support
Date:   Mon, 19 Aug 2019 14:22:15 +0300
Message-Id: <20190819112223.15359-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi all,

This is third iteration of the patch series adding support for the Intel
Ice Lake integrated Thunderbolt controller. The biggest difference from the
previous discrete controllers is that the Ice Lake Thunderbolt controller
is now integrated as part of the SoC. The firmware messages pretty much
follow Titan Ridge but there are some differences as well (such as the new
RTD3 veto notification). Also Ice Lake does not implement security levels
so DMA protection is handled by IOMMU.

The previous versions of the series can be found here:

  v2: https://lwn.net/Articles/795979/
  v1: https://lwn.net/Articles/793066/

Changes from v2:

  * Moved ICL specific NHI ops into a separate file (nhi_ops.c)

  * Postpone rescan thread during resume when if get device connected
    notification from the firmware. This fixes an issue that happened
    occasionally when resuming with full chain of devices. The driver
    started to remove last devices in the chain even if they are still
    connected.

  * Move call to nhi->ops->init() before CM specific probe happens.
  
  * Added ack from Rafael

Changes from v1:

  * Check !x86_apple_machine for Titan Ridge also.

  * Drop ioread32() when updating prod/cons because hardware ignores writes
    to the read-only parts of the register this allows us to save one read.

  * Remove Light Ridge specific handling in eeprom.c as it is not necessary
    after patch 4/8.

  * Moved RTD3 veto handling into separate functions to avoid code
    duplication.

  * Reworked struct nhi_ops so that it provides hooks such as
    runtime_suspend and so on. The NHI implementation then can use those
    hooks to implement whatever additional logic is needed. This should
    allow us to move those bits into a separate files in future if needed.

    I also looked whether we could replace
    quirk_apple_poweroff_thunderbolt() using struct nhi_ops as well but it
    turns out to be unsuitable. The reason is that the ACPI magic sequence
    needs to be done after PCI core has moved the device into D3. The NHI
    driver does not have easy means to do so.

  * Clarified comment in icl_nhi_suspend()

  * Added clarification comment to icl_nhi_force_power()

  * Use "Thunderbolt" instead of "TBT" in new GUID entries

  * Added reviewed tag from Yehezkel

Mika Westerberg (8):
  thunderbolt: Correct path indices for PCIe tunnel
  thunderbolt: Move NVM upgrade support flag to struct icm
  thunderbolt: Use 32-bit writes when writing ring producer/consumer
  thunderbolt: Do not fail adding switch if some port is not implemented
  thunderbolt: Hide switch attributes that are not set
  thunderbolt: Expose active parts of NVM even if upgrade is not supported
  thunderbolt: Add support for Intel Ice Lake
  ACPI / property: Add two new Thunderbolt property GUIDs to the list

 drivers/acpi/property.c        |   6 +
 drivers/thunderbolt/Makefile   |   2 +-
 drivers/thunderbolt/ctl.c      |  23 +++-
 drivers/thunderbolt/eeprom.c   |   4 -
 drivers/thunderbolt/icm.c      | 194 ++++++++++++++++++++++++++++++---
 drivers/thunderbolt/nhi.c      | 134 +++++++++++++++++++++--
 drivers/thunderbolt/nhi.h      |  22 ++++
 drivers/thunderbolt/nhi_ops.c  | 179 ++++++++++++++++++++++++++++++
 drivers/thunderbolt/nhi_regs.h |  37 +++++++
 drivers/thunderbolt/switch.c   |  52 +++++++--
 drivers/thunderbolt/tb_msgs.h  |  16 ++-
 drivers/thunderbolt/tunnel.c   |   4 +-
 include/linux/thunderbolt.h    |   2 +
 13 files changed, 622 insertions(+), 53 deletions(-)
 create mode 100644 drivers/thunderbolt/nhi_ops.c

-- 
2.23.0.rc1

