Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 328EB7009DE
	for <lists+linux-acpi@lfdr.de>; Fri, 12 May 2023 16:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241443AbjELODr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 12 May 2023 10:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241449AbjELODi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 12 May 2023 10:03:38 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48ED12EA1
        for <linux-acpi@vger.kernel.org>; Fri, 12 May 2023 07:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683900209; x=1715436209;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Cq01VFhjgj/mEhu0HxUgKXpUNPjV4fQitrA3AnSxcpE=;
  b=LG+ewfXvd0UFAagpBO/KAwIJv1/W6vrZPAX5t9f6c+vW3J4wy9KZcZfZ
   oPo9eVtemJEWCMYsdpTAYsKOly3OUzT2m0PqkapWIBQZU+ZYOn0mlmnHd
   dnorvjR1GX3gUxPOyn8g4NT0Up3sd2uf6NwzlE4elB+6gy9v/qIdxjLHQ
   fhrXBI1qMlg+SgPnhE+4DYFX89ZDuvoabbCKTHu67Lq66pyX5lLewnxRz
   eTC+gjOSFudZBQNEThnVqUMW9F2Y3Lj4FTsJJxtTauCvPa4iwXnRGAJTv
   9r0nV6FjIKlHUzbxiV4OR57N/pJL19eRgXCjKoMxEPMeO5E1zRJO86pgD
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="378931186"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="378931186"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 07:03:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="650649005"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="650649005"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 07:03:28 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v1 27/34] platform/x86/toshiba_bluetooth: Move handler installing logic to driver
Date:   Fri, 12 May 2023 16:02:15 +0200
Message-Id: <20230512140222.124868-28-michal.wilczynski@intel.com>
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
 drivers/platform/x86/toshiba_bluetooth.c | 27 ++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/toshiba_bluetooth.c b/drivers/platform/x86/toshiba_bluetooth.c
index d8f81962a240..7d8bd5f73eae 100644
--- a/drivers/platform/x86/toshiba_bluetooth.c
+++ b/drivers/platform/x86/toshiba_bluetooth.c
@@ -204,9 +204,12 @@ static const struct rfkill_ops rfk_ops = {
 };
 
 /* ACPI driver functions */
-static void toshiba_bt_rfkill_notify(struct acpi_device *device, u32 event)
+static void toshiba_bt_rfkill_notify(acpi_handle handle, u32 event, void *data)
 {
-	struct toshiba_bluetooth_dev *bt_dev = acpi_driver_data(device);
+	struct toshiba_bluetooth_dev *bt_dev;
+	struct acpi_device *device = data;
+
+	bt_dev = acpi_driver_data(device);
 
 	if (toshiba_bluetooth_sync_status(bt_dev))
 		return;
@@ -263,8 +266,8 @@ static int toshiba_bt_rfkill_add(struct acpi_device *device)
 				   bt_dev);
 	if (!bt_dev->rfk) {
 		pr_err("Unable to allocate rfkill device\n");
-		kfree(bt_dev);
-		return -ENOMEM;
+		result = -ENOMEM;
+		goto fail_allocate;
 	}
 
 	rfkill_set_hw_state(bt_dev->rfk, !bt_dev->killswitch);
@@ -272,10 +275,20 @@ static int toshiba_bt_rfkill_add(struct acpi_device *device)
 	result = rfkill_register(bt_dev->rfk);
 	if (result) {
 		pr_err("Unable to register rfkill device\n");
-		rfkill_destroy(bt_dev->rfk);
-		kfree(bt_dev);
+		goto fail_register;
 	}
 
+	result = acpi_device_install_event_handler(acpi_dev, ACPI_DEVICE_NOTIFY,
+						    toshiba_bt_rfkill_notify);
+	if (result)
+		goto fail_register;
+
+	return result;
+
+fail_register:
+	rfkill_destroy(bt_dev->rfk);
+fail_allocate:
+	kfree(bt_dev);
 	return result;
 }
 
@@ -283,6 +296,8 @@ static void toshiba_bt_rfkill_remove(struct acpi_device *device)
 {
 	struct toshiba_bluetooth_dev *bt_dev = acpi_driver_data(device);
 
+	acpi_device_remove_event_handler(acpi_dev, ACPI_DEVICE_NOTIFY, toshiba_bt_rfkill_notify);
+
 	/* clean up */
 	if (bt_dev->rfk) {
 		rfkill_unregister(bt_dev->rfk);
-- 
2.38.1

