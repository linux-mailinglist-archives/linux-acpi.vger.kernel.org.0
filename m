Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32DBC7009D7
	for <lists+linux-acpi@lfdr.de>; Fri, 12 May 2023 16:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241430AbjELODn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 12 May 2023 10:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241437AbjELODW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 12 May 2023 10:03:22 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7115E19B2
        for <linux-acpi@vger.kernel.org>; Fri, 12 May 2023 07:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683900201; x=1715436201;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3YaqGO9LFaIBj1gukzA8XXwIj/NiaYsVTjoox1IRCUI=;
  b=k6+UtgfHSByd/EmsIAJnuL2iWTyiaunYM7CtBWY7rkOyoEd0VlcG/vd3
   Q2/rctnrVLzozmg6b2Ya7AlWv/r+E1ozHI+8TpjyzLURnY2E19Ist8YTG
   /q5S5kM9HmkO/Cp792y8HD/mbpPK5MQEZ0Xh+7/QWnhsnFHB0SgNN7h33
   nX4cXuzoY+0Q0E0Zpf6sZ3YL3DUnHCInvzT4OqkHg/IMb8eIoJxdV+hEw
   6Tl55JC9jGpUpenBdx7/6uCDKrvBEx6mjaiu/lJfeZ0XakHlYQxIwp5iY
   /HIDxb4IGWxt77ccaQoxftKJDO+IvahLt1H2ST6sSKaLYcHV6bbxd26cB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="378931129"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="378931129"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 07:03:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="650648983"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="650648983"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 07:03:19 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v1 20/34] platform/x86/eeepc-laptop: Move handler installing logic to driver
Date:   Fri, 12 May 2023 16:02:08 +0200
Message-Id: <20230512140222.124868-21-michal.wilczynski@intel.com>
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
 drivers/platform/x86/eeepc-laptop.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index 62b71e8e3567..d96e0dce586a 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -1204,12 +1204,15 @@ static void eeepc_input_notify(struct eeepc_laptop *eeepc, int event)
 		pr_info("Unknown key %x pressed\n", event);
 }
 
-static void eeepc_acpi_notify(struct acpi_device *device, u32 event)
+static void eeepc_acpi_notify(acpi_handle handle, u32 event, void *data)
 {
-	struct eeepc_laptop *eeepc = acpi_driver_data(device);
 	int old_brightness, new_brightness;
+	struct acpi_device *device = data;
+	struct eeepc_laptop *eeepc;
 	u16 count;
 
+	eeepc = acpi_driver_data(device);
+
 	if (event > ACPI_MAX_SYS_NOTIFY)
 		return;
 	count = eeepc->event_count[event % 128]++;
@@ -1423,7 +1426,12 @@ static int eeepc_acpi_add(struct acpi_device *device)
 		goto fail_rfkill;
 
 	eeepc_device_present = true;
-	return 0;
+	result = acpi_install_notify_handler(device->handle, ACPI_ALL_NOTIFY,
+					     eeepc_acpi_notify, device);
+	if (result)
+		goto fail_rfkill;
+
+	return result;
 
 fail_rfkill:
 	eeepc_led_exit(eeepc);
@@ -1451,6 +1459,8 @@ static void eeepc_acpi_remove(struct acpi_device *device)
 	eeepc_platform_exit(eeepc);
 
 	kfree(eeepc);
+	acpi_remove_notify_handler(device->handle, ACPI_ALL_NOTIFY,
+				   eeepc_acpi_notify);
 }
 
 
@@ -1465,11 +1475,9 @@ static struct acpi_driver eeepc_acpi_driver = {
 	.class = EEEPC_ACPI_CLASS,
 	.owner = THIS_MODULE,
 	.ids = eeepc_device_ids,
-	.flags = ACPI_DRIVER_ALL_NOTIFY_EVENTS,
 	.ops = {
 		.add = eeepc_acpi_add,
 		.remove = eeepc_acpi_remove,
-		.notify = eeepc_acpi_notify,
 	},
 };
 
-- 
2.38.1

