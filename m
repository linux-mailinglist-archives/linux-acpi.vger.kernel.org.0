Return-Path: <linux-acpi+bounces-752-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 965567CE920
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Oct 2023 22:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6A561C209B8
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Oct 2023 20:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7A19CA40
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Oct 2023 20:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TjyblE1e"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B59335CA
	for <linux-acpi@vger.kernel.org>; Wed, 18 Oct 2023 19:10:14 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13021109;
	Wed, 18 Oct 2023 12:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697656213; x=1729192213;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ztoGdE0qg+ItzRYoFmpgpqeHEUkaq3yFJe9yMCKp7Z0=;
  b=TjyblE1eg1dKDY4mqXdC0MqxQE8kXdrMQ6vhG83K3Q7fxT6AlYOkmYIb
   /cV5U1+sVIHj3kWWB8tROHkX3C5MbpEedpzCNh/qdoMDNZ4PJjo2sUuUz
   SyofNmZEDUGZE1e2X/TYtqgXXe3uaa5M0EDz1hji2Hjc6hCFXV8HPHjaJ
   Hy8EHYcvvtJVvJa1Bv84yJZqq0G9Im0TsdEu2ZRw6jgmociloPg2Q9tVQ
   sw5c0QsPdtGyfORl4dl5HkE6JfjadWRc/osir6hUAweeKcXJq1tR58IjD
   pTWt8W3lUYgfHaM4AUJHPHWovwm3i6hAetfdo4ir5DSOaFZk8pbXvIEt5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="472323319"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="472323319"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 12:10:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="733277292"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="733277292"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 12:10:10 -0700
From: Michal Wilczynski <michal.wilczynski@intel.com>
To: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: rafael.j.wysocki@intel.com,
	andriy.shevchenko@linux.intel.com,
	lenb@kernel.org,
	Michal Wilczynski <michal.wilczynski@intel.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v2 2/3] ACPI: acpi_pad: Use dev groups for sysfs
Date: Wed, 18 Oct 2023 22:09:44 +0300
Message-ID: <20231018190945.252428-3-michal.wilczynski@intel.com>
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

Change the way sysfs files are created. Use dev_groups, as it's a
better approach - it allows to declare attributes, and the core code
would take care of the lifecycle of those objects.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
---
 drivers/acpi/acpi_pad.c | 42 +++++++++--------------------------------
 1 file changed, 9 insertions(+), 33 deletions(-)

diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
index 25068f2c5b4d..3ede3019d898 100644
--- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -337,33 +337,14 @@ static ssize_t idlecpus_show(struct device *dev,
 
 static DEVICE_ATTR_RW(idlecpus);
 
-static int acpi_pad_add_sysfs(struct acpi_device *device)
-{
-	int result;
-
-	result = device_create_file(&device->dev, &dev_attr_idlecpus);
-	if (result)
-		return -ENODEV;
-	result = device_create_file(&device->dev, &dev_attr_idlepct);
-	if (result) {
-		device_remove_file(&device->dev, &dev_attr_idlecpus);
-		return -ENODEV;
-	}
-	result = device_create_file(&device->dev, &dev_attr_rrtime);
-	if (result) {
-		device_remove_file(&device->dev, &dev_attr_idlecpus);
-		device_remove_file(&device->dev, &dev_attr_idlepct);
-		return -ENODEV;
-	}
-	return 0;
-}
+static struct attribute *acpi_pad_attrs[] = {
+	&dev_attr_idlecpus.attr,
+	&dev_attr_idlepct.attr,
+	&dev_attr_rrtime.attr,
+	NULL
+};
 
-static void acpi_pad_remove_sysfs(struct acpi_device *device)
-{
-	device_remove_file(&device->dev, &dev_attr_idlecpus);
-	device_remove_file(&device->dev, &dev_attr_idlepct);
-	device_remove_file(&device->dev, &dev_attr_rrtime);
-}
+ATTRIBUTE_GROUPS(acpi_pad);
 
 /*
  * Query firmware how many CPUs should be idle
@@ -439,15 +420,10 @@ static int acpi_pad_probe(struct platform_device *pdev)
 	strcpy(acpi_device_name(device), ACPI_PROCESSOR_AGGREGATOR_DEVICE_NAME);
 	strcpy(acpi_device_class(device), ACPI_PROCESSOR_AGGREGATOR_CLASS);
 
-	if (acpi_pad_add_sysfs(device))
-		return -ENODEV;
-
 	status = acpi_install_notify_handler(device->handle,
 		ACPI_DEVICE_NOTIFY, acpi_pad_notify, device);
-	if (ACPI_FAILURE(status)) {
-		acpi_pad_remove_sysfs(device);
+	if (ACPI_FAILURE(status))
 		return -ENODEV;
-	}
 
 	return 0;
 }
@@ -462,7 +438,6 @@ static void acpi_pad_remove(struct platform_device *pdev)
 
 	acpi_remove_notify_handler(device->handle,
 		ACPI_DEVICE_NOTIFY, acpi_pad_notify);
-	acpi_pad_remove_sysfs(device);
 }
 
 static const struct acpi_device_id pad_device_ids[] = {
@@ -475,6 +450,7 @@ static struct platform_driver acpi_pad_driver = {
 	.probe = acpi_pad_probe,
 	.remove_new = acpi_pad_remove,
 	.driver = {
+		.dev_groups = acpi_pad_groups,
 		.name = "processor_aggregator",
 		.acpi_match_table = pad_device_ids,
 	},
-- 
2.41.0


