Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEE7D4438A5
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Nov 2021 23:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbhKBWnA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 2 Nov 2021 18:43:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:57069 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229844AbhKBWm7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Nov 2021 18:42:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635892824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LtkGYeDupOVlp4mYmQYWHhyomssu+8nyW0y2n+jxxU8=;
        b=eRV2QBM6xgEQ5BJ/1Ez9Co02ICY983wivwrnWKtvIrJC4VpI0Rz4Y45E3lp3gFHd5qf8Pi
        JFgWKlNA6cdqH5UMhbFfR1S5w0fXNlwX7u89SNGdAKJQTB3Qfd0bYFREqxNAxNJZENwiq0
        GtgMVkNJMehhr34WLzIdmjNdjC4f48c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-oF-Srp45NZ-2dzHu3Q8K0w-1; Tue, 02 Nov 2021 18:40:18 -0400
X-MC-Unique: oF-Srp45NZ-2dzHu3Q8K0w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ED05E80A5C0;
        Tue,  2 Nov 2021 22:40:16 +0000 (UTC)
Received: from x1.localdomain (unknown [10.39.192.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 71FCB60C05;
        Tue,  2 Nov 2021 22:40:08 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Sebastian Reichel <sre@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, Yauhen Kharuzhy <jekhor@gmail.com>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [RFC v2 2/2] platform/x86: xiaomi-mipad2: New driver for Xiaomi Mi Pad 2 tablets
Date:   Tue,  2 Nov 2021 23:39:59 +0100
Message-Id: <20211102223959.3873-3-hdegoede@redhat.com>
In-Reply-To: <20211102223959.3873-1-hdegoede@redhat.com>
References: <20211102223959.3873-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The ACPI tables on the Xiaomi Mi Pad 2 hide a number of devices from Linux,
such as the fuel-gauge IC used for battery monitoring.

This adds a xiaomi-mipad2 "board-file" which manually instantiates
device-objects for the missing devices.

When build as a module this will only ever get auto-loaded on Xiaomi
Mi Pad 2 tablets, allowing us to support these tablets in generic X86
kernels at the cost of just a small amount of diskspace for the module.

As discussed previously this is the least ugly option to get these
devices to fully work and to do so without adding any extra code to
the main kernel image (vmlinuz) when built as a module.

Link: https://lore.kernel.org/platform-driver-x86/20211031162428.22368-1-hdegoede@redhat.com/
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/Kconfig         |  13 +++
 drivers/platform/x86/Makefile        |   1 +
 drivers/platform/x86/xiaomi-mipad2.c | 126 +++++++++++++++++++++++++++
 3 files changed, 140 insertions(+)
 create mode 100644 drivers/platform/x86/xiaomi-mipad2.c

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 9cb8d33cc6e1..df8101fdfc6a 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -958,6 +958,19 @@ config TOPSTAR_LAPTOP
 
 	  If you have a Topstar laptop, say Y or M here.
 
+config XIAOMI_MIPAD2
+	tristate "Xiaomi Mi Pad 2 support"
+	depends on I2C && ACPI
+	help
+	  The ACPI tables on the Xiaomi Mi Pad 2 hide a number of devices
+	  from Linux, such as the fuel-gauge IC used for battery monitoring.
+
+	  Say Y or M here to enable building a xiaomi-mipad2 board-file which
+	  manually instantiates device-objects for the missing devices.
+
+	  If you have a Xiaomi Mi Pad 2 say Y or M here, for a generic X86
+	  distro config say M here.
+
 config I2C_MULTI_INSTANTIATE
 	tristate "I2C multi instantiate pseudo device driver"
 	depends on I2C && ACPI
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 3f610332b556..631f1b948cd0 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -105,6 +105,7 @@ obj-$(CONFIG_PANASONIC_LAPTOP)	+= panasonic-laptop.o
 obj-$(CONFIG_SONY_LAPTOP)	+= sony-laptop.o
 obj-$(CONFIG_SYSTEM76_ACPI)	+= system76_acpi.o
 obj-$(CONFIG_TOPSTAR_LAPTOP)	+= topstar-laptop.o
+obj-$(CONFIG_XIAOMI_MIPAD2)	+= xiaomi-mipad2.o
 
 # Platform drivers
 obj-$(CONFIG_DMI_DEVICE_PROPERTIES)	+= dmi_device_properties.o
diff --git a/drivers/platform/x86/xiaomi-mipad2.c b/drivers/platform/x86/xiaomi-mipad2.c
new file mode 100644
index 000000000000..bf333aaa0edf
--- /dev/null
+++ b/drivers/platform/x86/xiaomi-mipad2.c
@@ -0,0 +1,126 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * On the Xiaomi Mi Pad 2 X86 tablet a bunch of devices are hidden when
+ * the EFI if the tablet does thinks the OS it is booting is Windows
+ * (OSID in the DSDT is set to 1); and the EFI code thinks this as soon
+ * as the EFI bootloader is not Xiaomi's own signed Android loader :|
+ *
+ * This "board-file" takes care of instantiating the hidden devices manually.
+ *
+ * Copyright (C) 2021 Hans de Goede <hdegoede@redhat.com>
+ */
+
+#define pr_fmt(fmt) "xiaomi-mipad2: " fmt
+
+#include <linux/acpi.h>
+#include <linux/dmi.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+
+/********** BQ27520 fuel-gauge info **********/
+#define BQ27520_ADAPTER "\\_SB_.PCI0.I2C1"
+
+static const char * const bq27520_suppliers[] = { "bq25890-charger" };
+
+static const struct property_entry bq27520_props[] = {
+	PROPERTY_ENTRY_STRING_ARRAY("supplied-from", bq27520_suppliers),
+	{ }
+};
+
+static const struct software_node bq27520_node = {
+	.properties = bq27520_props,
+};
+
+static const struct i2c_board_info bq27520_board_info = {
+	.type = "bq27520",
+	.addr = 0x55,
+	.dev_name = "bq27520",
+	.swnode = &bq27520_node,
+};
+
+static struct i2c_client *bq27520_client;
+
+/********** KTD2026 RGB notification LED controller **********/
+#define KTD2026_ADAPTER "\\_SB_.PCI0.I2C3"
+
+static const struct i2c_board_info ktd2026_board_info = {
+	.type = "ktd2026",
+	.addr = 0x30,
+	.dev_name = "ktd2026",
+};
+
+static struct i2c_client *ktd2026_client;
+
+/********** DMI-match, probe(), etc. **********/
+static const struct dmi_system_id xiaomi_mipad2_ids[] __initconst = {
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Xiaomi Inc"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Mipad2"),
+		},
+	},
+	{} /* Terminating entry */
+};
+MODULE_DEVICE_TABLE(dmi, xiaomi_mipad2_ids);
+
+static __init struct i2c_client *xiaomi_instantiate_i2c_client(
+				char *adapter_path,
+				const struct i2c_board_info *board_info)
+{
+	struct i2c_client *client;
+	struct i2c_adapter *adap;
+	acpi_handle handle;
+	acpi_status status;
+
+	status = acpi_get_handle(NULL, adapter_path, &handle);
+	if (ACPI_FAILURE(status)) {
+		pr_err("Error could not get %s handle\n", adapter_path);
+		return ERR_PTR(-ENODEV);
+	}
+
+	adap = i2c_acpi_find_adapter_by_handle(handle);
+	if (!adap) {
+		pr_err("Error could not get %s adapter\n", adapter_path);
+		return ERR_PTR(-ENODEV);
+	}
+
+	client = i2c_new_client_device(adap, board_info);
+
+	put_device(&adap->dev);
+
+	return client;
+}
+
+static __init int xiaomi_mipad2_init(void)
+{
+	if (!dmi_first_match(xiaomi_mipad2_ids))
+		return -ENODEV;
+
+	bq27520_client = xiaomi_instantiate_i2c_client(BQ27520_ADAPTER,
+						       &bq27520_board_info);
+	if (IS_ERR(bq27520_client))
+		return PTR_ERR(bq27520_client);
+
+	ktd2026_client = xiaomi_instantiate_i2c_client(KTD2026_ADAPTER,
+						       &ktd2026_board_info);
+	if (IS_ERR(ktd2026_client)) {
+		i2c_unregister_device(bq27520_client);
+		return PTR_ERR(ktd2026_client);
+	}
+
+	return 0;
+}
+
+static __exit void xiaomi_mipad2_cleanup(void)
+{
+	i2c_unregister_device(ktd2026_client);
+	i2c_unregister_device(bq27520_client);
+}
+
+module_init(xiaomi_mipad2_init);
+module_exit(xiaomi_mipad2_cleanup);
+
+MODULE_AUTHOR("Hans de Goede <hdegoede@redhat.com");
+MODULE_DESCRIPTION("Xiaomi Mi Pad 2 board-file");
+MODULE_LICENSE("GPL");
-- 
2.31.1

