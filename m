Return-Path: <linux-acpi+bounces-778-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F8B7D0D5B
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Oct 2023 12:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3489281F84
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Oct 2023 10:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A1D15EB9
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Oct 2023 10:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CMEDCpUP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398E2DDB3
	for <linux-acpi@vger.kernel.org>; Fri, 20 Oct 2023 08:48:14 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9FAD49;
	Fri, 20 Oct 2023 01:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697791692; x=1729327692;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=1P08c+02XrBKccGcreruYeIgD28f7+s17ZZyX78daGc=;
  b=CMEDCpUPJOswyAe6+vH3IfTQrD2FzFchFXSwCa591iFEzTBXlR3CDcem
   2a6ljM4MO4+iNwOAJVNZgrPWUKZQlDL+a04uWR7DL0EYYvlPvKIcy8m6z
   bw5hW1HVBfTv5WlpgFa2Gg2RB2k1d4l8shW5WYSM42djjm+5prUOyT7hx
   WxuH4NZnMUaK8iZwVQAAaJcc1taPBNWSi36wQrJnnzHiVHPBccfsQZBB0
   WDT4Q8vb8aBEwY7TrDBf3KIZkJLHjLXCQi5U05fgoIE9EDxK4iiSS75Bn
   U8+Kebjg6SA0yahw20UnMj6VPzJEQ3/LuoiHp7nkUNQw9lx+1PAsrr8th
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="450683511"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="450683511"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 01:48:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="873832168"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="873832168"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by fmsmga002.fm.intel.com with ESMTP; 20 Oct 2023 01:47:56 -0700
From: Raag Jadav <raag.jadav@intel.com>
To: rafael@kernel.org,
	len.brown@intel.com,
	robert.moore@intel.com,
	mika.westerberg@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	mark.rutland@arm.com,
	will@kernel.org,
	linux@roeck-us.net
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	acpica-devel@lists.linuxfoundation.org,
	linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-hwmon@vger.kernel.org,
	mallikarjunappa.sangannavar@intel.com,
	bala.senthil@intel.com,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1 3/8] ACPI: sysfs: use acpi_device_uid() for fetching _UID
Date: Fri, 20 Oct 2023 14:17:27 +0530
Message-Id: <20231020084732.17130-4-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231020084732.17130-1-raag.jadav@intel.com>
References: <20231020084732.17130-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

Convert manual _UID references to use standard ACPI helpers.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/acpi/device_sysfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
index b9bbf0746199..9d8e90744cb5 100644
--- a/drivers/acpi/device_sysfs.c
+++ b/drivers/acpi/device_sysfs.c
@@ -410,7 +410,7 @@ static ssize_t uid_show(struct device *dev,
 {
 	struct acpi_device *acpi_dev = to_acpi_device(dev);
 
-	return sprintf(buf, "%s\n", acpi_dev->pnp.unique_id);
+	return sprintf(buf, "%s\n", acpi_device_uid(acpi_dev));
 }
 static DEVICE_ATTR_RO(uid);
 
@@ -554,7 +554,7 @@ int acpi_device_setup_files(struct acpi_device *dev)
 
 	if (dev->pnp.type.bus_address)
 		result = device_create_file(&dev->dev, &dev_attr_adr);
-	if (dev->pnp.unique_id)
+	if (acpi_device_uid(dev))
 		result = device_create_file(&dev->dev, &dev_attr_uid);
 
 	if (acpi_has_method(dev->handle, "_SUN")) {
@@ -635,7 +635,7 @@ void acpi_device_remove_files(struct acpi_device *dev)
 	if (acpi_has_method(dev->handle, "_HRV"))
 		device_remove_file(&dev->dev, &dev_attr_hrv);
 
-	if (dev->pnp.unique_id)
+	if (acpi_device_uid(dev))
 		device_remove_file(&dev->dev, &dev_attr_uid);
 	if (dev->pnp.type.bus_address)
 		device_remove_file(&dev->dev, &dev_attr_adr);
-- 
2.17.1


