Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2287332221
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Mar 2021 10:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbhCIJiC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 9 Mar 2021 04:38:02 -0500
Received: from mga18.intel.com ([134.134.136.126]:33412 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229649AbhCIJht (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 9 Mar 2021 04:37:49 -0500
IronPort-SDR: kSgwqjBL4xhu97k6y21ydpPe4HJ/TU4LIuafLYP2EOLdcZdw6+UWicA+dHpvS4115erlEHl6Cs
 jT98OYcyXjMQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="175802436"
X-IronPort-AV: E=Sophos;i="5.81,234,1610438400"; 
   d="scan'208";a="175802436"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2021 01:37:40 -0800
IronPort-SDR: F3cw82QTEjRFAEaDiraLXuF1BborSLskO6Qyi371vv+yiWUNKos1+i3q2eCwSjo4IKhqObRk1r
 /ilPoNi4Mcjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,234,1610438400"; 
   d="scan'208";a="599256167"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 09 Mar 2021 01:37:37 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 611BD490; Tue,  9 Mar 2021 11:37:38 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Cc:     Marc Zyngier <maz@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v6 2/6] gpiolib: Unify the checks on fwnode type
Date:   Tue,  9 Mar 2021 11:37:32 +0200
Message-Id: <20210309093736.67925-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210309093736.67925-1-andriy.shevchenko@linux.intel.com>
References: <20210309093736.67925-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

We have (historically) different approaches how we identify the type
of a given fwnode. Let's standardize them across the library code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpiolib.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 7ec0822c0505..1b3b0acdb803 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -3677,11 +3677,12 @@ EXPORT_SYMBOL_GPL(fwnode_gpiod_get_index);
  */
 int gpiod_count(struct device *dev, const char *con_id)
 {
+	const struct fwnode_handle *fwnode = dev ? dev_fwnode(dev) : NULL;
 	int count = -ENOENT;
 
-	if (IS_ENABLED(CONFIG_OF) && dev && dev->of_node)
+	if (is_of_node(fwnode))
 		count = of_gpio_get_count(dev, con_id);
-	else if (IS_ENABLED(CONFIG_ACPI) && dev && ACPI_HANDLE(dev))
+	else if (is_acpi_node(fwnode))
 		count = acpi_gpio_count(dev, con_id);
 
 	if (count < 0)
@@ -3819,18 +3820,17 @@ struct gpio_desc *__must_check gpiod_get_index(struct device *dev,
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
@@ -3914,9 +3914,6 @@ struct gpio_desc *fwnode_get_named_gpiod(struct fwnode_handle *fwnode,
 	struct gpio_desc *desc = ERR_PTR(-ENODEV);
 	int ret;
 
-	if (!fwnode)
-		return ERR_PTR(-EINVAL);
-
 	if (is_of_node(fwnode)) {
 		desc = gpiod_get_from_of_node(to_of_node(fwnode),
 					      propname, index,
@@ -3932,7 +3929,8 @@ struct gpio_desc *fwnode_get_named_gpiod(struct fwnode_handle *fwnode,
 
 		acpi_gpio_update_gpiod_flags(&dflags, &info);
 		acpi_gpio_update_gpiod_lookup_flags(&lflags, &info);
-	}
+	} else
+		return ERR_PTR(-EINVAL);
 
 	/* Currently only ACPI takes this path */
 	ret = gpiod_request(desc, label);
-- 
2.30.1

