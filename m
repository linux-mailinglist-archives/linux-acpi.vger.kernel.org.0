Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 183F2304347
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Jan 2021 17:01:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403872AbhAZQAv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 26 Jan 2021 11:00:51 -0500
Received: from mga17.intel.com ([192.55.52.151]:61152 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404815AbhAZQAn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 26 Jan 2021 11:00:43 -0500
IronPort-SDR: o06TftTu5RGhof57dgUuAyWoPZhPQFe3WooiaYMu2qltKbTx5E/om0wyp23J1gw4NqEByglPFd
 yIXT6GwXm1ow==
X-IronPort-AV: E=McAfee;i="6000,8403,9876"; a="159697373"
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="159697373"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 07:57:27 -0800
IronPort-SDR: D6UH5KULZV1GthGBOUjBESoyaiyOvwlvMZI8FPO2EK53mv6ev6Mg9hFY6UTKDfW9nAiGFQFF/f
 RISVW/w64wBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="406758727"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 26 Jan 2021 07:57:24 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 1DD2714F; Tue, 26 Jan 2021 17:57:24 +0200 (EET)
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
Subject: [PATCH 1/6] thunderbolt: Fix possible NULL pointer dereference in tb_acpi_add_link()
Date:   Tue, 26 Jan 2021 18:57:18 +0300
Message-Id: <20210126155723.9388-2-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210126155723.9388-1-mika.westerberg@linux.intel.com>
References: <20210126155723.9388-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Mario Limonciello <mario.limonciello@dell.com>

When we walk up the device hierarchy in tb_acpi_add_link() make sure we
break the loop if the device has no parent. Otherwise we may crash the
kernel by dereferencing a NULL pointer.

Fixes: b2be2b05cf3b ("thunderbolt: Create device links from ACPI description")
Cc: stable@vger.kernel.org
Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thunderbolt/acpi.c b/drivers/thunderbolt/acpi.c
index a5f988a9f948..b5442f979b4d 100644
--- a/drivers/thunderbolt/acpi.c
+++ b/drivers/thunderbolt/acpi.c
@@ -56,7 +56,7 @@ static acpi_status tb_acpi_add_link(acpi_handle handle, u32 level, void *data,
 	 * managed with the xHCI and the SuperSpeed hub so we create the
 	 * link from xHCI instead.
 	 */
-	while (!dev_is_pci(dev))
+	while (dev && !dev_is_pci(dev))
 		dev = dev->parent;
 
 	if (!dev)
-- 
2.29.2

