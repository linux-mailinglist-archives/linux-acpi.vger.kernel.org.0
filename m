Return-Path: <linux-acpi+bounces-12649-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 579FAA78E4E
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Apr 2025 14:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EE753B517C
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Apr 2025 12:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7332123BCFD;
	Wed,  2 Apr 2025 12:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PvRjJ+/L"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED4423A98F;
	Wed,  2 Apr 2025 12:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743596593; cv=none; b=ldpS1n1IRGC3Qks8Y5oIXW0p2Z0Xs66TBuPx5K937dvYmCOWDODoZY36jVjLfhGjfy6vCtHiClUPUtLv9Ov1Me4P0TvhriSovm3gWiSQivvKe7kJnWk1ltMshimym4zwIlBGc1SEJQX5/co7Let/z2bj4rR2SVeX41QmBRcuTeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743596593; c=relaxed/simple;
	bh=ipW7SukMx+y4OYBPi1rirqi+iPYrDFo8757SlZ1abVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=foKKQ0KH1a1tmhWtFZvWMeRAK/T+O0WL2vloPAYFch0sZ3LQST+gkjzhSo1VW8p51NXuX5YnPxLctz7H+HBphlPo/OzhcxfZ82wC6Z8ltmVZRcWAQc/YGjzdymGNWKN47UKrQaXv1LTNjcVz1cFrYPv+8XUtmLcfKZM4+mQvSJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PvRjJ+/L; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743596592; x=1775132592;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ipW7SukMx+y4OYBPi1rirqi+iPYrDFo8757SlZ1abVc=;
  b=PvRjJ+/Len21IgzbPBU9jMWsaCE/TduAPe32MNAhjJfWveWGgmy2gQoU
   n6CDkXzvgtt2tfxblZsmKu9QH5kCRsFyfomXzMNJa/1bcTNcUN15UP5oq
   nxf+m/CX3gHOPIBIg4skF8RoxS3K/7ooneV9l16uIWxlEhY0xSSZESTxd
   2d64kuCciqk/cMcR7qUUYumoEeSfrNWM+pwNsEoswkNzXqFX55R3ZqI4+
   H2SBSLdJQXPTiaSlpAJXG1bX6KQQdrtr9Dcg4jrlJekImq0+TIz7FMk2y
   Qin6IeZfYm5VZ5OvnM7ECWWzNDJc0qCYNe6rmFLs2lg6UuyuQdKMk0Lg2
   Q==;
X-CSE-ConnectionGUID: 3iLmoYUuS4qBxuosFrARFA==
X-CSE-MsgGUID: vrbLpepmS9Cx6BNS2V763w==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="44865054"
X-IronPort-AV: E=Sophos;i="6.15,182,1739865600"; 
   d="scan'208";a="44865054"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 05:23:10 -0700
X-CSE-ConnectionGUID: wM3iTc2ITBevt+9P9ReMjQ==
X-CSE-MsgGUID: Y+IjvnIMTXCANZURAb0Jtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,182,1739865600"; 
   d="scan'208";a="157635548"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 02 Apr 2025 05:23:08 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 804CB597; Wed, 02 Apr 2025 15:23:03 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mika Westerberg <westeri@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v1 5/5] gpiolib: acpi: Deduplicate some code in __acpi_find_gpio()
Date: Wed,  2 Apr 2025 15:21:20 +0300
Message-ID: <20250402122301.1517463-6-andriy.shevchenko@linux.intel.com>
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

__acpi_find_gpio() calls two functions depending on the supplied con_id
and possibility to fallback to _CRS lookup. Those functions have the same
pieces of code that can be done only in one place. Do it so.

This gives an impressive shrink of the generated code for x86_64:

add/remove: 0/2 grow/shrink: 0/4 up/down: 0/-1204 (-1204)
Function                                     old     new   delta
acpi_find_gpio.__UNIQUE_ID_ddebug478          56       -     -56
acpi_dev_gpio_irq_wake_get_by.__UNIQUE_ID_ddebug480      56       -     -56
acpi_find_gpio                               354     216    -138
acpi_get_gpiod_by_index                      456     307    -149
__acpi_find_gpio                             877     638    -239
acpi_dev_gpio_irq_wake_get_by                695     129    -566
Total: Before=15358, After=14154, chg -7.84%

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib-acpi.c | 103 +++++++++++++++++-------------------
 1 file changed, 49 insertions(+), 54 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 750724601106..5c6ef419f875 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -804,8 +804,7 @@ static int acpi_populate_gpio_lookup(struct acpi_resource *ares, void *data)
 	return 1;
 }
 
