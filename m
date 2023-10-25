Return-Path: <linux-acpi+bounces-979-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D737D75B9
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 22:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2E9CB210A6
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 20:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7FA27ED1
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 20:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fq/B05hj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA172250EA
	for <linux-acpi@vger.kernel.org>; Wed, 25 Oct 2023 18:43:11 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56946111;
	Wed, 25 Oct 2023 11:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698259389; x=1729795389;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dpLiufvLW4ReyqiDHIArSLkX2JA+hA4CEIqKp4YRTIA=;
  b=Fq/B05hjLOj7NVxInMmTm3MMZNDfOue2B2WXBujoPldP6kxsC3MLuRbW
   lrBOJDpien2tSkFgptlLCtg64kaixV/P7gK4zP3yZ+JBjaGRipkRogCDY
   2fi7oaEAh5YqqyBZesK/o9Li/ojC4QNoe+YPfBnv1GQdu303IIxjXN7bG
   Xp9ehJDQIS7uCKEIBLcH5jA75vEF951p3GlKcSHOvv6pd68PLQS5FZHrD
   REqzD9A+6WXA1EpB7uSV2p1C1fT2wFBtw1mkpEhWS5gtcls0AnU3DpzgN
   pd7IWKNU3dhB+X4z7P6gU27tvHTLfiIMxXTDKqY5mXy/T3jaU1PGB+UsX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="390233013"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="390233013"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 11:43:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="932458248"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="932458248"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 25 Oct 2023 11:43:03 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id E0D64430; Wed, 25 Oct 2023 21:43:01 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andy Shevchenko <andy@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v1 2/3] gpio: mmio: Make use of device properties
Date: Wed, 25 Oct 2023 21:42:58 +0300
Message-Id: <20231025184259.250588-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20231025184259.250588-1-andriy.shevchenko@linux.intel.com>
References: <20231025184259.250588-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the module to be property provider agnostic and allow
it to be used on non-OF platforms.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpio-mmio.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/drivers/gpio/gpio-mmio.c b/drivers/gpio/gpio-mmio.c
index 3ff0ea1e351c..66308b165a0d 100644
--- a/drivers/gpio/gpio-mmio.c
+++ b/drivers/gpio/gpio-mmio.c
@@ -58,7 +58,6 @@ o        `                     ~~~~\___/~~~~    ` controller in FPGA is ,.`
 #include <linux/platform_device.h>
 #include <linux/property.h>
 #include <linux/mod_devicetable.h>
-#include <linux/of.h>
 
 #include "gpiolib.h"
 
@@ -688,7 +687,6 @@ static void __iomem *bgpio_map(struct platform_device *pdev,
 	return devm_ioremap_resource(&pdev->dev, r);
 }
 
-#ifdef CONFIG_OF
 static const struct of_device_id bgpio_of_match[] = {
 	{ .compatible = "brcm,bcm6345-gpio" },
 	{ .compatible = "wd,mbl-gpio" },
@@ -697,36 +695,27 @@ static const struct of_device_id bgpio_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, bgpio_of_match);
 
-static struct bgpio_pdata *bgpio_parse_dt(struct platform_device *pdev,
-					  unsigned long *flags)
+static struct bgpio_pdata *bgpio_parse_fw(struct device *dev, unsigned long *flags)
 {
 	struct bgpio_pdata *pdata;
 
-	if (!pdev->dev.of_node)
+	if (!dev_fwnode(dev))
 		return NULL;
 
-	pdata = devm_kzalloc(&pdev->dev, sizeof(struct bgpio_pdata),
-			     GFP_KERNEL);
+	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
 		return ERR_PTR(-ENOMEM);
 
 	pdata->base = -1;
 
-	if (of_device_is_big_endian(pdev->dev.of_node))
+	if (device_is_big_endian(dev))
 		*flags |= BGPIOF_BIG_ENDIAN_BYTE_ORDER;
 
-	if (of_property_read_bool(pdev->dev.of_node, "no-output"))
+	if (device_property_read_bool(dev, "no-output"))
 		*flags |= BGPIOF_NO_OUTPUT;
 
 	return pdata;
 }
-#else
-static struct bgpio_pdata *bgpio_parse_dt(struct platform_device *pdev,
-					  unsigned long *flags)
-{
-	return NULL;
-}
-#endif /* CONFIG_OF */
 
 static int bgpio_pdev_probe(struct platform_device *pdev)
 {
@@ -743,7 +732,7 @@ static int bgpio_pdev_probe(struct platform_device *pdev)
 	struct gpio_chip *gc;
 	struct bgpio_pdata *pdata;
 
-	pdata = bgpio_parse_dt(pdev, &flags);
+	pdata = bgpio_parse_fw(dev, &flags);
 	if (IS_ERR(pdata))
 		return PTR_ERR(pdata);
 
@@ -814,7 +803,7 @@ MODULE_DEVICE_TABLE(platform, bgpio_id_table);
 static struct platform_driver bgpio_driver = {
 	.driver = {
 		.name = "basic-mmio-gpio",
-		.of_match_table = of_match_ptr(bgpio_of_match),
+		.of_match_table = bgpio_of_match,
 	},
 	.id_table = bgpio_id_table,
 	.probe = bgpio_pdev_probe,
-- 
2.40.0.1.gaa8946217a0b


