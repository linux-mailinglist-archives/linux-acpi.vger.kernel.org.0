Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 990CF704CE6
	for <lists+linux-acpi@lfdr.de>; Tue, 16 May 2023 13:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232901AbjEPLsr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 16 May 2023 07:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232951AbjEPLsm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 16 May 2023 07:48:42 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554E45592
        for <linux-acpi@vger.kernel.org>; Tue, 16 May 2023 04:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684237694; x=1715773694;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I2qxpSnbpgLjM78ZtYch42J8ILoMjAtDeHGN9eT4sCo=;
  b=GxPVn2EgF1/6gIR2EZMKElfOe0aqNTJ5AfxHckuo5WKym8hXqGO12bDl
   xAl0Q61V3W/EW3xa8kGBZNTjogmEM0KMjX6eh0hQO+d6VvPnWG54AH/Lz
   6sKb31MzM/dKImHAjmb/mjq86Z2lQOu9jGnSHJoadeFkK0447/i4rfniN
   Xga0Z3riUFqF3+FdgD021cKaAReGd1aqeT8q9HU8e4u46vsTwiFou03lF
   LXpZjBfWdweG3Q0IP8kJ64gard2nh+bbLH24mYSr7plNhq5a1ESHJj6Yx
   RmKehPKqIK6rHYBiuQSQ0s/XHcoggvrtnfCtbZ44ZydcJDnNl/uLTPlxT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="417111656"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="417111656"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 04:46:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="731961827"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="731961827"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 04:46:53 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v2 15/34] platform/x86/acer-wireless: Move handler installing logic to driver
Date:   Tue, 16 May 2023 13:45:58 +0200
Message-Id: <20230516114617.148963-16-michal.wilczynski@intel.com>
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
 drivers/platform/x86/acer-wireless.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/acer-wireless.c b/drivers/platform/x86/acer-wireless.c
index 1b5d935d085a..275215fd18c2 100644
--- a/drivers/platform/x86/acer-wireless.c
+++ b/drivers/platform/x86/acer-wireless.c
@@ -18,9 +18,12 @@ static const struct acpi_device_id acer_wireless_acpi_ids[] = {
 };
 MODULE_DEVICE_TABLE(acpi, acer_wireless_acpi_ids);
 
-static void acer_wireless_notify(struct acpi_device *adev, u32 event)
+static void acer_wireless_notify(acpi_handle handle, u32 event, void *data)
 {
-	struct input_dev *idev = acpi_driver_data(adev);
+	struct acpi_device *adev = data;
+	struct input_dev *idev;
+
+	idev = acpi_driver_data(adev);
 
 	dev_dbg(&adev->dev, "event=%#x\n", event);
 	if (event != 0x80) {
@@ -36,6 +39,7 @@ static void acer_wireless_notify(struct acpi_device *adev, u32 event)
 static int acer_wireless_add(struct acpi_device *adev)
 {
 	struct input_dev *idev;
+	int ret;
 
 	idev = devm_input_allocate_device(&adev->dev);
 	if (!idev)
@@ -50,7 +54,17 @@ static int acer_wireless_add(struct acpi_device *adev)
 	set_bit(EV_KEY, idev->evbit);
 	set_bit(KEY_RFKILL, idev->keybit);
 
-	return input_register_device(idev);
+	ret = input_register_device(idev);
+
+	if (ret)
+		return ret;
+
+	return acpi_device_install_event_handler(device, ACPI_DEVICE_NOTIFY, acer_wireless_notify);
+}
+
+static void acer_wireless_remove(struct acpi_device *adev)
+{
+	acpi_device_remove_event_handler(device, ACPI_DEVICE_NOTIFY, acer_wireless_notify);
 }
 
 static struct acpi_driver acer_wireless_driver = {
@@ -59,7 +73,7 @@ static struct acpi_driver acer_wireless_driver = {
 	.ids = acer_wireless_acpi_ids,
 	.ops = {
 		.add = acer_wireless_add,
-		.notify = acer_wireless_notify,
+		.remove = acer_wireless_remove,
 	},
 };
 module_acpi_driver(acer_wireless_driver);
-- 
2.40.1

