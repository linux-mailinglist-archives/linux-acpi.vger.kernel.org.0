Return-Path: <linux-acpi+bounces-12688-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7AEA7A75D
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Apr 2025 18:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D62D1896B7C
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Apr 2025 16:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FC624E018;
	Thu,  3 Apr 2025 16:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="emFq9L13"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E673149C4A;
	Thu,  3 Apr 2025 16:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743696047; cv=none; b=dYD5y0aLqhqaH6WfN5GgIU/q8rEyVrQvMXo+4/a9BJ4wEQb8QpHN8Xm1ZoIo4KqE2KddSYAnxlUxNiaXAbXBiLUonznVTHXMMiGMiVv3TTdzDb04wvn3XWvjoUvMQm77TcrJXycdbmF2mBsY9QIC3hydwQ1TxboFEqBoPZwHTN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743696047; c=relaxed/simple;
	bh=LRKHiTtshFgZNPJAnBtQFUQlju7HJJJmlBxX+E467Rk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U2+jAqoS7qPLizdSI2b4Zhtng9LJNNg83D5aMEi0KXzbOQ8DmxuT/X4L1pgA+egR1eahsqAQzN2obWGgzDcGVC+Ltbx14XRHuz044KqlBcU0Nxs36UIPkit7660/NF2p95x5qGOLpteDoWpnJhBlLPbJ+PCRsx1hdGhy1MHE1S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=emFq9L13; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743696045; x=1775232045;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LRKHiTtshFgZNPJAnBtQFUQlju7HJJJmlBxX+E467Rk=;
  b=emFq9L13ouZ/xrrO6iEYGo6OTKimakJaa6zdbxbHp6tl4iHs2tIhusax
   dKYU2V1C8OAqT0kB9Le8hlUoIAN4Aw9+1bidX6KLxBimkE7Xn6SO0N5zm
   deFkRGJdCyppbAMw67O7W4L+go4F+qlTMzB2tGy9eXfZqitUvGh+hnSE0
   q07yUXKosralcTFI8+0a44c5STFoooM3/skLd5rDy0sGuYs2KatVq5UvJ
   2m1aUNIP8MV7AzhjRFyxYma7PlMPEN9NCubbVLjjtJpD2vYGjyesFAQog
   HTWplFQJ/WLm6Y/GzRKzNwxvGnYGu2Y0EqQDR2zUhAMC3U1FQeQB3nVVx
   g==;
X-CSE-ConnectionGUID: wmu0i06mShu3hetYVdT6ng==
X-CSE-MsgGUID: 3pGfKlitQtClay2FLIeydA==
X-IronPort-AV: E=McAfee;i="6700,10204,11393"; a="62651612"
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="62651612"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2025 09:00:43 -0700
X-CSE-ConnectionGUID: bxS8qnZDTXmXnLH8gNkq1A==
X-CSE-MsgGUID: x23ln8zdQyqUV+IHsuR3hA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="132029475"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 03 Apr 2025 09:00:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 5F9C726F; Thu, 03 Apr 2025 19:00:36 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mika Westerberg <westeri@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v2 5/6] gpiolib: acpi: Reuse struct acpi_gpio_params in struct acpi_gpio_lookup
Date: Thu,  3 Apr 2025 18:59:16 +0300
Message-ID: <20250403160034.2680485-6-andriy.shevchenko@linux.intel.com>
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

