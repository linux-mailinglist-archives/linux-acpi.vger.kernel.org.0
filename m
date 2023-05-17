Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E89C7061E9
	for <lists+linux-acpi@lfdr.de>; Wed, 17 May 2023 09:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjEQH6j (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 17 May 2023 03:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbjEQH6X (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 17 May 2023 03:58:23 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F7B3AA1
        for <linux-acpi@vger.kernel.org>; Wed, 17 May 2023 00:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684310296; x=1715846296;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5K8b5g4trxVH4rdVCpBVEH2kyOc8An5MTSOLTpAvBzw=;
  b=fdBkGT7Kez5x11x7YyvESneuoyNBe0zHRJh2oWqi3xOPRqpy0wG8scbM
   sp0o63PwYfK1lGEa6kz5L6u4KPFGTnD7i79eiM7ZCxiV2TbXrvQ46rUYR
   9l+huscfUSzLqB358DggNS/OOcz64qcAkOxosUwj/LvCZUFqoyb/8/K8/
   QVO04/tYAIFde6jHv1i1n7ZOuBfxxaWmkTgf3SqQVcZWaIW2Qjdo5Meme
   /OURZ7p6cmDc2IQAOtIeQ0Qbz4Rm7CpwG9n5cZfJT7Wh7FJiFJGcm6UH/
   lQKWTcfXW4/1AasJ92ph/8fkgSb2pOmsEG1mAyGVe/nI7kU/39d9WNEeu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="415105357"
X-IronPort-AV: E=Sophos;i="5.99,281,1677571200"; 
   d="scan'208";a="415105357"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 00:57:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="825877250"
X-IronPort-AV: E=Sophos;i="5.99,281,1677571200"; 
   d="scan'208";a="825877250"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 00:57:58 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, srinivas.pandruvada@linux.intel.com,
        Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v3 01/34] acpi: Adjust functions installing bus event handlers
Date:   Wed, 17 May 2023 09:56:51 +0200
Message-Id: <20230517075724.153992-2-michal.wilczynski@intel.com>
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

Currently acpi_device_install_notify_handler() and
acpi_device_remove_notify_handler() always install acpi_notify_device()
as a function handler, and only then the real .notify callback gets
called. This is not efficient and doesn't provide any real advantage.

Introduce new acpi_device_install_event_handler() and
acpi_device_remove_event_handler(). Those functions are replacing old
installers, and after all drivers switch to the new model, old installers
will be removed at the end of the patchset.

Make new installer/removal function arguments to take function pointer as
an argument instead of using .notify callback. Introduce new variable in
struct acpi_device, as fixed events still needs to be handled by an
intermediary that would schedule them for later execution. This is due to
fixed hardware event handlers being executed in interrupt context.

Make acpi_device_install_event_handler() and
acpi_device_remove_event_handler() non-static, and export symbols. This
will allow the drivers to call them directly, instead of relying on
.notify callback.

Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
---
 drivers/acpi/bus.c      | 56 ++++++++++++++++++++++++++++++++++++++++-
 include/acpi/acpi_bus.h |  7 ++++++
 2 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index d161ff707de4..00309df56c24 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -535,7 +535,7 @@ static void acpi_notify_device_fixed(void *data)
 	struct acpi_device *device = data;
 
 	/* Fixed hardware devices have no handles */
-	acpi_notify_device(NULL, ACPI_FIXED_HARDWARE_EVENT, device);
+	device->fixed_event_notify(NULL, ACPI_FIXED_HARDWARE_EVENT, device);
 }
 
 static u32 acpi_device_fixed_event(void *data)
