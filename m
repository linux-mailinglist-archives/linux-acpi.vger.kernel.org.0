Return-Path: <linux-acpi+bounces-12900-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 281C3A82652
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Apr 2025 15:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 334C7446EA8
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Apr 2025 13:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1D02627F9;
	Wed,  9 Apr 2025 13:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oJX8qxHd"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3622620C1;
	Wed,  9 Apr 2025 13:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744205389; cv=none; b=pyZFwUa/i52he+jptmSGY/RcaNWD9RBuRFrDFzWcYcxnJkbQRMCqLIqRZEEkAINZMy7PnTlBLYSlEX1fs5r9DLXwPkYnkAVera0Rbkb/ywJoJC6o1wZcfCSlECSuT35gZe6VHxUxuPFdh2nzvy8PvVvHXaWXA5dXZM40tytRJ+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744205389; c=relaxed/simple;
	bh=f0UrLMWyKa1LjHP7Q2pj817b5atznihK+sH1QX2L+OU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ajRIMw416lxyFo2f7hPdId6BSmTsBoYTgEmzC7dC2z0hQZlr1uI34M/vmxT5URl9otEqTIXABt6PAmlfuqqJmRsQ13pvRir2yvBvOWB/ub1Qj0OPOT1OqStW1LVV2wbPEoksoW3gG4lzvTPJCuz/Jt+L/yU8DotLsC8qT3cHJrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oJX8qxHd; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744205388; x=1775741388;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f0UrLMWyKa1LjHP7Q2pj817b5atznihK+sH1QX2L+OU=;
  b=oJX8qxHdVimgTB56vAg5AuWXPxu+d2lG29R3o7a/yv1qhR9PdndQ2JwT
   TpQqQuMuKUDiqvdX9B/BbDbBgcWceY1w28FoBH4pjsT78mj7HlBL6QOg6
   VDp9XOGnvxHsicWFdmUsKN5RX3AWDmwtVJgTDiqcZ4/3AbPeSuweKCoYq
   536SqeBU3wdynRIusD0YhU3UwNyvLNX9iKAtvkddKzsbMe0SKFkJ67goS
   57AaQAWiRmm+Y4mHTu9v2Ix55sm/6HYVcN8V2D78o4pR/wkMNDcsISGHO
   r0ZU5cSDAM08GmKVEkNlBOJLGsfDJ/TU59aoEJDXeIzdeyacmWbK0Yl4B
   A==;
