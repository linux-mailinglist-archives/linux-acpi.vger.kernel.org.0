Return-Path: <linux-acpi+bounces-12644-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE2EA78E2F
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Apr 2025 14:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39DAC7A27F1
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Apr 2025 12:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D82238D2E;
	Wed,  2 Apr 2025 12:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TjhJ0zT0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3712356AB;
	Wed,  2 Apr 2025 12:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743596588; cv=none; b=Sry3xQqkipCVJCtHOAjkrZ+BA1mPU4XHFTRz/Ua6XYR5RKqwJyWzUmHDssDoa0uUhAcQ9u7fKrWKsImq4RHAabbKOwm0xd2TxN9sBEbvrLst359p41Izp06JYjCyqeYokMEDfLRv68dnHczHE0+R16EzaG7M7ajn+IMeAajugGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743596588; c=relaxed/simple;
	bh=jrQuqRPZTLRY/Nv4wjP8wiHYwDHsodAh6RSZDaxljOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LKU+T32mSafDmM14YybpaKnFq39tLVAMm60tZbycxLP7lW6Dh45TElHXbffPztoUAYVUaonogRRQoWZfvSH5i236cLy0pkuexj2TULBgRpHrEjsnnTrh70h9FD5VEoRfihlqUzsvkXm2fjlmZT5Dldek6oav5zz6KLKDby3U5UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TjhJ0zT0; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743596587; x=1775132587;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jrQuqRPZTLRY/Nv4wjP8wiHYwDHsodAh6RSZDaxljOA=;
  b=TjhJ0zT0Km3lLyIPt5zqZ0N8KOBWO8ybNLcL1G9H8Xx85rvay0FaWGLR
   3ouy4aJk98jGVPbwHdz7AQx1bjsbus6XwJPggZ6C032HgWebjijg8+n9i
   sVPPbfNHAtoLcq5BRZ/2peTNsgfBfJBytTXGOaJYaTMLvOeNjxxwkX4zG
   VHwtZRCu1W7e15/hVpOL8neNWdpLJGoPdVoPgQTaa+FEdDDQMOlN/HqBB
   OYdm+V8yDjqgoVQTOL8MJzxGhW+vp6g2UvNRhOhOJxOhsQDws6bMDBWUT
   ZAjmOD7YYd26LirEPeGgqbOs+28tTpBWxMafAmvWtWKL453rsl+pc/GMV
   w==;
X-CSE-ConnectionGUID: YEahfclmTBysQWaARrbT/w==
X-CSE-MsgGUID: FLDrPTH9RAqmilNwInep1Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="44104530"
X-IronPort-AV: E=Sophos;i="6.15,182,1739865600"; 
   d="scan'208";a="44104530"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 05:23:06 -0700
X-CSE-ConnectionGUID: ss7ZNeBlRhKHvpd1/tEbwA==
X-CSE-MsgGUID: JBaTt+7QRqWAk6a/fiZEVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,182,1739865600"; 
   d="scan'208";a="149872337"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa002.fm.intel.com with ESMTP; 02 Apr 2025 05:23:04 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 745794B0; Wed, 02 Apr 2025 15:23:03 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mika Westerberg <westeri@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v1 4/5] gpiolib: acpi: Reuse struct acpi_gpio_params in struct acpi_gpio_lookup
Date: Wed,  2 Apr 2025 15:21:19 +0300
Message-ID: <20250402122301.1517463-5-andriy.shevchenko@linux.intel.com>
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

