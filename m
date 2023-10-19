Return-Path: <linux-acpi+bounces-764-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4127D01ED
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Oct 2023 20:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95534280D9B
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Oct 2023 18:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B8139843
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Oct 2023 18:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FK3dayYJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D49335A7
	for <linux-acpi@vger.kernel.org>; Thu, 19 Oct 2023 17:35:09 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79398187;
	Thu, 19 Oct 2023 10:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697736907; x=1729272907;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3LQFQSjAmhdexmjB2MNVF4dNzHqUHaGq6iDWHa57HD8=;
  b=FK3dayYJ/IsW38/39Fd9b1lUfTJb1y5FN3c3veNQFrsbbzZnNcPO3lIB
   Hh7QAsKpaZzAXcIicrZpilpHj8/MGxx/DqkW6RwkzNsRaJ2TtFz2BuUYW
   iQFQyll3ocE5IgtUpPWGufM+wricACyO7B9q12u4UJ7f5pWwCjasucqJa
   DNwxIGvMAsh35gMUZEYWZmWIDTatqRQLNOMs5HMITsYLwIflpldD22zVB
   sb1GLXl62h181Sr9Nqj+on1AgosvX9/FlQn2j7jf/E6s5QtxlF+Jh+o5W
   AJRyyp4khZGsExmnDX7xg+pK5oTGD1Q5xUBvAl/cV1qU/tygjedgB/dJt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="389184265"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="389184265"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 10:35:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="760723569"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="760723569"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 19 Oct 2023 10:35:02 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 676D9A46; Thu, 19 Oct 2023 20:35:01 +0300 (EEST)
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
Subject: [PATCH v1 3/3] gpiolib: Make debug messages in gpiod_find_by_fwnode() less confusing
Date: Thu, 19 Oct 2023 20:34:57 +0300
Message-Id: <20231019173457.2445119-4-andriy.shevchenko@linux.intel.com>
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

Currently the extended debug messages have added confusion,
but value when con_id is NULL, which is the case for, e.g.,
GPIO LEDs.

Improve the messaging by using GPIO function name rather than con_id.
This requires to split and move the second part after the respective
calls.

Reported-by: Ferry Toth <ftoth@exalondelft.nl>
Fixes: 8eb1f71e7acc ("gpiolib: consolidate GPIO lookups")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index beac3031246e..2cc275fb62b6 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -3946,18 +3946,15 @@ static struct gpio_desc *gpiod_find_by_fwnode(struct fwnode_handle *fwnode,
 	struct gpio_desc *desc = ERR_PTR(-ENOENT);
 
 	if (is_of_node(fwnode)) {
-		dev_dbg(consumer, "using DT '%pfw' for '%s' GPIO lookup\n",
-			fwnode, con_id);
+		dev_dbg(consumer, "using DT '%pfw' for GPIO lookup\n", fwnode);
 		desc = of_find_gpio(to_of_node(fwnode), con_id, idx, propname, propsize,
 				    lookupflags);
 	} else if (is_acpi_node(fwnode)) {
-		dev_dbg(consumer, "using ACPI '%pfw' for '%s' GPIO lookup\n",
-			fwnode, con_id);
+		dev_dbg(consumer, "using ACPI '%pfw' for GPIO lookup\n", fwnode);
 		desc = acpi_find_gpio(fwnode, con_id, idx, propname, propsize,
 				      flags, lookupflags);
 	} else if (is_software_node(fwnode)) {
-		dev_dbg(consumer, "using swnode '%pfw' for '%s' GPIO lookup\n",
-			fwnode, con_id);
+		dev_dbg(consumer, "using swnode '%pfw' for GPIO lookup\n", fwnode);
 		desc = swnode_find_gpio(fwnode, con_id, idx, propname, propsize,
 					lookupflags);
 	}
@@ -3993,10 +3990,12 @@ static struct gpio_desc *gpiod_find_and_request(struct device *consumer,
 	}
 
 	if (IS_ERR(desc)) {
-		dev_dbg(consumer, "No GPIO consumer %s found\n", con_id);
+		dev_dbg(consumer, "No GPIO descriptor for '%s' found\n", funcname);
 		return desc;
 	}
 
+	dev_dbg(consumer, "Found GPIO descriptor for '%s'\n", funcname);
+
 	/*
 	 * If a connection label was passed use that, else attempt to use
 	 * the device name as label
@@ -4015,13 +4014,13 @@ static struct gpio_desc *gpiod_find_and_request(struct device *consumer,
 		 * FIXME: Make this more sane and safe.
 		 */
 		dev_info(consumer,
-			 "nonexclusive access to GPIO for %s\n", con_id);
+			 "nonexclusive access to GPIO for %s\n", funcname);
 		return desc;
 	}
 
 	ret = gpiod_configure_flags(desc, funcname, lookupflags, flags);
 	if (ret < 0) {
-		dev_dbg(consumer, "setup of GPIO %s failed\n", con_id);
+		dev_dbg(consumer, "setup of GPIO %s failed\n", funcname);
 		gpiod_put(desc);
 		return ERR_PTR(ret);
 	}
-- 
2.40.0.1.gaa8946217a0b


