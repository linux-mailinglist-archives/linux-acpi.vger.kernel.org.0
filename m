Return-Path: <linux-acpi+bounces-7667-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B58C4956D41
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Aug 2024 16:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A696282845
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Aug 2024 14:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79AAC17332A;
	Mon, 19 Aug 2024 14:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eDNn3/XC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4201E170A3A;
	Mon, 19 Aug 2024 14:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724077796; cv=none; b=L48MlPc1TN6dTW2s8Rj/9UaAVpklUTp65jK0aqz3E6632/NqfJ93eyEOaY8wGPTMyTKDIAjecweLruvcrdzZuPLzzOIED/HTvdvLD+XkMqF0FeA2Y9c5TXeGZkoPkE+Py3ZuoGpLxRJ0yWoD7WEEa6VD6+hROcw2S/ADHyxvpn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724077796; c=relaxed/simple;
	bh=C5ACBFQpLuJg+E8NQQggc4sxL+G3zBv8J5W1Xd3/EE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KY1P4WEi77uPTQOZN7dOtNMEMDKPb3Vwku89LybUB4UdQWnALkF29wr/IuDGeur2xTznFAg1cvr/OVKZ2UvxU4gCBVL48a/k24yjX2rPKtIlIeGDMZds4NZzBah1O5JuYy1ETA+I7FdJgMqo3QwactOgst9O8D5bx67CjE6XIhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eDNn3/XC; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724077793; x=1755613793;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=C5ACBFQpLuJg+E8NQQggc4sxL+G3zBv8J5W1Xd3/EE8=;
  b=eDNn3/XC4ABuBcgLAm2j5VIHKcT6bdR6x1z0mAKV20eIpRPx75UzPrUL
   tRx4XS7DZgdVZSCW+yNXVVZR8Jhbia+QpBFzp0XiBSzw6Fqsf0FLbOTH1
   pBDcFKPnyTWW+F5LOQ5/UG8Hj1WaK6P0FMVNsl0Y2d6Tm1FBvceO95XCy
   OvIhWCJ51iSH2bDT6kGPdQ1lnsss3OLDywsQs6DMcXZZ68UkQjlwx/dYp
   Ex2dm26ClZP09ddxdMD8kJq8MReW5elMMMAxt2VynSNichNmOUIgK+Hsz
   dKbunUvbOkIEv+v4uK/zZX1/yaF+rDRCsgitMBQJGelOM1Xi0giT0Y3SN
   Q==;
X-CSE-ConnectionGUID: UhhUZH6bQYKTRk4XiraWHw==
X-CSE-MsgGUID: TP0Us7F6Qzmxo3v8r7zDBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="21873813"
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="21873813"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 07:29:52 -0700
X-CSE-ConnectionGUID: XDeB6+l6TzqxXwjYJatz4w==
X-CSE-MsgGUID: BhpVxZ/ETmSJjQ6p5+421g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="65350560"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 19 Aug 2024 07:29:51 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 2D498213; Mon, 19 Aug 2024 17:29:49 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v2 1/5] gpiolib: Introduce for_each_gpio_property_name() helper
Date: Mon, 19 Aug 2024 17:28:56 +0300
Message-ID: <20240819142945.327808-2-andriy.shevchenko@linux.intel.com>
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

