Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C919D706204
	for <lists+linux-acpi@lfdr.de>; Wed, 17 May 2023 09:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjEQH7V (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 17 May 2023 03:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjEQH6l (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 17 May 2023 03:58:41 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E085CEA
        for <linux-acpi@vger.kernel.org>; Wed, 17 May 2023 00:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684310319; x=1715846319;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vPErQFvNbDQV5UxbBwjTeZS4Z3UrzYSQ/WcQgm1VIHs=;
  b=WaJylMIS2wnnFk4jmCFsovqcM4oKy8a2XAp+tKiiOo6wk357xuMLx6dk
   8dxokD1qFS1p1Q+759a1lc/8mmUthQjCEWUMBBHZTSL+rIAx8gbBR9DYi
   WSdOg72eflKD6pekStuVydkuJaGAwjwrMzSwBdFHn3v5PtoNiOWjW5Z6K
   1scPz+CQhULur/3AZUr3GpcwyGiJ5Lmr6Tx6qWxHwKFvhiYqb/oMWTUUm
   ip350QXi/4oq0IzCmwG2ptrSMrjEKJ44I3qn2kVo8oLHaxOzXJ9mFx0mr
   Pmpr/TKqDMRoBA5XJvEhbemK5Qq15LwcZA+lEm4lFyLyqMKlna3WgaoIx
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="415105497"
X-IronPort-AV: E=Sophos;i="5.99,281,1677571200"; 
   d="scan'208";a="415105497"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 00:58:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="825877511"
X-IronPort-AV: E=Sophos;i="5.99,281,1677571200"; 
   d="scan'208";a="825877511"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 00:58:38 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, srinivas.pandruvada@linux.intel.com,
        Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v3 28/34] platform/x86/toshiba_haps: Move handler installing logic to driver
Date:   Wed, 17 May 2023 09:57:18 +0200
Message-Id: <20230517075724.153992-29-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230517075724.153992-1-michal.wilczynski@intel.com>
References: <20230517075724.153992-1-michal.wilczynski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

