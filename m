Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 854B2719EB6
	for <lists+linux-acpi@lfdr.de>; Thu,  1 Jun 2023 15:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233356AbjFANqj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 1 Jun 2023 09:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233293AbjFANqh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Jun 2023 09:46:37 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5441107;
        Thu,  1 Jun 2023 06:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685627196; x=1717163196;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JYFmYUw76nAn3KyHhuquIXLpkkEfqoEDyhR2NxJSr40=;
  b=DO6Ess4hhYM7O7qjUZdAyeinG8FW+YpVw/ZKOKehMxy6dpBPlo/8Velx
   jXv7T1qTqD6bJMdnGuzyKuwyHz+hkUDNrxCfG6zFPNt8RJHXN/Wps+9xO
   6OUXFqEj2cGfVjtGVxvfX3JCI7o9XpIUkNr7BlKEzcjNKqhydGtKBRifh
   N+AQceO1IMzZNS1Gxj99Ea8Z7A8+dxey7bbV0IfsDaCh9WDueMIq+u92e
   fEabD/BloMvk6CkcCveMq38qqaoMkDg+4isFsLbxBwp1osT2ZqVKEoWpo
   MJTO0rFjM2u724nG3wAOWZjdCa8u+4C34XPCrv8mHQI5Zmt/HjdgyJIR/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="419068932"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="419068932"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 06:20:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="881602180"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="881602180"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 06:20:17 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     Mattia Dongili <malattia@linux.it>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     Michal Wilczynski <michal.wilczynski@intel.com>,
        platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org,
        rafael@kernel.org
Subject: [PATCH v4 31/35] platform/x86/sony-laptop: Move handler installing logic to driver
Date:   Thu,  1 Jun 2023 15:17:34 +0200
Message-Id: <20230601131739.300760-32-michal.wilczynski@intel.com>
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
 drivers/platform/x86/sony-laptop.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index 9569f11dec8c..93e630d937a8 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -1178,7 +1178,7 @@ enum event_types {
 	KILLSWITCH,
 	GFX_SWITCH
 };
-static void sony_nc_notify(struct acpi_device *device, u32 event)
+static void sony_nc_notify(acpi_handle handle, u32 event, void *data)
 {
 	u32 real_ev = event;
 	u8 ev_type = 0;
@@ -3246,6 +3246,11 @@ static int sony_nc_add(struct acpi_device *device)
 		}
 	}
 
+	result = acpi_device_install_event_handler(device, ACPI_DEVICE_NOTIFY,
+						   sony_nc_notify);
+	if (result)
+		goto out_sysfs;
+
 	pr_info("SNC setup done.\n");
 	return 0;
 
@@ -3272,6 +3277,7 @@ static void sony_nc_remove(struct acpi_device *device)
 {
 	struct sony_nc_value *item;
 
+	acpi_device_remove_event_handler(device, ACPI_DEVICE_NOTIFY, sony_nc_notify);
 	sony_nc_backlight_cleanup();
 
 	sony_nc_acpi_device = NULL;
@@ -3307,7 +3313,6 @@ static struct acpi_driver sony_nc_driver = {
 	.ops = {
 		.add = sony_nc_add,
 		.remove = sony_nc_remove,
-		.notify = sony_nc_notify,
 		},
 	.drv.pm = &sony_nc_pm,
 };
-- 
2.40.1

