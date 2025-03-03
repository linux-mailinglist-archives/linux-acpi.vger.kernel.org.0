Return-Path: <linux-acpi+bounces-11735-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34BD7A4C646
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Mar 2025 17:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9025165ECA
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Mar 2025 16:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D237B23717E;
	Mon,  3 Mar 2025 16:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gGXtLRUA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBE72356BD;
	Mon,  3 Mar 2025 16:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741017833; cv=none; b=GCD3x7GJ5IR1+ElyCRWyvPaNBt0Cw+7zW8nRLpfT7nVAit+Y7HnSIPhQnhF9otnx+atAGVylP7BkJk1hemOAsvEsKI6Xpt+PhOgAqVPV/BwRL5HXcxy/cTHxYcOItn47pM6q0/yGbMmxpSer3f0mMNypbadIbBUwbjUJP5PpzwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741017833; c=relaxed/simple;
	bh=augAjJ6JBGkm/7HH6cDggAy9sIwGeNJ3Wqj6kBfuH3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X3ICuJP0HcMrgyZ0X2jG6+QZxZwwDHCntu47WncfATUUsSzR/M0l5MBd6dcBPJ8AB4dW4ssgfVamtn72fIROG9PyLcEKYq1tKEeDDtS39QEcanFjbrLFYSmLduR58ZrrjDMCXZ7nIj/3kUrJQUiG6wd+TimJw3OTERC9tAbeAkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gGXtLRUA; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741017832; x=1772553832;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=augAjJ6JBGkm/7HH6cDggAy9sIwGeNJ3Wqj6kBfuH3A=;
  b=gGXtLRUAB7s5nENSx+7qtT9gbmvulSALViexwhnrJlVC4hvCIe9K3U4i
   HX3B0geMqfce27Y0yfcYCqlHmmVmkh6MNcyI5aAAbkEqRecE5zAUpuFPB
   aPUlXlzDvHUcA7S5v54SGJYeFaWySYykp+pCp1WdWrYr7/Kc6qBnk2wYV
   akMeggDSwisnrdZkbrmet7olISgemJcg6nm/YoZhG+GXZHtCXmguHTllT
   4mXd5oWwzcdMfviHBCTEF+MI5FvkL4GtG0F2MT5SOSaC7Xs0IZVgYb9Do
   8+MaGTClR87vZwyUO/7BcH7rZKWJeil3pRu4vle6XpjJNog8hVYRRwcjt
   A==;
X-CSE-ConnectionGUID: b6e88eTVTsGLl+9akR0Q4g==
X-CSE-MsgGUID: vUvFUJFfQ9e5dx210TYjaw==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="41606704"
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; 
   d="scan'208";a="41606704"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 08:03:48 -0800
X-CSE-ConnectionGUID: i7L2M9F0RVu//8paJfl1yg==
X-CSE-MsgGUID: ShdMkc4fS/CEU86m0ora/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; 
   d="scan'208";a="141285581"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa002.fm.intel.com with ESMTP; 03 Mar 2025 08:03:44 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id F38D0DC; Mon, 03 Mar 2025 18:03:42 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mika Westerberg <westeri@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Kent Gibson <warthog618@gmail.com>
Subject: [PATCH v1 1/3] gpiolib: Align FLAG_* definitions in the struct gpio_desc
Date: Mon,  3 Mar 2025 18:00:32 +0200
Message-ID: <20250303160341.1322640-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250303160341.1322640-1-andriy.shevchenko@linux.intel.com>
References: <20250303160341.1322640-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Align FLAG_* definitions in the struct gpio_desc for better readability.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib.h | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index 7663c9caebaf..65db879d1c74 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -183,24 +183,24 @@ struct gpio_desc {
 	struct gpio_device	*gdev;
 	unsigned long		flags;
 /* flag symbols are bit numbers */
-#define FLAG_REQUESTED	0
-#define FLAG_IS_OUT	1
-#define FLAG_EXPORT	2	/* protected by sysfs_lock */
-#define FLAG_SYSFS	3	/* exported via /sys/class/gpio/control */
-#define FLAG_ACTIVE_LOW	6	/* value has active low */
-#define FLAG_OPEN_DRAIN	7	/* Gpio is open drain type */
-#define FLAG_OPEN_SOURCE 8	/* Gpio is open source type */
-#define FLAG_USED_AS_IRQ 9	/* GPIO is connected to an IRQ */
-#define FLAG_IRQ_IS_ENABLED 10	/* GPIO is connected to an enabled IRQ */
-#define FLAG_IS_HOGGED	11	/* GPIO is hogged */
-#define FLAG_TRANSITORY 12	/* GPIO may lose value in sleep or reset */
-#define FLAG_PULL_UP    13	/* GPIO has pull up enabled */
-#define FLAG_PULL_DOWN  14	/* GPIO has pull down enabled */
-#define FLAG_BIAS_DISABLE    15	/* GPIO has pull disabled */
-#define FLAG_EDGE_RISING     16	/* GPIO CDEV detects rising edge events */
-#define FLAG_EDGE_FALLING    17	/* GPIO CDEV detects falling edge events */
-#define FLAG_EVENT_CLOCK_REALTIME	18 /* GPIO CDEV reports REALTIME timestamps in events */
-#define FLAG_EVENT_CLOCK_HTE		19 /* GPIO CDEV reports hardware timestamps in events */
+#define FLAG_REQUESTED			0
+#define FLAG_IS_OUT			1
+#define FLAG_EXPORT			2	/* protected by sysfs_lock */
+#define FLAG_SYSFS			3	/* exported via /sys/class/gpio/control */
+#define FLAG_ACTIVE_LOW			6	/* value has active low */
+#define FLAG_OPEN_DRAIN			7	/* Gpio is open drain type */
+#define FLAG_OPEN_SOURCE		8	/* Gpio is open source type */
+#define FLAG_USED_AS_IRQ		9	/* GPIO is connected to an IRQ */
+#define FLAG_IRQ_IS_ENABLED		10	/* GPIO is connected to an enabled IRQ */
+#define FLAG_IS_HOGGED			11	/* GPIO is hogged */
+#define FLAG_TRANSITORY			12	/* GPIO may lose value in sleep or reset */
+#define FLAG_PULL_UP			13	/* GPIO has pull up enabled */
+#define FLAG_PULL_DOWN			14	/* GPIO has pull down enabled */
+#define FLAG_BIAS_DISABLE		15	/* GPIO has pull disabled */
+#define FLAG_EDGE_RISING		16	/* GPIO CDEV detects rising edge events */
+#define FLAG_EDGE_FALLING		17	/* GPIO CDEV detects falling edge events */
+#define FLAG_EVENT_CLOCK_REALTIME	18	/* GPIO CDEV reports REALTIME timestamps in events */
+#define FLAG_EVENT_CLOCK_HTE		19	/* GPIO CDEV reports hardware timestamps in events */
 
 	/* Connection label */
 	struct gpio_desc_label __rcu *label;
-- 
2.47.2


