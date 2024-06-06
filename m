Return-Path: <linux-acpi+bounces-6248-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1989C8FF634
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jun 2024 22:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C20771F285FE
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jun 2024 20:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B4E198E99;
	Thu,  6 Jun 2024 20:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lWd8iso7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2C6196449;
	Thu,  6 Jun 2024 20:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717707446; cv=none; b=kmNOkekVFwQKmfMMbuQ6yQamhLkRU7o21JWD//m3RBIrMZEkZP6LwoQQ87j7fVy0wO+MKcIHDH0tpAMwyDYvcwXeQ9L5M9kD/SuvRGEhgN1DkqUbek6dVWIEeGLFEtNN9NQLPHNJ7SASFNK8/KS8ZVfYrbc6LFUzNEy6DZZm/YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717707446; c=relaxed/simple;
	bh=0YDydmrLM+QcJt9k0PKK2l8blVDYOm5Dy8R+sDL5ZoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vm6/Pc6qLmMkMZs7kVdV/5h4Il5PAvhStQ/eDr+2zFpomPwwc4Rha5xHW8T+hlWTc5zft9S4fLSC5Ig5NZM1gnHomkWTZRfckkLWSmm2EXt2zCbOGBYM+5DSBsOAogdMPkO3MXeqL7gqs3/0U1IiLLxIlN1HgcVCMncQEgkzPNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lWd8iso7; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717707444; x=1749243444;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0YDydmrLM+QcJt9k0PKK2l8blVDYOm5Dy8R+sDL5ZoU=;
  b=lWd8iso7ncPBVMDHPDZqSm1UdXabLd9DS4MIHLkz040N/JkG5mj5bRR4
   mFOkTpqC4ylpO4NNnwMD5YbNtyTZTqOfUt12v+5kKhUCeyW1nfmhtLtLY
   iUqj7EzQdKura++P687bqkNqOH1QIYM9b5syrHtcnrtBvHaiWQeil85pj
   ude6C3oKRHakHzFZGoLqLekUmPyFfq2AARCa0U9Mhc38VhEcXxNAWvrM0
   2jXbn5e+9p2WlTT3A/ntcGt+F7mfgHmyTR565cczVgAfQY0kYYS7NGrG5
   hNCKBPpRASue4cW2LCXwyZrCQedbzHSXy/hoTj/hsgOUOlJiOhgZdFXx9
   A==;
X-CSE-ConnectionGUID: PHsBnh2LSACVk+4Ir8lLpQ==
X-CSE-MsgGUID: acCcdXXKQXCQh+jrZcwqPw==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="25037103"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="25037103"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 13:57:21 -0700
X-CSE-ConnectionGUID: eCSDLjILRbWzkLQGw6eCCQ==
X-CSE-MsgGUID: oRLCIz2TRByKgYpSFipjnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="61304490"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa002.fm.intel.com with ESMTP; 06 Jun 2024 13:57:19 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 82B4F30B; Thu, 06 Jun 2024 23:57:18 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v4 3/3] ACPI: PMIC: Replace open coded be16_to_cpu()
Date: Thu,  6 Jun 2024 23:54:16 +0300
Message-ID: <20240606205712.3187675-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240606205712.3187675-1-andriy.shevchenko@linux.intel.com>
References: <20240606205712.3187675-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's easier to understand the nature of a data type when
it's written explicitly. With that, replace open coded
endianess conversion.

As a side effect it fixes the returned value of
intel_crc_pmic_update_aux() since ACPI PMIC core code
expects negative or zero and never uses positive one.

While at it, use macros from bits.h to reduce a room for mistake.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/acpi/pmic/intel_pmic_chtdc_ti.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/pmic/intel_pmic_chtdc_ti.c b/drivers/acpi/pmic/intel_pmic_chtdc_ti.c
index 35744a0307aa..79f9df552524 100644
--- a/drivers/acpi/pmic/intel_pmic_chtdc_ti.c
+++ b/drivers/acpi/pmic/intel_pmic_chtdc_ti.c
@@ -8,12 +8,16 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/bits.h>
 #include <linux/init.h>
 #include <linux/mfd/intel_soc_pmic.h>
 #include <linux/platform_device.h>
+#include <asm/byteorder.h>
 #include "intel_pmic.h"
 
 /* registers stored in 16bit BE (high:low, total 10bit) */
+#define PMIC_REG_MASK		GENMASK(9, 0)
+
 #define CHTDC_TI_VBAT		0x54
 #define CHTDC_TI_DIETEMP	0x56
 #define CHTDC_TI_BPTHERM	0x58
@@ -73,7 +77,7 @@ static int chtdc_ti_pmic_get_power(struct regmap *regmap, int reg, int bit,
 	if (regmap_read(regmap, reg, &data))
 		return -EIO;
 
-	*value = data & 1;
+	*value = data & BIT(0);
 	return 0;
 }
 
@@ -85,13 +89,12 @@ static int chtdc_ti_pmic_update_power(struct regmap *regmap, int reg, int bit,
 
 static int chtdc_ti_pmic_get_raw_temp(struct regmap *regmap, int reg)
 {
-	u8 buf[2];
+	__be16 buf;
 
-	if (regmap_bulk_read(regmap, reg, buf, sizeof(buf)))
+	if (regmap_bulk_read(regmap, reg, &buf, sizeof(buf)))
 		return -EIO;
 
-	/* stored in big-endian */
-	return ((buf[0] & 0x03) << 8) | buf[1];
+	return be16_to_cpu(buf) & PMIC_REG_MASK;
 }
 
 static const struct intel_pmic_opregion_data chtdc_ti_pmic_opregion_data = {
-- 
2.43.0.rc1.1336.g36b5255a03ac


