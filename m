Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 499187009E0
	for <lists+linux-acpi@lfdr.de>; Fri, 12 May 2023 16:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241450AbjELODt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 12 May 2023 10:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241453AbjELODj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 12 May 2023 10:03:39 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86D213854
        for <linux-acpi@vger.kernel.org>; Fri, 12 May 2023 07:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683900212; x=1715436212;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+DuzAcBIoQKvNVVST5kArg3jtPsfRDK7DxEi4uAzm3s=;
  b=DdZpC8Fso7R0EjlMeNCVHaZ0VtiURDIIr5GNS0hfMaHxrAQpb/8vYy7h
   P4iZrD4kJIl4fM09vNqDeHDiGJSThhkDOnw1vXEeF9flf4v4w+NrSmV3g
   JnP3dkFZ+WMNIC453vkxQJ0ZJp7Dq8NHpFbMeKZLsJibwGVgakEawwyOD
   EodVCIVPN5Qcg31WHMuCURrjmc8VuRAR0ZBy+HIZ66bErT6xV7ItBqy/D
   VSAKz2jKpsFBK1YckRhqiGJvuEx5mUJRGjzxyZJf07g92hYMElObf/6Ea
   RkUejDOVVJzgyWR0KbkwBbt3eMRNOdlbMeuK/y5iWxr68NaKFkRR/G5Qd
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="378931196"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="378931196"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 07:03:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="650649013"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="650649013"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 07:03:30 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v1 29/34] platform/x86/wireless-hotkey: Move handler installing logic to driver
Date:   Fri, 12 May 2023 16:02:17 +0200
Message-Id: <20230512140222.124868-30-michal.wilczynski@intel.com>
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
 drivers/platform/x86/wireless-hotkey.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/wireless-hotkey.c b/drivers/platform/x86/wireless-hotkey.c
index 4422863f47bb..51169509fea1 100644
--- a/drivers/platform/x86/wireless-hotkey.c
+++ b/drivers/platform/x86/wireless-hotkey.c
@@ -68,9 +68,12 @@ static void wireless_input_destroy(struct acpi_device *device)
 	kfree(button);
 }
 
-static void wl_notify(struct acpi_device *acpi_dev, u32 event)
+static void wl_notify(acpi_handle handle, u32 event, void *data)
 {
-	struct wl_button *button = acpi_driver_data(acpi_dev);
+	struct acpi_device *acpi_dev = data;
+	struct wl_button *button;
+
+	button = acpi_driver_data(acpi_dev);
 
 	if (event != 0x80) {
 		pr_info("Received unknown event (0x%x)\n", event);
@@ -95,16 +98,24 @@ static int wl_add(struct acpi_device *device)
 	device->driver_data = button;
 
 	err = wireless_input_setup(device);
-	if (err) {
-		pr_err("Failed to setup wireless hotkeys\n");
-		kfree(button);
-	}
+	if (err)
+		goto fail;
 
+	err = acpi_device_install_event_handler(device, ACPI_DEVICE_NOTIFY, wl_notify);
+	if (err)
+		goto fail;
+
+	return err;
+
+fail:
+	pr_err("Failed to setup wireless hotkeys\n");
+	kfree(button);
 	return err;
 }
 
 static void wl_remove(struct acpi_device *device)
 {
+	acpi_device_remove_event_handler(device, ACPI_DEVICE_NOTIFY, wl_notify);
 	wireless_input_destroy(device);
 }
 
-- 
2.38.1

