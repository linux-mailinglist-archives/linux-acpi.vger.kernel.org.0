Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C67A5704CE7
	for <lists+linux-acpi@lfdr.de>; Tue, 16 May 2023 13:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233040AbjEPLtH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 16 May 2023 07:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233049AbjEPLs7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 16 May 2023 07:48:59 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6EB665B4
        for <linux-acpi@vger.kernel.org>; Tue, 16 May 2023 04:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684237702; x=1715773702;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g78n4JtrV5AuyACtMRvoWGwc1OTpMBYSGKwkHgUu8Lc=;
  b=A4/F6LuDC5Kxwcvu4YuXDypk+kv6ly2u8aQQsDqtyQjn94G+lZS2Qe/F
   i35BYFtTaaKnroFuJeSUMLD0uNOHtk69ZrVi6z64cC8jJIlRP8vKZejbc
   7t3dFjthJhvx3KPFzamd3InNfAvGct08RHPcgFx13PukLf269B41oT+T3
   A5If2VU5Z32Q8noRSbjHhkrqtTpzDaJeAzQRLnl/znYZMlM7+nfcuIJ6F
   hVu4x5a/8hzmDWaOvGJkxepl36rkkBj/fBOeAjMYAghdlqu6JiUxs76uL
   rmEYIp3TwNQp1BPHsWhCmzOi6LSD3KsH2DTn6h9Zz8WBv/lAFtD1jsRNB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="417111660"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="417111660"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 04:46:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="731961834"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="731961834"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 04:46:54 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v2 16/34] platform/x86/asus-laptop: Move handler installing logic to driver
Date:   Tue, 16 May 2023 13:45:59 +0200
Message-Id: <20230516114617.148963-17-michal.wilczynski@intel.com>
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
2.40.1

