Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46AA01A26DD
	for <lists+linux-acpi@lfdr.de>; Wed,  8 Apr 2020 18:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730245AbgDHQJn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 8 Apr 2020 12:09:43 -0400
Received: from mga02.intel.com ([134.134.136.20]:63811 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730200AbgDHQJe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 8 Apr 2020 12:09:34 -0400
IronPort-SDR: ixUddFKgbwTcsXRwhJplwu5HXP23mBuWMunR7hAlegQJ6TOGHnTrlAZAfd0f3Yp2Vb161d3ytO
 lgJKsx7GvPWw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2020 09:09:31 -0700
IronPort-SDR: X/HwM5LlHlyOMs2ZwnEBQI1g1sURXg95Cz1kNUHKE4pTeHyE2gsYBm1Jb2ZJFw0kGUfV8vIE1A
 2Qb9l2bdmzfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,359,1580803200"; 
   d="scan'208";a="398246243"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 08 Apr 2020 09:09:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id AA5FE981; Wed,  8 Apr 2020 19:09:25 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org,
        Darren Hart <dvhart@infradead.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 6/6] platform/x86: intel_cht_int33fe: Fix spelling issues
Date:   Wed,  8 Apr 2020 19:09:06 +0300
Message-Id: <20200408160905.12101-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200408160905.12101-1-andriy.shevchenko@linux.intel.com>
References: <20200408160905.12101-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Fix spelling issues over the comments in the code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 .../platform/x86/intel_cht_int33fe_typec.c    | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/platform/x86/intel_cht_int33fe_typec.c b/drivers/platform/x86/intel_cht_int33fe_typec.c
index e89defb33067..48638d1c56e5 100644
--- a/drivers/platform/x86/intel_cht_int33fe_typec.c
+++ b/drivers/platform/x86/intel_cht_int33fe_typec.c
@@ -6,14 +6,14 @@
  *
  * Some Intel Cherry Trail based device which ship with Windows 10, have
  * this weird INT33FE ACPI device with a CRS table with 4 I2cSerialBusV2
- * resources, for 4 different chips attached to various i2c busses:
- * 1. The Whiskey Cove pmic, which is also described by the INT34D3 ACPI device
+ * resources, for 4 different chips attached to various I²C buses:
+ * 1. The Whiskey Cove PMIC, which is also described by the INT34D3 ACPI device
  * 2. Maxim MAX17047 Fuel Gauge Controller
  * 3. FUSB302 USB Type-C Controller
  * 4. PI3USB30532 USB switch
  *
  * So this driver is a stub / pseudo driver whose only purpose is to
- * instantiate i2c-clients for chips 2 - 4, so that standard i2c drivers
+ * instantiate I²C clients for chips 2 - 4, so that standard I²C drivers
  * for these chips can bind to the them.
  */
 
@@ -29,11 +29,11 @@
 #include "intel_cht_int33fe_common.h"
 
 /*
- * Grrr I severly dislike buggy BIOS-es. At least one BIOS enumerates
+ * Grrr, I severely dislike buggy BIOS-es. At least one BIOS enumerates
  * the max17047 both through the INT33FE ACPI device (it is right there
  * in the resources table) as well as through a separate MAX17047 device.
  *
- * These helpers are used to work around this by checking if an i2c-client
+ * These helpers are used to work around this by checking if an I²C client
  * for the max17047 has already been registered.
  */
 static int cht_int33fe_check_for_max17047(struct device *dev, void *data)
@@ -235,9 +235,9 @@ cht_int33fe_register_max17047(struct device *dev, struct cht_int33fe_data *data)
 
 	i2c_for_each_dev(&max17047, cht_int33fe_check_for_max17047);
 	if (max17047) {
-		/* Pre-existing i2c-client for the max17047, add device-props */
+		/* Pre-existing I²C client for the max17047, add device properties */
 		set_secondary_fwnode(&max17047->dev, fwnode);
-		/* And re-probe to get the new device-props applied. */
+		/* And re-probe to get the new device properties applied */
 		ret = device_reprobe(&max17047->dev);
 		if (ret)
 			dev_warn(dev, "Reprobing max17047 error: %d\n", ret);
@@ -272,7 +272,7 @@ int cht_int33fe_typec_probe(struct cht_int33fe_data *data)
 	 *    must be registered before the fusb302 is instantiated, otherwise
 	 *    it will end up with a dummy-regulator.
 	 * Note "cht_wc_usb_typec_vbus" comes from the regulator_init_data
-	 * which is defined in i2c-cht-wc.c from where the bq24292i i2c-client
+	 * which is defined in i2c-cht-wc.c from where the bq24292i I²C client
 	 * gets instantiated. We use regulator_get_optional here so that we
 	 * don't end up getting a dummy-regulator ourselves.
 	 */
@@ -283,7 +283,7 @@ int cht_int33fe_typec_probe(struct cht_int33fe_data *data)
 	}
 	regulator_put(regulator);
 
-	/* The FUSB302 uses the irq at index 1 and is the only irq user */
+	/* The FUSB302 uses the IRQ at index 1 and is the only IRQ user */
 	fusb302_irq = acpi_dev_gpio_irq_get(ACPI_COMPANION(dev), 1);
 	if (fusb302_irq < 0) {
 		if (fusb302_irq != -EPROBE_DEFER)
@@ -295,7 +295,7 @@ int cht_int33fe_typec_probe(struct cht_int33fe_data *data)
 	if (ret)
 		return ret;
 
-	/* Work around BIOS bug, see comment on cht_int33fe_check_for_max17047 */
+	/* Work around BIOS bug, see comment on cht_int33fe_check_for_max17047() */
 	ret = cht_int33fe_register_max17047(dev, data);
 	if (ret)
 		goto out_remove_nodes;
-- 
2.25.1

