Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F16719E87
	for <lists+linux-acpi@lfdr.de>; Thu,  1 Jun 2023 15:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232984AbjFANoQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 1 Jun 2023 09:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbjFANoQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Jun 2023 09:44:16 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3825A107;
        Thu,  1 Jun 2023 06:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685627055; x=1717163055;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/zOt8Ip/74RNexXI8wybJ/13PRTBt2DlRVAtzxRcwFc=;
  b=TCoLlNyZPH740IEZ+hGFmnnN53Z3CJ7IoPNp/9zkfqtUcIY3e2QAETUs
   aZ3YV/9hyINPAMhxe5RtAvbQossA8WaZhFJ0v1vxGpgTLu5tR8Q4QKRti
   fJChG4NS7H1deVpCu8DpOjP7FyypgriJFvbVPhCA0rT/teJTpNYS0AwmN
   fuWpwbffmBuOIheDZ0E3VFk5nr9sCjc1ZFjeiECMh3BlmGIwPJnj2FwOU
   SWCphN3HvirLqB8AOJHhHKlKPxaqkztpEB22t1LPemN2vKo6r4f69B6yd
   uhIWAaLKe71eTstuxuX/6KplSBKv4NzEOImXXeXTEu0xMm8nY5o8oYMfI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="419067545"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="419067545"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 06:19:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="881601714"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="881601714"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 06:19:12 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     Benson Leung <bleung@chromium.org>
Cc:     Michal Wilczynski <michal.wilczynski@intel.com>,
        chrome-platform@lists.linux.dev, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, rafael@kernel.org
Subject: [PATCH v4 13/35] platform/wilco_ec: Move handler installing logic to driver
Date:   Thu,  1 Jun 2023 15:17:16 +0200
Message-Id: <20230601131739.300760-14-michal.wilczynski@intel.com>
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
 drivers/platform/chrome/wilco_ec/event.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/chrome/wilco_ec/event.c b/drivers/platform/chrome/wilco_ec/event.c
index a40f60bcefb6..23fd6de623f4 100644
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
 
@@ -490,6 +484,11 @@ static int event_device_add(struct acpi_device *adev)
 	if (error)
 		goto free_dev_data;
 
+	error =  acpi_device_install_event_handler(adev, ACPI_DEVICE_NOTIFY,
+						   event_device_notify);
+	if (error)
+		goto free_dev_data;
+
 	return 0;
 
 free_dev_data:
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

