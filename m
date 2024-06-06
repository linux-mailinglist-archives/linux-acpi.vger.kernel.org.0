Return-Path: <linux-acpi+bounces-6247-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF3528FF633
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jun 2024 22:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F287B1C2241E
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jun 2024 20:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7225C197A68;
	Thu,  6 Jun 2024 20:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n1NVa/OF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17D413A40F;
	Thu,  6 Jun 2024 20:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717707445; cv=none; b=q2mo4N2XTyB7chDsoH5Z0QJZxrM2fQxskLWmkMyaBy2yX3BbQ7Zb+Vojfrc9cReR2i5vfRgIr1fumoaqEkg/DTCrk1zq7EtYFbyBHXX0uTiCi1rmchQo0wjsxr84CVt0BziRighFUsFYv+w999LMWprZ+mtKUjbTjn1ecDhvpww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717707445; c=relaxed/simple;
	bh=LdMVV7VYjMW/QGtJELET0s9Ow3c8JeYwxFjxuDpdc1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ccWAwJ6gwll4NTHtdOk+z1kphp/1T4f1aHExF823qqcS13R3HJBzBThNLskgGAyLjHzPtpai/VuQ2WHSMs61A0dC2rpKWRNZ38xfjfkYkA6pKAIt51WhLEPIvjoRgHaw/QN849Y9l1BP8dYOnt17tRZgGPULCpssIA58vsB0FK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n1NVa/OF; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717707444; x=1749243444;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LdMVV7VYjMW/QGtJELET0s9Ow3c8JeYwxFjxuDpdc1I=;
  b=n1NVa/OFNJmqbCwvwTHnAlEr2uGX9r9tejZDIx5x3yzVuGZ/K1z0/hBZ
   3LNhTr0bHU/IVgqdTR3kE+9LVwAZTGhLQj0090DLeO4KqpRtxypJHzF2R
   0xNtdInqxnwaTrnJP3uyjpltBJb3hzuWCgKCwveIGMij5T59KuJiUO33A
   roPmySORCOo8p3NhvS9aWw06wmnrXO6Ys2Enzh9Bs/ZGp6iQttquceJzT
   S2cw2iiK0e8dYkEB4Xpuu10DmNune5UyDxwA3ABUfDTgfesbwfiNPe3qM
   GlzGG2bU3BzeK3geBbkeFQPMDUJWG7Gkt6nwWcdKDt4qNCFhu5u7rb3W7
   A==;
X-CSE-ConnectionGUID: eTsRbNaISamf2w24eWj59g==
X-CSE-MsgGUID: ufW2pL5jRBmQJO0eGyAcOA==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="25037096"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="25037096"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 13:57:21 -0700
X-CSE-ConnectionGUID: 520WyKoZReKiXykETOskaA==
X-CSE-MsgGUID: NUIPwQjTQZaMlnGwMWS0RA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="61304491"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa002.fm.intel.com with ESMTP; 06 Jun 2024 13:57:19 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 6B4A6F7; Thu, 06 Jun 2024 23:57:18 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v4 1/3] ACPI: PMIC: Use sizeof() instead of hard coded value
Date: Thu,  6 Jun 2024 23:54:14 +0300
Message-ID: <20240606205712.3187675-2-andriy.shevchenko@linux.intel.com>
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

It's better to use sizeof() of a given buffer than spreading
a hard coded value.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/acpi/pmic/intel_pmic_chtdc_ti.c | 2 +-
 drivers/acpi/pmic/intel_pmic_xpower.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/pmic/intel_pmic_chtdc_ti.c b/drivers/acpi/pmic/intel_pmic_chtdc_ti.c
index c84ef3d15181..35744a0307aa 100644
--- a/drivers/acpi/pmic/intel_pmic_chtdc_ti.c
+++ b/drivers/acpi/pmic/intel_pmic_chtdc_ti.c
@@ -87,7 +87,7 @@ static int chtdc_ti_pmic_get_raw_temp(struct regmap *regmap, int reg)
 {
 	u8 buf[2];
 
-	if (regmap_bulk_read(regmap, reg, buf, 2))
+	if (regmap_bulk_read(regmap, reg, buf, sizeof(buf)))
 		return -EIO;
 
 	/* stored in big-endian */
diff --git a/drivers/acpi/pmic/intel_pmic_xpower.c b/drivers/acpi/pmic/intel_pmic_xpower.c
index 61bbe4c24d87..33c5e85294cd 100644
--- a/drivers/acpi/pmic/intel_pmic_xpower.c
+++ b/drivers/acpi/pmic/intel_pmic_xpower.c
@@ -255,7 +255,7 @@ static int intel_xpower_pmic_get_raw_temp(struct regmap *regmap, int reg)
 	if (ret)
 		return ret;
 
-	ret = regmap_bulk_read(regmap, AXP288_GP_ADC_H, buf, 2);
+	ret = regmap_bulk_read(regmap, AXP288_GP_ADC_H, buf, sizeof(buf));
 	if (ret == 0)
 		ret = (buf[0] << 4) + ((buf[1] >> 4) & 0x0f);
 
-- 
2.43.0.rc1.1336.g36b5255a03ac


