Return-Path: <linux-acpi+bounces-12648-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 478F2A78E4A
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Apr 2025 14:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A89418979F0
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Apr 2025 12:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E60A23AE70;
	Wed,  2 Apr 2025 12:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LLtc0UWx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F07C23A562;
	Wed,  2 Apr 2025 12:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743596592; cv=none; b=aURXfeHzxEicVu78SeX3VSvzxq7OxZp9weB7UTXlJkzhy/XPf6Zj4N8TWknxfxm6/L0V4KAnpHqkV5EsbSsALnGhYWgL1LTbAzZUgt34C3eAL7qunU4mNxn7St6PQ4Pv6z9NMzQLdBCw6dXZYnnFkn+ScYr4Sm8Hb4WA/CW8TZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743596592; c=relaxed/simple;
	bh=KhR+Pky0mFIa3pNQqaREuTbEmqI6wQSqKz8nfeHdwdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=klEqxNMZu6f6Wa8BQza1ipKHfiSpBV4pwKTBc+rAaSPxXRgjASeR+2SdW17rrMuEV3nvTmXqTZz5T4IT+1oVOR98vHm4B1P8G6WRObHLGSdD5qiWj11V86wz/CAfUHXhUR/TBsjUY5KMko24xG8S7lNbD2jDjvW3PuRYLGWmGUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LLtc0UWx; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743596592; x=1775132592;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KhR+Pky0mFIa3pNQqaREuTbEmqI6wQSqKz8nfeHdwdk=;
  b=LLtc0UWxduq1OFjEM7KfaRAnffm/FHSd2VnztKgfNG3X5OATFSkiFBNE
   h43IUqhFakirwyl3PLIJE2pHMfo00odJzEAqGaqQ3pCaDqka3L0dsLVZz
   8MRnzZu2cohkRNIgO+Whm9gOh+Hn1D35PCHwPtJKjJpXJ67ckNP3E7a5R
   3b8O01z7rz+nMfcv0xT4MXFE1E038uxgG0gmsG+Jwr9YJTs4cB3lvhSyd
   ruMRu8yb8Ipe8tFQr6fPfe9gZiof1VFBlQMOVfBnsCiG6IQ1bJXnq70NV
   bcUr7JVC1t9LsIETOCCdGyrqM48X5DYPhWoMYahnPd3/vjbAIod1It/Vz
   A==;
X-CSE-ConnectionGUID: QGQI4gPfTNCfAJuOcHmxPw==
X-CSE-MsgGUID: tKOuz7N6QJmSMOtEdpHl/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="44865046"
X-IronPort-AV: E=Sophos;i="6.15,182,1739865600"; 
   d="scan'208";a="44865046"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 05:23:07 -0700
X-CSE-ConnectionGUID: NpNW/DtrQOKquOEGygrJuQ==
X-CSE-MsgGUID: 2YCFpDCtRdeTBRarn2hWXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,182,1739865600"; 
   d="scan'208";a="157635539"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 02 Apr 2025 05:23:05 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 68EB32B9; Wed, 02 Apr 2025 15:23:03 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mika Westerberg <westeri@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v1 3/5] gpiolib: acpi: Reduce memory footprint for struct acpi_gpio_params
Date: Wed,  2 Apr 2025 15:21:18 +0300
Message-ID: <20250402122301.1517463-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250402122301.1517463-1-andriy.shevchenko@linux.intel.com>
References: <20250402122301.1517463-1-andriy.shevchenko@linux.intel.com>
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


