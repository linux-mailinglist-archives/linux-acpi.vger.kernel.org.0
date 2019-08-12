Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E358789E99
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Aug 2019 14:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbfHLMjV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 12 Aug 2019 08:39:21 -0400
Received: from mga14.intel.com ([192.55.52.115]:31861 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726502AbfHLMiw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 12 Aug 2019 08:38:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Aug 2019 05:38:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,377,1559545200"; 
   d="scan'208";a="175871409"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 12 Aug 2019 05:38:48 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 046FAF9; Mon, 12 Aug 2019 15:38:47 +0300 (EEST)
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
Subject: [PATCH v2 0/8] thunderbolt: Intel Ice Lake support
Date:   Mon, 12 Aug 2019 15:38:39 +0300
Message-Id: <20190812123847.50802-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi all,

This is second version of the patch series adding support for the Intel Ice
Lake integrated Thunderbolt controller. The biggest difference from the
previous discrete controllers is that the Ice Lake Thunderbolt controller
is now integrated as part of the SoC. The firmware messages pretty much
follow Titan Ridge but there are some differences as well (such as the new
RTD3 veto notification). Also Ice Lake does not implement security levels
so DMA protection is handled by IOMMU.

The previous version of the series can be found here:

  https://lwn.net/Articles/793066/

Changes from the previous version:

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
 drivers/thunderbolt/ctl.c      |  23 ++-
 drivers/thunderbolt/eeprom.c   |   4 -
 drivers/thunderbolt/icm.c      | 176 ++++++++++++++++--
 drivers/thunderbolt/nhi.c      | 326 +++++++++++++++++++++++++++++++--
 drivers/thunderbolt/nhi.h      |   2 +
 drivers/thunderbolt/nhi_regs.h |  25 +++
 drivers/thunderbolt/switch.c   |  52 ++++--
 drivers/thunderbolt/tb_msgs.h  |  16 +-
 drivers/thunderbolt/tunnel.c   |   4 +-
 include/linux/thunderbolt.h    |   2 +
 11 files changed, 584 insertions(+), 52 deletions(-)

-- 
2.20.1