X-CSE-ConnectionGUID: 5ENymN/zSqWnOHvTK8dV4w==
X-CSE-MsgGUID: e/hKSC6CSqayE2ZV8ngPjA==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="71056559"
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="71056559"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 06:29:47 -0700
X-CSE-ConnectionGUID: Z2EGyJTLSyaiE19YpRzdaQ==
X-CSE-MsgGUID: lHTcN+BrTFWb+sxol7C1/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="133795231"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa005.jf.intel.com with ESMTP; 09 Apr 2025 06:29:45 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 0DF50554; Wed, 09 Apr 2025 16:29:43 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mika Westerberg <westeri@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v1 1/2] gpiolib: acpi: Use temporary variable for struct acpi_gpio_info
Date: Wed,  9 Apr 2025 16:27:53 +0300
Message-ID: <20250409132942.2550719-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250409132942.2550719-1-andriy.shevchenko@linux.intel.com>
References: <20250409132942.2550719-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use temporary variable to access the struct acpi_gpio_info members.
This will help further changes to be cleaner. No functional change
intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib-acpi.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index bebb74528cfe..5b6344f0d065 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -752,6 +752,7 @@ static int acpi_populate_gpio_lookup(struct acpi_resource *ares, void *data)
 {
 	struct acpi_gpio_lookup *lookup = data;
 	struct acpi_gpio_params *params = &lookup->params;
+	struct acpi_gpio_info *info = &lookup->info;
 
 	if (ares->type != ACPI_RESOURCE_TYPE_GPIO)
 		return 1;
@@ -762,7 +763,7 @@ static int acpi_populate_gpio_lookup(struct acpi_resource *ares, void *data)
 		struct gpio_desc *desc;
 		u16 pin_index;
 
-		if (lookup->info.quirks & ACPI_GPIO_QUIRK_ONLY_GPIOIO && gpioint)
+		if (info->quirks & ACPI_GPIO_QUIRK_ONLY_GPIOIO && gpioint)
 			params->crs_entry_index++;
 
 		if (lookup->n++ != params->crs_entry_index)
@@ -772,16 +773,16 @@ static int acpi_populate_gpio_lookup(struct acpi_resource *ares, void *data)
 		if (pin_index >= agpio->pin_table_length)
 			return 1;
 
-		if (lookup->info.quirks & ACPI_GPIO_QUIRK_ABSOLUTE_NUMBER)
+		if (info->quirks & ACPI_GPIO_QUIRK_ABSOLUTE_NUMBER)
 			desc = gpio_to_desc(agpio->pin_table[pin_index]);
 		else
 			desc = acpi_get_gpiod(agpio->resource_source.string_ptr,
 					      agpio->pin_table[pin_index]);
 		lookup->desc = desc;
-		lookup->info.pin_config = agpio->pin_config;
-		lookup->info.debounce = agpio->debounce_timeout;
-		lookup->info.gpioint = gpioint;
-		lookup->info.wake_capable = acpi_gpio_irq_is_wake(&lookup->info.adev->dev, agpio);
+		info->pin_config = agpio->pin_config;
+		info->debounce = agpio->debounce_timeout;
+		info->gpioint = gpioint;
+		info->wake_capable = acpi_gpio_irq_is_wake(&info->adev->dev, agpio);
 
 		/*
 		 * Polarity and triggering are only specified for GpioInt
@@ -790,14 +791,14 @@ static int acpi_populate_gpio_lookup(struct acpi_resource *ares, void *data)
 		 * - ACPI_ACTIVE_LOW == GPIO_ACTIVE_LOW
 		 * - ACPI_ACTIVE_HIGH == GPIO_ACTIVE_HIGH
 		 */
-		if (lookup->info.gpioint) {
-			lookup->info.polarity = agpio->polarity;
-			lookup->info.triggering = agpio->triggering;
+		if (info->gpioint) {
+			info->polarity = agpio->polarity;
+			info->triggering = agpio->triggering;
 		} else {
-			lookup->info.polarity = params->active_low;
+			info->polarity = params->active_low;
 		}
 
-		lookup->info.flags = acpi_gpio_to_gpiod_flags(agpio, lookup->info.polarity);
+		info->flags = acpi_gpio_to_gpiod_flags(agpio, info->polarity);
 	}
 
 	return 1;
@@ -805,7 +806,8 @@ static int acpi_populate_gpio_lookup(struct acpi_resource *ares, void *data)
 
 static int acpi_gpio_resource_lookup(struct acpi_gpio_lookup *lookup)
 {
-	struct acpi_device *adev = lookup->info.adev;
+	struct acpi_gpio_info *info = &lookup->info;
+	struct acpi_device *adev = info->adev;
 	struct list_head res_list;
 	int ret;
 
@@ -830,6 +832,7 @@ static int acpi_gpio_property_lookup(struct fwnode_handle *fwnode, const char *p
 {
 	struct fwnode_reference_args args;
 	struct acpi_gpio_params *params = &lookup->params;
+	struct acpi_gpio_info *info = &lookup->info;
 	unsigned int index = params->crs_entry_index;
 	unsigned int quirks = 0;
 	int ret;
@@ -857,8 +860,8 @@ static int acpi_gpio_property_lookup(struct fwnode_handle *fwnode, const char *p
 	params->line_index = args.args[1];
 	params->active_low = !!args.args[2];
 
-	lookup->info.adev = to_acpi_device_node(args.fwnode);
-	lookup->info.quirks = quirks;
+	info->adev = to_acpi_device_node(args.fwnode);
+	info->quirks = quirks;
 
 	return 0;
 }
-- 
2.47.2


