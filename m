Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D5F7061F0
	for <lists+linux-acpi@lfdr.de>; Wed, 17 May 2023 09:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjEQH7B (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 17 May 2023 03:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjEQH6b (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 17 May 2023 03:58:31 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F2943AA3
        for <linux-acpi@vger.kernel.org>; Wed, 17 May 2023 00:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684310307; x=1715846307;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hM51g4LvmO5TXW4gm++QbkwmPKMxxaZZYt1NUl8p1KA=;
  b=BgUJfKKSqqdM6KmY3lK9IVb1azCP8aiCfvW64OS24KpqbUSb35MnrT7m
   x5LHl4jlSfGqyWZdml6nwbncRyu0dkCO89ywhWedcUNzTXP9KFsqGg/6G
   /tK4Sbdrg8qohz4iEhqaAiM4EF5sufn1HGes4N1uBbU6LLNY/b2iVeyg6
   HXvbRbNFMMKNt4C2DcRxyzgFwFBcHDz/oCU9YPN9Spw8kpOUvPKQ0ZR2N
   31ahF+Y95QASGSWeHygrhHXSomGorbGtRFLQD2ThdzFjW8BtFuAamDuiV
   nG2pk+T/OSlWgK/pUDf9Z9QDNffwvNQqANsXykBuRBp76MQh2M/KoVof/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="415105388"
X-IronPort-AV: E=Sophos;i="5.99,281,1677571200"; 
   d="scan'208";a="415105388"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 00:58:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="825877283"
X-IronPort-AV: E=Sophos;i="5.99,281,1677571200"; 
   d="scan'208";a="825877283"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 00:58:07 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, srinivas.pandruvada@linux.intel.com,
        Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v3 07/34] acpi/nfit: Move handler installing logic to driver
Date:   Wed, 17 May 2023 09:56:57 +0200
Message-Id: <20230517075724.153992-8-michal.wilczynski@intel.com>
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

Call acpi_device_install_event_handler() at the end of .add() callback.
Call acpi_device_remove_event_handler() at the beginning of .remove()
callback. Change arguments passed to the notify callback to match with
what's required by acpi_device_install_event_handler().

Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
---
 drivers/acpi/nfit/core.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 07204d482968..633c34513071 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -3312,6 +3312,15 @@ void acpi_nfit_shutdown(void *data)
 }
 EXPORT_SYMBOL_GPL(acpi_nfit_shutdown);
 
+static void acpi_nfit_notify(acpi_handle handle, u32 event, void *data)
+{
+	struct acpi_device *device = data;
+
+	device_lock(&device->dev);
+	__acpi_nfit_notify(&device->dev, handle, event);
+	device_unlock(&device->dev);
+}
+
 static int acpi_nfit_add(struct acpi_device *adev)
 {
 	struct acpi_buffer buf = { ACPI_ALLOCATE_BUFFER, NULL };
@@ -3368,12 +3377,18 @@ static int acpi_nfit_add(struct acpi_device *adev)
 
 	if (rc)
 		return rc;
-	return devm_add_action_or_reset(dev, acpi_nfit_shutdown, acpi_desc);
+
+	rc = devm_add_action_or_reset(dev, acpi_nfit_shutdown, acpi_desc);
+	if (rc)
+		return rc;
+
+	return acpi_device_install_event_handler(adev, ACPI_DEVICE_NOTIFY, acpi_nfit_notify);
 }
 
 static void acpi_nfit_remove(struct acpi_device *adev)
 {
 	/* see acpi_nfit_unregister */
+	acpi_device_remove_event_handler(adev, ACPI_DEVICE_NOTIFY, acpi_nfit_notify);
 }
 
 static void acpi_nfit_update_notify(struct device *dev, acpi_handle handle)
@@ -3446,13 +3461,6 @@ void __acpi_nfit_notify(struct device *dev, acpi_handle handle, u32 event)
 }
 EXPORT_SYMBOL_GPL(__acpi_nfit_notify);
 
-static void acpi_nfit_notify(struct acpi_device *adev, u32 event)
-{
-	device_lock(&adev->dev);
-	__acpi_nfit_notify(&adev->dev, adev->handle, event);
-	device_unlock(&adev->dev);
-}
-
 static const struct acpi_device_id acpi_nfit_ids[] = {
 	{ "ACPI0012", 0 },
 	{ "", 0 },
@@ -3465,7 +3473,6 @@ static struct acpi_driver acpi_nfit_driver = {
 	.ops = {
 		.add = acpi_nfit_add,
 		.remove = acpi_nfit_remove,
-		.notify = acpi_nfit_notify,
 	},
 };
 
-- 
2.40.1

