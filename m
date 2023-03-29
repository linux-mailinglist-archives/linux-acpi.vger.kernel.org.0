Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3CCF6CD758
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Mar 2023 12:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbjC2KKD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 29 Mar 2023 06:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbjC2KKA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Mar 2023 06:10:00 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565A919A;
        Wed, 29 Mar 2023 03:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680084599; x=1711620599;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Bgz28ewbRcBG6cgmyNwmPI2DHGuZZdE2Xqakl+AkmbI=;
  b=FGXwCeVadF37YB3ynR+WPrJ7iMs3VDe4pLlZqiT8gwGVXupA0vBJ/ojP
   6H9xggdOB5ya06HrcDaPk79lTEIPAftZzeg4z9rSTaBcChWOVXT8gyj4E
   UULeTddLVpc7po5V9CzG+A/LhPcXzVfPJ2UEEaIl75O/z14DrgJrVF/Vf
   HJ82ZtiS/DBldscnGlYsWrhrcWxX3Glws5YyFHNroIQdD+HV5gOrABbfh
   n2BQGN5pnZl7aZqaxN9mMhF6tAVuZNmnPBANrWGbeSrYcTm22k3rS50l0
   H5zVlVT1zlrWplEkHYm7iGjt3pIXuCFm8CbukChz+NfJkU/cEWwKSgr7w
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="343256224"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="343256224"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 03:09:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="773517704"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="773517704"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 03:09:56 -0700
Received: from svinhufvud.ger.corp.intel.com (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with ESMTP id 88B8D12259B;
        Wed, 29 Mar 2023 13:09:53 +0300 (EEST)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     linux-media@vger.kernel.org, rafael@kernel.org,
        andriy.shevchenko@linux.intel.com, heikki.krogerus@linux.intel.com
Subject: [PATCH v8 01/10] ACPI: scan: Remove the second DSDT traversal
Date:   Wed, 29 Mar 2023 13:09:42 +0300
Message-Id: <20230329100951.1522322-2-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230329100951.1522322-1-sakari.ailus@linux.intel.com>
References: <20230329100951.1522322-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Collect the devices with _DEP into a list and continue processing them
after a full traversal, instead of doing a full second traversal of the
tree.

This makes the second DSDT traversal pass unnecessary as we already have
the nodes we're interested in in a linked list.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/acpi/scan.c | 125 ++++++++++++++++++++++++++++++++------------
 1 file changed, 92 insertions(+), 33 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 0c6f06abe3f4..280d12e0aa2f 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2029,10 +2029,52 @@ static u32 acpi_scan_check_dep(acpi_handle handle, bool check_dep)
 	return count;
 }
 
-static bool acpi_bus_scan_second_pass;
+/**
+ * struct acpi_postponed_handle - A postponed ACPI handle
+ * @list: Entry in a postponed list
+ * @handle: The postponed handle
+ *
+ * One such entry represents an ACPI handle the scanning of which has been
+ * postponed.
+ */
+struct acpi_postponed_handle {
+	struct list_head list;
+	acpi_handle handle;
+};
+
+/**
+ * struct acpi_scan_context - Context for scanning ACPI devices
+ * @postponed_head: The list head of the postponed ACPI handles
+ * @device: The first encountered device, typically the root of the scanned tree
+ */
+struct acpi_scan_context {
+	struct list_head postponed_head;
+	struct acpi_device *device;
+};
+
+/**
+ * acpi_bus_handle_postpone - Add an ACPI handle to a given postponed list
+ * @handle: The ACPI handle
+ * @head: Postponed list head
+ *
+ * Add a given ACPI handle to a list of ACPI objects for which the creation
+ * of the device objects is to be postponed.
+ */
+static void acpi_bus_handle_postpone(acpi_handle handle,
+				     struct list_head *head)
+{
+	struct acpi_postponed_handle *ph;
+
+	ph = kzalloc(sizeof(*ph), GFP_KERNEL);
+	if (!ph)
+		return;
+
+	ph->handle = handle;
+	list_add(&ph->list, head);
+}
 
 static acpi_status acpi_bus_check_add(acpi_handle handle, bool check_dep,
-				      struct acpi_device **adev_p)
+				      struct acpi_scan_context *ctx)
 {
 	struct acpi_device *device = acpi_fetch_acpi_dev(handle);
 	acpi_object_type acpi_type;
@@ -2051,7 +2093,7 @@ static acpi_status acpi_bus_check_add(acpi_handle handle, bool check_dep,
 
 		/* Bail out if there are dependencies. */
 		if (acpi_scan_check_dep(handle, check_dep) > 0) {
-			acpi_bus_scan_second_pass = true;
+			acpi_bus_handle_postpone(handle, &ctx->postponed_head);
 			return AE_CTRL_DEPTH;
 		}
 
@@ -2086,22 +2128,22 @@ static acpi_status acpi_bus_check_add(acpi_handle handle, bool check_dep,
 	acpi_scan_init_hotplug(device);
 
 out:
-	if (!*adev_p)
-		*adev_p = device;
+	if (!ctx->device)
+		ctx->device = device;
 
 	return AE_OK;
 }
 
 static acpi_status acpi_bus_check_add_1(acpi_handle handle, u32 lvl_not_used,
-					void *not_used, void **ret_p)
+					void *ctx, void **unused)
 {
-	return acpi_bus_check_add(handle, true, (struct acpi_device **)ret_p);
+	return acpi_bus_check_add(handle, true, (struct acpi_scan_context *)ctx);
 }
 
 static acpi_status acpi_bus_check_add_2(acpi_handle handle, u32 lvl_not_used,
-					void *not_used, void **ret_p)
+					void *ctx, void **device)
 {
-	return acpi_bus_check_add(handle, false, (struct acpi_device **)ret_p);
+	return acpi_bus_check_add(handle, false, (struct acpi_scan_context *)ctx);
 }
 
 static void acpi_default_enumeration(struct acpi_device *device)
