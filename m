Return-Path: <linux-acpi+bounces-13698-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 354ACAB50F7
	for <lists+linux-acpi@lfdr.de>; Tue, 13 May 2025 12:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C5FC18953AA
	for <lists+linux-acpi@lfdr.de>; Tue, 13 May 2025 10:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483592459E3;
	Tue, 13 May 2025 10:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TXG7GA5Q"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EB9242D77;
	Tue, 13 May 2025 10:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747130722; cv=none; b=usIlYbZt87SUp8YYxhD4VnZAar/uVR10/vRDI0WHfb2JTanCaqVJ0qyRMqCSNkSsEYNQ1cVnds1VeCISI3vhHWGzGOPoD8lYfPjPtADIDZ+g8nqjEDzAl/+sqhzQSLrqVvdaeZB3MWmL3Hzg2k6mRuF/TiytqCtWqt4IOMVK/ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747130722; c=relaxed/simple;
	bh=uCq+SQTxC0y9guP7QdWGf2fjFMm26Wqsa1zj6FRKsYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fq9ffmuT1yqgxcLFt4a9ZGxR99x8rvK+WuZc/ete1xkolvA+82xZT/usJnVDRBOOwEhb6XnR55cpu27E7hwx0jl6+tT3ps5ZYlRo7O7k6uh5QPtcG+i0XUQ0Bz3VIO9tUsOxaPoRq/i5loiclht1ksZrPrDx7E/r65wK7P0Mjuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TXG7GA5Q; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747130721; x=1778666721;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uCq+SQTxC0y9guP7QdWGf2fjFMm26Wqsa1zj6FRKsYI=;
  b=TXG7GA5QFnf/zF6Xu6fScaNUvM/ZF1R0oDNV+2aZ+mNmsvm1uoPW3/Ax
   tvVSqTdEoaGOog04IaBqUS0kSB/a2JfZ9HMo4KwjcmL2c5LReAgqNxf6Q
   T2WahErWeGtBGpFjcI7zDgX5qaQC3zk5pkVOG+Ff2rUq663X76lp44Onc
   bTf1WBPzXZKoC62vImSsdVyonFBvLK4v3i2pvZCjl4DcJNgx/9Ew3G8/w
   4Na2fzc3WNYtDRaXZ8lXuQDp9QaFn5jHkZZQNg6Xqo58EVjxbvb0zP14s
   /nFBAj8NSHKgbze/1FbN2jd/fe9hszOkH5VVpacbWSN1v+k25w91U8H2G
   g==;
X-CSE-ConnectionGUID: aE987b4XSr2XsKDoBjuI+A==
X-CSE-MsgGUID: N1CPZuCSTgGCP4izBJuTFQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="59639128"
X-IronPort-AV: E=Sophos;i="6.15,284,1739865600"; 
   d="scan'208";a="59639128"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 03:05:20 -0700
X-CSE-ConnectionGUID: vAYTMQndSfaYWEv1A0ePPA==
X-CSE-MsgGUID: imfGNRw/TRmDEMEhNTLz+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,284,1739865600"; 
   d="scan'208";a="137521340"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 13 May 2025 03:05:17 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id D2B821FD; Tue, 13 May 2025 13:05:15 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
	Mika Westerberg <westeri@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v1 1/4] gpiolib: acpi: Switch to use enum in acpi_gpio_in_ignore_list()
Date: Tue, 13 May 2025 13:00:31 +0300
Message-ID: <20250513100514.2492545-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250513100514.2492545-1-andriy.shevchenko@linux.intel.com>
References: <20250513100514.2492545-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch to use enum instead of pointers in acpi_gpio_in_ignore_list()
which moves towards isolating the GPIO ACPI and quirk APIs. It will
helps splitting them completely in the next changes.

No functional changes.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib-acpi.c | 21 ++++++++++++++++-----
 drivers/gpio/gpiolib-acpi.h |  8 ++++++++
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 3c9535d767e7..fb573b5f0ba1 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -350,14 +350,25 @@ static struct gpio_desc *acpi_request_own_gpiod(struct gpio_chip *chip,
 	return desc;
 }
 
-static bool acpi_gpio_in_ignore_list(const char *ignore_list, const char *controller_in,
-				     unsigned int pin_in)
+bool acpi_gpio_in_ignore_list(enum acpi_gpio_ignore_list list, const char *controller_in,
+			      unsigned int pin_in)
 {
-	const char *controller, *pin_str;
+	const char *ignore_list, *controller, *pin_str;
 	unsigned int pin;
 	char *endp;
 	int len;
 
+	switch (list) {
+	case ACPI_GPIO_IGNORE_WAKE:
+		ignore_list = ignore_wake;
+		break;
+	case ACPI_GPIO_IGNORE_INTERRUPT:
+		ignore_list = ignore_interrupt;
+		break;
+	default:
+		return false;
+	}
+
 	controller = ignore_list;
 	while (controller) {
 		pin_str = strchr(controller, '@');
@@ -394,7 +405,7 @@ static bool acpi_gpio_irq_is_wake(struct device *parent,
 	if (agpio->wake_capable != ACPI_WAKE_CAPABLE)
 		return false;
 
-	if (acpi_gpio_in_ignore_list(ignore_wake, dev_name(parent), pin)) {
+	if (acpi_gpio_in_ignore_list(ACPI_GPIO_IGNORE_WAKE, dev_name(parent), pin)) {
 		dev_info(parent, "Ignoring wakeup on pin %u\n", pin);
 		return false;
 	}
@@ -437,7 +448,7 @@ static acpi_status acpi_gpiochip_alloc_event(struct acpi_resource *ares,
 	if (!handler)
 		return AE_OK;
 
-	if (acpi_gpio_in_ignore_list(ignore_interrupt, dev_name(chip->parent), pin)) {
+	if (acpi_gpio_in_ignore_list(ACPI_GPIO_IGNORE_INTERRUPT, dev_name(chip->parent), pin)) {
 		dev_info(chip->parent, "Ignoring interrupt on pin %u\n", pin);
 		return AE_OK;
 	}
diff --git a/drivers/gpio/gpiolib-acpi.h b/drivers/gpio/gpiolib-acpi.h
index 7e1c51d04040..ef0b1a3c85d7 100644
--- a/drivers/gpio/gpiolib-acpi.h
+++ b/drivers/gpio/gpiolib-acpi.h
@@ -58,4 +58,12 @@ static inline int acpi_gpio_count(const struct fwnode_handle *fwnode,
 }
 #endif
 
+enum acpi_gpio_ignore_list {
+	ACPI_GPIO_IGNORE_WAKE,
+	ACPI_GPIO_IGNORE_INTERRUPT,
+};
+
+bool acpi_gpio_in_ignore_list(enum acpi_gpio_ignore_list list,
+			      const char *controller_in, unsigned int pin_in);
+
 #endif /* GPIOLIB_ACPI_H */
-- 
2.47.2


