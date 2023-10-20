Return-Path: <linux-acpi+bounces-785-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9939D7D0D72
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Oct 2023 12:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53589280EB9
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Oct 2023 10:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0280D17981
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Oct 2023 10:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mFNw4VWF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A7C847D
	for <linux-acpi@vger.kernel.org>; Fri, 20 Oct 2023 08:48:28 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1900D55;
	Fri, 20 Oct 2023 01:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697791705; x=1729327705;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=pUffY3rZpA/Ma3FQvoHxe1V6N2z+ycJPoTJ6FPj6xDw=;
  b=mFNw4VWFCEKJxzxdn/4rHI+pg9qbQrr+bQ46f3focuCnMNRjviTjExV7
   ZEBBgqxmuOppAVzSZ3r9W//s79JgHeyRWlH9tvg8FYxn+Ye8BtIpJnOTW
   qXV8iZOC+4c90XjdOQBftd0suwRqs05Dc7qkHlZj3nZsCSc2o03Zi52RF
   4emVoD0luk2VR7IU6PE8FepiPndx15zxjGVqtfwiUcgJ9vxqvvRcfI2NV
   H503ny4lOVfWFLX7AHLhwdqUtbxCR4lT5vR4o4IF92+C34kk3NS5496TE
   QRLPj85d6cyQecYaOI2mvf5rm1ID5LQWFhE7LoRgstOfuUVBsz47zIIrD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="450683685"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="450683685"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 01:48:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="873832206"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="873832206"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by fmsmga002.fm.intel.com with ESMTP; 20 Oct 2023 01:48:21 -0700
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
Subject: [PATCH v1 8/8] perf: arm_cspmu: use acpi_dev_hid_uid_match() for matching _HID and _UID
Date: Fri, 20 Oct 2023 14:17:32 +0530
Message-Id: <20231020084732.17130-9-raag.jadav@intel.com>
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
 drivers/perf/arm_cspmu/arm_cspmu.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
index e2b7827c4563..f0e6d14281d6 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.c
+++ b/drivers/perf/arm_cspmu/arm_cspmu.c
@@ -1061,7 +1061,7 @@ static int arm_cspmu_request_irq(struct arm_cspmu *cspmu)
 
 static inline int arm_cspmu_find_cpu_container(int cpu, u32 container_uid)
 {
-	u32 acpi_uid;
+	u64 acpi_uid;
 	struct device *cpu_dev;
 	struct acpi_device *acpi_dev;
 
@@ -1071,10 +1071,8 @@ static inline int arm_cspmu_find_cpu_container(int cpu, u32 container_uid)
 
 	acpi_dev = ACPI_COMPANION(cpu_dev);
 	while (acpi_dev) {
-		if (!strcmp(acpi_device_hid(acpi_dev),
-			    ACPI_PROCESSOR_CONTAINER_HID) &&
-		    !kstrtouint(acpi_device_uid(acpi_dev), 0, &acpi_uid) &&
-		    acpi_uid == container_uid)
+		if (acpi_dev_hid_uid_match(acpi_dev, ACPI_PROCESSOR_CONTAINER_HID, NULL) &&
+		    !acpi_dev_uid_to_integer(acpi_dev, &acpi_uid) && acpi_uid == container_uid)
 			return 0;
 
 		acpi_dev = acpi_dev_parent(acpi_dev);
-- 
2.17.1


