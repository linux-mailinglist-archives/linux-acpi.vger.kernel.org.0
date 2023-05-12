Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5717009C8
	for <lists+linux-acpi@lfdr.de>; Fri, 12 May 2023 16:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241420AbjELODH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 12 May 2023 10:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241387AbjELODB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 12 May 2023 10:03:01 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A563D19BE
        for <linux-acpi@vger.kernel.org>; Fri, 12 May 2023 07:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683900179; x=1715436179;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9ornG7hWOY6i8oXxZC9eMfmzDrjvXb8WBsDPkaTucWY=;
  b=ICqOlo8UmgjlHjihcX8udwCDRTANg/WtPHjQ7BlBwmndTDzvbiDwOWFc
   qqKusTA/qvsRJGmV9tf1Y+IK8QAAc/hoIBVmd63rysvYvfusMNvpzzIje
   zFH6w0exGk/soukYO7K4bNOeLMSweW8T4REv+EM250CG8La2dRlh6YwdC
   kyv657NJoLKmvUzYmbS7rIvvyad+8gErfsYt73/x+RF1xpcPJvzbE+mf3
   YeJ1XH9PlvKdIFCtN4gXxihR+AdHWrwHDSkroB/XWjkWW/Lo+gMT7pQnA
   5Wp3xcglWQ7B7CPW+ALN0Kl/9JhPogaV5iI4CgZIVP1ZoLUXT1xhwbt33
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="378931024"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="378931024"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 07:02:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="650648915"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="650648915"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 07:02:53 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v1 05/34] acpi/button: Move handler installing logic to driver
Date:   Fri, 12 May 2023 16:01:53 +0200
Message-Id: <20230512140222.124868-6-michal.wilczynski@intel.com>
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
 drivers/acpi/button.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 475e1eddfa3b..e978b2eafb27 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -126,7 +126,7 @@ static const struct dmi_system_id dmi_lid_quirks[] = {
 
 static int acpi_button_add(struct acpi_device *device);
 static void acpi_button_remove(struct acpi_device *device);
-static void acpi_button_notify(struct acpi_device *device, u32 event);
+static void acpi_button_notify(acpi_handle handle, u32 event, void *data);
 
 #ifdef CONFIG_PM_SLEEP
 static int acpi_button_suspend(struct device *dev);
@@ -144,7 +144,6 @@ static struct acpi_driver acpi_button_driver = {
 	.ops = {
 		.add = acpi_button_add,
 		.remove = acpi_button_remove,
-		.notify = acpi_button_notify,
 	},
 	.drv.pm = &acpi_button_pm,
 };
@@ -400,11 +399,14 @@ static void acpi_lid_initialize_state(struct acpi_device *device)
 	button->lid_state_initialized = true;
 }
 
-static void acpi_button_notify(struct acpi_device *device, u32 event)
+static void acpi_button_notify(acpi_handle handle, u32 event, void *data)
 {
-	struct acpi_button *button = acpi_driver_data(device);
+	struct acpi_device *device = data;
+	struct acpi_button *button;
 	struct input_dev *input;
 
+	button = acpi_driver_data(device);
+
 	switch (event) {
 	case ACPI_FIXED_HARDWARE_EVENT:
 		event = ACPI_BUTTON_NOTIFY_STATUS;
@@ -569,7 +571,12 @@ static int acpi_button_add(struct acpi_device *device)
 
 	device_init_wakeup(&device->dev, true);
 	pr_info("%s [%s]\n", name, acpi_device_bid(device));
-	return 0;
+
+	error =  acpi_device_install_event_handler(device, ACPI_DEVICE_NOTIFY, acpi_button_notify);
+	if (error)
+		goto err_remove_fs;
+
+	return error;
 
  err_remove_fs:
 	acpi_button_remove_fs(device);
@@ -584,6 +591,7 @@ static void acpi_button_remove(struct acpi_device *device)
 {
 	struct acpi_button *button = acpi_driver_data(device);
 
+	acpi_device_remove_event_handler(device, ACPI_DEVICE_NOTIFY, acpi_button_notify);
 	acpi_button_remove_fs(device);
 	input_unregister_device(button->input);
 	kfree(button);
-- 
2.38.1