Introduce a helper macro for_each_gpio_property_name().
With that in place, update users. This, in particular,
will help making the following simplifications easier.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib-acpi.c | 21 ++-------------------
 drivers/gpio/gpiolib-of.c   | 25 ++++---------------------
 drivers/gpio/gpiolib.h      | 13 +++++++++++++
 3 files changed, 19 insertions(+), 40 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 69cd2be9c7f3..cf4b1f068bac 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -973,18 +973,9 @@ __acpi_find_gpio(struct fwnode_handle *fwnode, const char *con_id, unsigned int
 	struct acpi_device *adev = to_acpi_device_node(fwnode);
 	struct gpio_desc *desc;
 	char propname[32];
-	int i;
 
 	/* Try first from _DSD */
-	for (i = 0; i < gpio_suffix_count; i++) {
-		if (con_id) {
-			snprintf(propname, sizeof(propname), "%s-%s",
-				 con_id, gpio_suffixes[i]);
-		} else {
-			snprintf(propname, sizeof(propname), "%s",
-				 gpio_suffixes[i]);
-		}
-
+	for_each_gpio_property_name(propname, con_id) {
 		if (adev)
 			desc = acpi_get_gpiod_by_index(adev,
 						       propname, idx, info);
@@ -1450,17 +1441,9 @@ int acpi_gpio_count(const struct fwnode_handle *fwnode, const char *con_id)
 	int count = -ENOENT;
 	int ret;
 	char propname[32];
-	unsigned int i;
 
 	/* Try first from _DSD */
-	for (i = 0; i < gpio_suffix_count; i++) {
-		if (con_id)
-			snprintf(propname, sizeof(propname), "%s-%s",
-				 con_id, gpio_suffixes[i]);
-		else
-			snprintf(propname, sizeof(propname), "%s",
-				 gpio_suffixes[i]);
-
+	for_each_gpio_property_name(propname, con_id) {
 		ret = acpi_dev_get_property(adev, propname, ACPI_TYPE_ANY, &obj);
 		if (ret == 0) {
 			if (obj->type == ACPI_TYPE_LOCAL_REFERENCE)
diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 6683e531df52..92984f6d2aa8 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -97,20 +97,12 @@ int of_gpio_count(const struct fwnode_handle *fwnode, const char *con_id)
 	const struct device_node *np = to_of_node(fwnode);
 	int ret;
 	char propname[32];
-	unsigned int i;
 
 	ret = of_gpio_spi_cs_get_count(np, con_id);
 	if (ret > 0)
 		return ret;
 
-	for (i = 0; i < gpio_suffix_count; i++) {
-		if (con_id)
-			snprintf(propname, sizeof(propname), "%s-%s",
-				 con_id, gpio_suffixes[i]);
-		else
-			snprintf(propname, sizeof(propname), "%s",
-				 gpio_suffixes[i]);
-
+	for_each_gpio_property_name(propname, con_id) {
 		ret = of_gpio_named_count(np, propname);
 		if (ret > 0)
 			break;
@@ -687,23 +679,14 @@ static const of_find_gpio_quirk of_find_gpio_quirks[] = {
 struct gpio_desc *of_find_gpio(struct device_node *np, const char *con_id,
 			       unsigned int idx, unsigned long *flags)
 {
-	char prop_name[32]; /* 32 is max size of property name */
+	char propname[32]; /* 32 is max size of property name */
 	enum of_gpio_flags of_flags;
 	const of_find_gpio_quirk *q;
 	struct gpio_desc *desc;
-	unsigned int i;
 
 	/* Try GPIO property "foo-gpios" and "foo-gpio" */
-	for (i = 0; i < gpio_suffix_count; i++) {
-		if (con_id)
-			snprintf(prop_name, sizeof(prop_name), "%s-%s", con_id,
-				 gpio_suffixes[i]);
-		else
-			snprintf(prop_name, sizeof(prop_name), "%s",
-				 gpio_suffixes[i]);
-
-		desc = of_get_named_gpiod_flags(np, prop_name, idx, &of_flags);
-
+	for_each_gpio_property_name(propname, con_id) {
+		desc = of_get_named_gpiod_flags(np, propname, idx, &of_flags);
 		if (!gpiod_not_found(desc))
 			break;
 	}
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index 4de0bf1a62d3..0271e747fb6e 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -93,6 +93,19 @@ static inline struct gpio_device *to_gpio_device(struct device *dev)
 extern const char *const gpio_suffixes[];
 extern const size_t gpio_suffix_count;
 
+#define for_each_gpio_property_name(propname, con_id)					\
+	for (unsigned int __i = 0;							\
+	     __i < gpio_suffix_count && ({						\
+		     const char *__gs = gpio_suffixes[__i];				\
+											\
+		if (con_id)								\
+			snprintf(propname, sizeof(propname), "%s-%s", con_id, __gs);	\
+		else									\
+			snprintf(propname, sizeof(propname), "%s", __gs);		\
+		1;									\
+	     });									\
+	     __i++)
+
 /**
  * struct gpio_array - Opaque descriptor for a structure of GPIO array attributes
  *
-- 
2.43.0.rc1.1336.g36b5255a03ac


