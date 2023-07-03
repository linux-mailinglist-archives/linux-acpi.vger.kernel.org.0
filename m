Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 998367456CF
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Jul 2023 10:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbjGCIEI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 3 Jul 2023 04:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbjGCIDm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Jul 2023 04:03:42 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6874C1729;
        Mon,  3 Jul 2023 01:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688371407; x=1719907407;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OhNb4diD7c3/96GlreLql7JOogYRt1zgUXPKOSDhXMw=;
  b=Ejvv1Xz/A99NYeiomddcCpGM+4BzMPfaZwiEh7DOD9kH66++VGWIvPfr
   SRylkncnrHjoXYsc0DiwnLzfsyNDmdh/S+fSd0KJqm9Rma+2tpMMWQPyr
   gclSeujAIie2GjITMNi8reGgaDkg6tEnLha0pObxlL4h+POA2t6PHoRiV
   lc43lWgVyPFFIUklvzmtU2AguovQIHYPzYzO+SPX5OBZE4D/Rika65CR7
   CFgvHiq+vObPkwonCBQSLJLDPWgElt35L1AFaYlJ8Xyc3OsbcBDpY93JY
   TQMynb4tr1BFiKDIIg8G39faDwgZb3h1DYZR7+eeDy6pVq1WRXkZfolhP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="366304048"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="366304048"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 01:03:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="862994547"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="862994547"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 01:03:23 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, lenb@kernel.org, dave.jiang@intel.com,
        ira.weiny@intel.com, rui.zhang@intel.com,
        linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v7 4/9] acpi/video: Move handler installing logic to driver
Date:   Mon,  3 Jul 2023 11:02:47 +0300
Message-ID: <20230703080252.2899090-5-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230703080252.2899090-1-michal.wilczynski@intel.com>
References: <20230703080252.2899090-1-michal.wilczynski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Call acpi_dev_install_notify_handler() at the end of .add() callback.
Call acpi_dev_remove_notify_handler() at the beginning of .remove()
callback. Change arguments passed to the notify function to match with
what's required by acpi_dev_install_notify_handler(). Remove .notify
callback initialization in acpi_driver.

Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
---
 drivers/acpi/acpi_video.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 62f4364e4460..168bb43e0c65 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -77,7 +77,7 @@ static DEFINE_MUTEX(video_list_lock);
 static LIST_HEAD(video_bus_head);
 static int acpi_video_bus_add(struct acpi_device *device);
 static void acpi_video_bus_remove(struct acpi_device *device);
-static void acpi_video_bus_notify(struct acpi_device *device, u32 event);
+static void acpi_video_bus_notify(acpi_handle handle, u32 event, void *data);
 
 /*
  * Indices in the _BCL method response: the first two items are special,
@@ -104,7 +104,6 @@ static struct acpi_driver acpi_video_bus = {
 	.ops = {
 		.add = acpi_video_bus_add,
 		.remove = acpi_video_bus_remove,
-		.notify = acpi_video_bus_notify,
 		},
 };
 
@@ -1527,8 +1526,9 @@ static int acpi_video_bus_stop_devices(struct acpi_video_bus *video)
 				  acpi_osi_is_win8() ? 0 : 1);
 }
 
-static void acpi_video_bus_notify(struct acpi_device *device, u32 event)
+static void acpi_video_bus_notify(acpi_handle handle, u32 event, void *data)
 {
+	struct acpi_device *device = data;
 	struct acpi_video_bus *video = acpi_driver_data(device);
 	struct input_dev *input;
 	int keycode = 0;
@@ -2053,8 +2053,20 @@ static int acpi_video_bus_add(struct acpi_device *device)
 
 	acpi_video_bus_add_notify_handler(video);
 
+	error = acpi_dev_install_notify_handler(device,
+						ACPI_DEVICE_NOTIFY,
+						acpi_video_bus_notify);
+	if (error)
+		goto err_remove;
+
 	return 0;
 
+err_remove:
+	mutex_lock(&video_list_lock);
+	list_del(&video->entry);
+	mutex_unlock(&video_list_lock);
+	acpi_video_bus_remove_notify_handler(video);
+	acpi_video_bus_unregister_backlight(video);
 err_put_video:
 	acpi_video_bus_put_devices(video);
 	kfree(video->attached_array);
@@ -2075,6 +2087,10 @@ static void acpi_video_bus_remove(struct acpi_device *device)
 
 	video = acpi_driver_data(device);
 
+	acpi_dev_remove_notify_handler(device,
+				       ACPI_DEVICE_NOTIFY,
+				       acpi_video_bus_notify);
+
 	mutex_lock(&video_list_lock);
 	list_del(&video->entry);
 	mutex_unlock(&video_list_lock);
-- 
2.41.0

