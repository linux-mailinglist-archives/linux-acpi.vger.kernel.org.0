Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82934719E6A
	for <lists+linux-acpi@lfdr.de>; Thu,  1 Jun 2023 15:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233394AbjFANmI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 1 Jun 2023 09:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232699AbjFANmH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Jun 2023 09:42:07 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5968C138;
        Thu,  1 Jun 2023 06:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685626926; x=1717162926;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HeoLSGt6pPNEEutOyliAyAZ1IupbH/0zizPbH0EBwxQ=;
  b=C8Pyg5pqgAOeaLCy+fDZrF+4vMWA0PX/YADCj1cilO8mikRKHjrKUIpw
   tuxkY6llR3XsZo6lqbFyCzI0CCQUPkJ+4gEIzaM/m4L5P7SioJtQ+M/4L
   6z0tC2osomuP6ef7K+Sq9SOD5nsfuZgKuwkTUlYedLKxEFoF/etZbD3Yp
   55c7Us9z5JGOj7qiBU2pq2a06sWoxejN4kZ5k65LkanKoVxUYSTcgx8cU
   uUfVTSWO9NvjJJL7uukSGJTV70psEVkl1MFoSjqZTBofhuSps1XUJtuOC
   h/iWAqsqjDMsxjcMPcJ4drsk2Nb8FKDS8ys5IazFvPuZ/zHomeR0vqz9I
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="419066592"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="419066592"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 06:18:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="881601431"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="881601431"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 06:18:23 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Cc:     Michal Wilczynski <michal.wilczynski@intel.com>,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH v4 05/35] acpi/button: Move handler installing logic to driver
Date:   Thu,  1 Jun 2023 15:17:08 +0200
Message-Id: <20230601131739.300760-6-michal.wilczynski@intel.com>
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
 drivers/acpi/button.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index ef77c14c72a9..96ed1877a61a 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -135,7 +135,7 @@ static const struct dmi_system_id dmi_lid_quirks[] = {
 
 static int acpi_button_add(struct acpi_device *device);
 static void acpi_button_remove(struct acpi_device *device);
-static void acpi_button_notify(struct acpi_device *device, u32 event);
+static void acpi_button_notify(acpi_handle handle, u32 event, void *data);
 
 #ifdef CONFIG_PM_SLEEP
 static int acpi_button_suspend(struct device *dev);
@@ -153,7 +153,6 @@ static struct acpi_driver acpi_button_driver = {
 	.ops = {
 		.add = acpi_button_add,
 		.remove = acpi_button_remove,
-		.notify = acpi_button_notify,
 	},
 	.drv.pm = &acpi_button_pm,
 };
@@ -409,11 +408,14 @@ static void acpi_lid_initialize_state(struct acpi_device *device)
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
@@ -578,6 +580,11 @@ static int acpi_button_add(struct acpi_device *device)
 
 	device_init_wakeup(&device->dev, true);
 	pr_info("%s [%s]\n", name, acpi_device_bid(device));
+
+	error =  acpi_device_install_event_handler(device, ACPI_DEVICE_NOTIFY, acpi_button_notify);
+	if (error)
+		goto err_remove_fs;
+
 	return 0;
 
  err_remove_fs:
@@ -593,6 +600,7 @@ static void acpi_button_remove(struct acpi_device *device)
 {
 	struct acpi_button *button = acpi_driver_data(device);
 
+	acpi_device_remove_event_handler(device, ACPI_DEVICE_NOTIFY, acpi_button_notify);
 	acpi_button_remove_fs(device);
 	input_unregister_device(button->input);
 	kfree(button);
-- 
2.40.1

