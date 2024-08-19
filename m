Return-Path: <linux-acpi+bounces-7668-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9182956D44
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Aug 2024 16:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 542DD1F23760
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Aug 2024 14:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECB11741D4;
	Mon, 19 Aug 2024 14:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D1dYFuA0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7968C1714CA;
	Mon, 19 Aug 2024 14:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724077797; cv=none; b=kr0+5Y2L35p8d5xhLvzxDNoXvzSA8lR5Lq5H7mtSihk9r/UM7ELYYxJGrdgKjn3kjSN8gvSnwizW12n1J1UD/hlQM5aFWy1CDkUbIUsbb2m6dvZnLgEjWG8Wgkoix7xSKpJfpTLBNym8vEJKss5kKhuVIaJwJRDL/LTwheYa4Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724077797; c=relaxed/simple;
	bh=DXf/668hEJFBZCZunwJNVzH/sOB3Oy72nRMF+xG4+GA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M12dLwnBBcZVYRZFkC6weALQTZPFL0Z2AhgtbcAPBbbMyG90lCziSzrMuyijsa4hKF8sNe9roh/o4zV0ibzrcKE04errtpNN9+9OWXA7E+BrDt6scVJkeSCOA5yAkh9TneXC5268QTrC6ReL8s9oQCOY8fz4e9w3OwErrS9ZsKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D1dYFuA0; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724077796; x=1755613796;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DXf/668hEJFBZCZunwJNVzH/sOB3Oy72nRMF+xG4+GA=;
  b=D1dYFuA0siPW1iqE5BPJ9Qj4ETP4Ul8dCIfCqLgf5WL6q5cVQoAVh/QY
   J+HystNQZauHqvOwiKrqru8D4EkKl0AanKivoQtYXCdKGrTTPhnQXcQJv
   a4N/VIsY3Y/22mOaYyiyYLDo3lHIo8aSwM9hBHYbRLQsQe1idQ+3y6zhB
   mDs4RHD3C0KHc7Utnppiw2Os1Uy7ZuBmYFUiEYKTYNqIDIo+ny7x3kuPM
   t7LHdfMXOl/XVZy0ZltQCt5XLK6rZpgD+O01MzG+5MdjuPSiJ74PHJkZW
   g+vC6AD3eTmOjKCABVypVm/9Px1MLvKbvmuAn8PxVyFLbhMB1Y9q1VjC5
   g==;
X-CSE-ConnectionGUID: j5evXee+Q0qGZG4NCjGMfQ==
X-CSE-MsgGUID: zMMCPVFQTIqiVCBHx6+0iQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="33744488"
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="33744488"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 07:29:53 -0700
X-CSE-ConnectionGUID: +rVE+JrdSz+xh3+O2E2nBQ==
X-CSE-MsgGUID: CDQpmSeXS7SACr0ZKkSdoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="64783795"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP; 19 Aug 2024 07:29:50 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 5A32F562; Mon, 19 Aug 2024 17:29:49 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v2 4/5] gpiolib: swnode: Make use of for_each_gpio_property_name()
Date: Mon, 19 Aug 2024 17:28:59 +0300
Message-ID: <20240819142945.327808-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240819142945.327808-1-andriy.shevchenko@linux.intel.com>
References: <20240819142945.327808-1-andriy.shevchenko@linux.intel.com>
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
index d5e58a9673b5..1a6f70671816 100644
--- a/drivers/gpio/gpiolib-swnode.c
+++ b/drivers/gpio/gpiolib-swnode.c
@@ -24,20 +24,6 @@
 
 #define GPIOLIB_SWNODE_UNDEFINED_NAME "swnode-gpio-undefined"
 
-static void swnode_format_propname(const char *con_id, char *propname,
-				   size_t max_size)
-{
-	/*
-	 * Note we do not need to try both -gpios and -gpio suffixes,
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


