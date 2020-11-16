Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 066AE2B45DA
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Nov 2020 15:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgKPO3E (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 16 Nov 2020 09:29:04 -0500
Received: from mga11.intel.com ([192.55.52.93]:2629 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729446AbgKPO3E (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 16 Nov 2020 09:29:04 -0500
IronPort-SDR: Xx86j9uNvuUr1tyBh+6Ume0JM6+1CDB3Dyb5LGZEWLD4QaLWdys08mTsUaWwDjZqEvBr7JrVDU
 JE+3e0hTNoUw==
X-IronPort-AV: E=McAfee;i="6000,8403,9806"; a="167241605"
X-IronPort-AV: E=Sophos;i="5.77,482,1596524400"; 
   d="scan'208";a="167241605"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 06:29:03 -0800
IronPort-SDR: cJOzPQHxlyVNoAYpMnc6L/jHmRXk2oOX2XMLnjm588yVytwMFoHcsdTk/MbnPGrT5XQ7IJ61eI
 JoduHMaMJf9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,482,1596524400"; 
   d="scan'208";a="340548529"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 16 Nov 2020 06:29:02 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4559511E; Mon, 16 Nov 2020 16:29:01 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, linux-acpi@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 3/3] rtc: ds1307: Drop of_match_ptr and CONFIG_OF protections
Date:   Mon, 16 Nov 2020 16:28:59 +0200
Message-Id: <20201116142859.31257-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201116142859.31257-1-andriy.shevchenko@linux.intel.com>
References: <20201116142859.31257-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

These prevent use of this driver with ACPI via PRP0001.
Drop them to remove this restriction.

Also added mod_devicetable.h include given use of struct of_device_id.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: no changes
 drivers/rtc/rtc-ds1307.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index 49260bc260e3..fdf25db1b1b3 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -11,8 +11,8 @@
 #include <linux/bcd.h>
 #include <linux/i2c.h>
 #include <linux/init.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of.h>
 #include <linux/property.h>
 #include <linux/rtc/ds1307.h>
 #include <linux/rtc.h>
@@ -1091,7 +1091,6 @@ static const struct i2c_device_id ds1307_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, ds1307_id);
 
-#ifdef CONFIG_OF
 static const struct of_device_id ds1307_of_match[] = {
 	{
 		.compatible = "dallas,ds1307",
@@ -1168,7 +1167,6 @@ static const struct of_device_id ds1307_of_match[] = {
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ds1307_of_match);
-#endif
 
 /*
  * The ds1337 and ds1339 both have two alarms, but we only use the first
@@ -2035,7 +2033,7 @@ static int ds1307_probe(struct i2c_client *client,
 static struct i2c_driver ds1307_driver = {
 	.driver = {
 		.name	= "rtc-ds1307",
-		.of_match_table = of_match_ptr(ds1307_of_match),
+		.of_match_table = ds1307_of_match,
 	},
 	.probe		= ds1307_probe,
 	.id_table	= ds1307_id,
-- 
2.28.0

