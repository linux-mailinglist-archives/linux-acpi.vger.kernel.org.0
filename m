Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5F2E92229
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Aug 2019 13:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbfHSLWw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 19 Aug 2019 07:22:52 -0400
Received: from mga18.intel.com ([134.134.136.126]:16982 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727498AbfHSLWc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 19 Aug 2019 07:22:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Aug 2019 04:22:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,403,1559545200"; 
   d="scan'208";a="377402401"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 19 Aug 2019 04:22:28 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id E5F902BA; Mon, 19 Aug 2019 14:22:23 +0300 (EEST)
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
Subject: [PATCH v3 6/8] thunderbolt: Expose active parts of NVM even if upgrade is not supported
Date:   Mon, 19 Aug 2019 14:22:21 +0300
Message-Id: <20190819112223.15359-7-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190819112223.15359-1-mika.westerberg@linux.intel.com>
References: <20190819112223.15359-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Ice Lake Thunderbolt controller NVM firmware is part of the BIOS image
which means it is not writable through the DMA port anymore. However, we
can still read it so we can keep nvm_version and active parts of NVM.
This way users still can find out the active NVM version and other
potentially useful information directly from Linux.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Yehezkel Bernat <YehezkelShB@gmail.com>
---
 drivers/thunderbolt/switch.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index bd3eaaf34ea1..531f11fecf75 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -364,12 +364,14 @@ static int tb_switch_nvm_add(struct tb_switch *sw)
 		nvm->active = nvm_dev;
 	}
 
-	nvm_dev = register_nvmem(sw, nvm->id, NVM_MAX_SIZE, false);
-	if (IS_ERR(nvm_dev)) {
-		ret = PTR_ERR(nvm_dev);
-		goto err_nvm_active;
+	if (!sw->no_nvm_upgrade) {
+		nvm_dev = register_nvmem(sw, nvm->id, NVM_MAX_SIZE, false);
+		if (IS_ERR(nvm_dev)) {
+			ret = PTR_ERR(nvm_dev);
+			goto err_nvm_active;
+		}
+		nvm->non_active = nvm_dev;
 	}
-	nvm->non_active = nvm_dev;
 
 	sw->nvm = nvm;
 	return 0;
@@ -398,7 +400,8 @@ static void tb_switch_nvm_remove(struct tb_switch *sw)
 	if (!nvm->authenticating)
 		nvm_clear_auth_status(sw);
 
-	nvmem_unregister(nvm->non_active);
+	if (nvm->non_active)
+		nvmem_unregister(nvm->non_active);
 	if (nvm->active)
 		nvmem_unregister(nvm->active);
 	ida_simple_remove(&nvm_ida, nvm->id);
@@ -1355,8 +1358,11 @@ static umode_t switch_attr_is_visible(struct kobject *kobj,
 		    sw->security_level == TB_SECURITY_SECURE)
 			return attr->mode;
 		return 0;
-	} else if (attr == &dev_attr_nvm_authenticate.attr ||
-		   attr == &dev_attr_nvm_version.attr) {
+	} else if (attr == &dev_attr_nvm_authenticate.attr) {
+		if (sw->dma_port && !sw->no_nvm_upgrade)
+			return attr->mode;
+		return 0;
+	} else if (attr == &dev_attr_nvm_version.attr) {
 		if (sw->dma_port)
 			return attr->mode;
 		return 0;
@@ -1707,13 +1713,17 @@ static int tb_switch_add_dma_port(struct tb_switch *sw)
 		break;
 	}
 
-	if (sw->no_nvm_upgrade)
+	/* Root switch DMA port requires running firmware */
+	if (!tb_route(sw) && sw->config.enabled)
 		return 0;
 
 	sw->dma_port = dma_port_alloc(sw);
 	if (!sw->dma_port)
 		return 0;
 
+	if (sw->no_nvm_upgrade)
+		return 0;
+
 	/*
 	 * Check status of the previous flash authentication. If there
 	 * is one we need to power cycle the switch in any case to make
-- 
2.23.0.rc1

