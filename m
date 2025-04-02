Return-Path: <linux-acpi+bounces-12646-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A347FA78E37
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Apr 2025 14:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4A4E17250E
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Apr 2025 12:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09ABB2397BE;
	Wed,  2 Apr 2025 12:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eXcRNqjA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4367B239095;
	Wed,  2 Apr 2025 12:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743596590; cv=none; b=J77P0+Z2uxzKJM/nh5Ib/7KDQdL24Xbec1HMbxgGcDYk/TozhypDAyZT0gf3qyDWou2kqVaHdNZnrY380EQLR/WATxqdlmI82jsNMIXFMUMoU9dpEegQoRf7QGb7aOcJhklR3cYT1jeDFiuu3EXdrxt1Ief0RwO+wxmlyhp2PDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743596590; c=relaxed/simple;
	bh=JzZ2zxRH5WzmArsIBFNmyYfJ/ZT+m/rFHFyi90jX0UY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AgETIDxCqdEnwrypN9/75XFXEh0bria/94o/GDBrfVtMcKL6wnlbt86z78GwywZsXn0Q3lV0BmDRP0v86THjjkUhMGY//ioSFMbbK+VzDYFmZKB263GXn5EQVjRM5hK3i77+R8B6I0SOtpVcS9nxbAZK7wewOH+gG+WCJcEW7f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eXcRNqjA; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743596590; x=1775132590;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JzZ2zxRH5WzmArsIBFNmyYfJ/ZT+m/rFHFyi90jX0UY=;
  b=eXcRNqjAOE7PBVnqMzZix37UGPFAhlvMY9hwa0ui59ThGeTb0jBIuW41
   dQpO8YEN1r+gMVB8TCR16/FYEFrom0OTPbP3WQ2d+3sjsoNaE1onq0llI
   LvYQkKPjHY+qA6EvPS6Jj23fx606vQW6jfP4ktvEh9CqmcgkQVGeZxsog
   yFtJf186fXYT5nP+DWDfnIKtLZEvDIzVdf+y7ICg3Qz+Ir5ym/KyNNnpR
   axPOF4LdidSlyBGVkoV9M8wTrO3hImUQVVjAyx92hwMYXoAifRaqxvYzi
   +rZyz+5B1+y85DECsPlMR0UEXtFEn+tRdGH+IPTzO2OasRN3zUjhOzul2
   Q==;
X-CSE-ConnectionGUID: NzjHj0TfS8e+9Cv3W/Tibw==
X-CSE-MsgGUID: AUz1hHEcQK6zOE9NFSITqw==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="44865032"
X-IronPort-AV: E=Sophos;i="6.15,182,1739865600"; 
   d="scan'208";a="44865032"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 05:23:07 -0700
X-CSE-ConnectionGUID: sh1aI/qYRe2QoO6yG4DGvQ==
X-CSE-MsgGUID: EQSyEldZQceIM0wjM5VOyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,182,1739865600"; 
   d="scan'208";a="157635535"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 02 Apr 2025 05:23:05 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 474E915C; Wed, 02 Apr 2025 15:23:03 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mika Westerberg <westeri@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v1 1/5] gpiolib: acpi: Improve struct acpi_gpio_info memory footprint
Date: Wed,  2 Apr 2025 15:21:16 +0300
Message-ID: <20250402122301.1517463-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250402122301.1517463-1-andriy.shevchenko@linux.intel.com>
References: <20250402122301.1517463-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The struct acpi_gpio_info has two boolean members that are located
not close to each other making two gaps due to alignment requirements.
Group them to improve memory footprint.

`pahole` difference before and after (on 32-bit):

-       /* size: 36, cachelines: 1, members: 9 */
-       /* sum members: 30, holes: 2, sum holes: 6 */

+       /* size: 32, cachelines: 1, members: 9 */
+       /* sum members: 30, holes: 1, sum holes: 2 */

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib-acpi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 69caa35c58df..878b11c81c7b 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -96,10 +96,10 @@ struct acpi_gpio_chip {
  * @adev: reference to ACPI device which consumes GPIO resource
  * @flags: GPIO initialization flags
  * @gpioint: if %true this GPIO is of type GpioInt otherwise type is GpioIo
+ * @wake_capable: wake capability as provided by ACPI
  * @pin_config: pin bias as provided by ACPI
  * @polarity: interrupt polarity as provided by ACPI
  * @triggering: triggering type as provided by ACPI
- * @wake_capable: wake capability as provided by ACPI
  * @debounce: debounce timeout as provided by ACPI
  * @quirks: Linux specific quirks as provided by struct acpi_gpio_mapping
  */
@@ -107,10 +107,10 @@ struct acpi_gpio_info {
 	struct acpi_device *adev;
 	enum gpiod_flags flags;
 	bool gpioint;
+	bool wake_capable;
 	int pin_config;
 	int polarity;
 	int triggering;
-	bool wake_capable;
 	unsigned int debounce;
 	unsigned int quirks;
 };
-- 
2.47.2


