Return-Path: <linux-acpi+bounces-11733-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E643A4C640
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Mar 2025 17:09:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FCF11895D70
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Mar 2025 16:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A12F2356BB;
	Mon,  3 Mar 2025 16:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lBaP7Y5L"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CC123496B;
	Mon,  3 Mar 2025 16:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741017832; cv=none; b=Y3bI2yGGYUIZT5Xu3cLlsqXGqSfSnfVzmt+9MzWcHSOlIrznFyNQQE2KsifLa/iCzjNh3nv7PSZMCU2FezlzU8OEacWtLnmBLrN2eht6Oh3oEoTyRF8OksDscWi+87JJJsSbqBYeFGjKt3lSYkOAVabhUKuV7Vkhk0hwm7upqLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741017832; c=relaxed/simple;
	bh=7X6WHFYBLbOh3gruZjblSPMPaVJ2eb2Purwjk6hT300=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gS65aO/xyzZZ/0NXm2nIhAp+kxuYiEta35+e/B89x2J35ouZvjITIJ/64Ba6Z7zzN+xc0g0TrU8e75fZZWwbqT5ENFnGTuM2XWgfLXa9V8WNKoQXKW22jKoaLUu15EKpTts9S7abqQAOVUXiNmtpSmIVGZy99fpIEJc8g+wAA70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lBaP7Y5L; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741017831; x=1772553831;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7X6WHFYBLbOh3gruZjblSPMPaVJ2eb2Purwjk6hT300=;
  b=lBaP7Y5LNYCwEZ/rxfwHceazY3H2y8xdsLPnMSCTdY17JzYJADUBACVw
   tKcNJqnftrZFhcU7fuJYn1BDMebWy2t6L2YonXwTUPZiWfMHWaOU23+3X
   5EiqdTMDMtjuYu5TCUuB6WAVjS3IEuoFZwT8pusKL9La0lvEWoN/xCPwi
   yEJsyNm5ncwpqzUACsXhx/UPSp52jgNasd2cHCB4VPMuIn5XR/XDjCW3a
   IQdGWpgY7Kai6m3f0wWLdE9lm1FxO1UZtknNA+KppdB4W0BaYRAaOV2pN
   +0v7dNHm9hqsVVOFVvXOx5PpmZxRnJxwV9irD0nyyhfToWUQIYCxxg8Lg
   w==;
X-CSE-ConnectionGUID: ChmVP5dnRFaNHlDsxI5WXw==
X-CSE-MsgGUID: nDpdL/JrRYWr6bTH9K5KpQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="41606691"
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; 
   d="scan'208";a="41606691"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 08:03:47 -0800
X-CSE-ConnectionGUID: FL6UjEcmSumMo9xz6A64yQ==
X-CSE-MsgGUID: 1U8U8Q4zS7qFKflw1sEcrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; 
   d="scan'208";a="141285579"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa002.fm.intel.com with ESMTP; 03 Mar 2025 08:03:44 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 25EE333D; Mon, 03 Mar 2025 18:03:43 +0200 (EET)
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
Subject: [PATCH v1 3/3] gpiolib: Rename gpio_do_set_config() --> gpiod_do_set_config()
Date: Mon,  3 Mar 2025 18:00:34 +0200
Message-ID: <20250303160341.1322640-4-andriy.shevchenko@linux.intel.com>
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
rename gpio_do_set_config() to gpiod_do_set_config().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib-cdev.c | 2 +-
 drivers/gpio/gpiolib.c      | 6 +++---
 drivers/gpio/gpiolib.h      | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index c8b7499a1e6e..68b6e27ce6ef 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -927,7 +927,7 @@ static int debounce_setup(struct line *line, unsigned int debounce_period_us)
 	 * Try hardware. Skip gpiod_set_config() to avoid emitting two
 	 * CHANGED_CONFIG line state events.
 	 */
-	ret = gpio_do_set_config(line->desc,
+	ret = gpiod_do_set_config(line->desc,
 			pinconf_to_config_packed(PIN_CONFIG_INPUT_DEBOUNCE,
 						 debounce_period_us));
 	if (ret != -ENOTSUPP)
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 8980eef6802c..efaf34a30c20 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2599,7 +2599,7 @@ EXPORT_SYMBOL_GPL(gpiochip_free_own_desc);
  * rely on gpio_request() having been called beforehand.
  */
 
-int gpio_do_set_config(struct gpio_desc *desc, unsigned long config)
+int gpiod_do_set_config(struct gpio_desc *desc, unsigned long config)
 {
 	int ret;
 
@@ -2634,7 +2634,7 @@ static int gpio_set_config_with_argument(struct gpio_desc *desc,
 	unsigned long config;
 
 	config = pinconf_to_config_packed(mode, argument);
-	return gpio_do_set_config(desc, config);
+	return gpiod_do_set_config(desc, config);
 }
 
 static int gpio_set_config_with_argument_optional(struct gpio_desc *desc,
@@ -3104,7 +3104,7 @@ int gpiod_set_config(struct gpio_desc *desc, unsigned long config)
 
 	VALIDATE_DESC(desc);
 
-	ret = gpio_do_set_config(desc, config);
+	ret = gpiod_do_set_config(desc, config);
 	if (ret)
 		return ret;
 
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index b3ea7b710995..4f603a530d38 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -260,7 +260,7 @@ struct gpio_desc *gpiod_find_and_request(struct device *consumer,
 					 const char *label,
 					 bool platform_lookup_allowed);
 
-int gpio_do_set_config(struct gpio_desc *desc, unsigned long config);
+int gpiod_do_set_config(struct gpio_desc *desc, unsigned long config);
 int gpiod_configure_flags(struct gpio_desc *desc, const char *con_id,
 		unsigned long lflags, enum gpiod_flags dflags);
 int gpiod_do_set_debounce(struct gpio_desc *desc, unsigned int debounce);
-- 
2.47.2


