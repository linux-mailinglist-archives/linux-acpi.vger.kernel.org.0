Return-Path: <linux-acpi+bounces-12692-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B3AA7A767
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Apr 2025 18:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 844B43B7194
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Apr 2025 16:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E1B25179D;
	Thu,  3 Apr 2025 16:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OfUtCzvv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3581D251786;
	Thu,  3 Apr 2025 16:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743696056; cv=none; b=bJ9HA8Mk7AAInpReSXyhbni2r4cjebNwhAIGKUhRlQPq3qz6HCTUs62WyDtg5LB09O7a+HjHEo9izsWb4ZmMgU5xmsnGWrD5Z90kPT6PexgH48NvFcW8q9wycG/rMq7/2MUOknQiswUow2rNvL2D9w9K9Pab9gCGm6irCtXP6YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743696056; c=relaxed/simple;
	bh=vjI5klfXDk5T17g4Xw3ZZiIo7UPS2209JJJrsDjn1iI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QyX3V+P+AOHHurNA4CuGlEvAmWdA20XAuDE1uMGQdQp++aeusnBLSWJepBzQprxQ2pBeAp5HoK3CedZUi2ptJNlOP8cwr1Qn6bAsCQeXcz7+Ac5rLsxGitfu/ZwmNtJMxc2QGXiy5Vswa7jgHWZH5rcnHLK1S3sWGABvAPkQcPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OfUtCzvv; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743696055; x=1775232055;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vjI5klfXDk5T17g4Xw3ZZiIo7UPS2209JJJrsDjn1iI=;
  b=OfUtCzvvzZLQnk7pHtMhZLNGUpKOVes6sxFTb4jQ08/+JE7jjCxQCVlJ
   kMZA/9Xdfj7a5enWjOwvyZfMC8fLvw9O3WkzSXI1IgJZI1ipNQI2RoJqQ
   2pzInQp550ek3wrsmAP55RmuaLnIydolIxbZ7lRr2wBX9HIWk1kmB6yot
   sdtjV4UH+EDq3XxBPulyu/I1K4UEn5fNc0+gE2KrmEFcv4t6XKml/58VA
   8ONfSMzlVBtawPGR5Fzo5Ozb2yaLKNTff7fgxOocPXnQX7dATE/IN0Y8y
   Bi6T0adsNCNQ5pcOrysHJOLOGxOvOlLdL2uDozgmr7FHuv4Pnt2+etfE9
   g==;
X-CSE-ConnectionGUID: WjTBo1VMQ1uwVelVC/fDKA==
X-CSE-MsgGUID: INwv4u2OQreTJ92X5glQ2g==
X-IronPort-AV: E=McAfee;i="6700,10204,11393"; a="44369243"
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="44369243"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2025 09:00:52 -0700
X-CSE-ConnectionGUID: dbHragxiS2C12LDSG0jNPg==
X-CSE-MsgGUID: L9hMbCSHTeKpUxJfCa8FqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="158036301"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa001.fm.intel.com with ESMTP; 03 Apr 2025 09:00:37 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 47F2F22A; Thu, 03 Apr 2025 19:00:36 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mika Westerberg <westeri@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v2 3/6] gpiolib: acpi: Reduce memory footprint for struct acpi_gpio_params
Date: Thu,  3 Apr 2025 18:59:14 +0300
Message-ID: <20250403160034.2680485-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250403160034.2680485-1-andriy.shevchenko@linux.intel.com>
References: <20250403160034.2680485-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The line_index member in the struct acpi_gpio_params replicates
what is covered in the ACPI GpioIo() or GpioInt() resource.
The value there is limited to 16-bit one, so we don't really need
to have a full 32-bit storage for it. Together with followed
boolean the structure will be smaller.

add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-3 (-3)
Function                                     old     new   delta
acpi_gpio_property_lookup                    417     414      -3
Total: Before=15361, After=15358, chg -0.02%

`pahole` difference before and after:

-	/* size: 12, cachelines: 1, members: 3 */
-	/* padding: 3 */

+	/* size: 8, cachelines: 1, members: 3 */
+	/* padding: 1 */

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/gpio/consumer.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index 45b651c05b9c..899179972bec 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -587,7 +587,7 @@ struct gpio_desc *devm_fwnode_gpiod_get(struct device *dev,
 
 struct acpi_gpio_params {
 	unsigned int crs_entry_index;
-	unsigned int line_index;
+	unsigned short line_index;
 	bool active_low;
 };
 
-- 
2.47.2


