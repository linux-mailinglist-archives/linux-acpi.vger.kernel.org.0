Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51985704CF1
	for <lists+linux-acpi@lfdr.de>; Tue, 16 May 2023 13:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233104AbjEPLts (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 16 May 2023 07:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233134AbjEPLtk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 16 May 2023 07:49:40 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4367692
        for <linux-acpi@vger.kernel.org>; Tue, 16 May 2023 04:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684237753; x=1715773753;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R2YodYciSCZ/rcVXozR0qOeGtYKTgupDcD2qiV8prv4=;
  b=RcXZ/Hxva1lyJRVYYTTxaz5ruOju02z9ldWGXLvC/VmLYR/6ip/PBZMT
   btoiODI0BU8kZA81N/4RidVVXXJUkodcPJGQK2WDzCMF29TZxbW4qIW0d
   naAD93OQIlJiu9PhYZlKlA7l8uHI9JnBrL9B3xzoNhVw03mbzVO+PRI3X
   IpLfUdxxERKLXwF6rsr/QQQVoUCikVq7ffVU1zW15FGUa1OWdT3lXA+Vg
   ZXTxq7KwiAldd98m84jo1mgpmsn0YLKvP1UV7FFo6ENPS+ViC9xUB3nof
   qfZQefaQBhplIqBEwU2WyMzluWB5DEYfgSJGZJhZMoziQzNK535aI6t4B
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="417111716"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="417111716"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 04:47:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="731961951"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="731961951"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 04:47:05 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v2 25/34] platform/x86/topstar-laptop: Move handler installing logic to driver
Date:   Tue, 16 May 2023 13:46:08 +0200
Message-Id: <20230516114617.148963-26-michal.wilczynski@intel.com>
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
 drivers/platform/x86/topstar-laptop.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/topstar-laptop.c b/drivers/platform/x86/topstar-laptop.c
index 20df1ebefc30..87c72625482f 100644
--- a/drivers/platform/x86/topstar-laptop.c
+++ b/drivers/platform/x86/topstar-laptop.c
@@ -232,12 +232,15 @@ static int topstar_acpi_fncx_switch(struct acpi_device *device, bool state)
 	return 0;
 }
 
-static void topstar_acpi_notify(struct acpi_device *device, u32 event)
+static void topstar_acpi_notify(acpi_handle handle, u32 event, void *data)
 {
-	struct topstar_laptop *topstar = acpi_driver_data(device);
+	struct acpi_device *device = data;
+	struct topstar_laptop *topstar;
 	static bool dup_evnt[2];
 	bool *dup;
 
+	topstar = acpi_driver_data(device);
+
 	/* 0x83 and 0x84 key events comes duplicated... */
 	if (event == 0x83 || event == 0x84) {
 		dup = &dup_evnt[event - 0x83];
@@ -319,7 +322,11 @@ static int topstar_acpi_add(struct acpi_device *device)
 			goto err_input_exit;
 	}
 
-	return 0;
+	err = acpi_device_install_event_handler(device, ACPI_DEVICE_NOTIFY, topstar_acpi_notify);
+	if (err)
+		goto err_input_exit;
+
+	return err;
 
 err_input_exit:
 	topstar_input_exit(topstar);
@@ -336,6 +343,8 @@ static void topstar_acpi_remove(struct acpi_device *device)
 {
 	struct topstar_laptop *topstar = acpi_driver_data(device);
 
+	acpi_device_remove_event_handler(device, ACPI_DEVICE_NOTIFY, topstar_acpi_notify);
+
 	if (led_workaround)
 		topstar_led_exit(topstar);
 
@@ -360,7 +369,6 @@ static struct acpi_driver topstar_acpi_driver = {
 	.ops = {
 		.add = topstar_acpi_add,
 		.remove = topstar_acpi_remove,
-		.notify = topstar_acpi_notify,
 	},
 };
 
-- 
2.40.1