@@ -2422,37 +2464,54 @@ EXPORT_SYMBOL_GPL(acpi_dev_get_next_consumer_dev);
  */
 int acpi_bus_scan(acpi_handle handle)
 {
-	struct acpi_device *device = NULL;
-
-	acpi_bus_scan_second_pass = false;
-
-	/* Pass 1: Avoid enumerating devices with missing dependencies. */
+	struct acpi_scan_context ctx = {
+		.postponed_head = LIST_HEAD_INIT(ctx.postponed_head),
+	};
+	struct acpi_postponed_handle *ph, *tmp_ph;
+	int ret = 0;
 
-	if (ACPI_SUCCESS(acpi_bus_check_add(handle, true, &device)))
+	if (ACPI_SUCCESS(acpi_bus_check_add(handle, true, &ctx)))
 		acpi_walk_namespace(ACPI_TYPE_ANY, handle, ACPI_UINT32_MAX,
-				    acpi_bus_check_add_1, NULL, NULL,
-				    (void **)&device);
-
-	if (!device)
-		return -ENODEV;
-
-	acpi_bus_attach(device, (void *)true);
+				    acpi_bus_check_add_1, NULL, (void *)&ctx,
+				    NULL);
 
-	if (!acpi_bus_scan_second_pass)
-		return 0;
-
-	/* Pass 2: Enumerate all of the remaining devices. */
+	if (!ctx.device) {
+		ret = -ENODEV;
+		goto out_release;
+	}
 
-	device = NULL;
+	acpi_bus_attach(ctx.device, (void *)true);
 
-	if (ACPI_SUCCESS(acpi_bus_check_add(handle, false, &device)))
-		acpi_walk_namespace(ACPI_TYPE_ANY, handle, ACPI_UINT32_MAX,
-				    acpi_bus_check_add_2, NULL, NULL,
-				    (void **)&device);
+	/*
+	 * Proceed to register ACPI devices that were postponed due to _DEP
+	 * objects during the namespace walk.
+	 */
+	list_for_each_entry_safe(ph, tmp_ph, &ctx.postponed_head, list) {
+		list_del(&ph->list);
+		/* Set device NULL here to obtain the root for this sub-tree. */
+		ctx.device = NULL;
+		/*
+		 * Do this manually, as the namespace walk will only include
+		 * sub-nodes, not the node itself. ctx.device is set to the
+		 * ACPI device corresponding ph->handle.
+		 */
+		acpi_bus_check_add_2(ph->handle, 0, &ctx, NULL);
+		/* Walk the rest of the sub-namespace. */
+		acpi_walk_namespace(ACPI_TYPE_ANY, ph->handle, ACPI_UINT32_MAX,
+				    acpi_bus_check_add_2, NULL, (void *)&ctx,
+				    NULL);
+		if (ctx.device)
+			acpi_bus_attach(ctx.device, NULL);
+		kfree(ph);
+	}
 
-	acpi_bus_attach(device, NULL);
+out_release:
+	list_for_each_entry_safe(ph, tmp_ph, &ctx.postponed_head, list) {
+		list_del(&ph->list);
+		kfree(ph);
+	}
 
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL(acpi_bus_scan);
 
-- 
2.30.2

