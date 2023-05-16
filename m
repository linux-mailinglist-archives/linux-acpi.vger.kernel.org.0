Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C52704CE2
	for <lists+linux-acpi@lfdr.de>; Tue, 16 May 2023 13:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbjEPLs2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 16 May 2023 07:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232958AbjEPLs0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 16 May 2023 07:48:26 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8113C3A
        for <linux-acpi@vger.kernel.org>; Tue, 16 May 2023 04:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684237662; x=1715773662;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kqgNW8OvryYyrV4L3xPcxq88n689A4LPp2Kr4WOs0mw=;
  b=euYkTnfd1fjywfJOhIJl162+x+TGUaJ3tUc9w4Uo5bW+k6Sh5TW3B5q5
   O7BBpMcy2aX7vosCqAi1dW111t8ZMIIc/RXZLncUEq+zyKc3DYyynwW6p
   a/g1blA1U9/IhLwWPaaDOG1H/ackdIZdLNmZWRZz/VdtfJgBLNTgYJjVB
   12kWqZjhvMYvqIJY9wX8N61AGQ3cIAEgEnIc/Ht39RCzgyZ+XAJtay6hV
   tYY2n68vpRbEqKukofcSaUgUQm5l/9ESSnzAsHzCEWSL4TVKTQIWnm9DY
   V1RhlHYgwahu2FIeub6rOyvCfuEbHrOn0pkO9c0SK2UoZYcpIvIj0VoUx
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="417111640"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="417111640"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 04:46:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="731961813"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="731961813"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 04:46:49 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v2 12/34] platform/chromeos_tbmc: Move handler installing logic to driver
Date:   Tue, 16 May 2023 13:45:55 +0200
Message-Id: <20230516114617.148963-13-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230516114617.148963-1-michal.wilczynski@intel.com>
References: <20230516114617.148963-1-michal.wilczynski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Currently logic for installing notifications from ACPI devices is
implemented using notify callback in struct acpi_driver. Preparations
are being made to replace acpi_driver with more generic struct
platform_driver, which doesn't contain notify callback. Furthermore
as of now handlers are being called indirectly through
acpi_notify_device(), which decreases performance.

Call acpi_device_install_event_handler() at the end of .add() callback.
Call acpi_device_remove_event_handler() at the beginning of .remove()
callback. Change arguments passed to the notify callback to match with
what's required by acpi_device_install_event_handler().

Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
---
 drivers/platform/chrome/chromeos_tbmc.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/chrome/chromeos_tbmc.c b/drivers/platform/chrome/chromeos_tbmc.c
index d1cf8f3463ce..ac0f43fc530a 100644
--- a/drivers/platform/chrome/chromeos_tbmc.c
+++ b/drivers/platform/chrome/chromeos_tbmc.c
@@ -45,8 +45,10 @@ static __maybe_unused int chromeos_tbmc_resume(struct device *dev)
 	return chromeos_tbmc_query_switch(adev, adev->driver_data);
 }
 
-static void chromeos_tbmc_notify(struct acpi_device *adev, u32 event)
+static void chromeos_tbmc_notify(acpi_handle handle, u32 event, void *data)
 {
+	struct acpi_device *adev = data;
+
 	acpi_pm_wakeup_event(&adev->dev);
 	switch (event) {
 	case 0x80:
@@ -92,7 +94,13 @@ static int chromeos_tbmc_add(struct acpi_device *adev)
 		return ret;
 	}
 	device_init_wakeup(dev, true);
-	return 0;
+
+	return acpi_device_install_event_handler(adev, ACPI_DEVICE_NOTIFY, chromeos_tbmc_notify);
+}
+
+static void chromeos_tbmc_remove(struct acpi_device *adev)
+{
+	acpi_device_remove_event_handler(adev, ACPI_DEVICE_NOTIFY, chromeos_tbmc_notify);
 }
 
 static const struct acpi_device_id chromeos_tbmc_acpi_device_ids[] = {
@@ -110,7 +118,7 @@ static struct acpi_driver chromeos_tbmc_driver = {
 	.ids = chromeos_tbmc_acpi_device_ids,
 	.ops = {
 		.add = chromeos_tbmc_add,
-		.notify = chromeos_tbmc_notify,
+		.remove = chromeos_tbmc_remove,
 	},
 	.drv.pm = &chromeos_tbmc_pm_ops,
 };
-- 
2.40.1

