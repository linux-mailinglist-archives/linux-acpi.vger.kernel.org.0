Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82CA9704CE3
	for <lists+linux-acpi@lfdr.de>; Tue, 16 May 2023 13:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232706AbjEPLs3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 16 May 2023 07:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232985AbjEPLs1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 16 May 2023 07:48:27 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A02A76AE
        for <linux-acpi@vger.kernel.org>; Tue, 16 May 2023 04:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684237664; x=1715773664;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dpQXRY65iSYpMYBGCqugkZMcPMypiiSUk2q3EXCvg0U=;
  b=hhHnsG6rlUwrGPNRAvjE8dYfdzqRbhdu/IYt4szY9bOrV1UxW3nGMVfi
   uNC+n72tdNx6qaDuOIoEKLSU28DJzKIVWJAdM1QUzwueKMF7hv0X9S3Jf
   UpswUH60HR2hLY2MbTjLZ5iuEp+NBXM92Lws8dwy1J40r+XWkljVfRlYf
   6Ls5u3n5ixAFdUqdUz1eFcrcZ02lz8lYoZ6dA2XVkqVos46IhadQYbtzE
   aLmUJqeZcYkIFEv3gfc0nd3lrhaAio3ORIkC1XAPuhpzzp7xu7TZc5FSa
   SMvt8p9b/muupxl8QZhyZkcpoRMZ5OeeY/WJTErmRE60JXsphq4PeIkDB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="417111646"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="417111646"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 04:46:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="731961816"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="731961816"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 04:46:50 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v2 13/34] platform/wilco_ec: Move handler installing logic to driver
Date:   Tue, 16 May 2023 13:45:56 +0200
Message-Id: <20230516114617.148963-14-michal.wilczynski@intel.com>
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

