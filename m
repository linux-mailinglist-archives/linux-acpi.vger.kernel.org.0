Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6E377061F4
	for <lists+linux-acpi@lfdr.de>; Wed, 17 May 2023 09:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjEQH7E (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 17 May 2023 03:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjEQH6c (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 17 May 2023 03:58:32 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CEC5468A
        for <linux-acpi@vger.kernel.org>; Wed, 17 May 2023 00:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684310309; x=1715846309;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dpQXRY65iSYpMYBGCqugkZMcPMypiiSUk2q3EXCvg0U=;
  b=Lgh8DZlSeTq3LIz2/4M8wC7ovVl7QGVB1R2HSsrgEbVtdJRcQ2RSgCQc
   PkkLKECBL+xGpz2tu56lYNR8SexK79ZpErI3wL+ZNpfkkPYvqVU7xk72r
   Q7QyTFl3/7G7uQOIiDYPy3BQYj0kYNMxhOJU5wklQRgFC3IU+7bZHdGYJ
   Ed9wR5/jpmbhPkkHL7cAq4EX4PV3VJvAQl/2TajO9SqkNKbIF9X2MASeu
   bnNHq8O9VGt9q5zbpjOONuEHyn5qSGUB0Sqy15LKrv+b+dbQ4GGMx+dik
   qpOdLdo3CGTFdZpdwzcvmAEx79oJU1Aycw42mJ0GppFagRpO/F89zFIOu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="415105415"
X-IronPort-AV: E=Sophos;i="5.99,281,1677571200"; 
   d="scan'208";a="415105415"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 00:58:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="825877378"
X-IronPort-AV: E=Sophos;i="5.99,281,1677571200"; 
   d="scan'208";a="825877378"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 00:58:16 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, srinivas.pandruvada@linux.intel.com,
        Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v3 13/34] platform/wilco_ec: Move handler installing logic to driver
Date:   Wed, 17 May 2023 09:57:03 +0200
Message-Id: <20230517075724.153992-14-michal.wilczynski@intel.com>
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
 drivers/platform/chrome/wilco_ec/event.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/platform/chrome/wilco_ec/event.c b/drivers/platform/chrome/wilco_ec/event.c
index a40f60bcefb6..37b83e83f617 100644
--- a/drivers/platform/chrome/wilco_ec/event.c
+++ b/drivers/platform/chrome/wilco_ec/event.c
@@ -251,16 +251,10 @@ static int enqueue_events(struct acpi_device *adev, const u8 *buf, u32 length)
 	return 0;
 }
 
-/**
- * event_device_notify() - Callback when EC generates an event over ACPI.
- * @adev: The device that the event is coming from.
- * @value: Value passed to Notify() in ACPI.
- *
- * This function will read the events from the device and enqueue them.
- */
-static void event_device_notify(struct acpi_device *adev, u32 value)
+static void event_device_notify(acpi_handle handle, u32 value, void *data)
 {
 	struct acpi_buffer event_buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	struct acpi_device *adev = data;
 	union acpi_object *obj;
 	acpi_status status;
 
@@ -490,7 +484,12 @@ static int event_device_add(struct acpi_device *adev)
 	if (error)
 		goto free_dev_data;
 
-	return 0;
+	error =  acpi_device_install_event_handler(adev, ACPI_DEVICE_NOTIFY,
+						   event_device_notify);
+	if (error)
+		goto free_dev_data;
+
+	return error;
 
 free_dev_data:
 	hangup_device(dev_data);
@@ -503,6 +502,7 @@ static void event_device_remove(struct acpi_device *adev)
 {
 	struct event_device_data *dev_data = adev->driver_data;
 
+	acpi_device_remove_event_handler(adev, ACPI_DEVICE_NOTIFY, event_device_notify);
 	cdev_device_del(&dev_data->cdev, &dev_data->dev);
 	ida_simple_remove(&event_ida, MINOR(dev_data->dev.devt));
 	hangup_device(dev_data);
@@ -520,7 +520,6 @@ static struct acpi_driver event_driver = {
 	.ids = event_acpi_ids,
 	.ops = {
 		.add = event_device_add,
-		.notify = event_device_notify,
 		.remove = event_device_remove,
 	},
 	.owner = THIS_MODULE,
-- 
2.40.1