@@ -550,11 +550,13 @@ static int acpi_device_install_notify_handler(struct acpi_device *device,
 	acpi_status status;
 
 	if (device->device_type == ACPI_BUS_TYPE_POWER_BUTTON) {
+		device->fixed_event_notify = acpi_notify_device;
 		status =
 		    acpi_install_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
 						     acpi_device_fixed_event,
 						     device);
 	} else if (device->device_type == ACPI_BUS_TYPE_SLEEP_BUTTON) {
+		device->fixed_event_notify = acpi_notify_device;
 		status =
 		    acpi_install_fixed_event_handler(ACPI_EVENT_SLEEP_BUTTON,
 						     acpi_device_fixed_event,
@@ -579,9 +581,11 @@ static void acpi_device_remove_notify_handler(struct acpi_device *device,
 	if (device->device_type == ACPI_BUS_TYPE_POWER_BUTTON) {
 		acpi_remove_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
 						acpi_device_fixed_event);
+		device->fixed_event_notify = NULL;
 	} else if (device->device_type == ACPI_BUS_TYPE_SLEEP_BUTTON) {
 		acpi_remove_fixed_event_handler(ACPI_EVENT_SLEEP_BUTTON,
 						acpi_device_fixed_event);
+		device->fixed_event_notify = NULL;
 	} else {
 		u32 type = acpi_drv->flags & ACPI_DRIVER_ALL_NOTIFY_EVENTS ?
 				ACPI_ALL_NOTIFY : ACPI_DEVICE_NOTIFY;
@@ -592,6 +596,56 @@ static void acpi_device_remove_notify_handler(struct acpi_device *device,
 	acpi_os_wait_events_complete();
 }
 
+int acpi_device_install_event_handler(struct acpi_device *device,
+				      u32 type,
+				      void (*notify)(acpi_handle, u32, void*))
+{
+	acpi_status status;
+
+	if (device->device_type == ACPI_BUS_TYPE_POWER_BUTTON) {
+		device->fixed_event_notify = notify;
+		status =
+		    acpi_install_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
+						     acpi_device_fixed_event,
+						     device);
+	} else if (device->device_type == ACPI_BUS_TYPE_SLEEP_BUTTON) {
+		device->fixed_event_notify = notify;
+		status =
+		    acpi_install_fixed_event_handler(ACPI_EVENT_SLEEP_BUTTON,
+						     acpi_device_fixed_event,
+						     device);
+	} else {
+		status = acpi_install_notify_handler(device->handle, type,
+						     notify,
+						     device);
+	}
+
+	if (ACPI_FAILURE(status))
+		return -EINVAL;
+	return 0;
+}
+EXPORT_SYMBOL(acpi_device_install_event_handler);
+
+void acpi_device_remove_event_handler(struct acpi_device *device,
+				      u32 type,
+				      void (*notify)(acpi_handle, u32, void*))
+{
+	if (device->device_type == ACPI_BUS_TYPE_POWER_BUTTON) {
+		acpi_remove_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
+						acpi_device_fixed_event);
+		device->fixed_event_notify = NULL;
+	} else if (device->device_type == ACPI_BUS_TYPE_SLEEP_BUTTON) {
+		acpi_remove_fixed_event_handler(ACPI_EVENT_SLEEP_BUTTON,
+						acpi_device_fixed_event);
+		device->fixed_event_notify = NULL;
+	} else {
+		acpi_remove_notify_handler(device->handle, type,
+					   notify);
+	}
+	acpi_os_wait_events_complete();
+}
+EXPORT_SYMBOL(acpi_device_remove_event_handler);
+
 /* Handle events targeting \_SB device (at present only graceful shutdown) */
 
 #define ACPI_SB_NOTIFY_SHUTDOWN_REQUEST 0x81
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index a6affc0550b0..7fb411438b6f 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -387,6 +387,7 @@ struct acpi_device {
 	struct list_head physical_node_list;
 	struct mutex physical_node_lock;
 	void (*remove)(struct acpi_device *);
+	void (*fixed_event_notify)(acpi_handle handle, u32 type, void *data);
 };
 
 /* Non-device subnode */
@@ -513,6 +514,12 @@ void acpi_bus_private_data_handler(acpi_handle, void *);
 int acpi_bus_get_private_data(acpi_handle, void **);
 int acpi_bus_attach_private_data(acpi_handle, void *);
 void acpi_bus_detach_private_data(acpi_handle);
+int acpi_device_install_event_handler(struct acpi_device *device,
+				      u32 type,
+				      void (*notify)(acpi_handle, u32, void*));
+void acpi_device_remove_event_handler(struct acpi_device *device,
+				      u32 type,
+				      void (*notify)(acpi_handle, u32, void*));
 extern int acpi_notifier_call_chain(struct acpi_device *, u32, u32);
 extern int register_acpi_notifier(struct notifier_block *);
 extern int unregister_acpi_notifier(struct notifier_block *);
-- 
2.40.1

