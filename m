Return-Path: <linux-acpi+bounces-953-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB507D6BE1
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 14:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E05EB1C20C5C
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 12:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A790EAEC
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 12:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iYD+r70B"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F758273CD
	for <linux-acpi@vger.kernel.org>; Wed, 25 Oct 2023 11:18:39 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274AD18A;
	Wed, 25 Oct 2023 04:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698232717; x=1729768717;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kk6qAnA8TIEab1NEc+P02lCCwI8ZDSv7ghqU2ChGxeA=;
  b=iYD+r70BDOhEoz17qQZVQ3vDaqsUiJUyQrrIfo7X0VnZa8bkZRa6PZzE
   4HJNJmxX24BW769qbhPjMDZJcKFsAHTGJpE/rcnJQhOdWCDVBMaggtv+R
   WeEIDEyw6TjsAqU0xseEHkRv2Orrb6eLtpjreShNB/pPghE5RKk32A3HE
   Zq5PXq4GvISz3Izfae0zk2IeSwEbxevnf21J94f4PMrfCVBBcP5NvxFzx
   5etnzotPIEg2EuOoksTC5jOv3ZPkPDugpob/CRNcJ9556C2NNoplaigqu
   wrxlDRdgWdjTPinMkLdr0u/UaBtaR9uA9IsCz3VPUb+0nh02/In5T1+nx
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="391154631"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="391154631"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 04:18:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="762425117"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="762425117"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 04:18:24 -0700
From: Michal Wilczynski <michal.wilczynski@intel.com>
To: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: rafael.j.wysocki@intel.com,
	andriy.shevchenko@linux.intel.com,
	lenb@kernel.org,
	Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v1 4/6] ACPI: acpi_video: Replace acpi_driver with platform_driver
Date: Wed, 25 Oct 2023 14:18:04 +0300
Message-ID: <20231025111806.2416524-5-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231025111806.2416524-1-michal.wilczynski@intel.com>
References: <20231025111806.2416524-1-michal.wilczynski@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The acpi_video driver uses struct acpi_driver to register itself while it
would be more logically consistent to use struct platform_driver for this
purpose, because the corresponding platform device is present and the
role of struct acpi_device is to amend the other bus types. ACPI devices
are not meant to be used as proper representation of hardware entities,
but to collect information on those hardware entities provided by the
platform firmware.

Use struct platform_driver for registering the acpi_video driver.

Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
---
 drivers/acpi/acpi_video.c | 41 ++++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 0c93b0ef0feb..5b9fb3374a2e 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -25,6 +25,7 @@
 #include <linux/dmi.h>
 #include <linux/suspend.h>
 #include <linux/acpi.h>
+#include <linux/platform_device.h>
 #include <acpi/video.h>
 #include <linux/uaccess.h>
 
@@ -75,8 +76,8 @@ static int register_count;
 static DEFINE_MUTEX(register_count_mutex);
 static DEFINE_MUTEX(video_list_lock);
 static LIST_HEAD(video_bus_head);
-static int acpi_video_bus_add(struct acpi_device *device);
-static void acpi_video_bus_remove(struct acpi_device *device);
+static int acpi_video_bus_probe(struct platform_device *pdev);
+static void acpi_video_bus_remove(struct platform_device *pdev);
 static void acpi_video_bus_notify(acpi_handle handle, u32 event, void *data);
 
 /*
@@ -97,14 +98,13 @@ static const struct acpi_device_id video_device_ids[] = {
 };
 MODULE_DEVICE_TABLE(acpi, video_device_ids);
 
-static struct acpi_driver acpi_video_bus = {
-	.name = "video",
-	.class = ACPI_VIDEO_CLASS,
-	.ids = video_device_ids,
-	.ops = {
-		.add = acpi_video_bus_add,
-		.remove = acpi_video_bus_remove,
-		},
+static struct platform_driver acpi_video_bus = {
+	.probe = acpi_video_bus_probe,
+	.remove_new = acpi_video_bus_remove,
+	.driver = {
+		.name = "video",
+		.acpi_match_table = video_device_ids,
+	},
 };
 
 struct acpi_video_bus_flags {
@@ -1525,8 +1525,8 @@ static int acpi_video_bus_stop_devices(struct acpi_video_bus *video)
 
 static void acpi_video_bus_notify(acpi_handle handle, u32 event, void *data)
 {
-	struct acpi_device *device = data;
-	struct acpi_video_bus *video = acpi_driver_data(device);
+	struct acpi_video_bus *video = data;
+	struct acpi_device *device = video->device;
 	struct input_dev *input;
 	int keycode = 0;
 
@@ -1969,8 +1969,9 @@ static int acpi_video_bus_put_devices(struct acpi_video_bus *video)
 
 static int instance;
 
-static int acpi_video_bus_add(struct acpi_device *device)
+static int acpi_video_bus_probe(struct platform_device *pdev)
 {
+	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
 	struct acpi_video_bus *video;
 	bool auto_detect;
 	int error;
@@ -2010,7 +2011,7 @@ static int acpi_video_bus_add(struct acpi_device *device)
 	video->device = device;
 	strcpy(acpi_device_name(device), ACPI_VIDEO_BUS_NAME);
 	strcpy(acpi_device_class(device), ACPI_VIDEO_CLASS);
-	device->driver_data = video;
+	platform_set_drvdata(pdev, video);
 
 	acpi_video_bus_find_cap(video);
 	error = acpi_video_bus_check(video);
@@ -2059,7 +2060,7 @@ static int acpi_video_bus_add(struct acpi_device *device)
 		goto err_del;
 
 	error = acpi_dev_install_notify_handler(device, ACPI_DEVICE_NOTIFY,
-						acpi_video_bus_notify, device);
+						acpi_video_bus_notify, video);
 	if (error)
 		goto err_remove;
 
@@ -2081,11 +2082,11 @@ static int acpi_video_bus_add(struct acpi_device *device)
 	return error;
 }
 
-static void acpi_video_bus_remove(struct acpi_device *device)
+static void acpi_video_bus_remove(struct platform_device *pdev)
 {
-	struct acpi_video_bus *video = acpi_driver_data(device);
+	struct acpi_video_bus *video = platform_get_drvdata(pdev);
 
-	acpi_dev_remove_notify_handler(device, ACPI_DEVICE_NOTIFY,
+	acpi_dev_remove_notify_handler(video->device, ACPI_DEVICE_NOTIFY,
 				       acpi_video_bus_notify);
 
 	mutex_lock(&video_list_lock);
@@ -2200,7 +2201,7 @@ int acpi_video_register(void)
 
 	dmi_check_system(video_dmi_table);
 
-	ret = acpi_bus_register_driver(&acpi_video_bus);
+	ret = platform_driver_register(&acpi_video_bus);
 	if (ret)
 		goto leave;
 
@@ -2220,7 +2221,7 @@ void acpi_video_unregister(void)
 {
 	mutex_lock(&register_count_mutex);
 	if (register_count) {
-		acpi_bus_unregister_driver(&acpi_video_bus);
+		platform_driver_unregister(&acpi_video_bus);
 		register_count = 0;
 		may_report_brightness_keys = false;
 	}
-- 
2.41.0


