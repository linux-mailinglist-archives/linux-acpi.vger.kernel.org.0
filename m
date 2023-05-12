Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709527009D3
	for <lists+linux-acpi@lfdr.de>; Fri, 12 May 2023 16:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241434AbjELODk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 12 May 2023 10:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241430AbjELODR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 12 May 2023 10:03:17 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F21124B6
        for <linux-acpi@vger.kernel.org>; Fri, 12 May 2023 07:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683900195; x=1715436195;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/JtMl547iYpyECwmCftqBv8Oj+zJ2NXV2HrJ5r7Ez4M=;
  b=BD+GxbEaocF3jGs9FD7CP9c1H2cNi/UAsTWQse4y6hCY9VIl9RRkCrva
   e9sZGXyqL6FWirvHsjIxznwSXiKnNId8/8ym4HDV4C8S3rw1Uh7jDufmm
   eCCUCt4XFIxS1gAN1exkeg6b/C+on6+E7zc6jBO8YcBEEOPe3mkRqtb6u
   98Wh4D+n7Zy/QiO0pCDcN0UcSQ37LTI17m2krzFMT8abre781hNSdzsCw
   yd+6VLHmNZMtOqTh3+Iyasx7B2wBQqK58tcVqDtLC6yHK118JBZg0zTc5
   9FG8IhF7MBoYQWzW7EL+/mpx3zTm5435O5Q1HyGTG+Yn1SeGchpqrRsWE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="378931107"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="378931107"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 07:03:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="650648971"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="650648971"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 07:03:14 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v1 16/34] platform/x86/asus-laptop: Move handler installing logic to driver
Date:   Fri, 12 May 2023 16:02:04 +0200
Message-Id: <20230512140222.124868-17-michal.wilczynski@intel.com>
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
 drivers/platform/x86/asus-laptop.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/asus-laptop.c b/drivers/platform/x86/asus-laptop.c
index 761029f39314..fa348c96be16 100644
--- a/drivers/platform/x86/asus-laptop.c
+++ b/drivers/platform/x86/asus-laptop.c
@@ -1515,11 +1515,14 @@ static void asus_input_exit(struct asus_laptop *asus)
 /*
  * ACPI driver
  */
-static void asus_acpi_notify(struct acpi_device *device, u32 event)
+static void asus_acpi_notify(acpi_handle handle, u32 event, void *data)
 {
-	struct asus_laptop *asus = acpi_driver_data(device);
+	struct acpi_device *device = data;
+	struct asus_laptop *asus;
 	u16 count;
 
+	asus = acpi_driver_data(device);
+
 	/* TODO Find a better way to handle events count. */
 	count = asus->event_count[event % 128]++;
 	acpi_bus_generate_netlink_event(asus->device->pnp.device_class,
@@ -1880,8 +1883,12 @@ static int asus_acpi_add(struct acpi_device *device)
 	if (result && result != -ENODEV)
 		goto fail_pega_rfkill;
 
+	result =  acpi_device_install_event_handler(device, ACPI_ALL_NOTIFY, asus_acpi_notify);
+	if (result)
+		goto fail_pega_rfkill;
+
 	asus_device_present = true;
-	return 0;
+	return result;
 
 fail_pega_rfkill:
 	pega_accel_exit(asus);
@@ -1905,6 +1912,7 @@ static void asus_acpi_remove(struct acpi_device *device)
 {
 	struct asus_laptop *asus = acpi_driver_data(device);
 
+	acpi_device_remove_event_handler(device, ACPI_ALL_NOTIFY, asus_acpi_notify);
 	asus_backlight_exit(asus);
 	asus_rfkill_exit(asus);
 	asus_led_exit(asus);
@@ -1928,11 +1936,9 @@ static struct acpi_driver asus_acpi_driver = {
 	.class = ASUS_LAPTOP_CLASS,
 	.owner = THIS_MODULE,
 	.ids = asus_device_ids,
-	.flags = ACPI_DRIVER_ALL_NOTIFY_EVENTS,
 	.ops = {
 		.add = asus_acpi_add,
 		.remove = asus_acpi_remove,
-		.notify = asus_acpi_notify,
 		},
 };
 
-- 
2.38.1

