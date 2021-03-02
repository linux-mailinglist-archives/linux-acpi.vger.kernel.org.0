Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2C8832B44B
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Mar 2021 06:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353117AbhCCE54 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 2 Mar 2021 23:57:56 -0500
Received: from mga06.intel.com ([134.134.136.31]:34803 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1575730AbhCBPgh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 2 Mar 2021 10:36:37 -0500
IronPort-SDR: 3cOjDXXNB8z/wbmIQ0EmW5Aj7p6NBPUIxUYtjJopFY8pdTB4ji85rILzk9Kyz+3T5lXHRqyiME
 McV3lu9LLuhg==
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="248260337"
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
   d="scan'208";a="248260337"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2021 07:35:04 -0800
IronPort-SDR: IdF4RWc6/Ae8vJ9iKrEFdzbbtZcN4AqzXbUioWzbd2A4l5mjbMnQBd49BRg0cQmlj+tqPWTIb8
 i2oRAIRgl5vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
   d="scan'208";a="399068015"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 02 Mar 2021 07:35:03 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A218E13A; Tue,  2 Mar 2021 17:35:02 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v1 1/4] gpiolib: Unify the checks on fwnode type
Date:   Tue,  2 Mar 2021 17:34:48 +0200
Message-Id: <20210302153451.50593-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

We have (historically) different approaches how we identify the type
of a given fwnode. Let's standardize them across the library code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index adf55db080d8..484ac92903ab 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -3678,11 +3678,12 @@ EXPORT_SYMBOL_GPL(fwnode_gpiod_get_index);
  */
 int gpiod_count(struct device *dev, const char *con_id)
 {
+	const struct fwnode_handle *fwnode = dev_fwnode(dev);
 	int count = -ENOENT;
 
-	if (IS_ENABLED(CONFIG_OF) && dev && dev->of_node)
+	if (is_of_node(fwnode))
 		count = of_gpio_get_count(dev, con_id);
-	else if (IS_ENABLED(CONFIG_ACPI) && dev && ACPI_HANDLE(dev))
+	else if (is_acpi_node(fwnode))
 		count = acpi_gpio_count(dev, con_id);
 
 	if (count < 0)
@@ -3820,18 +3821,17 @@ struct gpio_desc *__must_check gpiod_get_index(struct device *dev,
 	int ret;
 	/* Maybe we have a device name, maybe not */
 	const char *devname = dev ? dev_name(dev) : "?";
+	const struct fwnode_handle *fwnode = dev ? dev_fwnode(dev) : NULL;
 
 	dev_dbg(dev, "GPIO lookup for consumer %s\n", con_id);
 
-	if (dev) {
-		/* Using device tree? */
-		if (IS_ENABLED(CONFIG_OF) && dev->of_node) {
-			dev_dbg(dev, "using device tree for GPIO lookup\n");
-			desc = of_find_gpio(dev, con_id, idx, &lookupflags);
-		} else if (ACPI_COMPANION(dev)) {
-			dev_dbg(dev, "using ACPI for GPIO lookup\n");
-			desc = acpi_find_gpio(dev, con_id, idx, &flags, &lookupflags);
-		}
+	/* Using device tree? */
+	if (is_of_node(fwnode)) {
+		dev_dbg(dev, "using device tree for GPIO lookup\n");
+		desc = of_find_gpio(dev, con_id, idx, &lookupflags);
+	} else if (is_acpi_node(fwnode)) {
+		dev_dbg(dev, "using ACPI for GPIO lookup\n");
+		desc = acpi_find_gpio(dev, con_id, idx, &flags, &lookupflags);
 	}
 
 	/*
@@ -3915,9 +3915,6 @@ struct gpio_desc *fwnode_get_named_gpiod(struct fwnode_handle *fwnode,
 	struct gpio_desc *desc = ERR_PTR(-ENODEV);
 	int ret;
 
-	if (!fwnode)
-		return ERR_PTR(-EINVAL);
-
 	if (is_of_node(fwnode)) {
 		desc = gpiod_get_from_of_node(to_of_node(fwnode),
 					      propname, index,
@@ -3933,7 +3930,8 @@ struct gpio_desc *fwnode_get_named_gpiod(struct fwnode_handle *fwnode,
 
 		acpi_gpio_update_gpiod_flags(&dflags, &info);
 		acpi_gpio_update_gpiod_lookup_flags(&lflags, &info);
-	}
+	} else
+		return ERR_PTR(-EINVAL);
 
 	/* Currently only ACPI takes this path */
 	ret = gpiod_request(desc, label);
-- 
2.30.1

