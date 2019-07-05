Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5150F6039B
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Jul 2019 11:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbfGEJ6p (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 5 Jul 2019 05:58:45 -0400
Received: from mga01.intel.com ([192.55.52.88]:16861 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728431AbfGEJ6H (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 5 Jul 2019 05:58:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jul 2019 02:58:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,454,1557212400"; 
   d="scan'208";a="316054682"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 05 Jul 2019 02:58:01 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id BE499254; Fri,  5 Jul 2019 12:58:00 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Mario.Limonciello@dell.com,
        Anthony Wong <anthony.wong@canonical.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org
Subject: [PATCH 0/8] thunderbolt: Intel Ice Lake support
Date:   Fri,  5 Jul 2019 12:57:52 +0300
Message-Id: <20190705095800.43534-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi all,

With the exception of the first patch which is fix, this series enables
Thunderbolt on Intel Ice Lake. Biggest difference from the previous
controllers is that the Thunderbolt controller is now integrated as part of
the SoC. The firmware messages pretty much follow Titan Ridge but there are
some differences as well (such as the new RTD3 veto notification). Also Ice
Lake does not implement security levels so DMA protection is handled by IOMMU.

This is v5.4 material but I'm sending it out now because I will be on
vacation next 4 weeks mostly without internet access. When I get back I'll
gather all the comments and update the series accordingly.

Thanks!

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
 drivers/thunderbolt/icm.c      | 169 +++++++++++++++++--
 drivers/thunderbolt/nhi.c      | 300 ++++++++++++++++++++++++++++++++-
 drivers/thunderbolt/nhi.h      |   2 +
 drivers/thunderbolt/nhi_regs.h |  25 +++
 drivers/thunderbolt/switch.c   |  52 ++++--
 drivers/thunderbolt/tb_msgs.h  |  16 +-
 drivers/thunderbolt/tunnel.c   |   4 +-
 include/linux/thunderbolt.h    |   2 +
 10 files changed, 553 insertions(+), 46 deletions(-)

-- 
2.20.1

