Return-Path: <linux-acpi+bounces-7659-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B08956BFF
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Aug 2024 15:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83EFD28688A
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Aug 2024 13:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB05D173328;
	Mon, 19 Aug 2024 13:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iGiciWtA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D5A16CD0F;
	Mon, 19 Aug 2024 13:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724073912; cv=none; b=uokFwga4YoQgSejWyicMbileEL1veWyBylXwNIigDZMDZ9nkhzomUlsded5YPz9mezBoW8oyh5oEg9mrhNdlxzpEi+VWUo6PfdLItU9ASK4Eqy4GQTw0tDiQkIPE2zyRB8hQJIWfkMObbBn8DhEMKsBvSQcFiLoy2FYeCa4C3aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724073912; c=relaxed/simple;
	bh=DZkkfksY4RuNkDc6eYi1tB+4DQHIyYH/G6/B6BAG23U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TXjKZ5eHEDVhP5sS+CKm81S3ImqqKgXw1POES+eVbIJFMJCNe1Vw78SZAiEBPYmNhQY02zb6+swLoLMYHatfH2Dz4OhGr76QnaBql/4sdvqwfr/Y5UkX5d1NYUqI62xRdZmSh5OR0mtJYDHPMq0wUTo+1ljYGP4gRNhMUjsTln4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iGiciWtA; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724073911; x=1755609911;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DZkkfksY4RuNkDc6eYi1tB+4DQHIyYH/G6/B6BAG23U=;
  b=iGiciWtAU59MmeMrcI4qVDXciaPbsuRGAW1rYh6mSL1wZQgMWGKH8pMX
   x/e/qZV9oSy7qpvhpctOBA7UuFpYgm1YIBqgGjAXtmr6VFvIilht1iBQi
   1Vzsm5GFMn4x6hKPdnqN5TVt+yuu+94C1TSQ2ZV5qOa5dAR8swylqqq9D
   A9qrB3d28rB3ZtiHgOYXuCulVZYmt1j97630Jg4+/qPrOBZf9pQ1yfPmw
   VlTfnpuNEknfU2WbPRexPDTd70N32F40dT7WNWHfq7n/YP1sOPtlBgmfB
   lbqoohiEzyprGqCx1xYPMFIgJU0M8497e18NFzxW4wSIGub9DCuG2bofQ
   Q==;
X-CSE-ConnectionGUID: eQv7BSYzQEKOioGiwo1Kug==
X-CSE-MsgGUID: /LqO+1WsTeybEiw+cg8m4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="47718622"
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="47718622"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 06:25:08 -0700
X-CSE-ConnectionGUID: A/VFWTMUQuCboJ6EUCe00Q==
X-CSE-MsgGUID: Hz4GXzlMQD6U+8tWyjZMKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="60211807"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 19 Aug 2024 06:25:06 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 101A7719; Mon, 19 Aug 2024 16:25:02 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v1 5/5] gpiolib: Replace gpio_suffix_count with NULL-terminated array
Date: Mon, 19 Aug 2024 16:22:47 +0300
Message-ID: <20240819132458.208677-6-andriy.shevchenko@linux.intel.com>
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

There is no need to have and export the count variable for the array
in question. Instead, make it NULL-terminated.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib.c |  3 +--
 drivers/gpio/gpiolib.h | 11 +++++------
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 7f6060c5b5e0..08fdf06a258f 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -91,8 +91,7 @@ DEFINE_STATIC_SRCU(gpio_devices_srcu);
 static DEFINE_MUTEX(gpio_machine_hogs_mutex);
 static LIST_HEAD(gpio_machine_hogs);
 
-const char *const gpio_suffixes[] = { "gpios", "gpio" };
-const size_t gpio_suffix_count = ARRAY_SIZE(gpio_suffixes);
+const char *const gpio_suffixes[] = { "gpios", "gpio", NULL };
 
 static void gpiochip_free_hogs(struct gpio_chip *gc);
 static int gpiochip_add_irqchip(struct gpio_chip *gc,
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index d38e83d82796..3c7e80f8a0c5 100644
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


