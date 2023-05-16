Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1C0704CEF
	for <lists+linux-acpi@lfdr.de>; Tue, 16 May 2023 13:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233088AbjEPLtr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 16 May 2023 07:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233117AbjEPLtj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 16 May 2023 07:49:39 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E864F7294
        for <linux-acpi@vger.kernel.org>; Tue, 16 May 2023 04:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684237750; x=1715773750;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4Wa3TUwrjVaSBSe8B2UwW35CPazvfGooGOhRB7ku0sM=;
  b=E88ROqrK8rcqvUpad6BPWynzcYTp20naBA29mPnPAB+I2REgMUw5IiFU
   OnoC7dqrPu3yKb/8pjh5ED+5obQbDk6sZYB3xRMrWH5djXQLLwUkOK6A+
   llkHnynRTuPMalahWawqtmrxT+nhpmJxuDidw6sF402eG8JEcSFTJQv3+
   HmVht4YLkPpjWdQJMZJeri3SNXrp849aBAfgvSOww9sB5vDVcXIRXzcBs
   saRPA2srNcurWiu3HST7S7Ah5QaLq1usiBvdFjGd3UxH9Mv4u2GQZKBL6
   gGpjMGTJLidiZ0UtH+lZcoO4UVrZTad65/kZ5En4BCYVgK5aCy34m6ltv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="417111702"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="417111702"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 04:47:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="731961928"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="731961928"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 04:47:03 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v2 23/34] platform/x86/panasonic-laptop: Move handler installing logic to driver
Date:   Tue, 16 May 2023 13:46:06 +0200
Message-Id: <20230516114617.148963-24-michal.wilczynski@intel.com>
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
 drivers/platform/x86/panasonic-laptop.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/panasonic-laptop.c b/drivers/platform/x86/panasonic-laptop.c
index cf845ee1c7b1..37be1047b50d 100644
--- a/drivers/platform/x86/panasonic-laptop.c
+++ b/drivers/platform/x86/panasonic-laptop.c
@@ -833,9 +833,12 @@ static void acpi_pcc_generate_keyinput(struct pcc_acpi *pcc)
 		pr_err("Unknown hotkey event: 0x%04llx\n", result);
 }
 
-static void acpi_pcc_hotkey_notify(struct acpi_device *device, u32 event)
+static void acpi_pcc_hotkey_notify(acpi_handle handle, u32 event, void *data)
 {
-	struct pcc_acpi *pcc = acpi_driver_data(device);
+	struct acpi_device *device = data;
+	struct pcc_acpi *pcc;
+
+	pcc = acpi_driver_data(device);
 
 	switch (event) {
 	case HKEY_NOTIFY:
@@ -1049,7 +1052,13 @@ static int acpi_pcc_hotkey_add(struct acpi_device *device)
 	}
 
 	i8042_install_filter(panasonic_i8042_filter);
-	return 0;
+
+	result =  acpi_device_install_event_handler(device, ACPI_DEVICE_NOTIFY,
+						    acpi_pcc_hotkey_notify);
+	if (result)
+		goto out_platform;
+
+	return result;
 
 out_platform:
 	platform_device_unregister(pcc->platform);
@@ -1072,6 +1081,8 @@ static void acpi_pcc_hotkey_remove(struct acpi_device *device)
 	if (!device || !pcc)
 		return;
 
+	acpi_device_remove_event_handler(device, ACPI_DEVICE_NOTIFY, acpi_pcc_hotkey_notify);
+
 	i8042_remove_filter(panasonic_i8042_filter);
 
 	if (pcc->platform) {
-- 
2.40.1

