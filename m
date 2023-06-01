Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 401A9719EA3
	for <lists+linux-acpi@lfdr.de>; Thu,  1 Jun 2023 15:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232942AbjFANpu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 1 Jun 2023 09:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233276AbjFANpn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Jun 2023 09:45:43 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692A6180;
        Thu,  1 Jun 2023 06:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685627142; x=1717163142;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QBH5fW45n6DZLxzTgXmIAEJSQORppkpy6BU/i1JxNM4=;
  b=e/bLKkGMpWYkzJICjK2MGqt3lfzTdqLiYyLuFx8NMsnRY06fD3lLNi+m
   0eZ8kEOX7rFb7qSR7iwaZkTo02QU+tOgyfHP9Zm122SsVMVnLwAkIkwc2
   dehWdW4VserVYFq8x3FUXFBmAa/Z6JF8lYrj8Erec7zhh0Li1BUTh+xtW
   uCGrHUnf8Fk8toYF8X/BrHZt5p0kyAMJvtTr0ojuCk7Mbj2h7QpfkuWbF
   9LbAdysDBDxf5L2Ch56Rv7nXo5S5rJp+xJmIWMkLlntDn37hwl/iTh+zF
   LDVIzEJTVAKSNd3lk/fi6nViW4X7PcTtHm7BMfcP7Fdyo0WZ0UHx+yNWg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="419068402"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="419068402"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 06:19:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="881601989"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="881601989"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 06:19:52 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     Kenneth Chan <kenneth.t.chan@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     Michal Wilczynski <michal.wilczynski@intel.com>,
        platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org,
        rafael@kernel.org
Subject: [PATCH v4 23/35] platform/x86/panasonic-laptop: Move handler installing logic to driver
Date:   Thu,  1 Jun 2023 15:17:26 +0200
Message-Id: <20230601131739.300760-24-michal.wilczynski@intel.com>
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
 drivers/platform/x86/panasonic-laptop.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/panasonic-laptop.c b/drivers/platform/x86/panasonic-laptop.c
index cf845ee1c7b1..723a898738d0 100644
--- a/drivers/platform/x86/panasonic-laptop.c
+++ b/drivers/platform/x86/panasonic-laptop.c
@@ -184,7 +184,7 @@ enum SINF_BITS { SINF_NUM_BATTERIES = 0,
 
 static int acpi_pcc_hotkey_add(struct acpi_device *device);
 static void acpi_pcc_hotkey_remove(struct acpi_device *device);
-static void acpi_pcc_hotkey_notify(struct acpi_device *device, u32 event);
+static void acpi_pcc_hotkey_notify(acpi_handle handle, u32 event, void *data);
 
 static const struct acpi_device_id pcc_device_ids[] = {
 	{ "MAT0012", 0},
@@ -207,7 +207,6 @@ static struct acpi_driver acpi_pcc_driver = {
 	.ops =		{
 				.add =		acpi_pcc_hotkey_add,
 				.remove =	acpi_pcc_hotkey_remove,
-				.notify =	acpi_pcc_hotkey_notify,
 			},
 	.drv.pm =	&acpi_pcc_hotkey_pm,
 };
@@ -833,9 +832,12 @@ static void acpi_pcc_generate_keyinput(struct pcc_acpi *pcc)
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
@@ -1049,6 +1051,12 @@ static int acpi_pcc_hotkey_add(struct acpi_device *device)
 	}
 
 	i8042_install_filter(panasonic_i8042_filter);
+
+	result = acpi_device_install_event_handler(device, ACPI_DEVICE_NOTIFY,
+						   acpi_pcc_hotkey_notify);
+	if (result)
+		goto out_platform;
+
 	return 0;
 
 out_platform:
@@ -1072,6 +1080,8 @@ static void acpi_pcc_hotkey_remove(struct acpi_device *device)
 	if (!device || !pcc)
 		return;
 
+	acpi_device_remove_event_handler(device, ACPI_DEVICE_NOTIFY, acpi_pcc_hotkey_notify);
+
 	i8042_remove_filter(panasonic_i8042_filter);
 
 	if (pcc->platform) {
-- 
2.40.1