Some of the contents of struct acpi_gpio_lookup repeats what we have
in the struct acpi_gpio_params. Reuse the latter in the former.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib-acpi.c | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index d6e9563d9364..f44d25df15cb 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -744,9 +744,7 @@ static int acpi_gpio_update_gpiod_lookup_flags(unsigned long *lookupflags,
 
 struct acpi_gpio_lookup {
 	struct acpi_gpio_info info;
-	int index;
-	u16 pin_index;
-	bool active_low;
+	struct acpi_gpio_params params;
 	struct gpio_desc *desc;
 	int n;
 };
@@ -754,6 +752,7 @@ struct acpi_gpio_lookup {
 static int acpi_populate_gpio_lookup(struct acpi_resource *ares, void *data)
 {
 	struct acpi_gpio_lookup *lookup = data;
+	struct acpi_gpio_params *params = &lookup->params;
 
 	if (ares->type != ACPI_RESOURCE_TYPE_GPIO)
 		return 1;
@@ -765,12 +764,12 @@ static int acpi_populate_gpio_lookup(struct acpi_resource *ares, void *data)
 		u16 pin_index;
 
 		if (lookup->info.quirks & ACPI_GPIO_QUIRK_ONLY_GPIOIO && gpioint)
-			lookup->index++;
+			params->crs_entry_index++;
 
-		if (lookup->n++ != lookup->index)
+		if (lookup->n++ != params->crs_entry_index)
 			return 1;
 
-		pin_index = lookup->pin_index;
+		pin_index = params->line_index;
 		if (pin_index >= agpio->pin_table_length)
 			return 1;
 
@@ -796,7 +795,7 @@ static int acpi_populate_gpio_lookup(struct acpi_resource *ares, void *data)
 			lookup->info.polarity = agpio->polarity;
 			lookup->info.triggering = agpio->triggering;
 		} else {
-			lookup->info.polarity = lookup->active_low;
+			lookup->info.polarity = params->active_low;
 		}
 
 		lookup->info.flags = acpi_gpio_to_gpiod_flags(agpio, lookup->info.polarity);
@@ -834,7 +833,8 @@ static int acpi_gpio_property_lookup(struct fwnode_handle *fwnode, const char *p
 				     struct acpi_gpio_lookup *lookup)
 {
 	struct fwnode_reference_args args;
-	unsigned int index = lookup->index;
+	struct acpi_gpio_params *params = &lookup->params;
+	unsigned int index = params->crs_entry_index;
 	unsigned int quirks = 0;
 	int ret;
 
@@ -857,9 +857,9 @@ static int acpi_gpio_property_lookup(struct fwnode_handle *fwnode, const char *p
 	if (args.nargs != 3)
 		return -EPROTO;
 
-	lookup->index = args.args[0];
-	lookup->pin_index = args.args[1];
-	lookup->active_low = !!args.args[2];
+	params->crs_entry_index = args.args[0];
+	params->line_index = args.args[1];
+	params->active_low = !!args.args[2];
 
 	lookup->info.adev = to_acpi_device_node(args.fwnode);
 	lookup->info.quirks = quirks;
@@ -897,10 +897,11 @@ static struct gpio_desc *acpi_get_gpiod_by_index(struct acpi_device *adev,
 						 struct acpi_gpio_info *info)
 {
 	struct acpi_gpio_lookup lookup;
+	struct acpi_gpio_params *params = &lookup.params;
 	int ret;
 
 	memset(&lookup, 0, sizeof(lookup));
-	lookup.index = index;
+	params->crs_entry_index = index;
 
 	if (propname) {
 		dev_dbg(&adev->dev, "GPIO: looking up %s\n", propname);
@@ -909,11 +910,11 @@ static struct gpio_desc *acpi_get_gpiod_by_index(struct acpi_device *adev,
 		if (ret)
 			return ERR_PTR(ret);
 
-		dev_dbg(&adev->dev, "GPIO: _DSD returned %s %d %u %u\n",
-			dev_name(&lookup.info.adev->dev), lookup.index,
-			lookup.pin_index, lookup.active_low);
+		dev_dbg(&adev->dev, "GPIO: _DSD returned %s %u %u %u\n",
+			dev_name(&lookup.info.adev->dev),
+			params->crs_entry_index, params->line_index, params->active_low);
 	} else {
-		dev_dbg(&adev->dev, "GPIO: looking up %d in _CRS\n", index);
+		dev_dbg(&adev->dev, "GPIO: looking up %u in _CRS\n", params->crs_entry_index);
 		lookup.info.adev = adev;
 	}
 
@@ -943,6 +944,7 @@ static struct gpio_desc *acpi_get_gpiod_from_data(struct fwnode_handle *fwnode,
 						  struct acpi_gpio_info *info)
 {
 	struct acpi_gpio_lookup lookup;
+	struct acpi_gpio_params *params = &lookup.params;
 	int ret;
 
 	if (!is_acpi_data_node(fwnode))
@@ -952,7 +954,7 @@ static struct gpio_desc *acpi_get_gpiod_from_data(struct fwnode_handle *fwnode,
 		return ERR_PTR(-EINVAL);
 
 	memset(&lookup, 0, sizeof(lookup));
-	lookup.index = index;
+	params->crs_entry_index = index;
 
 	ret = acpi_gpio_property_lookup(fwnode, propname, &lookup);
 	if (ret)
-- 
2.47.2


