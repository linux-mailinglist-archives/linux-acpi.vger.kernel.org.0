Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97EEE719E85
	for <lists+linux-acpi@lfdr.de>; Thu,  1 Jun 2023 15:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233867AbjFANoJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 1 Jun 2023 09:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232984AbjFANoI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Jun 2023 09:44:08 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2008D13D;
        Thu,  1 Jun 2023 06:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685627047; x=1717163047;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kqgNW8OvryYyrV4L3xPcxq88n689A4LPp2Kr4WOs0mw=;
  b=FzLAAXFe6w8TCT/0niALQpj4bSC6Vy/6M5tH1UozmXOxGEaXYAZNL+iJ
   DtARd5tnOG97bzgfPAgTn9YGzuY1pX51NWB2hnaOhpRTX2MEiEybzhh1i
   iCJLh9EDS+VdwltVkQ6ToTFS4VmdG6CWos/fm0PAbfQTpozGMSOC3kinm
   5ejDpIGD/6YoIWmLi7KACG2bNwMrVTNeL+BMdZDb/JehMp2C2KoDihzL9
   +ZqVgdqdNI5zNRldqDBoDzanekyYZ84JBEoTuaaPlvuJa9vTq4jz6sKAb
   +G6cLxqw4LLQdhDILw23xoT0lAEW7Im+xf1GVgl+x+3WFIH8/cX2KSUl1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="419067469"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="419067469"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 06:19:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="881601692"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="881601692"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 06:19:08 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     Benson Leung <bleung@chromium.org>
Cc:     Michal Wilczynski <michal.wilczynski@intel.com>,
        chrome-platform@lists.linux.dev, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, rafael@kernel.org
Subject: [PATCH v4 12/35] platform/chromeos_tbmc: Move handler installing logic to driver
Date:   Thu,  1 Jun 2023 15:17:15 +0200
Message-Id: <20230601131739.300760-13-michal.wilczynski@intel.com>
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
 drivers/platform/chrome/chromeos_tbmc.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/chrome/chromeos_tbmc.c b/drivers/platform/chrome/chromeos_tbmc.c
index d1cf8f3463ce..ac0f43fc530a 100644
--- a/drivers/platform/chrome/chromeos_tbmc.c
+++ b/drivers/platform/chrome/chromeos_tbmc.c
@@ -45,8 +45,10 @@ static __maybe_unused int chromeos_tbmc_resume(struct device *dev)
 	return chromeos_tbmc_query_switch(adev, adev->driver_data);
 }
 
-static void chromeos_tbmc_notify(struct acpi_device *adev, u32 event)
+static void chromeos_tbmc_notify(acpi_handle handle, u32 event, void *data)
 {
+	struct acpi_device *adev = data;
+
 	acpi_pm_wakeup_event(&adev->dev);
 	switch (event) {
 	case 0x80:
@@ -92,7 +94,13 @@ static int chromeos_tbmc_add(struct acpi_device *adev)
 		return ret;
 	}
 	device_init_wakeup(dev, true);
-	return 0;
+
+	return acpi_device_install_event_handler(adev, ACPI_DEVICE_NOTIFY, chromeos_tbmc_notify);
+}
+
+static void chromeos_tbmc_remove(struct acpi_device *adev)
+{
+	acpi_device_remove_event_handler(adev, ACPI_DEVICE_NOTIFY, chromeos_tbmc_notify);
 }
 
 static const struct acpi_device_id chromeos_tbmc_acpi_device_ids[] = {
@@ -110,7 +118,7 @@ static struct acpi_driver chromeos_tbmc_driver = {
 	.ids = chromeos_tbmc_acpi_device_ids,
 	.ops = {
 		.add = chromeos_tbmc_add,
-		.notify = chromeos_tbmc_notify,
+		.remove = chromeos_tbmc_remove,
 	},
 	.drv.pm = &chromeos_tbmc_pm_ops,
 };
-- 
2.40.1

