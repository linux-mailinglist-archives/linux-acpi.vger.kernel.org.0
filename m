Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9B3D7009CF
	for <lists+linux-acpi@lfdr.de>; Fri, 12 May 2023 16:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241421AbjELODU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 12 May 2023 10:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241379AbjELODJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 12 May 2023 10:03:09 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB06F1B1
        for <linux-acpi@vger.kernel.org>; Fri, 12 May 2023 07:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683900188; x=1715436188;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rKnJsXc5SXda6k+1QyFHn1GBFF395qP1NAcf6VFSCKc=;
  b=EiSBov0pXy3IMQRYPstH5QwQsGBQqkM0bhRQPQVO9rF6mHLIiJlf251T
   u80yv3jsJ0Q8BM07CbMFY1u1XWtswgrNG4E98Xt4pKv2Sra5n7dNk8tLU
   vxAKs3U1x3aEwgfj5sUB6tlVkNcLrXOw+SA+bNL8/RGGkiU789nL8fycM
   8JvaM8AefAVP8h828EGMQoIqL+NIOStBmwQXv1P4hkTJraM+LJNlqJdaq
   /Yw2NTowMNx2v7PoVPk3uO/riMy8Fr3zYfUg/kJVY2ltBoEF02+S1xpcT
   re9gk6BFRvlLHl/7mRC14+ZxXDmxTjkqbpZG3jEuswp39dCV5PMiEf7bf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="378931080"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="378931080"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 07:03:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="650648946"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="650648946"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 07:03:07 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v1 12/34] platform/chromeos_tbmc: Move handler installing logic to driver
Date:   Fri, 12 May 2023 16:02:00 +0200
Message-Id: <20230512140222.124868-13-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230512140222.124868-1-michal.wilczynski@intel.com>
References: <20230512140222.124868-1-michal.wilczynski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
index d1cf8f3463ce..399429bd7635 100644
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
+	return acpi_device_install_event_handler(device, ACPI_DEVICE_NOTIFY, chromeos_tbmc_notify);
+}
+
+static void chromeos_tbmc_remove(struct acpi_device *device)
+{
+	acpi_device_remove_event_handler(device, ACPI_DEVICE_NOTIFY, chromeos_tbmc_notify);
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
2.38.1

