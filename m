Return-Path: <linux-acpi+bounces-868-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 072A87D4787
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 08:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C4D1280F86
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 06:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51E014277
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 06:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="miF0FbPh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176611FB5
	for <linux-acpi@vger.kernel.org>; Tue, 24 Oct 2023 06:21:19 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EDEC198D;
	Mon, 23 Oct 2023 23:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698128468; x=1729664468;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=3yrAjMBirTIUAhTanyYbEMtK/J+a0HZi5Xr6F7vjCTw=;
  b=miF0FbPhdv5nYzlLy0kqL4U9Ht1eIN9TUbxeWYzWUAj8NLBbubmAtYd0
   tqdC7qcyQyF0PKiOECZWaqWEYhGAFdcFMDv9jvX11U2723r87V1XM+QYR
   yRPjVHL/ifs2bQ5y1p926bgZyC8G6tX95D2SRf2+NK38c+5cnvXkSJ+2A
   JGRTG3blE1fgLt8G8BG7gTDYnVF3znaL7kNHtJPjOfHRVFoS5uq2cFBJx
   ABUi4KN7fAdQelCFfZN0azsvBgDjOg3NnlyG7CUvF74lWlMkrXO6RYDQY
   YJsW3FzXaO4O1BlYxn2WSm8rhMC81azS9rExPUYhWWV8OF14QmIBj0aiX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="386806618"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="386806618"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 23:21:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="751891479"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="751891479"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by orsmga007.jf.intel.com with ESMTP; 23 Oct 2023 23:21:03 -0700
From: Raag Jadav <raag.jadav@intel.com>
To: rafael@kernel.org,
	len.brown@intel.com,
	robert.moore@intel.com,
	mika.westerberg@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	mark.rutland@arm.com,
	will@kernel.org,
	linux@roeck-us.net,
	Jonathan.Cameron@Huawei.com
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	acpica-devel@lists.linuxfoundation.org,
	linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-hwmon@vger.kernel.org,
	mallikarjunappa.sangannavar@intel.com,
	bala.senthil@intel.com,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v3 6/6] perf: arm_cspmu: use acpi_dev_hid_uid_match() for matching _HID and _UID
Date: Tue, 24 Oct 2023 11:50:18 +0530
Message-Id: <20231024062018.23839-7-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231024062018.23839-1-raag.jadav@intel.com>
References: <20231024062018.23839-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

Convert manual _UID references to use the standard ACPI helpers.

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


