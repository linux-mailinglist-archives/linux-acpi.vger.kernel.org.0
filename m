Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F093704CF7
	for <lists+linux-acpi@lfdr.de>; Tue, 16 May 2023 13:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233152AbjEPLu1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 16 May 2023 07:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233195AbjEPLt6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 16 May 2023 07:49:58 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8662B7284
        for <linux-acpi@vger.kernel.org>; Tue, 16 May 2023 04:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684237780; x=1715773780;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=y0VBERQ5PR3nyeSq+O7hX0oeQ5wwm1bOcmrLZAB/n3I=;
  b=lTvKpGx0WsJIFj5Ynb3e/+9VTIPUFVHLmDW6NPEKAG30yFNSTfUcJyD1
   feRRUxrCtpSqEC9deDQWzk87Nht8kQQ4Mce2WHWWi4wMwXBt+dxLkKKuy
   kzL7nfxfohKoHMTgLDgWQaOv333n+9CBmgMkKEpBppUqwhBDC4XEBuETS
   pgqEtOKw6EFbmj4v4WrrLqHY7486HLupE1kX47V8vTuTKvszfqyKOWXqt
   KNP2y6Mk08saDWqRJhLGLEAHA0BGtCjSpZJjTQIv3YGo0tBJUwsRthaAw
   DNVE9UDUspvytiPXHUKlGJg9w68doNWw2w8KxUNlnq+kYEMNsc8LAKPdG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="417111740"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="417111740"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 04:47:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="731961999"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="731961999"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 04:47:12 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v2 30/34] platform/x86/xo15-ebook: Move handler installing logic to driver
Date:   Tue, 16 May 2023 13:46:13 +0200
Message-Id: <20230516114617.148963-31-michal.wilczynski@intel.com>
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
 drivers/platform/x86/xo15-ebook.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/xo15-ebook.c b/drivers/platform/x86/xo15-ebook.c
index 391f7ea4431e..8b5b05429889 100644
--- a/drivers/platform/x86/xo15-ebook.c
+++ b/drivers/platform/x86/xo15-ebook.c
@@ -56,8 +56,9 @@ static int ebook_send_state(struct acpi_device *device)
 	return 0;
 }
 
-static void ebook_switch_notify(struct acpi_device *device, u32 event)
+static void ebook_switch_notify(acpi_handle handle, u32 event, void *data)
 {
+	struct acpi_device *device = data;
 	switch (event) {
 	case ACPI_FIXED_HARDWARE_EVENT:
 	case XO15_EBOOK_NOTIFY_STATUS:
@@ -134,7 +135,11 @@ static int ebook_switch_add(struct acpi_device *device)
 		device_set_wakeup_enable(&device->dev, true);
 	}
 
-	return 0;
+	error = acpi_device_install_event_handler(device, ACPI_DEVICE_NOTIFY, ebook_switch_notify);
+	if (error)
+		goto err_free_input;
+
+	return error;
 
  err_free_input:
 	input_free_device(input);
@@ -147,6 +152,7 @@ static void ebook_switch_remove(struct acpi_device *device)
 {
 	struct ebook_switch *button = acpi_driver_data(device);
 
+	acpi_device_remove_event_handler(device, ACPI_DEVICE_NOTIFY, ebook_switch_notify);
 	input_unregister_device(button->input);
 	kfree(button);
 }
@@ -158,7 +164,6 @@ static struct acpi_driver xo15_ebook_driver = {
 	.ops = {
 		.add = ebook_switch_add,
 		.remove = ebook_switch_remove,
-		.notify = ebook_switch_notify,
 	},
 	.drv.pm = &ebook_switch_pm,
 };
-- 
2.40.1

