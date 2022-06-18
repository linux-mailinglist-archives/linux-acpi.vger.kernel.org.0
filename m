Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8855D55043B
	for <lists+linux-acpi@lfdr.de>; Sat, 18 Jun 2022 13:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbiFRLXm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 18 Jun 2022 07:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbiFRLX3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 18 Jun 2022 07:23:29 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9683923BC3
        for <linux-acpi@vger.kernel.org>; Sat, 18 Jun 2022 04:23:26 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1o2WXv-0006pY-Lg; Sat, 18 Jun 2022 13:23:19 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1o2WXt-001F1W-Au; Sat, 18 Jun 2022 13:23:18 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1o2WXu-00HA0B-21; Sat, 18 Jun 2022 13:23:18 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>
Cc:     linux-acpi@vger.kernel.org, devel@acpica.org, kernel@pengutronix.de
Subject: [PATCH 2/2] ACPI: Drop driver member of struct acpi_device
Date:   Sat, 18 Jun 2022 13:23:11 +0200
Message-Id: <20220618112311.14661-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220618112311.14661-1-u.kleine-koenig@pengutronix.de>
References: <20220618112311.14661-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3884; h=from:subject; bh=3iKbkLDMedONIiVXXxpXy48gVNQ6hIFJAZCoG9BqSeA=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBirbWbVaxSA2zrp6bqmxK06vB2Z9d8YbrDnHtmDKaF dFqhRrqJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYq21mwAKCRDB/BR4rcrsCbb+B/ 99ugqgGPY3dWgZka8x6a8se1Ctxs1oSsSzhUBMX/bwG4dS5NKbSrRZ5T4JZg4wbp33kHymFEfVdz8o I/xFDl6Snrs3E9YiBcD6mmM6wdfbBM6RKj7i4Cjn4sPotWhSeUmk2l8NFsMIw22qLjNTeiZUxrRuYk Yx7Fb+kJfYIRqio2aO7dcrv51vdKi7zWF/mxlWTCI6R9ti7IMpvtyfXaEEm+/SvR6YZtxqnz1I5+HY fvND58sc9TNmXzU/+LrxkQ8YuwS+dWaZjqNgxME+Oi6wrve6pfLg2GPiQmX8H2tNpve95encQ03RXh o0yhu0ysZ/R6HgD07ZIJjz0XBuGJ8f
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-acpi@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

struct acpi_device::driver tracks the same information as the driver
member of struct acpi_device::dev.

Fix all users of the former to use the latter and drop the redundant
data from struct acpi_device.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/acpi/bus.c          | 21 ++++++++++-----------
 drivers/acpi/device_sysfs.c |  2 +-
 include/acpi/acpi_bus.h     |  1 -
 3 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 67a3f8cf42f9..c1c06c775ae1 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -465,7 +465,6 @@ static void acpi_bus_osc_negotiate_usb_control(void)
 static void acpi_bus_notify(acpi_handle handle, u32 type, void *data)
 {
 	struct acpi_device *adev;
-	struct acpi_driver *driver;
 	u32 ost_code = ACPI_OST_SC_NON_SPECIFIC_FAILURE;
 	bool hotplug_event = false;
 
@@ -517,10 +516,13 @@ static void acpi_bus_notify(acpi_handle handle, u32 type, void *data)
 	if (!adev)
 		goto err;
 
-	driver = adev->driver;
-	if (driver && driver->ops.notify &&
-	    (driver->flags & ACPI_DRIVER_ALL_NOTIFY_EVENTS))
-		driver->ops.notify(adev, type);
+	if (adev->dev.driver) {
+		struct acpi_driver *driver = to_acpi_driver(adev->dev.driver);
+
+		if (driver && driver->ops.notify &&
+		    (driver->flags & ACPI_DRIVER_ALL_NOTIFY_EVENTS))
+			driver->ops.notify(adev, type);
+	}
 
 	if (!hotplug_event) {
 		acpi_bus_put_acpi_device(adev);
@@ -539,8 +541,9 @@ static void acpi_bus_notify(acpi_handle handle, u32 type, void *data)
 static void acpi_notify_device(acpi_handle handle, u32 event, void *data)
 {
 	struct acpi_device *device = data;
+	struct acpi_driver *acpi_drv = to_acpi_driver(device->dev.driver);
 
-	device->driver->ops.notify(device, event);
+	acpi_drv->ops.notify(device, event);
 }
 
 static void acpi_notify_device_fixed(void *data)
@@ -1033,8 +1036,6 @@ static int acpi_device_probe(struct device *dev)
 	if (ret)
 		return ret;
 
-	acpi_dev->driver = acpi_drv;
-
 	pr_debug("Driver [%s] successfully bound to device [%s]\n",
 		 acpi_drv->name, acpi_dev->pnp.bus_id);
 
@@ -1044,7 +1045,6 @@ static int acpi_device_probe(struct device *dev)
 			if (acpi_drv->ops.remove)
 				acpi_drv->ops.remove(acpi_dev);
 
-			acpi_dev->driver = NULL;
 			acpi_dev->driver_data = NULL;
 			return ret;
 		}
@@ -1060,14 +1060,13 @@ static int acpi_device_probe(struct device *dev)
 static void acpi_device_remove(struct device *dev)
 {
 	struct acpi_device *acpi_dev = to_acpi_device(dev);
-	struct acpi_driver *acpi_drv = acpi_dev->driver;
+	struct acpi_driver *acpi_drv = to_acpi_driver(dev->driver);
 
 	if (acpi_drv->ops.notify)
 		acpi_device_remove_notify_handler(acpi_dev);
 	if (acpi_drv->ops.remove)
 		acpi_drv->ops.remove(acpi_dev);
 
-	acpi_dev->driver = NULL;
 	acpi_dev->driver_data = NULL;
 
 	put_device(dev);
diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
index d5d6403ba07b..120873dad2cc 100644
--- a/drivers/acpi/device_sysfs.c
+++ b/drivers/acpi/device_sysfs.c
@@ -376,7 +376,7 @@ eject_store(struct device *d, struct device_attribute *attr,
 		return -EINVAL;
 
 	if ((!acpi_device->handler || !acpi_device->handler->hotplug.enabled)
-	    && !acpi_device->driver)
+	    && !d->driver)
 		return -ENODEV;
 
 	status = acpi_get_type(acpi_device->handle, &not_used);
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 0dc1ea0b52f5..c7e4a588dfca 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -379,7 +379,6 @@ struct acpi_device {
 	struct acpi_device_data data;
 	struct acpi_scan_handler *handler;
 	struct acpi_hotplug_context *hp;
-	struct acpi_driver *driver;
 	const struct acpi_gpio_mapping *driver_gpios;
 	void *driver_data;
 	struct device dev;
-- 
2.36.1

