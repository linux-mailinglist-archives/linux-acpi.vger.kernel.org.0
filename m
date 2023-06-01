Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC53719EB0
	for <lists+linux-acpi@lfdr.de>; Thu,  1 Jun 2023 15:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbjFANqV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 1 Jun 2023 09:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbjFANqU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Jun 2023 09:46:20 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646C6107;
        Thu,  1 Jun 2023 06:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685627178; x=1717163178;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vPErQFvNbDQV5UxbBwjTeZS4Z3UrzYSQ/WcQgm1VIHs=;
  b=jb6L7p70QbJrNyxjSZXEMgrKEQFuJUtCfVT9XgLvDSzyNkXWoY0e5wp1
   eculHMHGSNPtuKlxS7vcvLAcmzVB3p6+0ZywWadhquKfzqGj1gHjpKRbS
   jibnXjGy0XPcnl3LhHH8vivtl9QRHkOp09NaZ4+jfML3XJTr+1lgoomT2
   ZhJH9FrrrwI3abNxjb/8FUHdVLAt1bqzLRwn4xFVG7GzbvfnohSZZ/6Pq
   46+XeTgySbPj8Tox5k45PF6BRgTZjxiUCN6JiTr6S2XazOOX0vuNMii9s
   tYxgUwaSBpiWd7NAx3Uv1UP+kJ/UjgBGwRpNmmTnKi26rA1yPC8KOfje0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="419068745"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="419068745"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 06:20:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="881602114"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="881602114"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 06:20:08 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     Azael Avalos <coproscefalo@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     Michal Wilczynski <michal.wilczynski@intel.com>,
        platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org,
        rafael@kernel.org
Subject: [PATCH v4 28/35] platform/x86/toshiba_haps: Move handler installing logic to driver
Date:   Thu,  1 Jun 2023 15:17:31 +0200
Message-Id: <20230601131739.300760-29-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230601131739.300760-3-michal.wilczynski@intel.com>
References: <20230601131739.300760-3-michal.wilczynski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
index 8c9f76286b08..39e4c49847a8 100644
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
+	acpi_device_remove_event_handler(device, ACPI_ALL_NOTIFY, toshiba_haps_notify);
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
2.40.1

