Return-Path: <linux-acpi+bounces-7662-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3106956C07
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Aug 2024 15:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAC2D28411F
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Aug 2024 13:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26EB175D5E;
	Mon, 19 Aug 2024 13:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FFh769ZY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0B617554A;
	Mon, 19 Aug 2024 13:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724073928; cv=none; b=Sh1ELrDzboF/g+dYhdtqgwPUGF5798R/kykOWgq3cmgWmljwgU99YeJe5CyVM+qEzL+B8zKbQbnw0d57Xupfxt9igu2Gyqu5goaF0VaWMsLay9+TXawncyYu7SEG1cWNsCq87V4q7KetWqGhHunWDDzRjSA+iFojw36fHRy7QJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724073928; c=relaxed/simple;
	bh=MjquhYEVqBOB758biJCcHGoD0iH6FoBsUzxobOaKxQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tZpT7X17kITEVIJ7IKWz9wY9yq3/t5UN8ll+07MhOZ+3bn574TOjPAH3VW2B8P8MPL3Q+Ic9XedlaNESumQK/+2+BCRDRjQELLnph7GUsJIXETDgNAnpBMQWYFx1tesmwu2QDyLsGHNtqvVfMRpXyMRBJCNz71VRfr88XHxv/+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FFh769ZY; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724073927; x=1755609927;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MjquhYEVqBOB758biJCcHGoD0iH6FoBsUzxobOaKxQs=;
  b=FFh769ZYRpf8r+YbaCXaZlouKlsVXdFPCvfYwZqensNROXQE9AEoHTLd
   RH2Qt60Fc7DZcbMqU3xQNh1BHX10gu0JuqY7l8783HXtuoElDiBVkn7jA
   +f3ZldFXWm8DRc2JAiySCtrSbNTwwHHKJkPC1+g5Mlc22wGphSDW6ufOt
   FvnDK8YNJ0TIDA/CbpUbymRcCxC6ix13HnQTwnHb5gthuLj+eLXNb3cg7
   zJ27WD52Aofh2+x5zzOqdPyt5u2l8GR9qAgmfUtOAVm2gKJocyrQJXeSE
   YgNzq8CBVCsM4W3rk/EvOqv68TO7r8Oef95/5gcU+cB5ipmmEWL2xnCq7
   Q==;
X-CSE-ConnectionGUID: hB9vcjwoTq+ZrDTiaFTbcw==
X-CSE-MsgGUID: rJT3pyJdRLSQLTIhhU3R4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="22462704"
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="22462704"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 06:25:05 -0700
X-CSE-ConnectionGUID: 6vf8TilSSWW8DumG35lcEw==
X-CSE-MsgGUID: zEdpsENLTX2hXxiZADmf3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="64531826"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa003.fm.intel.com with ESMTP; 19 Aug 2024 06:25:02 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id D05BF213; Mon, 19 Aug 2024 16:25:01 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v1 1/5] gpiolib: Introduce for_each_gpio_property_name() helper
Date: Mon, 19 Aug 2024 16:22:43 +0300
Message-ID: <20240819132458.208677-2-andriy.shevchenko@linux.intel.com>
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
index 70f029de63e6..d2fb69d227f4 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -983,18 +983,9 @@ __acpi_find_gpio(struct fwnode_handle *fwnode, const char *con_id, unsigned int
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
@@ -1461,17 +1452,9 @@ int acpi_gpio_count(const struct fwnode_handle *fwnode, const char *con_id)
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
index 006218cf9fc6..da4cab615013 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -105,20 +105,12 @@ int of_gpio_count(const struct fwnode_handle *fwnode, const char *con_id)
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
@@ -696,23 +688,14 @@ static const of_find_gpio_quirk of_find_gpio_quirks[] = {
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
index 5b545fd7b2c6..d38e83d82796 100644
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


