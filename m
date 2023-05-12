Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A04317009D4
	for <lists+linux-acpi@lfdr.de>; Fri, 12 May 2023 16:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241424AbjELODl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 12 May 2023 10:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241418AbjELODT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 12 May 2023 10:03:19 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7293C1B1
        for <linux-acpi@vger.kernel.org>; Fri, 12 May 2023 07:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683900198; x=1715436198;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XkKJ8TM3GYnv3u7IL03ncZgdAXLi2ZTXpbAt2ivi4h0=;
  b=DcJlYIDsGB5GK5WmSLUsTnVim2hKtdcyWstS/VYRRNElZW6jQ+c7cuow
   IAIL1cOEv2T76u9oDb71c0PH02SLzxrvbv7z8LeTQf116iyOCSLncVnXv
   yRmZrv1jgQPpYWZ1B1hCukL158/Y0bBg+9zm0OhkOxDxi7sPhbLJ0D5F2
   XPLcCnOhz6zHLHfmjrXGTn7sezu3j34tZkjqq4ub4riv1MJjRILvg5QsE
   CnreqW+3dEC7c5CM4FG04ImU4zXb+wDu9NwDigefemRqB54j3u4izSi6c
   EdouP6T6PlM+fTl21FzJzobLXJXPZRUxQypjH+j0YZl95oWNBCuIgV/ni
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="378931119"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="378931119"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 07:03:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="650648977"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="650648977"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 07:03:16 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v1 18/34] platform/x86/classmate-laptop: Move handler installing logic to driver
Date:   Fri, 12 May 2023 16:02:06 +0200
Message-Id: <20230512140222.124868-19-michal.wilczynski@intel.com>
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
 drivers/platform/x86/classmate-laptop.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/classmate-laptop.c b/drivers/platform/x86/classmate-laptop.c
index 2edaea2492df..51a0dd28b8ec 100644
--- a/drivers/platform/x86/classmate-laptop.c
+++ b/drivers/platform/x86/classmate-laptop.c
@@ -180,8 +180,9 @@ static acpi_status cmpc_get_accel_v4(acpi_handle handle,
 	return status;
 }
 
-static void cmpc_accel_handler_v4(struct acpi_device *dev, u32 event)
+static void cmpc_accel_handler_v4(acpi_handle handle, u32 event, void *data)
 {
+	struct acpi_device *dev = data;
 	if (event == 0x81) {
 		int16_t x, y, z;
 		acpi_status status;
@@ -407,7 +408,12 @@ static int cmpc_accel_add_v4(struct acpi_device *acpi)
 	inputdev = dev_get_drvdata(&acpi->dev);
 	dev_set_drvdata(&inputdev->dev, accel);
 
-	return 0;
+	error =  acpi_device_install_event_handler(device, ACPI_DEVICE_NOTIFY,
+						    cmpc_accel_handler_v4);
+	if (error)
+		goto failed_input;
+
+	return error;
 
 failed_input:
 	device_remove_file(&acpi->dev, &cmpc_accel_g_select_attr_v4);
@@ -420,6 +426,7 @@ static int cmpc_accel_add_v4(struct acpi_device *acpi)
 
 static void cmpc_accel_remove_v4(struct acpi_device *acpi)
 {
+	acpi_device_remove_event_handler(device, ACPI_DEVICE_NOTIFY, cmpc_accel_handler_v4);
 	device_remove_file(&acpi->dev, &cmpc_accel_sensitivity_attr_v4);
 	device_remove_file(&acpi->dev, &cmpc_accel_g_select_attr_v4);
 	cmpc_remove_acpi_notify_device(acpi);
@@ -1071,7 +1078,6 @@ static struct acpi_driver cmpc_keys_acpi_driver = {
 	.ops = {
 		.add = cmpc_keys_add,
 		.remove = cmpc_keys_remove,
-		.notify = cmpc_keys_handler,
 	}
 };
 
-- 
2.38.1

