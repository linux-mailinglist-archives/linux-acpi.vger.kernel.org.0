Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 263962CE8D2
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Dec 2020 08:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgLDHvd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Dec 2020 02:51:33 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:53869 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728006AbgLDHvd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Dec 2020 02:51:33 -0500
Received: from [111.196.65.193] (helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <hui.wang@canonical.com>)
        id 1kl5rd-0006Ro-9N; Fri, 04 Dec 2020 07:50:50 +0000
From:   Hui Wang <hui.wang@canonical.com>
To:     linux-acpi@vger.kernel.org, rafael.j.wysocki@intel.com
Cc:     lenb@kernel.org
Subject: [PATCH] ACPI / bus: skip the primary physical pnp device in companion_match
Date:   Fri,  4 Dec 2020 15:50:41 +0800
Message-Id: <20201204075041.44339-1-hui.wang@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

We are working on some latest Thinkpad Yoga and Carbon laptops, the
touchscreen doesn't work on those machines. And we found the
touchscreen module is I2C wacom WACF2200 (056A:5276).

The problem is in the acpi_pnp.c, the WACFXXX is in the
acpi_pnp_device_ids[], so a pnp device will be built and attach to the
acpi_dev as the 1st physical_node, later when I2C subsystem starts to
initialize, it will build an I2C_dev and attach to the acpi_dev as the
2nd physical_node. When I2C bus needs to match the acpi_id_table, it
will call acpi_companion_match(), because the 1st physical_node is not
I2C_dev, it fails to match, then the i2c driver (hid_i2c) will not be
called.

To fix it, adding a special treatment in the companion_match(): if the
1st dev is on pnp bus and the device in question is not on pnp bus,
skip the 1st physical device, just use the device in question to
match.

We could refer to the pnpacpi_add_device() in the
pnp/pnpacpi/core.c, pnp device will not be built if the acpi_dev
is already attached to a physical device, so a pnp device has
lower priority than other devices, it is safe to skip it in
the companion_match().

Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 drivers/acpi/bus.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 1682f8b454a2..8aa0a861ca29 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -582,6 +582,15 @@ bool acpi_device_is_first_physical_node(struct acpi_device *adev,
 	return !!acpi_primary_dev_companion(adev, dev);
 }
 
+/* Could move this function to linux/pnp.h in the future */
+static bool acpi_dev_is_on_pnp_bus(const struct device *dev)
+{
+	if (dev->bus)
+		return !strcmp(dev->bus->name, "pnp");
+	else
+		return false;
+}
+
 /*
  * acpi_companion_match() - Can we match via ACPI companion device
  * @dev: Device in question
@@ -597,7 +606,9 @@ bool acpi_device_is_first_physical_node(struct acpi_device *adev,
  * companion.  A typical case is an MFD device where all the sub-devices share
  * the parent's ACPI companion.  In such cases we can only allow the primary
  * (first) physical device to be matched with the help of the companion's PNP
- * IDs.
+ * IDs. And another case is a pnp device is attached to ACPI device first, then
+ * other function devices are attached too, in this case, the primary physical
+ * device (pnp) is ignored, just use the device in question to match.
  *
  * Additional physical devices sharing the ACPI companion can still use
  * resources available from it but they will be matched normally using functions
@@ -605,7 +616,7 @@ bool acpi_device_is_first_physical_node(struct acpi_device *adev,
  */
 struct acpi_device *acpi_companion_match(const struct device *dev)
 {
-	struct acpi_device *adev;
+	struct acpi_device *adev, *radev;
 
 	adev = ACPI_COMPANION(dev);
 	if (!adev)
@@ -614,7 +625,15 @@ struct acpi_device *acpi_companion_match(const struct device *dev)
 	if (list_empty(&adev->pnp.ids))
 		return NULL;
 
-	return acpi_primary_dev_companion(adev, dev);
+	radev = acpi_primary_dev_companion(adev, dev);
+	if (radev == NULL) {
+		const struct device *first_dev = acpi_get_first_physical_node(adev);
+
+		if (acpi_dev_is_on_pnp_bus(first_dev) && !acpi_dev_is_on_pnp_bus(dev))
+			radev = adev;
+	}
+
+	return radev;
 }
 
 /**
@@ -831,7 +850,6 @@ bool acpi_driver_match_device(struct device *dev,
 		return acpi_of_match_device(ACPI_COMPANION(dev),
 					    drv->of_match_table,
 					    NULL);
-
 	return __acpi_match_device(acpi_companion_match(dev),
 				   drv->acpi_match_table, drv->of_match_table,
 				   NULL, NULL);
-- 
2.25.1

