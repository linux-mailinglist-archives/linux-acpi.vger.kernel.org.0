Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0F77009E5
	for <lists+linux-acpi@lfdr.de>; Fri, 12 May 2023 16:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241379AbjELOEQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 12 May 2023 10:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241429AbjELODj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 12 May 2023 10:03:39 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F81C526F
        for <linux-acpi@vger.kernel.org>; Fri, 12 May 2023 07:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683900217; x=1715436217;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kEzEz2OTalUP65K0ey9fMviY/+IrUGpeYbTO2YVCrqw=;
  b=O8FxlKsZFD8U1Zd5hO6sJCqp08NoFALHkANtH80pMg2IzLYyNFNdOUYF
   MIB/GpQpqVqnLQtDgoNNGUhinz2MNB5H+Gus2z+aHXxPBOAGwiNJNARXI
   Kn9BW2fLlLzrSj4UVCNW7m/LvVREZVNAmR52PS23nJX7kIs55Li4ysSSt
   lV1j8yNde6w/N1UoMXt9ETJETUNBCt2sBhnLERMd2J0MbYHWFhqm2wqUP
   7hM4BTSIs6wvT7rF9VKXLAexGYZXkU+TZLtcVoKqws5UAtKTvPGMHFg8n
   7mMkHcCLx6IvRizezIIz1uR01flu3eaKadGgoGviB9FufSu1ny/UtnCsF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="378931227"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="378931227"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 07:03:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="650649025"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="650649025"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 07:03:35 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v1 33/34] acpi/bus: Remove redundant functions
Date:   Fri, 12 May 2023 16:02:21 +0200
Message-Id: <20230512140222.124868-34-michal.wilczynski@intel.com>
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
2.38.1

