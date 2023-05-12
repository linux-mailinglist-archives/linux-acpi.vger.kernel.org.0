Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B6C7009D6
	for <lists+linux-acpi@lfdr.de>; Fri, 12 May 2023 16:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241400AbjELODm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 12 May 2023 10:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241435AbjELODV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 12 May 2023 10:03:21 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D99E1729
        for <linux-acpi@vger.kernel.org>; Fri, 12 May 2023 07:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683900200; x=1715436200;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oJv43mtzy6+CJK5yy6JwXPkNgWqSQNkVyqt5EQi4dTI=;
  b=FaPhmqA2LkNm5lTDHzGeaBGlZi+CvdfVCjDVFvHtyTCxnYbjttddfIuq
   C8bKlfmi1PUPpzN/NfsmaXxQdZnz8S8Puk2NyqoS6/k2yXLt4xqO9u8Oz
   4jBZi6CdRXmtt0YSSihCPwMq0xsFePbFRHRFdeCcIzA4rXWnQ3pSXW4nd
   W4HCuCHxFin/HpaicjUz3y/nKu/d1HJx8zBHgS0CB0z+MsqITRQInCjbF
   A6+qKKg9uYg27mu83LmBKvtl/gA0KWzxLyd0nCFK64vKH/oBuZNZ+Afpc
   KD9yV4thHOREqj5qiQK9hgRSG2LVMqbcLGXpz8fyTRKZnADl/PEKMKBIk
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="378931124"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="378931124"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 07:03:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="650648980"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="650648980"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 07:03:18 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v1 19/34] platform/x86/dell/dell-rbtn: Move handler installing logic to driver
Date:   Fri, 12 May 2023 16:02:07 +0200
Message-Id: <20230512140222.124868-20-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230512140222.124868-1-michal.wilczynski@intel.com>
References: <20230512140222.124868-1-michal.wilczynski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
 drivers/platform/x86/dell/dell-rbtn.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/dell/dell-rbtn.c b/drivers/platform/x86/dell/dell-rbtn.c
index aa0e6c907494..679ff2d6adbf 100644
--- a/drivers/platform/x86/dell/dell-rbtn.c
+++ b/drivers/platform/x86/dell/dell-rbtn.c
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
2.38.1

