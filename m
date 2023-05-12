Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E612D7009DC
	for <lists+linux-acpi@lfdr.de>; Fri, 12 May 2023 16:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241428AbjELODq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 12 May 2023 10:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241444AbjELODd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 12 May 2023 10:03:33 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22FF8D870
        for <linux-acpi@vger.kernel.org>; Fri, 12 May 2023 07:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683900207; x=1715436207;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nbCBiSyuCy2m+4Tz/iazNSbMP/gr+s3bj2lE55c9N3A=;
  b=lc/MdTMbw2yt2kmDPx0HpO3RFv/yx/CfWuLqqwru0CZgrokntL8OBVcC
   Cg4RescfSV0U8NXXxjMftTFLFwIZ1UMh2Ye9Dts3XfjbciHBujWDMgIDD
   +xvdcOMt6Ctrsk8j7cfra0AXmarGu78HZe06ArBMj13henHtUKnaKGb1a
   jW53dl6nYezyHtNxDjs9Ae4+Tt2wd93ZmSQn3hAf9VDnC5pLyy7tU8y9Z
   fyLzSf3ok/qrVY6yanMFx4TYMR590F0670NzpMGnlcaDBWswnKV0sOZVO
   7x8t9e5MKbVjpb984RdERKrzoKY715SgWvUMWAW+fsz5LnBP4zNwtsgBk
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="378931169"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="378931169"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 07:03:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="650648999"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="650648999"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 07:03:25 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v1 25/34] platform/x86/topstar-laptop: Move handler installing logic to driver
Date:   Fri, 12 May 2023 16:02:13 +0200
Message-Id: <20230512140222.124868-26-michal.wilczynski@intel.com>
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
 drivers/platform/x86/topstar-laptop.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/topstar-laptop.c b/drivers/platform/x86/topstar-laptop.c
index 20df1ebefc30..31cc3ce9bff3 100644
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
@@ -319,7 +322,11 @@ static int topstar_acpi_add(struct acpi_device *device)
 			goto err_input_exit;
 	}
 
-	return 0;
+	err = acpi_device_install_event_handler(acpi_dev, ACPI_DEVICE_NOTIFY, topstar_acpi_notify);
+	if (err)
+		goto err_input_exit;
+
+	return err;
 
 err_input_exit:
 	topstar_input_exit(topstar);
@@ -336,6 +343,8 @@ static void topstar_acpi_remove(struct acpi_device *device)
 {
 	struct topstar_laptop *topstar = acpi_driver_data(device);
 
+	acpi_device_remove_event_handler(acpi_dev, ACPI_DEVICE_NOTIFY, topstar_acpi_notify);
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
2.38.1

