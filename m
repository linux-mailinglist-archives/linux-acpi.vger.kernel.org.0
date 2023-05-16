Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1BDC704CFF
	for <lists+linux-acpi@lfdr.de>; Tue, 16 May 2023 13:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232554AbjEPLup (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 16 May 2023 07:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbjEPLuI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 16 May 2023 07:50:08 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FC72701
        for <linux-acpi@vger.kernel.org>; Tue, 16 May 2023 04:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684237795; x=1715773795;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=znjg1HTj5xvxahu+0hAY1ilrkW02Q96e/dE6fQc+3t4=;
  b=h7oJV+bQSX0noBnXJDiz8BBCEZ9fVQwrMWSRrJMU/nVg541g8lweu1Hf
   TBakXL8zQ3bpSq8YAc8EwfrACVmPFo5Cqc9wgcbxUmTn3o/lYqLo/Zilv
   VL+zZlvZrn/fash9+MmLB72+yb2W1UtSnIuUzhyzQhPUKxzkjut2Lykdj
   WoS8iTMlqyN8wV8htTXxaSd2zq+IUph5nomMNnQYNCJUX/xFUwtqUJ+wr
   qsWWi7/RyJR+ANIaLVdrWHcS8nUhLQlCqIFdTLbvYlU3bL8z9X+vxstcZ
   QiysLBvt0SmRh0S1/OYQkzryWPf1qUIc/uRcQZ3py49m5LIsEuNs46Fh+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="417111757"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="417111757"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 04:47:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="731962015"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="731962015"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 04:47:16 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v2 33/34] acpi/bus: Remove redundant functions
Date:   Tue, 16 May 2023 13:46:16 +0200
Message-Id: <20230516114617.148963-34-michal.wilczynski@intel.com>
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

By this point all drivers switched from using .notify callback to
installing event handlers on their own. Remove redundant functions
acpi_device_install_notify_handler(),
acpi_device_remove_notify_handler() and acpi_notify_device().

Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
---
 drivers/acpi/bus.c | 60 ----------------------------------------------
 1 file changed, 60 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 3eeeec70e70b..bf0704bf8e04 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -522,14 +522,6 @@ static void acpi_bus_notify(acpi_handle handle, u32 type, void *data)
 	acpi_evaluate_ost(handle, type, ACPI_OST_SC_NON_SPECIFIC_FAILURE, NULL);
 }
 
-static void acpi_notify_device(acpi_handle handle, u32 event, void *data)
-{
-	struct acpi_device *device = data;
-	struct acpi_driver *acpi_drv = to_acpi_driver(device->dev.driver);
-
-	acpi_drv->ops.notify(device, event);
-}
-
 static void acpi_notify_device_fixed(void *data)
 {
 	struct acpi_device *device = data;
@@ -544,58 +536,6 @@ static u32 acpi_device_fixed_event(void *data)
 	return ACPI_INTERRUPT_HANDLED;
 }
 
-static int acpi_device_install_notify_handler(struct acpi_device *device,
-					      struct acpi_driver *acpi_drv)
-{
-	acpi_status status;
-
-	if (device->device_type == ACPI_BUS_TYPE_POWER_BUTTON) {
-		device->fixed_event_notify = acpi_notify_device;
-		status =
-		    acpi_install_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
-						     acpi_device_fixed_event,
-						     device);
-	} else if (device->device_type == ACPI_BUS_TYPE_SLEEP_BUTTON) {
-		device->fixed_event_notify = acpi_notify_device;
-		status =
-		    acpi_install_fixed_event_handler(ACPI_EVENT_SLEEP_BUTTON,
-						     acpi_device_fixed_event,
-						     device);
-	} else {
-		u32 type = acpi_drv->flags & ACPI_DRIVER_ALL_NOTIFY_EVENTS ?
-				ACPI_ALL_NOTIFY : ACPI_DEVICE_NOTIFY;
-
-		status = acpi_install_notify_handler(device->handle, type,
-						     acpi_notify_device,
-						     device);
-	}
-
-	if (ACPI_FAILURE(status))
-		return -EINVAL;
-	return 0;
-}
-
-static void acpi_device_remove_notify_handler(struct acpi_device *device,
-					      struct acpi_driver *acpi_drv)
-{
-	if (device->device_type == ACPI_BUS_TYPE_POWER_BUTTON) {
-		acpi_remove_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
-						acpi_device_fixed_event);
-		device->fixed_event_notify = NULL;
-	} else if (device->device_type == ACPI_BUS_TYPE_SLEEP_BUTTON) {
-		acpi_remove_fixed_event_handler(ACPI_EVENT_SLEEP_BUTTON,
-						acpi_device_fixed_event);
-		device->fixed_event_notify = NULL;
-	} else {
-		u32 type = acpi_drv->flags & ACPI_DRIVER_ALL_NOTIFY_EVENTS ?
-				ACPI_ALL_NOTIFY : ACPI_DEVICE_NOTIFY;
-
-		acpi_remove_notify_handler(device->handle, type,
-					   acpi_notify_device);
-	}
-	acpi_os_wait_events_complete();
-}
-
 int acpi_device_install_event_handler(struct acpi_device *device,
 				      u32 type,
 				      void (*notify)(acpi_handle, u32, void*))
-- 
2.40.1

