Return-Path: <linux-acpi+bounces-7671-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3254956D4D
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Aug 2024 16:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32C9B1C231FE
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Aug 2024 14:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806C7178CDE;
	Mon, 19 Aug 2024 14:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bPpJDkbB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1566175562;
	Mon, 19 Aug 2024 14:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724077800; cv=none; b=Ot+tPSO0wmxp2LhabisNRGX95uSYCzAs2hGrhdxUdzdLOEn17Bk3pUk6yY6j1KgJsVa4a5T30WxAC1auv7prOWLVTwhWZeSY6tYh9n0KpUFXMR6pwSK2ABC5MiWqpjM0ojuyKDQLcNbMjIySwdbsK2ijnxnxMeQR8erzvSAEgYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724077800; c=relaxed/simple;
	bh=p50BBbuZosL/TlItQcko7jEGPGXXBIr8gIdvQs6tEdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MmiLJVyLkh66A26cBmTmCZ9vzsPmJEvoGeCupShLy1i0pebgr0tfXqzY85jshSpLr04iw54ZyJ/G0CnzhBtvBhMbZtEx4LxOKyJ8P9sK4lmXFR3fhvxX/h9zHY110yfPpu9w/ymyf0H9QkbR+1/CnzitF5I77o38kjj4yOoNuVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bPpJDkbB; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724077798; x=1755613798;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p50BBbuZosL/TlItQcko7jEGPGXXBIr8gIdvQs6tEdA=;
  b=bPpJDkbBoUXTeAUAhlsGOfC4DoLfgAfKqWWMM9/byZo7F/g9NaouMOCs
   hZJpdxxiaCTZDN66IxgXkQ8czbJ++D2H3IFgNoCmP++D2x2gzL7R3S1EH
   1HXmRnt6hQKG1X6oTh+U4v85MN20sx4v6XtU/bFr0kkmm+uNuOTr0u9rH
   zQcYdJwlH+OaMBNWMOQuuXvOjlC05kiVn5u4S/H5GE116kaGZfrvzD4f/
   sBLC3Zsb22hGnMlQ5Mq5WnVeIcQVT+HhW+cmuEXhU1sI9HOfln6QUmuDF
   oHEf9gXlNe3Gw5gre7w7YULwRAQvEzkyv9gdVkqsC8nKTTKuc+yge3MO3
   A==;
X-CSE-ConnectionGUID: cGDtqvcnS6GCHtc0CqDaIQ==
X-CSE-MsgGUID: s9ZEO/t/Sz+po0Yh7NETcA==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="33744491"
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="33744491"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 07:29:55 -0700
X-CSE-ConnectionGUID: zsttDnP4SY63X7vIXkkq9Q==
X-CSE-MsgGUID: NJOY/Nu2RTieT9MvbkiBBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="64783811"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP; 19 Aug 2024 07:29:53 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 6E193719; Mon, 19 Aug 2024 17:29:49 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v2 5/5] gpiolib: Replace gpio_suffix_count with NULL-terminated array
Date: Mon, 19 Aug 2024 17:29:00 +0300
Message-ID: <20240819142945.327808-6-andriy.shevchenko@linux.intel.com>
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

There is no need to have and export the count variable for the array
in question. Instead, make it NULL-terminated.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib.c |  3 +--
 drivers/gpio/gpiolib.h | 11 +++++------
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 3a9668cc100d..3903d0a75304 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -90,8 +90,7 @@ DEFINE_STATIC_SRCU(gpio_devices_srcu);
 static DEFINE_MUTEX(gpio_machine_hogs_mutex);
 static LIST_HEAD(gpio_machine_hogs);
 
-const char *const gpio_suffixes[] = { "gpios", "gpio" };
-const size_t gpio_suffix_count = ARRAY_SIZE(gpio_suffixes);
+const char *const gpio_suffixes[] = { "gpios", "gpio", NULL };
 
 static void gpiochip_free_hogs(struct gpio_chip *gc);
 static int gpiochip_add_irqchip(struct gpio_chip *gc,
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index 0271e747fb6e..067197d61d57 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -89,14 +89,13 @@ static inline struct gpio_device *to_gpio_device(struct device *dev)
 	return container_of(dev, struct gpio_device, dev);
 }
 
-/* gpio suffixes used for ACPI and device tree lookup */
+/* GPIO suffixes used for ACPI and device tree lookup */
 extern const char *const gpio_suffixes[];
-extern const size_t gpio_suffix_count;
 
 #define for_each_gpio_property_name(propname, con_id)					\
-	for (unsigned int __i = 0;							\
-	     __i < gpio_suffix_count && ({						\
-		     const char *__gs = gpio_suffixes[__i];				\
+	for (const char * const *__suffixes = gpio_suffixes;				\
+	     *__suffixes && ({								\
+		const char *__gs = *__suffixes;						\
 											\
 		if (con_id)								\
 			snprintf(propname, sizeof(propname), "%s-%s", con_id, __gs);	\
@@ -104,7 +103,7 @@ extern const size_t gpio_suffix_count;
 			snprintf(propname, sizeof(propname), "%s", __gs);		\
 		1;									\
 	     });									\
-	     __i++)
+	     __suffixes++)
 
 /**
  * struct gpio_array - Opaque descriptor for a structure of GPIO array attributes
-- 
2.43.0.rc1.1336.g36b5255a03ac