Some of the contents of struct acpi_gpio_lookup repeats what we have
in the struct acpi_gpio_params. Reuse the latter in the former.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib-acpi.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index afeb8d1c7102..750724601106 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -744,9 +744,7 @@ static int acpi_gpio_update_gpiod_lookup_flags(unsigned long *lookupflags,
 
 struct acpi_gpio_lookup {
 	struct acpi_gpio_info info;
-	int index;
-	u16 pin_index;
-	bool active_low;
+	struct acpi_gpio_params par;
 	struct gpio_desc *desc;
 	int n;
 };
@@ -754,6 +752,7 @@ struct acpi_gpio_lookup {
 static int acpi_populate_gpio_lookup(struct acpi_resource *ares, void *data)
 {
 	struct acpi_gpio_lookup *lookup = data;
+	struct acpi_gpio_params *par = &lookup->par;
 
 	if (ares->type != ACPI_RESOURCE_TYPE_GPIO)
 		return 1;
@@ -765,12 +764,12 @@ static int acpi_populate_gpio_lookup(struct acpi_resource *ares, void *data)
 		u16 pin_index;
 
 		if (lookup->info.quirks & ACPI_GPIO_QUIRK_ONLY_GPIOIO && gpioint)
-			lookup->index++;
+			par->crs_entry_index++;
 
-		if (lookup->n++ != lookup->index)
+		if (lookup->n++ != par->crs_entry_index)
 			return 1;
 
-		pin_index = lookup->pin_index;
+		pin_index = par->line_index;
 		if (pin_index >= agpio->pin_table_length)
 			return 1;
 
@@ -796,7 +795,7 @@ static int acpi_populate_gpio_lookup(struct acpi_resource *ares, void *data)
 			lookup->info.polarity = agpio->polarity;
 			lookup->info.triggering = agpio->triggering;
 		} else {
-			lookup->info.polarity = lookup->active_low;
+			lookup->info.polarity = par->active_low;
 		}
 
 		lookup->info.flags = acpi_gpio_to_gpiod_flags(agpio, lookup->info.polarity);
@@ -834,7 +833,8 @@ static int acpi_gpio_property_lookup(struct fwnode_handle *fwnode, const char *p
 				     struct acpi_gpio_lookup *lookup)
 {
 	struct fwnode_reference_args args;
-	unsigned int index = lookup->index;
+	struct acpi_gpio_params *par = &lookup->par;
+	unsigned int index = par->crs_entry_index;
 	unsigned int quirks = 0;
 	int ret;
 
@@ -857,9 +857,9 @@ static int acpi_gpio_property_lookup(struct fwnode_handle *fwnode, const char *p
 	if (args.nargs != 3)
 		return -EPROTO;
 
-	lookup->index = args.args[0];
-	lookup->pin_index = args.args[1];
-	lookup->active_low = !!args.args[2];
+	par->crs_entry_index = args.args[0];
+	par->line_index = args.args[1];
+	par->active_low = !!args.args[2];
 
 	lookup->info.adev = to_acpi_device_node(args.fwnode);
 	lookup->info.quirks = quirks;
@@ -897,10 +897,11 @@ static struct gpio_desc *acpi_get_gpiod_by_index(struct acpi_device *adev,
 						 struct acpi_gpio_info *info)
 {
 	struct acpi_gpio_lookup lookup;
+	struct acpi_gpio_params *par = &lookup.par;
 	int ret;
 
 	memset(&lookup, 0, sizeof(lookup));
-	lookup.index = index;
+	par->crs_entry_index = index;
 
 	if (propname) {
 		dev_dbg(&adev->dev, "GPIO: looking up %s\n", propname);
@@ -909,9 +910,9 @@ static struct gpio_desc *acpi_get_gpiod_by_index(struct acpi_device *adev,
 		if (ret)
 			return ERR_PTR(ret);
 
-		dev_dbg(&adev->dev, "GPIO: _DSD returned %s %d %u %u\n",
-			dev_name(&lookup.info.adev->dev), lookup.index,
-			lookup.pin_index, lookup.active_low);
+		dev_dbg(&adev->dev, "GPIO: _DSD returned %s %u %u %u\n",
+			dev_name(&lookup.info.adev->dev),
+			par->crs_entry_index, par->line_index, par->active_low);
 	} else {
 		dev_dbg(&adev->dev, "GPIO: looking up %d in _CRS\n", index);
 		lookup.info.adev = adev;
@@ -943,6 +944,7 @@ static struct gpio_desc *acpi_get_gpiod_from_data(struct fwnode_handle *fwnode,
 						  struct acpi_gpio_info *info)
 {
 	struct acpi_gpio_lookup lookup;
+	struct acpi_gpio_params *par = &lookup.par;
 	int ret;
 
 	if (!is_acpi_data_node(fwnode))
@@ -952,7 +954,7 @@ static struct gpio_desc *acpi_get_gpiod_from_data(struct fwnode_handle *fwnode,
 		return ERR_PTR(-EINVAL);
 
 	memset(&lookup, 0, sizeof(lookup));
-	lookup.index = index;
+	par->crs_entry_index = index;
 
 	ret = acpi_gpio_property_lookup(fwnode, propname, &lookup);
 	if (ret)
-- 
2.47.2


