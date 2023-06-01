Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1139A719E9F
	for <lists+linux-acpi@lfdr.de>; Thu,  1 Jun 2023 15:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbjFANpZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 1 Jun 2023 09:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233419AbjFANpU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Jun 2023 09:45:20 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A482138;
        Thu,  1 Jun 2023 06:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685627117; x=1717163117;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ENJP73HXPeBgJ2fQ82QE/f5IGuVXsru7nSaUGYazssM=;
  b=CG5K4sOrIYbzdPuy8kapCEK2tJSiuFsaOG/ov7EtRiWcR5ZJ19pd6Y/H
   H+W9PFHiS39UStaOjdWrBiEWX8ljSbsoOHjNScplCpBaoBFkRzo7W44aW
   NqlyV/X9ZFlo3xwcygMKz0qpDupAdtAbsO2kqOt0DxrF6Kju+rTw9AcNL
   xi1n8z55qXymdbuIlxdsA2TG4zuNf3nkNNtT8Qzm0CRVf7sDyYwvDLSM1
   CEkyYMIdBya6RFkBFQ200ZOh4MODuZVimDG37+YRSANs3F0n6g8TRUThY
   ukg37yDDXWr0CX2ZdcdmgvTIKRzO8Pvts13QaueTNdv3aoOPGYHMmBbXK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="419068165"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="419068165"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 06:19:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="881601912"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="881601912"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 06:19:40 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     Corentin Chary <corentin.chary@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     Michal Wilczynski <michal.wilczynski@intel.com>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org,
        rafael@kernel.org
Subject: [PATCH v4 20/35] platform/x86/eeepc-laptop: Move handler installing logic to driver
Date:   Thu,  1 Jun 2023 15:17:23 +0200
Message-Id: <20230601131739.300760-21-michal.wilczynski@intel.com>
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
 drivers/platform/x86/eeepc-laptop.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index 62b71e8e3567..bd6ada963d88 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -1204,12 +1204,15 @@ static void eeepc_input_notify(struct eeepc_laptop *eeepc, int event)
 		pr_info("Unknown key %x pressed\n", event);
 }
 
-static void eeepc_acpi_notify(struct acpi_device *device, u32 event)
+static void eeepc_acpi_notify(acpi_handle handle, u32 event, void *data)
 {
-	struct eeepc_laptop *eeepc = acpi_driver_data(device);
 	int old_brightness, new_brightness;
+	struct acpi_device *device = data;
+	struct eeepc_laptop *eeepc;
 	u16 count;
 
+	eeepc = acpi_driver_data(device);
+
 	if (event > ACPI_MAX_SYS_NOTIFY)
 		return;
 	count = eeepc->event_count[event % 128]++;
@@ -1423,6 +1426,11 @@ static int eeepc_acpi_add(struct acpi_device *device)
 		goto fail_rfkill;
 
 	eeepc_device_present = true;
+	result = acpi_device_install_event_handler(device, ACPI_ALL_NOTIFY,
+						   eeepc_acpi_notify);
+	if (result)
+		goto fail_rfkill;
+
 	return 0;
 
 fail_rfkill:
@@ -1444,6 +1452,8 @@ static void eeepc_acpi_remove(struct acpi_device *device)
 {
 	struct eeepc_laptop *eeepc = acpi_driver_data(device);
 
+	acpi_device_remove_event_handler(device, ACPI_ALL_NOTIFY,
+					 eeepc_acpi_notify);
 	eeepc_backlight_exit(eeepc);
 	eeepc_rfkill_exit(eeepc);
 	eeepc_input_exit(eeepc);
@@ -1465,11 +1475,9 @@ static struct acpi_driver eeepc_acpi_driver = {
 	.class = EEEPC_ACPI_CLASS,
 	.owner = THIS_MODULE,
 	.ids = eeepc_device_ids,
-	.flags = ACPI_DRIVER_ALL_NOTIFY_EVENTS,
 	.ops = {
 		.add = eeepc_acpi_add,
 		.remove = eeepc_acpi_remove,
-		.notify = eeepc_acpi_notify,
 	},
 };
 
-- 
2.40.1

