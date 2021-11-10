Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96D7344C274
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Nov 2021 14:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbhKJNuo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 10 Nov 2021 08:50:44 -0500
Received: from mga03.intel.com ([134.134.136.65]:61417 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232127AbhKJNuf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 10 Nov 2021 08:50:35 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10163"; a="232615009"
X-IronPort-AV: E=Sophos;i="5.87,223,1631602800"; 
   d="scan'208";a="232615009"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 05:47:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,223,1631602800"; 
   d="scan'208";a="546103996"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 10 Nov 2021 05:47:45 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D392F18E; Wed, 10 Nov 2021 15:47:47 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v1 2/2] gpiolib: acpi: shrink devm_acpi_dev_add_driver_gpios()
Date:   Wed, 10 Nov 2021 15:47:43 +0200
Message-Id: <20211110134743.4300-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211110134743.4300-1-andriy.shevchenko@linux.intel.com>
References: <20211110134743.4300-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

If all we want to manage is a single pointer, there's no need to
manually allocate and add a new devres. We can simply use
devm_add_action_or_reset() and shrink the code by a good bit.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib-acpi.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 25ecc0a37054..7dd0484b89c6 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -579,28 +579,22 @@ void acpi_dev_remove_driver_gpios(struct acpi_device *adev)
 }
 EXPORT_SYMBOL_GPL(acpi_dev_remove_driver_gpios);
 
-static void devm_acpi_dev_release_driver_gpios(struct device *dev, void *res)
+static void acpi_dev_release_driver_gpios(void *adev)
 {
-	acpi_dev_remove_driver_gpios(ACPI_COMPANION(dev));
+	acpi_dev_remove_driver_gpios(adev);
 }
 
 int devm_acpi_dev_add_driver_gpios(struct device *dev,
 				   const struct acpi_gpio_mapping *gpios)
 {
-	void *res;
+	struct acpi_device *adev = ACPI_COMPANION(dev);
 	int ret;
 
-	res = devres_alloc(devm_acpi_dev_release_driver_gpios, 0, GFP_KERNEL);
-	if (!res)
-		return -ENOMEM;
-
-	ret = acpi_dev_add_driver_gpios(ACPI_COMPANION(dev), gpios);
-	if (ret) {
-		devres_free(res);
+	ret = acpi_dev_add_driver_gpios(adev, gpios);
+	if (ret)
 		return ret;
-	}
-	devres_add(dev, res);
-	return 0;
+
+	return devm_add_action_or_reset(dev, acpi_dev_release_driver_gpios, adev);
 }
 EXPORT_SYMBOL_GPL(devm_acpi_dev_add_driver_gpios);
 
-- 
2.33.0

