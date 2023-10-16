Return-Path: <linux-acpi+bounces-673-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB21D7CB2B8
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Oct 2023 20:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65F64281608
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Oct 2023 18:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B87930D02
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Oct 2023 18:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BvYa/iSX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C547A168DE
	for <linux-acpi@vger.kernel.org>; Mon, 16 Oct 2023 17:01:57 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9639132;
	Mon, 16 Oct 2023 10:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697475716; x=1729011716;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9oL22kUdP5wBHGbwrW3JNkABa1U23D68tubspO8rF2s=;
  b=BvYa/iSXvBdRBfRh3SYEN8F0BR7Lx8SWLCLMKJxlBRgMuwST1MFITrao
   Mv8hR7irNbIpBSrMyrjyp/skUQfjh3Ux/kqwOvK7kyVyxaScBndWkdBJX
   OItxgBOAPYWJ91Pg86Qg3yA6iQK4UrzJ6EjJaoN+93PdThIzfpPlhgqHt
   ruYM8nVI8Uv/CKaFNEny23xbtntolG5mMMJ/qgr6MkosYyfB81vbMr4f5
   CiuS7ZOIAGKvq1qt09ZLU8OlGsd7rsHuajUEVu+9rNzVwzcWwXLi2dEMm
   i6W1VJFfjL4XpSCj4ufQQ/ShvG3jTFiXTjb/YWUtmUYZbhxflNsJs1syd
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="385427298"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="385427298"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 10:01:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="1087133937"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="1087133937"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 10:01:40 -0700
From: Michal Wilczynski <michal.wilczynski@intel.com>
To: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: rafael.j.wysocki@intel.com,
	andriy.shevchenko@linux.intel.com,
	lenb@kernel.org,
	Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v1 3/3] ACPI: acpi_pad: Rename ACPI device from device to adev
Date: Mon, 16 Oct 2023 20:01:25 +0300
Message-ID: <20231016170125.576159-4-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231016170125.576159-1-michal.wilczynski@intel.com>
References: <20231016170125.576159-1-michal.wilczynski@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Since transformation from ACPI driver to platform driver there are two
devices on which the driver operates - ACPI device and platform device.
For the sake of reader this calls for the distinction in their naming,
to avoid confusion. Rename device to adev, as corresponding
platform device is called pdev.

Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
---
 drivers/acpi/acpi_pad.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
index 2513028a0299..87cf2234ecd2 100644
--- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -398,12 +398,12 @@ static void acpi_pad_handle_notify(acpi_handle handle)
 static void acpi_pad_notify(acpi_handle handle, u32 event, void *data)
 {
 	struct device *dev = data;
-	struct acpi_device *device = ACPI_COMPANION(dev);
+	struct acpi_device *adev = ACPI_COMPANION(dev);
 
 	switch (event) {
 	case ACPI_PROCESSOR_AGGREGATOR_NOTIFY:
 		acpi_pad_handle_notify(handle);
-		acpi_bus_generate_netlink_event(device->pnp.device_class,
+		acpi_bus_generate_netlink_event(adev->pnp.device_class,
 						dev_name(dev), event, 0);
 		break;
 	default:
@@ -414,14 +414,14 @@ static void acpi_pad_notify(acpi_handle handle, u32 event, void *data)
 
 static int acpi_pad_probe(struct platform_device *pdev)
 {
-	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
+	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
 	struct device *dev = &pdev->dev;
 	acpi_status status;
 
-	strcpy(acpi_device_name(device), ACPI_PROCESSOR_AGGREGATOR_DEVICE_NAME);
-	strcpy(acpi_device_class(device), ACPI_PROCESSOR_AGGREGATOR_CLASS);
+	strcpy(acpi_device_name(adev), ACPI_PROCESSOR_AGGREGATOR_DEVICE_NAME);
+	strcpy(acpi_device_class(adev), ACPI_PROCESSOR_AGGREGATOR_CLASS);
 
-	status = acpi_install_notify_handler(device->handle,
+	status = acpi_install_notify_handler(adev->handle,
 					     ACPI_DEVICE_NOTIFY,
 					     acpi_pad_notify,
 					     dev);
@@ -433,13 +433,13 @@ static int acpi_pad_probe(struct platform_device *pdev)
 
 static void acpi_pad_remove(struct platform_device *pdev)
 {
-	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
+	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
 
 	mutex_lock(&isolated_cpus_lock);
 	acpi_pad_idle_cpus(0);
 	mutex_unlock(&isolated_cpus_lock);
 
-	acpi_remove_notify_handler(device->handle,
+	acpi_remove_notify_handler(adev->handle,
 				   ACPI_DEVICE_NOTIFY,
 				   acpi_pad_notify);
 }
-- 
2.41.0


