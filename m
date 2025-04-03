Return-Path: <linux-acpi+bounces-12691-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6CAA7A769
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Apr 2025 18:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A9291750D7
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Apr 2025 16:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2786B251785;
	Thu,  3 Apr 2025 16:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KYgbQVjD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6FC2512FD;
	Thu,  3 Apr 2025 16:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743696055; cv=none; b=MKkrvoZFFSVJwWvLbHeQXV8wqNUB2qa3CNS0xSvn3pl7IIhXpsPzQLeDP7rD5Wk3Z1U3ec9iu0rJFAY8EGoQtSDWa49lkYPnb6TvFO03ONAYw4rgUlgJX4Q5wRra9p9kRz/Y8cHy4XSJLDYglFQ6/oBlhTz4WLmkLIWas5WMU0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743696055; c=relaxed/simple;
	bh=JzZ2zxRH5WzmArsIBFNmyYfJ/ZT+m/rFHFyi90jX0UY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kVF4ObVpKcl54N29Qur2PCVH6qqelESuyhCwaLjsna+XBLgDiisvbhyxnBA7YDxX+SuYRcS1BfuM66NKR0+pcoKnPz7otp77lYhjUSmKwPid7QETCVIHNDgJaiIe7/J8JtbXbVY9naA6jLiwrmFbdRKKXvXj0JTJ8Z9TPAzxGQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KYgbQVjD; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743696053; x=1775232053;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JzZ2zxRH5WzmArsIBFNmyYfJ/ZT+m/rFHFyi90jX0UY=;
  b=KYgbQVjD1Y6KWDpptMkmIiidYQUSWitayuZMeaS96tpUOMmrQj1XrrW1
   RamewHRGqIOqjIhnhGPSgXhrFK54c1Fwj+xX/craEUWfjbh4mM1IsuAdQ
   PnxmOHisheBiNMfIfg8WhBJGx1YW10vW29IADBmqxfppvE0Re1Vp0y07v
   DahOXNT4lXV5jcTfPHvz2rwD6RcL99jZyflm0CGcSFQPWfluT20uIitRt
   s3PtVFfq7lqn2LEMZVahnSA1NFJPzZTl7LO8PBU/K0FCU/w32n9H0LT19
   k7nUcTmE58756NHheiWTKWjmHb5ZLCMEuYLZZELwjyJH5Z75bzfqSHCS0
   g==;
X-CSE-ConnectionGUID: asObfcIITIasvzgwXMfddg==
X-CSE-MsgGUID: qTv+nBwlQSWcrJ2e0wZSxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11393"; a="44369239"
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="44369239"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2025 09:00:52 -0700
X-CSE-ConnectionGUID: zFe+AvXiTRakGhxQ/xGz/A==
X-CSE-MsgGUID: SDTrjG1PQKuvsXn2QKQBFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="158036302"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa001.fm.intel.com with ESMTP; 03 Apr 2025 09:00:37 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 2B8F2E0; Thu, 03 Apr 2025 19:00:36 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mika Westerberg <westeri@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v2 1/6] gpiolib: acpi: Improve struct acpi_gpio_info memory footprint
Date: Thu,  3 Apr 2025 18:59:12 +0300
Message-ID: <20250403160034.2680485-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250403160034.2680485-1-andriy.shevchenko@linux.intel.com>
References: <20250403160034.2680485-1-andriy.shevchenko@linux.intel.com>
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


