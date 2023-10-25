Return-Path: <linux-acpi+bounces-981-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F927D75BC
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 22:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 105BB1C20CE9
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 20:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C2934182
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 20:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QP1lsWlI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13693286B1
	for <linux-acpi@vger.kernel.org>; Wed, 25 Oct 2023 18:51:35 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D19DC
	for <linux-acpi@vger.kernel.org>; Wed, 25 Oct 2023 11:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698259895; x=1729795895;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DsRoRBNKoqw/Cc7dTmkqie/fv1TrhPx6ZfTLpdADeQM=;
  b=QP1lsWlIEzIyTZLA3k4MMUQ5D2E2ekDphc61eEvKAGqwNL5Dt471Dk14
   VX9Y0M5HOyfDlrlxH7sIpFQzqfZam42qbaa5mA6CAXuqGSKYDH4O6f7Ve
   ocX/Lmg8vS8qY9DnEZ91STlbgCpNX02y3layPrfTyWS3k6mr7Ll8kbCJZ
   9Or9NpCZypA9tFD0EIKI/WCFOUE4yi85NIunG6pih/pqw2u6xfqQKjKzM
   0jYaQrYYJ4oKY+Y2j0O0duMN5q6YIYairngSCnu/NscUcOnm/2voW6fw9
   ASRRhFgkje8+tOCqT36e5m/ULxrWLGFj1zEp8bJEM/jyLYEF3SM9OLd5g
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="176173"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="176173"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 11:50:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="902642576"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="902642576"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 25 Oct 2023 11:48:03 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id EABB12F3; Wed, 25 Oct 2023 21:43:01 +0300 (EEST)
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
Subject: [PATCH v1 3/3] gpio: mmio: Clean up headers
Date: Wed, 25 Oct 2023 21:42:59 +0300
Message-Id: <20231025184259.250588-4-andriy.shevchenko@linux.intel.com>
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

There is a few things done:
- include only the headers we are direct user of
- add missing headers
- group generic headers and subsystem headers
- sort each group alphabetically

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpio-mmio.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/gpio/gpio-mmio.c b/drivers/gpio/gpio-mmio.c
index 66308b165a0d..71e1af7c2184 100644
--- a/drivers/gpio/gpio-mmio.c
+++ b/drivers/gpio/gpio-mmio.c
@@ -40,24 +40,22 @@ o        `                     ~~~~\___/~~~~    ` controller in FPGA is ,.`
  *               `.......````.```
  */
 
-#include <linux/init.h>
-#include <linux/err.h>
-#include <linux/bug.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/spinlock.h>
-#include <linux/compiler.h>
-#include <linux/types.h>
-#include <linux/errno.h>
-#include <linux/log2.h>
-#include <linux/ioport.h>
-#include <linux/io.h>
-#include <linux/gpio/driver.h>
-#include <linux/slab.h>
 #include <linux/bitops.h>
+#include <linux/compiler.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
+#include <linux/log2.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
-#include <linux/mod_devicetable.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+
+#include <linux/gpio/driver.h>
 
 #include "gpiolib.h"
 
-- 
2.40.0.1.gaa8946217a0b


