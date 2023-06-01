Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01549719EA8
	for <lists+linux-acpi@lfdr.de>; Thu,  1 Jun 2023 15:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbjFANp6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 1 Jun 2023 09:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbjFANp5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Jun 2023 09:45:57 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF46C180;
        Thu,  1 Jun 2023 06:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685627155; x=1717163155;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4yduEeyJ1346QTcv/zmmPzhTWreP5vGV8AJ/QG13/tg=;
  b=H+QCz2PcEjDxzDiFMUrW9E3GmRksUYVmh+cZ1DRi6S8Lk0j0sfGgazUd
   qV9ETC3+8Q8CHzXDSv6xwvkSYLnP4uX3BrIAIzmBy3ql8fS/haiU/KmOh
   dC+t5F3tg8bgBOVudrctJqx5FD+NiGx+jHlZ4IX5g8ayRoStLg6buo4g3
   taxiEzTiIBNP3AoBVWtvo44jGic75gfTVFfQFbNG5Ix9eoqGcwyEZ4Mvs
   fx41nCw6XV3/7J6SzSepJqtXbcIDPcOJYaWh8SB4pq3Rf7Z4iqAxwCiAv
   sDbWbMk6Ezmz1d9S5SKBeeN4sp31ZDAkSRpwoAgc38U04aEuXafRuaDud
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="419068536"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="419068536"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 06:20:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="881602042"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="881602042"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 06:19:59 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     Herton Ronaldo Krzesinski <herton@canonical.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     Michal Wilczynski <michal.wilczynski@intel.com>,
        platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org,
        rafael@kernel.org
Subject: [PATCH v4 25/35] platform/x86/topstar-laptop: Move handler installing logic to driver
Date:   Thu,  1 Jun 2023 15:17:28 +0200
Message-Id: <20230601131739.300760-26-michal.wilczynski@intel.com>
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
 drivers/platform/x86/topstar-laptop.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/topstar-laptop.c b/drivers/platform/x86/topstar-laptop.c
index 20df1ebefc30..cfe2a92ef1f5 100644
--- a/drivers/platform/x86/topstar-laptop.c
+++ b/drivers/platform/x86/topstar-laptop.c
@@ -232,12 +232,15 @@ static int topstar_acpi_fncx_switch(struct acpi_device *device, bool state)
 	return 0;
 }
 
-static void topstar_acpi_notify(struct acpi_device *device, u32 event)
+static void topstar_acpi_notify(acpi_handle handle, u32 event, void *data)
 {
-	struct topstar_laptop *topstar = acpi_driver_data(device);
+	struct acpi_device *device = data;
+	struct topstar_laptop *topstar;
 	static bool dup_evnt[2];
 	bool *dup;
 
+	topstar = acpi_driver_data(device);
+
 	/* 0x83 and 0x84 key events comes duplicated... */
 	if (event == 0x83 || event == 0x84) {
 		dup = &dup_evnt[event - 0x83];
@@ -319,6 +322,10 @@ static int topstar_acpi_add(struct acpi_device *device)
 			goto err_input_exit;
 	}
 
+	err = acpi_device_install_event_handler(device, ACPI_DEVICE_NOTIFY, topstar_acpi_notify);
+	if (err)
+		goto err_input_exit;
+
 	return 0;
 
 err_input_exit:
@@ -336,6 +343,8 @@ static void topstar_acpi_remove(struct acpi_device *device)
 {
 	struct topstar_laptop *topstar = acpi_driver_data(device);
 
+	acpi_device_remove_event_handler(device, ACPI_DEVICE_NOTIFY, topstar_acpi_notify);
+
 	if (led_workaround)
 		topstar_led_exit(topstar);
 
@@ -360,7 +369,6 @@ static struct acpi_driver topstar_acpi_driver = {
 	.ops = {
 		.add = topstar_acpi_add,
 		.remove = topstar_acpi_remove,
-		.notify = topstar_acpi_notify,
 	},
 };
 
-- 
2.40.1

