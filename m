Return-Path: <linux-acpi+bounces-12694-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8F6A7A768
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Apr 2025 18:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 743C83B719B
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Apr 2025 16:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38F62528E8;
	Thu,  3 Apr 2025 16:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="efVUOZTZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D205F25179E;
	Thu,  3 Apr 2025 16:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743696058; cv=none; b=I1KDHxZddGkc2scNDD7VeUvNjWNhu0+iZe2ZXCMq7ilhE/O31tXs79kO+kjIK/swZ5LkVx6r1aUVA7rWZZTVy1Q5a7Jq2ATI7dvf4kqUqFlNOId1ODPUeKjHbdIyCx4UA8TtifTPFkWfRtOLS+s9EFRJS7TOqFtFLyOqO9bIR0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743696058; c=relaxed/simple;
	bh=XODY8LfdrBtTcIIHyGQ5a/GmoObL2peM0YKaifcX+Z0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZpNN9j184H62MiwCsKbmq59dazXLXL6/wS9PIGwjFjafvwQIULsphIZVjCZ04Cnae7TfQXJg9DdIakMKBrR9NMW/dW2m4TWpd4NL+L6bpUqSxGWPhqoggW79vsiafYSxc6ysgFltoWMUAZGn1rujzD+tQ+Go1ZRFvxsD71yPxDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=efVUOZTZ; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743696057; x=1775232057;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XODY8LfdrBtTcIIHyGQ5a/GmoObL2peM0YKaifcX+Z0=;
  b=efVUOZTZT4qHO5KOP3Bkut7PGhuGPcoCFkipOeIeSCFK3U/MyM0/pdsu
   tRWuiPlUiwAS2Ze3apPAsCAx98F005LMTE9CZwrvoemJ6LbzODoRoHYi4
   eypyB/e1YdzdtV9HZ9epXjd4i6BQJv3ycB3PFt2aeEMLl7EOUXrdFAZmJ
   1S9KbITf7FD8H63fSIOSCBVsxqQv9HzEO2e3pLduKusZ7Ely3F9l5k2yT
   Yrp5kmnnCd70ke48fnbxY0jD9NRNWbi60SOr0vy4CM8U55E6HlisrTpUT
   JLp/9IagQFnso8+9V75zI3Ww6swmuB34wv3g+KoCJMHzf6/J5IvYiEZIn
   A==;
X-CSE-ConnectionGUID: Id1E0ArfSyaZESThz5xHEg==
X-CSE-MsgGUID: nPH7LXQSS3CtYVCVV8Ywsg==
X-IronPort-AV: E=McAfee;i="6700,10204,11393"; a="44369247"
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="44369247"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2025 09:00:52 -0700
X-CSE-ConnectionGUID: 20RZYshrQnuU/FUkhE9Lfg==
X-CSE-MsgGUID: Cvuzk59KQf6orkTLlN2Jqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="158036305"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa001.fm.intel.com with ESMTP; 03 Apr 2025 09:00:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 6F7D4283; Thu, 03 Apr 2025 19:00:36 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mika Westerberg <westeri@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v2 6/6] gpiolib: acpi: Deduplicate some code in __acpi_find_gpio()
Date: Thu,  3 Apr 2025 18:59:17 +0300
Message-ID: <20250403160034.2680485-7-andriy.shevchenko@linux.intel.com>
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
 drivers/gpio/gpiolib-acpi.c | 101 +++++++++++++++++-------------------
 1 file changed, 48 insertions(+), 53 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index f44d25df15cb..b3fcb9d5a39f 100644
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
-	struct acpi_gpio_params *params = &lookup.params;
+	struct acpi_gpio_info *info = &lookup->info;
+	struct acpi_gpio_params *params = &lookup->params;
 	int ret;
 
-	memset(&lookup, 0, sizeof(lookup));
-	params->crs_entry_index = index;
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
 			params->crs_entry_index, params->line_index, params->active_low);
 	} else {
 		dev_dbg(&adev->dev, "GPIO: looking up %u in _CRS\n", params->crs_entry_index);
-		lookup.info.adev = adev;
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
-	struct acpi_gpio_params *params = &lookup.params;
 	int ret;
 
 	if (!is_acpi_data_node(fwnode))
-		return ERR_PTR(-ENODEV);
+		return -ENODEV;
 
 	if (!propname)
-		return ERR_PTR(-EINVAL);
+		return -EINVAL;
 
-	memset(&lookup, 0, sizeof(lookup));
-	params->crs_entry_index = index;
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
+	lookup.params.crs_entry_index = idx;
 
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


