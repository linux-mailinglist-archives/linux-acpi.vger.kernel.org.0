Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7EC8719E92
	for <lists+linux-acpi@lfdr.de>; Thu,  1 Jun 2023 15:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233240AbjFANpS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 1 Jun 2023 09:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234037AbjFANpQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Jun 2023 09:45:16 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423761A2;
        Thu,  1 Jun 2023 06:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685627110; x=1717163110;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NQLWnXWZae271CRjFuvZfxarWxX1dDRBywhMvrqXcx0=;
  b=Oojb5xdGjGhUKGW0c9jaS+z8+BExXEKRYGdhHdkovlCXpVbUl8yy1AQf
   CeHg0CUJX3YtJtoc95NvugZjlKFvWlaLefr39DC3PbZiqSXPFo8FmgDMj
   F6DN1z7YumaUb1hsaQsQ04YreOub/Jd4RY+oOQ42oIAGjW03koyX8D5pG
   Ys/4QVG7sz+7cPmGzM/Dbsz137pB0CEm0osZJEbFbbejLJoZkiG7p1egL
   wh7UouT31EX5n8WNz8QtYISzcLHG7T7NA0oKG38OkVyaT0Ygxmf6btA+T
   dPyZlhF+iOUEH5ZLYRPXpHfODSvNvXl7Rr/mOZN7GGWlVKzisVbxBwIVw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="419068093"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="419068093"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 06:19:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="881601895"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="881601895"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 06:19:37 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     Michal Wilczynski <michal.wilczynski@intel.com>,
        platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org,
        rafael@kernel.org
Subject: [PATCH v4 19/35] platform/x86/dell/dell-rbtn: Move handler installing logic to driver
Date:   Thu,  1 Jun 2023 15:17:22 +0200
Message-Id: <20230601131739.300760-20-michal.wilczynski@intel.com>
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
 drivers/platform/x86/dell/dell-rbtn.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/dell/dell-rbtn.c b/drivers/platform/x86/dell/dell-rbtn.c
index aa0e6c907494..4dcad59eb035 100644
--- a/drivers/platform/x86/dell/dell-rbtn.c
+++ b/drivers/platform/x86/dell/dell-rbtn.c
@@ -207,7 +207,7 @@ static void rbtn_input_event(struct rbtn_data *rbtn_data)
 
 static int rbtn_add(struct acpi_device *device);
 static void rbtn_remove(struct acpi_device *device);
-static void rbtn_notify(struct acpi_device *device, u32 event);
+static void rbtn_notify(acpi_handle handle, u32 event, void *data);
 
 static const struct acpi_device_id rbtn_ids[] = {
 	{ "DELRBTN", 0 },
@@ -293,7 +293,6 @@ static struct acpi_driver rbtn_driver = {
 	.ops = {
 		.add = rbtn_add,
 		.remove = rbtn_remove,
-		.notify = rbtn_notify,
 	},
 	.owner = THIS_MODULE,
 };
@@ -422,7 +421,10 @@ static int rbtn_add(struct acpi_device *device)
 		ret = -EINVAL;
 	}
 
-	return ret;
+	if (ret)
+		return ret;
+
+	return acpi_device_install_event_handler(device, ACPI_DEVICE_NOTIFY, rbtn_notify);
 
 }
 
@@ -430,6 +432,8 @@ static void rbtn_remove(struct acpi_device *device)
 {
 	struct rbtn_data *rbtn_data = device->driver_data;
 
+	acpi_device_remove_event_handler(device, ACPI_DEVICE_NOTIFY, rbtn_notify);
+
 	switch (rbtn_data->type) {
 	case RBTN_TOGGLE:
 		rbtn_input_exit(rbtn_data);
@@ -445,9 +449,12 @@ static void rbtn_remove(struct acpi_device *device)
 	device->driver_data = NULL;
 }
 
-static void rbtn_notify(struct acpi_device *device, u32 event)
+static void rbtn_notify(acpi_handle handle, u32 event, void *data)
 {
-	struct rbtn_data *rbtn_data = device->driver_data;
+	struct acpi_device *device = data;
+	struct rbtn_data *rbtn_data;
+
+	rbtn_data = device->driver_data;
 
 	/*
 	 * Some BIOSes send a notification at resume.
-- 
2.40.1

