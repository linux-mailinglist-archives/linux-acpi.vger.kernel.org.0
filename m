Return-Path: <linux-acpi+bounces-7663-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 746A1956C0B
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Aug 2024 15:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA5991F235B0
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Aug 2024 13:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E413177982;
	Mon, 19 Aug 2024 13:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FlnXAabl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1DA175D4A;
	Mon, 19 Aug 2024 13:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724073930; cv=none; b=nQv55uSYpeGgIP6cSTjX+Z2JwToMQnIPgZtQTG+NTh3XlTw2VllkYAAMMIBnamtPKk2L4kIKnxNNM1NxAJhHAIdNh9Oz66RMVFXswNLjGf80+jKXuANk+bMToBnRcHDLWvHWNlTdNfY3bfF1ygOKS5ONYZsqXuyXZ1VQZUbO6Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724073930; c=relaxed/simple;
	bh=Q5D2GX1ner8moRAIJYBQ51PVa6YVDkS1fzjLA4jX5WA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SFfjwbm1N4ScJjMORVc+3ev92ymRTvFpBV5SmG3Yzf5Z4pxmmFr0++zJOMlDzr3BChbqfwiuUaZUBQstG18Gknjr3gKO8RgFw8XA9AJMNs+mCXTYrEmnE8A7ZgE5GB5KBMojA9bzeMHYuM7fUhkUuj4cxTe1ShaFy0tRyMdwiVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FlnXAabl; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724073928; x=1755609928;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q5D2GX1ner8moRAIJYBQ51PVa6YVDkS1fzjLA4jX5WA=;
  b=FlnXAablCm90Jl1YjbUj5RbyQzQPEqid2fvQCL3F+fArVkj1/+CWzNFA
   LuhdRVFUYhF4ah3ZCBnh9viZmF1eA29O8P3ADpY5EV3Dk1jty9q8D83aL
   /35nnutLIbJm6pbtacSNQpV9UCFX+pq3PqiltLiUB5Bt7+t5fiB4ZlGyT
   WykR4swGb9LlGpyZxdh6tg+kQfKlG08s8R9RxFWkCRcpo7IKcKDkRZ5Ru
   hWfnlnnj4W/jENSXtM++Q2jLK0XiVNbfdfFeOl8wYBrYJpT8bRWtMcxrw
   IgBNvmPvk+njCWmSdJs173FvwtM6w2RyYUbC8TijMx7t/2h8fwvJwI+sK
   A==;
X-CSE-ConnectionGUID: Plo0/mCBRUyeR/joDBtt5Q==
X-CSE-MsgGUID: ZWd3A1RRTpOQNbQma/m/XQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="22462714"
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="22462714"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 06:25:06 -0700
X-CSE-ConnectionGUID: sM2BnpinS2ilSuwNje331g==
X-CSE-MsgGUID: HEK6gPpEQDeqsWvBSGZdPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="64531829"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa003.fm.intel.com with ESMTP; 19 Aug 2024 06:25:03 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 01515644; Mon, 19 Aug 2024 16:25:01 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v1 4/5] gpiolib: swnode: Make use of for_each_gpio_property_name()
Date: Mon, 19 Aug 2024 16:22:46 +0300
Message-ID: <20240819132458.208677-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240819132458.208677-1-andriy.shevchenko@linux.intel.com>
References: <20240819132458.208677-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For the sake of unification and easier maintenance replace
swnode_format_propname() call with for_each_gpio_property_name()
for-loop.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib-swnode.c | 38 +++++++++++++----------------------
 1 file changed, 14 insertions(+), 24 deletions(-)

diff --git a/drivers/gpio/gpiolib-swnode.c b/drivers/gpio/gpiolib-swnode.c
index 8dd3c1a5dc55..efcb4ae6eb26 100644
--- a/drivers/gpio/gpiolib-swnode.c
+++ b/drivers/gpio/gpiolib-swnode.c
@@ -24,20 +24,6 @@
 
 #define GPIOLIB_SWNODE_UNDEFINED_NAME "swnode-gpio-undefined"
 
-static void swnode_format_propname(const char *con_id, char *propname,
-				   size_t max_size)
-{
-	/*
-	 * NOTE: We do not need to try both -gpios and -gpio suffixes,
-	 * as, unlike OF and ACPI, we can fix software nodes to conform
-	 * to the proper binding.
-	 */
-	if (con_id)
-		snprintf(propname, max_size, "%s-gpios", con_id);
-	else
-		strscpy(propname, "gpios", max_size);
-}
-
 static struct gpio_device *swnode_get_gpio_device(struct fwnode_handle *fwnode)
 {
 	const struct software_node *gdev_node;
@@ -84,9 +70,11 @@ struct gpio_desc *swnode_find_gpio(struct fwnode_handle *fwnode,
 	if (!swnode)
 		return ERR_PTR(-EINVAL);
 
-	swnode_format_propname(con_id, propname, sizeof(propname));
-
-	ret = swnode_gpio_get_reference(fwnode, propname, idx, &args);
+	for_each_gpio_property_name(propname, con_id) {
+		ret = swnode_gpio_get_reference(fwnode, propname, idx, &args);
+		if (ret == 0)
+			break;
+	}
 	if (ret) {
 		pr_debug("%s: can't parse '%s' property of node '%pfwP[%d]'\n",
 			__func__, propname, fwnode, idx);
@@ -128,19 +116,21 @@ int swnode_gpio_count(const struct fwnode_handle *fwnode, const char *con_id)
 	char propname[32];
 	int count;
 
-	swnode_format_propname(con_id, propname, sizeof(propname));
-
 	/*
 	 * This is not very efficient, but GPIO lists usually have only
 	 * 1 or 2 entries.
 	 */
-	count = 0;
-	while (swnode_gpio_get_reference(fwnode, propname, count, &args) == 0) {
-		fwnode_handle_put(args.fwnode);
-		count++;
+	for_each_gpio_property_name(propname, con_id) {
+		count = 0;
+		while (swnode_gpio_get_reference(fwnode, propname, count, &args) == 0) {
+			fwnode_handle_put(args.fwnode);
+			count++;
+		}
+		if (count)
+			return count;
 	}
 
-	return count ?: -ENOENT;
+	return -ENOENT;
 }
 
 #if IS_ENABLED(CONFIG_GPIO_SWNODE_UNDEFINED)
-- 
2.43.0.rc1.1336.g36b5255a03ac


