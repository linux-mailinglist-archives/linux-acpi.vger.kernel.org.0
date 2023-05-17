Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B2E7061F2
	for <lists+linux-acpi@lfdr.de>; Wed, 17 May 2023 09:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbjEQH7C (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 17 May 2023 03:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjEQH6c (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 17 May 2023 03:58:32 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F0344AB
        for <linux-acpi@vger.kernel.org>; Wed, 17 May 2023 00:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684310308; x=1715846308;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wGccJ78CLi03k6nca7s4EOYG5mUfzdzU9KNUU7GPysY=;
  b=NEjJAgB416g4oNFTp/QzVLQv/ro2YeDQuDItAug8sccZFgoifSfnaAo1
   sfjxM+6McpFU2kT6WWxNAXGV/qK1qJyZvFhYonxQZC+rGx+Lmh5tNk6Nx
   zToY/Q+FvlWnGDDVGqUQGm2Yjb4kWxjIMmNcAPugIzctIUGmKVLLP4KD3
   tsw6lOUrc4EqShhE/J81HMKsRaI3Wm0fNIClWvxnC404RCYsoenTXuFbF
   DvrvmbR09FNR4DQusPqopzG0DfdsuPGPp4QojY8JT2s6vf86YqlVn1zZZ
   u105cp1Elrv7RJk/gQm7G85LO2BcezxQchWs7xL7ZAwMpfMa4mhshPNp7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="415105401"
X-IronPort-AV: E=Sophos;i="5.99,281,1677571200"; 
   d="scan'208";a="415105401"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 00:58:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="825877314"
X-IronPort-AV: E=Sophos;i="5.99,281,1677571200"; 
   d="scan'208";a="825877314"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 00:58:11 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, srinivas.pandruvada@linux.intel.com,
        Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v3 10/34] hwmon: Move handler installing logic to driver
Date:   Wed, 17 May 2023 09:57:00 +0200
Message-Id: <20230517075724.153992-11-michal.wilczynski@intel.com>
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
 drivers/hwmon/acpi_power_meter.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
index fa28d447f0df..5cc43986d9ab 100644
--- a/drivers/hwmon/acpi_power_meter.c
+++ b/drivers/hwmon/acpi_power_meter.c
@@ -817,9 +817,10 @@ static int read_capabilities(struct acpi_power_meter_resource *resource)
 }
 
 /* Handle ACPI event notifications */
-static void acpi_power_meter_notify(struct acpi_device *device, u32 event)
+static void acpi_power_meter_notify(acpi_handle handle, u32 event, void *data)
 {
 	struct acpi_power_meter_resource *resource;
+	struct acpi_device *device = data;
 	int res;
 
 	if (!device || !acpi_driver_data(device))
@@ -897,8 +898,12 @@ static int acpi_power_meter_add(struct acpi_device *device)
 		goto exit_remove;
 	}
 
-	res = 0;
-	goto exit;
+	res = acpi_device_install_event_handler(device, ACPI_DEVICE_NOTIFY,
+						acpi_power_meter_notify);
+	if (res)
+		goto exit_remove;
+
+	return res;
 
 exit_remove:
 	remove_attrs(resource);
@@ -906,7 +911,7 @@ static int acpi_power_meter_add(struct acpi_device *device)
 	free_capabilities(resource);
 exit_free:
 	kfree(resource);
-exit:
+
 	return res;
 }
 
@@ -917,6 +922,7 @@ static void acpi_power_meter_remove(struct acpi_device *device)
 	if (!device || !acpi_driver_data(device))
 		return;
 
+	acpi_device_remove_event_handler(device, ACPI_DEVICE_NOTIFY, acpi_power_meter_notify);
 	resource = acpi_driver_data(device);
 	hwmon_device_unregister(resource->hwmon_dev);
 
@@ -953,7 +959,6 @@ static struct acpi_driver acpi_power_meter_driver = {
 	.ops = {
 		.add = acpi_power_meter_add,
 		.remove = acpi_power_meter_remove,
-		.notify = acpi_power_meter_notify,
 		},
 	.drv.pm = pm_sleep_ptr(&acpi_power_meter_pm),
 };
-- 
2.40.1

