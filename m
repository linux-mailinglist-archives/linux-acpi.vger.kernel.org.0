Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C81329221D
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Aug 2019 13:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbfHSLWa (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 19 Aug 2019 07:22:30 -0400
Received: from mga17.intel.com ([192.55.52.151]:62266 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727463AbfHSLW3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 19 Aug 2019 07:22:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Aug 2019 04:22:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,403,1559545200"; 
   d="scan'208";a="172098142"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 19 Aug 2019 04:22:24 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id B115315C; Mon, 19 Aug 2019 14:22:23 +0300 (EEST)
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
Subject: [PATCH v3 2/8] thunderbolt: Move NVM upgrade support flag to struct icm
Date:   Mon, 19 Aug 2019 14:22:17 +0300
Message-Id: <20190819112223.15359-3-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190819112223.15359-1-mika.westerberg@linux.intel.com>
References: <20190819112223.15359-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This is depends on the controller and on the platform/CPU we are
running. Move it to struct icm so we can set it per controller.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Yehezkel Bernat <YehezkelShB@gmail.com>
---
 drivers/thunderbolt/icm.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
index fbdcef56a676..e9835ab35465 100644
--- a/drivers/thunderbolt/icm.c
+++ b/drivers/thunderbolt/icm.c
@@ -55,6 +55,7 @@
  * @safe_mode: ICM is in safe mode
  * @max_boot_acl: Maximum number of preboot ACL entries (%0 if not supported)
  * @rpm: Does the controller support runtime PM (RTD3)
+ * @can_upgrade_nvm: Can the NVM firmware be upgrade on this controller
  * @is_supported: Checks if we can support ICM on this controller
  * @cio_reset: Trigger CIO reset
  * @get_mode: Read and return the ICM firmware mode (optional)
@@ -74,6 +75,7 @@ struct icm {
 	int vnd_cap;
 	bool safe_mode;
 	bool rpm;
+	bool can_upgrade_nvm;
 	bool (*is_supported)(struct tb *tb);
 	int (*cio_reset)(struct tb *tb);
 	int (*get_mode)(struct tb *tb);
@@ -1913,12 +1915,7 @@ static int icm_start(struct tb *tb)
 	if (IS_ERR(tb->root_switch))
 		return PTR_ERR(tb->root_switch);
 
-	/*
-	 * NVM upgrade has not been tested on Apple systems and they
-	 * don't provide images publicly either. To be on the safe side
-	 * prevent root switch NVM upgrade on Macs for now.
-	 */
-	tb->root_switch->no_nvm_upgrade = x86_apple_machine;
+	tb->root_switch->no_nvm_upgrade = !icm->can_upgrade_nvm;
 	tb->root_switch->rpm = icm->rpm;
 
 	ret = tb_switch_add(tb->root_switch);
@@ -2021,6 +2018,7 @@ struct tb *icm_probe(struct tb_nhi *nhi)
 	switch (nhi->pdev->device) {
 	case PCI_DEVICE_ID_INTEL_FALCON_RIDGE_2C_NHI:
 	case PCI_DEVICE_ID_INTEL_FALCON_RIDGE_4C_NHI:
+		icm->can_upgrade_nvm = true;
 		icm->is_supported = icm_fr_is_supported;
 		icm->get_route = icm_fr_get_route;
 		icm->save_devices = icm_fr_save_devices;
@@ -2038,6 +2036,13 @@ struct tb *icm_probe(struct tb_nhi *nhi)
 	case PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_C_4C_NHI:
 	case PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_C_2C_NHI:
 		icm->max_boot_acl = ICM_AR_PREBOOT_ACL_ENTRIES;
+		/*
+		 * NVM upgrade has not been tested on Apple systems and
+		 * they don't provide images publicly either. To be on
+		 * the safe side prevent root switch NVM upgrade on Macs
+		 * for now.
+		 */
+		icm->can_upgrade_nvm = !x86_apple_machine;
 		icm->is_supported = icm_ar_is_supported;
 		icm->cio_reset = icm_ar_cio_reset;
 		icm->get_mode = icm_ar_get_mode;
@@ -2054,6 +2059,7 @@ struct tb *icm_probe(struct tb_nhi *nhi)
 	case PCI_DEVICE_ID_INTEL_TITAN_RIDGE_2C_NHI:
 	case PCI_DEVICE_ID_INTEL_TITAN_RIDGE_4C_NHI:
 		icm->max_boot_acl = ICM_AR_PREBOOT_ACL_ENTRIES;
+		icm->can_upgrade_nvm = !x86_apple_machine;
 		icm->is_supported = icm_ar_is_supported;
 		icm->cio_reset = icm_tr_cio_reset;
 		icm->get_mode = icm_ar_get_mode;
-- 
2.23.0.rc1