-static int acpi_gpio_resource_lookup(struct acpi_gpio_lookup *lookup,
-				     struct acpi_gpio_info *info)
+static int acpi_gpio_resource_lookup(struct acpi_gpio_lookup *lookup)
 {
 	struct acpi_device *adev = lookup->info.adev;
 	struct list_head res_list;
@@ -824,8 +823,6 @@ static int acpi_gpio_resource_lookup(struct acpi_gpio_lookup *lookup,
 	if (!lookup->desc)
 		return -ENOENT;
 
-	if (info)
-		*info = lookup->info;
 	return 0;
 }
 
@@ -871,97 +868,83 @@ static int acpi_gpio_property_lookup(struct fwnode_handle *fwnode, const char *p
  * acpi_get_gpiod_by_index() - get a GPIO descriptor from device resources
  * @adev: pointer to a ACPI device to get GPIO from
  * @propname: Property name of the GPIO (optional)
- * @index: index of GpioIo/GpioInt resource (starting from %0)
- * @info: info pointer to fill in (optional)
+ * @lookup: pointer to struct acpi_gpio_lookup to fill in
  *
- * Function goes through ACPI resources for @adev and based on @index looks
+ * Function goes through ACPI resources for @adev and based on @lookup.index looks
  * up a GpioIo/GpioInt resource, translates it to the Linux GPIO descriptor,
- * and returns it. @index matches GpioIo/GpioInt resources only so if there
- * are total %3 GPIO resources, the index goes from %0 to %2.
+ * and returns it. @lookup.index matches GpioIo/GpioInt resources only so if there
+ * are total 3 GPIO resources, the index goes from 0 to 2.
  *
  * If @propname is specified the GPIO is looked using device property. In
  * that case @index is used to select the GPIO entry in the property value
  * (in case of multiple).
  *
  * Returns:
- * GPIO descriptor to use with Linux generic GPIO API.
- * If the GPIO cannot be translated or there is an error an ERR_PTR is
- * returned.
+ * 0 on success, negative errno on failure.
+ *
+ * The @lookup is filled with GPIO descriptor to use with Linux generic GPIO API.
+ * If the GPIO cannot be translated an error will be returned.
  *
  * Note: if the GPIO resource has multiple entries in the pin list, this
  * function only returns the first.
  */
-static struct gpio_desc *acpi_get_gpiod_by_index(struct acpi_device *adev,
-						 const char *propname,
-						 int index,
-						 struct acpi_gpio_info *info)
+static int acpi_get_gpiod_by_index(struct acpi_device *adev, const char *propname,
+				   struct acpi_gpio_lookup *lookup)
 {
-	struct acpi_gpio_lookup lookup;
-	struct acpi_gpio_params *par = &lookup.par;
+	struct acpi_gpio_info *info = &lookup->info;
+	struct acpi_gpio_params *par = &lookup->par;
 	int ret;
 
-	memset(&lookup, 0, sizeof(lookup));
-	par->crs_entry_index = index;
-
 	if (propname) {
 		dev_dbg(&adev->dev, "GPIO: looking up %s\n", propname);
 
-		ret = acpi_gpio_property_lookup(acpi_fwnode_handle(adev), propname, &lookup);
+		ret = acpi_gpio_property_lookup(acpi_fwnode_handle(adev), propname, lookup);
 		if (ret)
-			return ERR_PTR(ret);
+			return ret;
 
 		dev_dbg(&adev->dev, "GPIO: _DSD returned %s %u %u %u\n",
-			dev_name(&lookup.info.adev->dev),
+			dev_name(&info->adev->dev),
 			par->crs_entry_index, par->line_index, par->active_low);
 	} else {
-		dev_dbg(&adev->dev, "GPIO: looking up %d in _CRS\n", index);
-		lookup.info.adev = adev;
+		dev_dbg(&adev->dev, "GPIO: looking up %u in _CRS\n", par->crs_entry_index);
+		info->adev = adev;
 	}
 
-	ret = acpi_gpio_resource_lookup(&lookup, info);
-	return ret ? ERR_PTR(ret) : lookup.desc;
+	return acpi_gpio_resource_lookup(lookup);
 }
 
 /**
  * acpi_get_gpiod_from_data() - get a GPIO descriptor from ACPI data node
  * @fwnode: pointer to an ACPI firmware node to get the GPIO information from
  * @propname: Property name of the GPIO
- * @index: index of GpioIo/GpioInt resource (starting from %0)
- * @info: info pointer to fill in (optional)
+ * @lookup: pointer to struct acpi_gpio_lookup to fill in
  *
  * This function uses the property-based GPIO lookup to get to the GPIO
  * resource with the relevant information from a data-only ACPI firmware node
  * and uses that to obtain the GPIO descriptor to return.
  *
  * Returns:
- * GPIO descriptor to use with Linux generic GPIO API.
- * If the GPIO cannot be translated or there is an error an ERR_PTR is
- * returned.
+ * 0 on success, negative errno on failure.
+ *
+ * The @lookup is filled with GPIO descriptor to use with Linux generic GPIO API.
+ * If the GPIO cannot be translated an error will be returned.
  */
-static struct gpio_desc *acpi_get_gpiod_from_data(struct fwnode_handle *fwnode,
-						  const char *propname,
-						  int index,
-						  struct acpi_gpio_info *info)
+static int acpi_get_gpiod_from_data(struct fwnode_handle *fwnode, const char *propname,
+				    struct acpi_gpio_lookup *lookup)
 {
-	struct acpi_gpio_lookup lookup;
-	struct acpi_gpio_params *par = &lookup.par;
 	int ret;
 
 	if (!is_acpi_data_node(fwnode))
-		return ERR_PTR(-ENODEV);
+		return -ENODEV;
 
 	if (!propname)
-		return ERR_PTR(-EINVAL);
+		return -EINVAL;
 
-	memset(&lookup, 0, sizeof(lookup));
-	par->crs_entry_index = index;
-
-	ret = acpi_gpio_property_lookup(fwnode, propname, &lookup);
+	ret = acpi_gpio_property_lookup(fwnode, propname, lookup);
 	if (ret)
-		return ERR_PTR(ret);
+		return ret;
 
-	ret = acpi_gpio_resource_lookup(&lookup, info);
-	return ret ? ERR_PTR(ret) : lookup.desc;
+	return acpi_gpio_resource_lookup(lookup);
 }
 
 static bool acpi_can_fallback_to_crs(struct acpi_device *adev,
@@ -983,17 +966,24 @@ __acpi_find_gpio(struct fwnode_handle *fwnode, const char *con_id, unsigned int
 		 bool can_fallback, struct acpi_gpio_info *info)
 {
 	struct acpi_device *adev = to_acpi_device_node(fwnode);
+	struct acpi_gpio_lookup lookup;
 	struct gpio_desc *desc;
 	char propname[32];
+	int ret;
+
+	memset(&lookup, 0, sizeof(lookup));
+	lookup.par.crs_entry_index = idx;
 
 	/* Try first from _DSD */
 	for_each_gpio_property_name(propname, con_id) {
 		if (adev)
-			desc = acpi_get_gpiod_by_index(adev,
-						       propname, idx, info);
+			ret = acpi_get_gpiod_by_index(adev, propname, &lookup);
 		else
-			desc = acpi_get_gpiod_from_data(fwnode,
-							propname, idx, info);
+			ret = acpi_get_gpiod_from_data(fwnode, propname, &lookup);
+		if (ret)
+			continue;
+
+		desc = lookup.desc;
 		if (PTR_ERR(desc) == -EPROBE_DEFER)
 			return desc;
 
@@ -1002,8 +992,13 @@ __acpi_find_gpio(struct fwnode_handle *fwnode, const char *con_id, unsigned int
 	}
 
 	/* Then from plain _CRS GPIOs */
-	if (can_fallback)
-		return acpi_get_gpiod_by_index(adev, NULL, idx, info);
+	if (can_fallback) {
+		ret = acpi_get_gpiod_by_index(adev, NULL, &lookup);
+		if (ret)
+			return ERR_PTR(ret);
+
+		return lookup.desc;
+	}
 
 	return ERR_PTR(-ENOENT);
 }
-- 
2.47.2


