Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0757061EA
	for <lists+linux-acpi@lfdr.de>; Wed, 17 May 2023 09:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbjEQH6k (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 17 May 2023 03:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjEQH6Z (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 17 May 2023 03:58:25 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38681701
        for <linux-acpi@vger.kernel.org>; Wed, 17 May 2023 00:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684310297; x=1715846297;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wNzFAp+2Askmwe3Z0I4i+TRfnPUKD8KrFQAyDNVZazs=;
  b=DVwuUKofWgLjv6pxOyhYD9hRoxJ0djdE+JMTlXHwZS40+Ja+16/DckxU
   pu2r4qnQQ7Eg2MCTCfQ7U5hrErd7bJgso5xw5s+9PFyIXU+qUpPMkwVxA
   tPQF1IlQhuYZCIVZv/F9DL7NNioWExObEHzppau3KukJ9fIG2WlQTPO7b
   ze67ZsMBDD7spINUPmvxQ7v75sVkVJ9C0lmKcIl3NMBtVNGoEb3Qpmd1M
   uMY1LlU5PMd+nQwkDYjj7c/ApNJF/daINVcW+e86cwr6+uYrCj2MH7aVR
   brkuczu7uRnPCec554fAPQcGko9qWxbPslJUE5hmXaAqf2UomrrILTkdJ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="415105364"
X-IronPort-AV: E=Sophos;i="5.99,281,1677571200"; 
   d="scan'208";a="415105364"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 00:58:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="825877256"
X-IronPort-AV: E=Sophos;i="5.99,281,1677571200"; 
   d="scan'208";a="825877256"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 00:58:00 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, srinivas.pandruvada@linux.intel.com,
        Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v3 02/34] acpi/ac: Move handler installing logic to driver
Date:   Wed, 17 May 2023 09:56:52 +0200
Message-Id: <20230517075724.153992-3-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230517075724.153992-1-michal.wilczynski@intel.com>
References: <20230517075724.153992-1-michal.wilczynski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

Call acpi_device_install_event_handler() at the end of .add callback.
Call acpi_device_remove_event_handler() at the beginning of .remove
callback. Change arguments passed to the notify callback to match with
what's required by acpi_install_event_handler().

Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
---
 drivers/acpi/ac.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index 1ace70b831cd..208af5a3106e 100644
--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -34,7 +34,7 @@ MODULE_LICENSE("GPL");
 
 static int acpi_ac_add(struct acpi_device *device);
 static void acpi_ac_remove(struct acpi_device *device);
-static void acpi_ac_notify(struct acpi_device *device, u32 event);
+static void acpi_ac_notify(acpi_handle handle, u32 event, void *data);
 
 static const struct acpi_device_id ac_device_ids[] = {
 	{"ACPI0003", 0},
@@ -54,11 +54,9 @@ static struct acpi_driver acpi_ac_driver = {
 	.name = "ac",
 	.class = ACPI_AC_CLASS,
 	.ids = ac_device_ids,
-	.flags = ACPI_DRIVER_ALL_NOTIFY_EVENTS,
 	.ops = {
 		.add = acpi_ac_add,
 		.remove = acpi_ac_remove,
-		.notify = acpi_ac_notify,
 		},
 	.drv.pm = &acpi_ac_pm,
 };
@@ -128,9 +126,12 @@ static enum power_supply_property ac_props[] = {
 };
 
 /* Driver Model */
-static void acpi_ac_notify(struct acpi_device *device, u32 event)
+static void acpi_ac_notify(acpi_handle handle, u32 event, void *data)
 {
-	struct acpi_ac *ac = acpi_driver_data(device);
+	struct acpi_device *device = data;
+	struct acpi_ac *ac;
+
+	ac = acpi_driver_data(device);
 
 	if (!ac)
 		return;
@@ -256,6 +257,8 @@ static int acpi_ac_add(struct acpi_device *device)
 
 	ac->battery_nb.notifier_call = acpi_ac_battery_notify;
 	register_acpi_notifier(&ac->battery_nb);
+
+	result = acpi_device_install_event_handler(device, ACPI_ALL_NOTIFY, acpi_ac_notify);
 end:
 	if (result)
 		kfree(ac);
@@ -297,6 +300,7 @@ static void acpi_ac_remove(struct acpi_device *device)
 
 	ac = acpi_driver_data(device);
 
+	acpi_device_remove_event_handler(device, ACPI_ALL_NOTIFY, acpi_ac_notify);
 	power_supply_unregister(ac->charger);
 	unregister_acpi_notifier(&ac->battery_nb);
 
-- 
2.40.1

