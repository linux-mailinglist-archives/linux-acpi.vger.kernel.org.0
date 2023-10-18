Return-Path: <linux-acpi+bounces-753-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C61B27CE921
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Oct 2023 22:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55719B20D55
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Oct 2023 20:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CAE9CA40
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Oct 2023 20:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eu6gsYLP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2590D335CA
	for <linux-acpi@vger.kernel.org>; Wed, 18 Oct 2023 19:10:17 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF0011F;
	Wed, 18 Oct 2023 12:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697656215; x=1729192215;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v4UODrq8h3M2ue98vfE4pky6De+v+9Ny98Hg4mFpil8=;
  b=eu6gsYLPWNk0d+IYkdsAnVauBd2Tv+RZ5MNX/cwdyuSbMslAAMGpllHH
   TwjPekiAP9jo6B/GD1XJkNPjsQvZ5Cdpkse46t+doW1J7DLBFFkELL6se
   ndpsNRLmk/F073c+aq7SfT4V53xtwio+kDWq+kka1adQbh1jKP4LAeDhR
   dRhNIIQUJKIn7BIC40lW1xyOIhxKY2Zi/aOSWBP7jktoEnEjW0FobVeb0
   mqE2fhorv6HKCXZnEvtK0xxmcR1cJVBBhHj9IOo2OnXE3ew2M+zbxE+P0
   zY6//k2ARdVKJe4vIbEyi4lhZWNecJ4w4DbUmzZXyz4oN4rbOnf00amSp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="472323324"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="472323324"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 12:10:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="733277300"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="733277300"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 12:10:12 -0700
From: Michal Wilczynski <michal.wilczynski@intel.com>
To: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: rafael.j.wysocki@intel.com,
	andriy.shevchenko@linux.intel.com,
	lenb@kernel.org,
	Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v2 3/3] ACPI: acpi_pad: Rename ACPI device from device to adev
Date: Wed, 18 Oct 2023 22:09:45 +0300
Message-ID: <20231018190945.252428-4-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018190945.252428-1-michal.wilczynski@intel.com>
References: <20231018190945.252428-1-michal.wilczynski@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since transformation from ACPI driver to platform driver there are two
devices on which the driver operates - ACPI device and platform device.
For the sake of reader this calls for the distinction in their naming,
to avoid confusion. Rename device to adev, as corresponding
platform device is called pdev.

Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
---
 drivers/acpi/acpi_pad.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
index 3ede3019d898..32a2c006908b 100644
--- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -398,13 +398,13 @@ static void acpi_pad_handle_notify(acpi_handle handle)
 static void acpi_pad_notify(acpi_handle handle, u32 event,
 	void *data)
 {
-	struct acpi_device *device = data;
+	struct acpi_device *adev = data;
 
 	switch (event) {
 	case ACPI_PROCESSOR_AGGREGATOR_NOTIFY:
 		acpi_pad_handle_notify(handle);
-		acpi_bus_generate_netlink_event(device->pnp.device_class,
-			dev_name(&device->dev), event, 0);
+		acpi_bus_generate_netlink_event(adev->pnp.device_class,
+			dev_name(&adev->dev), event, 0);
 		break;
 	default:
 		pr_warn("Unsupported event [0x%x]\n", event);
@@ -414,14 +414,15 @@ static void acpi_pad_notify(acpi_handle handle, u32 event,
 
 static int acpi_pad_probe(struct platform_device *pdev)
 {
-	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
+	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
 	acpi_status status;
 
-	strcpy(acpi_device_name(device), ACPI_PROCESSOR_AGGREGATOR_DEVICE_NAME);
-	strcpy(acpi_device_class(device), ACPI_PROCESSOR_AGGREGATOR_CLASS);
+	strcpy(acpi_device_name(adev), ACPI_PROCESSOR_AGGREGATOR_DEVICE_NAME);
+	strcpy(acpi_device_class(adev), ACPI_PROCESSOR_AGGREGATOR_CLASS);
+
+	status = acpi_install_notify_handler(adev->handle,
+		ACPI_DEVICE_NOTIFY, acpi_pad_notify, adev);
 
-	status = acpi_install_notify_handler(device->handle,
-		ACPI_DEVICE_NOTIFY, acpi_pad_notify, device);
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
 
@@ -430,13 +431,13 @@ static int acpi_pad_probe(struct platform_device *pdev)
 
 static void acpi_pad_remove(struct platform_device *pdev)
 {
-	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
+	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
 
 	mutex_lock(&isolated_cpus_lock);
 	acpi_pad_idle_cpus(0);
 	mutex_unlock(&isolated_cpus_lock);
 
-	acpi_remove_notify_handler(device->handle,
+	acpi_remove_notify_handler(adev->handle,
 		ACPI_DEVICE_NOTIFY, acpi_pad_notify);
 }
 
-- 
2.41.0


