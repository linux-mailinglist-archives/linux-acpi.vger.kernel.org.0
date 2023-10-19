Return-Path: <linux-acpi+bounces-763-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0CE7D01EC
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Oct 2023 20:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0EE2B20D65
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Oct 2023 18:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6257B38DF2
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Oct 2023 18:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Oc8uynhB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AC327469
	for <linux-acpi@vger.kernel.org>; Thu, 19 Oct 2023 17:35:08 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619A7138;
	Thu, 19 Oct 2023 10:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697736906; x=1729272906;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OK+wrv+DMOQXPBESi5xHEfknrZptJg8C/cIK0m+tQ50=;
  b=Oc8uynhBrgzTo2ujIVSkfTn6dxW8SwfreV1tEfMYV7p0WXwm1QR6/bl8
   lFIzSo9bBeM+K8Cz7dDJ7eScjN1rdclmkqjF5ToNQV7zLpeH1xOjdkKRO
   2m4Ayhml04s2j2qpBRdd6BWE+I/XC1uxspe0F45SVEjlbLi/ZK4pbCv2y
   1dCaHwvalGBNWtSPOIs588KJIJVff5ZZ2uiZGvMYhH3CAgTCL53gpdIx6
   wmKyVX/R7O0v4AetmQoT6hYQ8CViftb+VvW4pilX2N8k0uVZGNegvmUj/
   XX8BE7w72RlbtDnWC4fKsZrHdku0qMrFS3iAyVI+c4GDEPI9JTYxi7jHr
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="389184246"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="389184246"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 10:35:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="760723566"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="760723566"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 19 Oct 2023 10:35:02 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 47B19F4; Thu, 19 Oct 2023 20:35:01 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Hans de Goede <hdegoede@redhat.com>,
	Ferry Toth <ftoth@exalondelft.nl>
Subject: [PATCH v1 1/3] gpiolib: acpi: Add missing memset(0) to acpi_get_gpiod_from_data()
Date: Thu, 19 Oct 2023 20:34:55 +0300
Message-Id: <20231019173457.2445119-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20231019173457.2445119-1-andriy.shevchenko@linux.intel.com>
References: <20231019173457.2445119-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When refactoring the acpi_get_gpiod_from_data() the change missed
cleaning up the variable on stack. Add missing memset().

Reported-by: Ferry Toth <ftoth@exalondelft.nl>
Fixes: 16ba046e86e9 ("gpiolib: acpi: teach acpi_find_gpio() to handle data-only nodes")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib-acpi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index fbda452fb4d6..51e41676de0b 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -951,6 +951,7 @@ static struct gpio_desc *acpi_get_gpiod_from_data(struct fwnode_handle *fwnode,
 	if (!propname)
 		return ERR_PTR(-EINVAL);
 
+	memset(&lookup, 0, sizeof(lookup));
 	lookup.index = index;
 
 	ret = acpi_gpio_property_lookup(fwnode, propname, index, &lookup);
-- 
2.40.0.1.gaa8946217a0b


