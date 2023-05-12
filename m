Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D61077009DF
	for <lists+linux-acpi@lfdr.de>; Fri, 12 May 2023 16:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241445AbjELODs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 12 May 2023 10:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241450AbjELODj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 12 May 2023 10:03:39 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED406132B4
        for <linux-acpi@vger.kernel.org>; Fri, 12 May 2023 07:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683900210; x=1715436210;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WLKJ1EHMeHpdKP/vBtOYJQNkoa4IDwWxTq1fyvbh/mM=;
  b=VEveL3h4qt1cY4Si7maf2D41PqQrSv/sW2tfdvQgkpoKJCZceI+cx0+2
   IFWKP6USWPW5VnO9QWPMD356rikXqkXxEwNX3caWkeDh7wvR/yeu//Vff
   vDnWz2P4zyrBGBVKYa041VyPrB2FTqz+bAn7ZEqIo0r2GzHEZQt7FV25f
   yXEaRfzL0441qRymS/KhWyf9ndgITfT05SvIGaG4OW4vWT51NYCjZmXHa
   gJK45GAYvAxsKKfqLnnDAsidaO4S+fqRXvyS8ouSfR5gaoxYKYETdlPuV
   C9Ycftv+Ju1tEzV9g0WxCZ/+buJX7HEw4H+TZGgm2yuFWodscNx5hhUHq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="378931192"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="378931192"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 07:03:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="650649009"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="650649009"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 07:03:29 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v1 28/34] platform/x86/toshiba_haps: Move handler installing logic to driver
Date:   Fri, 12 May 2023 16:02:16 +0200
Message-Id: <20230512140222.124868-29-michal.wilczynski@intel.com>
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
 drivers/platform/x86/toshiba_haps.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/toshiba_haps.c b/drivers/platform/x86/toshiba_haps.c
index 8c9f76286b08..ec0ffae3516c 100644
--- a/drivers/platform/x86/toshiba_haps.c
+++ b/drivers/platform/x86/toshiba_haps.c
@@ -129,8 +129,10 @@ static const struct attribute_group haps_attr_group = {
 /*
  * ACPI stuff
  */
-static void toshiba_haps_notify(struct acpi_device *device, u32 event)
+static void toshiba_haps_notify(acpi_handle handle, u32 event, void *data)
 {
+	struct acpi_device *device = data;
+
 	pr_debug("Received event: 0x%x\n", event);
 
 	acpi_bus_generate_netlink_event(device->pnp.device_class,
@@ -140,6 +142,7 @@ static void toshiba_haps_notify(struct acpi_device *device, u32 event)
 
 static void toshiba_haps_remove(struct acpi_device *device)
 {
+	acpi_device_remove_event_handler(acpi_dev, ACPI_ALL_NOTIFY, toshiba_haps_notify);
 	sysfs_remove_group(&device->dev.kobj, &haps_attr_group);
 
 	if (toshiba_haps)
@@ -203,7 +206,7 @@ static int toshiba_haps_add(struct acpi_device *acpi_dev)
 
 	toshiba_haps = haps;
 
-	return 0;
+	return acpi_device_install_event_handler(acpi_dev, ACPI_ALL_NOTIFY, toshiba_haps_notify);
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -253,11 +256,9 @@ static struct acpi_driver toshiba_haps_driver = {
 	.name = "Toshiba HAPS",
 	.owner = THIS_MODULE,
 	.ids = haps_device_ids,
-	.flags = ACPI_DRIVER_ALL_NOTIFY_EVENTS,
 	.ops = {
 		.add =		toshiba_haps_add,
 		.remove =	toshiba_haps_remove,
-		.notify =	toshiba_haps_notify,
 	},
 	.drv.pm = &toshiba_haps_pm,
 };
-- 
2.38.1

