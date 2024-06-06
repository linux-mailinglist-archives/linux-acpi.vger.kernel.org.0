Return-Path: <linux-acpi+bounces-6246-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B07058FF62E
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jun 2024 22:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4601CB21F20
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jun 2024 20:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABD013B583;
	Thu,  6 Jun 2024 20:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NxvaJO12"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BDB4AEC3;
	Thu,  6 Jun 2024 20:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717707443; cv=none; b=mq5bgdEE+R14ho0MdDNG2Qn03nk0Jl7P7vfxdGgMDhuOx5kWxUpdFJHIY5dGCmQPLCEd7obGZoqfa0Q6yIkkAr9rlEf8TprcYIw8hkoLa39fkOMz3wZnIElF+p9B4ZeBceaFSRhpKBqj/xrDBrK1RS4768foFSagd3Kudh6PR20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717707443; c=relaxed/simple;
	bh=ngr0dpqQ8SleCp2Ne5jcEzrIZLckdn+bTl/6fh4gbMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nKTvRpby7Wz0fJDYV5Umh5yYbJobP70oeT2WyHgBsp+Se5VTmA42icFF6jjekgcRqLxfUtq47DZZihOfUiGXMbvHo7L0X60CANJPMPJehwbfimAdn25uhFTKB5GZdQ0uJpmBBkIPLDuXlNlo+FVh3SbplH+UhDFHIZ+9yjlsf44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NxvaJO12; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717707442; x=1749243442;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ngr0dpqQ8SleCp2Ne5jcEzrIZLckdn+bTl/6fh4gbMk=;
  b=NxvaJO12v+K0kZ6nzamqKiDqRBOVbKB45gFWo6lKLccEXTNCI4v/EEIu
   pUYYeQnHQ7L9Eq2Ti6u70kiuw9BPzW4gVbh+ZrM8PrsHfXBHby6+d9SYl
   FmpPRld9BhY2s9zpYVHM6l3kqD/nPHogZDeUfBYE8jC3xpdc/2PAdKlnP
   5O56BaQLMe1SIFbjRb2s/aDHod6Yfhw8rM/Pw/6dT6SYzaFanfhepSdRL
   qlmXY2adSHhv2uUC1/BzCW9j7TRelyoaYod1bSa7qOlzlQ4gyTdfTefrQ
   PStXaMApG5FiXVV7ZissCgSSiahb9L1twLN+VjESL5mwnmQCFx2raKeT1
   w==;
X-CSE-ConnectionGUID: 1qiVjW8UQD6li1L/w0iItA==
X-CSE-MsgGUID: 6ze5cL8gTRCjmweb5tUWcQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="25812556"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="25812556"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 13:57:22 -0700
X-CSE-ConnectionGUID: KdjEOdf4QaaOLJMA4lwAxg==
X-CSE-MsgGUID: zjgdXO7wSFKo6stZcuLx7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="75570843"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa001.jf.intel.com with ESMTP; 06 Jun 2024 13:57:20 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 75BE52CF; Thu, 06 Jun 2024 23:57:18 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v4 2/3] ACPI: PMIC: Convert pr_*() to dev_*() printing macros
Date: Thu,  6 Jun 2024 23:54:15 +0300
Message-ID: <20240606205712.3187675-3-andriy.shevchenko@linux.intel.com>
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

Since we have a device pointer in the regmap, use it for
error messages.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/acpi/pmic/intel_pmic_chtwc.c  | 5 +++--
 drivers/acpi/pmic/intel_pmic_xpower.c | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/pmic/intel_pmic_chtwc.c b/drivers/acpi/pmic/intel_pmic_chtwc.c
index f2c42f4c79ca..25aa3e33b09a 100644
--- a/drivers/acpi/pmic/intel_pmic_chtwc.c
+++ b/drivers/acpi/pmic/intel_pmic_chtwc.c
@@ -236,11 +236,12 @@ static int intel_cht_wc_exec_mipi_pmic_seq_element(struct regmap *regmap,
 						   u32 reg_address,
 						   u32 value, u32 mask)
 {
+	struct device *dev = regmap_get_device(regmap);
 	u32 address;
 
 	if (i2c_client_address > 0xff || reg_address > 0xff) {
-		pr_warn("%s warning addresses too big client 0x%x reg 0x%x\n",
-			__func__, i2c_client_address, reg_address);
+		dev_warn(dev, "warning addresses too big client 0x%x reg 0x%x\n",
+			 i2c_client_address, reg_address);
 		return -ERANGE;
 	}
 
diff --git a/drivers/acpi/pmic/intel_pmic_xpower.c b/drivers/acpi/pmic/intel_pmic_xpower.c
index 33c5e85294cd..43c5850b4bf3 100644
--- a/drivers/acpi/pmic/intel_pmic_xpower.c
+++ b/drivers/acpi/pmic/intel_pmic_xpower.c
@@ -274,11 +274,12 @@ static int intel_xpower_exec_mipi_pmic_seq_element(struct regmap *regmap,
 						   u16 i2c_address, u32 reg_address,
 						   u32 value, u32 mask)
 {
+	struct device *dev = regmap_get_device(regmap);
 	int ret;
 
 	if (i2c_address != 0x34) {
-		pr_err("%s: Unexpected i2c-addr: 0x%02x (reg-addr 0x%x value 0x%x mask 0x%x)\n",
-		       __func__, i2c_address, reg_address, value, mask);
+		dev_err(dev, "Unexpected i2c-addr: 0x%02x (reg-addr 0x%x value 0x%x mask 0x%x)\n",
+			i2c_address, reg_address, value, mask);
 		return -ENXIO;
 	}
 
-- 
2.43.0.rc1.1336.g36b5255a03ac


