Return-Path: <linux-acpi+bounces-14613-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E7FAE8B6A
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 19:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBEF616DF89
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 17:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B644F273D86;
	Wed, 25 Jun 2025 17:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UfMpBhrU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0863074AC;
	Wed, 25 Jun 2025 17:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750872100; cv=none; b=fKi1cQ2mjFB7RtF2S+jdkm74QBW5C5mldaVnRW0RTttZy7IFgQ3OGipuqSFJiu5mq1/iM6F9X+BZh577gQd68nh3DuQfOzljkNPczKccYWpOn4CZRkQaoyEgxcpWQEzLbszB6Qwy3isu5Wj/jZrYg4CywiEhq66vD8kG9PdpYwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750872100; c=relaxed/simple;
	bh=guG45DLvKX7AACz8OfWdkmWxPqo8CO0/Q4YdI51rwwE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pYQlIdt2tl7YkVd9PedKoFmSwMS56vK7lNuCHV6TboJ5vGxHeMPT6ssCO3h5PNWxM4KuWSFDpqysY0FYWv7HxOMItsM4KB+tGKoMDSqKuDSkCyolLOsintEMgP1Jpt0tvgAVnq1JTpsr/38bprJhKGpS04hepOxFDSqBucBQ5UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UfMpBhrU; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750872099; x=1782408099;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=guG45DLvKX7AACz8OfWdkmWxPqo8CO0/Q4YdI51rwwE=;
  b=UfMpBhrUPK957FORUY4C5y6WU6Hda8F895qBjJQ1NZAS5K6yoMYgmzmS
   cf2A89agZvBnS9X94cfl8am+Evjf8JzDv3UpZ6yDTYWA8sXbcoePFgtak
   E2Vcyvf24wDTAFiSXHJae2XS54ig795qCRcI69ue9fdQC4FtGO75vgPwN
   Wi63HJqpG1goQsEk0KApiQFBOw/w5jTCXC5p3Y7k49ymFlOSCB/qJ8Fek
   Q3fVSW4OARVNmB5DRPnRAfQy/0XJgRo8o6u1aXNGSpnwngR5ouTrbO4Is
   QWkZ9NTqG9TEfmwcxAIt4V900zzfTRtzJd/Sh6kQcJfc1Md+m+mQsIiMi
   g==;
X-CSE-ConnectionGUID: 4y1nprCcRuW8ENlm9abweQ==
X-CSE-MsgGUID: Yv1x17WNQZ+Sj31w64GiBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="70585840"
X-IronPort-AV: E=Sophos;i="6.16,265,1744095600"; 
   d="scan'208";a="70585840"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 10:21:38 -0700
X-CSE-ConnectionGUID: BaUGF/e/QZWgm2SVsBgBkg==
X-CSE-MsgGUID: iz7ZrVmsSwOZcWEB5acjGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,265,1744095600"; 
   d="scan'208";a="158035040"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa005.jf.intel.com with ESMTP; 25 Jun 2025 10:21:36 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 67C5027C; Wed, 25 Jun 2025 20:21:35 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] ACPI: LPSS: Remove AudioDSP related ID
Date: Wed, 25 Jun 2025 20:21:32 +0300
Message-ID: <20250625172133.3996325-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The AudioDSP drivers are in control for all functions of the hardware
they have (they are multi-functional devices). The LPSS driver prepares
for enumeration only single devices, such as DMA, UART, SPI, I²C. Hence
the registration of AudioDSP should not be covered. Moreover, the very
same ACPI _HID has been added by the catpt driver a few years ago.

And even more serious issue with this, is that the register window at
offset 0x800 is actually D-SRAM0 in case of AudioDSP and writing to it
is a data corruption.

That all being said, remove the AudioDSP ID from the LPSS driver,
where it doesn't belong to.

Fixes: fb94b7b11c6a ("ASoC: Intel: Remove SST firmware components")
Fixes: 05668be1b364 ("ASoC: Intel: Remove SST ACPI component")
Fixes: 7a10b66a5df9 ("ASoC: Intel: catpt: Device driver lifecycle")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/x86/lpss.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/acpi/x86/lpss.c b/drivers/acpi/x86/lpss.c
index 258440b899a9..6daa6372f980 100644
--- a/drivers/acpi/x86/lpss.c
+++ b/drivers/acpi/x86/lpss.c
@@ -387,9 +387,6 @@ static const struct acpi_device_id acpi_lpss_device_ids[] = {
 	{ "INT3435", LPSS_ADDR(lpt_uart_dev_desc) },
 	{ "INT3436", LPSS_ADDR(lpt_sdio_dev_desc) },
 
-	/* Wildcat Point LPSS devices */
-	{ "INT3438", LPSS_ADDR(lpt_spi_dev_desc) },
-
 	{ }
 };
 
-- 
2.47.2


