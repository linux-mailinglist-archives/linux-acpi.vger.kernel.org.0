Return-Path: <linux-acpi+bounces-11734-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A994A4C645
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Mar 2025 17:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC66F7A5C1A
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Mar 2025 16:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96F6236427;
	Mon,  3 Mar 2025 16:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UysRW9qf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BB821B192;
	Mon,  3 Mar 2025 16:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741017832; cv=none; b=iV0NdQAvUuCxlwwoByCjKtHu1r4xNhvKFc6dKnhETny1Ay57oOItVhY+ujb8moWAOKlKMbO6Uf+f3T9Mem/KKhEmph3X19kZHv/2gIE+KJQFHRmL1qfFNJr7bNcA/f6ACNqW6uQCHBaTl2EKKMVyGFB+GBjzpUzmlmR3vjbGdls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741017832; c=relaxed/simple;
	bh=vnlS6EsPTldyML8DPc0zUKD3uTn6+GaFUkw/BuVYj9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GGwipneiRhm+7Mqqlh/41wzX471CMkGnj3dr+Y+pMgWsFy32wzq//E5wnXWpKlkdkp6bLdTcAxL7iimNEkOFt0GzQnvrwKcXG3S5iFbEUnwHsbF+WWb14fjkAfJsoESTbQbn99WYs0ZSM3c6/6dRCR19We+VvinsAkCBcziyZlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UysRW9qf; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741017831; x=1772553831;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vnlS6EsPTldyML8DPc0zUKD3uTn6+GaFUkw/BuVYj9g=;
  b=UysRW9qfm/GPseqD44pXc1Ik61DA/TeuUuxC1PHpporXaNAt3NBvObbQ
   Y/6dTqFiGcW1PFBbSlCu6BNNaWbWkglE8P6+W2R05a4pWoYyswPx5jd1I
   8NIfC7Yrre+8gkTn7yvBEmTHwQhIy/m9nLXxUId5kFdmz66hhK1bPuMQy
   KI0O/RWoAfRE/lxjH0zPs7dpLVvMlH9UPF/rYwcP3YWuF49gNI467mDys
   aiOBd9phWDiwmBsqdv0cG7k2Wvs/6Z8kfWsIDoGPFW8rHiHmo8QoUjL0o
   SV+6f4xD88TcSiDPbLtfAzBLbg2dVyaFfT6SEHmPZTB6FhOo/ibbWEEAv
   g==;
X-CSE-ConnectionGUID: 53lKB1J5RbeLbKOP4S01Vg==
X-CSE-MsgGUID: 1p2Q9jGBQCextmPrPhXuqw==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="41606699"
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; 
   d="scan'208";a="41606699"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 08:03:47 -0800
X-CSE-ConnectionGUID: PnSZglOfRIGT+ictFVIAgQ==
X-CSE-MsgGUID: XTcrz2XRTgqYMotE++8wMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; 
   d="scan'208";a="141285580"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa002.fm.intel.com with ESMTP; 03 Mar 2025 08:03:44 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 14C27224; Mon, 03 Mar 2025 18:03:43 +0200 (EET)
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
Subject: [PATCH v1 2/3] gpiolib: Rename gpio_set_debounce_timeout() to gpiod_do_set_debounce()
Date: Mon,  3 Mar 2025 18:00:33 +0200
Message-ID: <20250303160341.1322640-3-andriy.shevchenko@linux.intel.com>
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

In order to reduce the 'gpio' namespace when operate over GPIO descriptor
rename gpio_set_debounce_timeout() to gpiod_do_set_debounce().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib-acpi.c | 4 ++--
 drivers/gpio/gpiolib.c      | 4 ++--
 drivers/gpio/gpiolib.h      | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 2aa88ace5868..3f442127222d 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -340,7 +340,7 @@ static struct gpio_desc *acpi_request_own_gpiod(struct gpio_chip *chip,
 		return desc;
 
 	/* ACPI uses hundredths of milliseconds units */
-	ret = gpio_set_debounce_timeout(desc, agpio->debounce_timeout * 10);
+	ret = gpiod_do_set_debounce(desc, agpio->debounce_timeout * 10);
 	if (ret)
 		dev_warn(chip->parent,
 			 "Failed to set debounce-timeout for pin 0x%04X, err %d\n",
@@ -1098,7 +1098,7 @@ int acpi_dev_gpio_irq_wake_get_by(struct acpi_device *adev, const char *con_id,
 				return ret;
 
 			/* ACPI uses hundredths of milliseconds units */
-			ret = gpio_set_debounce_timeout(desc, info.debounce * 10);
+			ret = gpiod_do_set_debounce(desc, info.debounce * 10);
 			if (ret)
 				return ret;
 
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index df5b85284788..8980eef6802c 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2697,7 +2697,7 @@ static int gpio_set_bias(struct gpio_desc *desc)
 }
 
 /**
- * gpio_set_debounce_timeout() - Set debounce timeout
+ * gpiod_do_set_debounce() - Set debounce timeout
  * @desc:	GPIO descriptor to set the debounce timeout
  * @debounce:	Debounce timeout in microseconds
  *
@@ -2707,7 +2707,7 @@ static int gpio_set_bias(struct gpio_desc *desc)
  * Returns:
  * 0 on success, or negative errno on failure.
  */
-int gpio_set_debounce_timeout(struct gpio_desc *desc, unsigned int debounce)
+int gpiod_do_set_debounce(struct gpio_desc *desc, unsigned int debounce)
 {
 	int ret;
 
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index 65db879d1c74..b3ea7b710995 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -263,7 +263,7 @@ struct gpio_desc *gpiod_find_and_request(struct device *consumer,
 int gpio_do_set_config(struct gpio_desc *desc, unsigned long config);
 int gpiod_configure_flags(struct gpio_desc *desc, const char *con_id,
 		unsigned long lflags, enum gpiod_flags dflags);
-int gpio_set_debounce_timeout(struct gpio_desc *desc, unsigned int debounce);
+int gpiod_do_set_debounce(struct gpio_desc *desc, unsigned int debounce);
 int gpiod_hog(struct gpio_desc *desc, const char *name,
 		unsigned long lflags, enum gpiod_flags dflags);
 int gpiochip_get_ngpios(struct gpio_chip *gc, struct device *dev);
-- 
2.47.2


