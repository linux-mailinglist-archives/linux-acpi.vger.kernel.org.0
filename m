Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0746E25EDC5
	for <lists+linux-acpi@lfdr.de>; Sun,  6 Sep 2020 14:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbgIFMVf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 6 Sep 2020 08:21:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45512 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728807AbgIFMUm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 6 Sep 2020 08:20:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599394823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MCobL86FrEBavZygF1BSCZSOLRdneG+Jlnh8qtrQAF8=;
        b=UJC4DA8aF6NzDxqmPsAxbx3grfyjToi3G8q/j5irKVEsMwJvODDDr8pdDCbgJMsqxVCiD7
        hknqpSaMTkec7P/0JSrw4HpCD1UC9eVUxVimmIAvSd3acrH73PQ5c1evh2LUAHK4Hpe0/J
        tm8nxnAvbIY9KdURRcNrrLgT9dxW4bQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-560-Yg52OZkJP4SDFLSciZpGNQ-1; Sun, 06 Sep 2020 08:20:22 -0400
X-MC-Unique: Yg52OZkJP4SDFLSciZpGNQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DECBC1005E6E;
        Sun,  6 Sep 2020 12:20:20 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-17.ams2.redhat.com [10.36.112.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8327A5D9CC;
        Sun,  6 Sep 2020 12:20:19 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-input@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH] Input: soc_button_array - Work around DSDTs which modify the irqflags
Date:   Sun,  6 Sep 2020 14:20:16 +0200
Message-Id: <20200906122016.4628-2-hdegoede@redhat.com>
In-Reply-To: <20200906122016.4628-1-hdegoede@redhat.com>
References: <20200906122016.4628-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Some 2-in-1s which use the soc_button_array driver have this ugly issue in
their DSDT where the _LID method modifies the irq-type settings of the
GPIOs used for the power and home buttons. The intend of this AML code is
to disable these buttons when the lid is closed.

The AML does this by directly poking the GPIO controllers registers. This
is problematic because when re-enabling the irq, which happens whenever
_LID gets called with the lid open (e.g. on boot and on resume), it sets
the irq-type to IRQ_TYPE_LEVEL_LOW. Where as the gpio-keys driver programs
the type to, and expects it to be, IRQ_TYPE_EDGE_BOTH.

This commit adds a workaround for this which (on affected devices) does
not set gpio_keys_button.gpio on these 2-in-1s, instead it gets the irq for
the GPIO, configures it as IRQ_TYPE_LEVEL_LOW (to match how the _LID AML
code configures it) and passes the irq in gpio_keys_button.irq.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/misc/soc_button_array.c | 69 +++++++++++++++++++++++----
 1 file changed, 60 insertions(+), 9 deletions(-)

diff --git a/drivers/input/misc/soc_button_array.c b/drivers/input/misc/soc_button_array.c
index 837c787e9c4b..cae1a3fae83a 100644
--- a/drivers/input/misc/soc_button_array.c
+++ b/drivers/input/misc/soc_button_array.c
@@ -11,6 +11,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/acpi.h>
+#include <linux/dmi.h>
 #include <linux/gpio/consumer.h>
 #include <linux/gpio_keys.h>
 #include <linux/gpio.h>
@@ -42,23 +43,66 @@ struct soc_button_data {
 	struct platform_device *children[BUTTON_TYPES];
 };
 
+/*
+ * Some 2-in-1s which use the soc_button_array driver have this ugly issue in
+ * their DSDT where the _LID method modifies the irq-type settings of the GPIOs
+ * used for the power and home buttons. The intend of this AML code is to
+ * disable these buttons when the lid is closed.
+ * The AML does this by directly poking the GPIO controllers registers. This is
+ * problematic because when re-enabling the irq, which happens whenever _LID
+ * gets called with the lid open (e.g. on boot and on resume), it sets the
+ * irq-type to IRQ_TYPE_LEVEL_LOW. Where as the gpio-keys driver programs the
+ * type to, and expects it to be, IRQ_TYPE_EDGE_BOTH.
+ * To work around this we don't set gpio_keys_button.gpio on these 2-in-1s,
+ * instead we get the irq for the GPIO ourselves, configure it as
+ * IRQ_TYPE_LEVEL_LOW (to match how the _LID AML code configures it) and pass
+ * the irq in gpio_keys_button.irq. Below is a list of affected devices.
+ */
+static const struct dmi_system_id dmi_use_low_level_irq[] = {
+	{
+		/*
+		 * Acer Switch 10 SW5-012. _LID method messes with home- and
+		 * power-button GPIO IRQ settings. When (re-)enabling the irq
+		 * it ors in its own flags without clearing the previous set
+		 * ones, leading to an irq-type of IRQ_TYPE_LEVEL_LOW |
+		 * IRQ_TYPE_LEVEL_HIGH causing a continuous interrupt storm.
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire SW5-012"),
+		},
+	},
+	{
+		/*
+		 * Acer One S1003. _LID method messes with power-button GPIO
+		 * IRQ settings, leading to a non working power-button.
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "One S1003"),
+		},
+	},
+	{} /* Terminating entry */
+};
+
 /*
  * Get the Nth GPIO number from the ACPI object.
  */
-static int soc_button_lookup_gpio(struct device *dev, int acpi_index)
+static int soc_button_lookup_gpio(struct device *dev, int acpi_index,
+				  int *gpio_ret, int *irq_ret)
 {
 	struct gpio_desc *desc;
-	int gpio;
 
 	desc = gpiod_get_index(dev, NULL, acpi_index, GPIOD_ASIS);
 	if (IS_ERR(desc))
 		return PTR_ERR(desc);
 
-	gpio = desc_to_gpio(desc);
+	*gpio_ret = desc_to_gpio(desc);
+	*irq_ret = gpiod_to_irq(desc);
 
 	gpiod_put(desc);
 
-	return gpio;
+	return 0;
 }
 
 static struct platform_device *
@@ -70,9 +114,8 @@ soc_button_device_create(struct platform_device *pdev,
 	struct platform_device *pd;
 	struct gpio_keys_button *gpio_keys;
 	struct gpio_keys_platform_data *gpio_keys_pdata;
+	int error, gpio, irq;
 	int n_buttons = 0;
-	int gpio;
-	int error;
 
 	for (info = button_info; info->name; info++)
 		if (info->autorepeat == autorepeat)
@@ -92,8 +135,8 @@ soc_button_device_create(struct platform_device *pdev,
 		if (info->autorepeat != autorepeat)
 			continue;
 
-		gpio = soc_button_lookup_gpio(&pdev->dev, info->acpi_index);
-		if (!gpio_is_valid(gpio)) {
+		error = soc_button_lookup_gpio(&pdev->dev, info->acpi_index, &gpio, &irq);
+		if (error || irq < 0) {
 			/*
 			 * Skip GPIO if not present. Note we deliberately
 			 * ignore -EPROBE_DEFER errors here. On some devices
@@ -108,9 +151,17 @@ soc_button_device_create(struct platform_device *pdev,
 			continue;
 		}
 
+		/* See dmi_use_low_level_irq[] comment */
+		if (!autorepeat && dmi_check_system(dmi_use_low_level_irq)) {
+			irq_set_irq_type(irq, IRQ_TYPE_LEVEL_LOW);
+			gpio_keys[n_buttons].irq = irq;
+			gpio_keys[n_buttons].gpio = -ENOENT;
+		} else {
+			gpio_keys[n_buttons].gpio = gpio;
+		}
+
 		gpio_keys[n_buttons].type = info->event_type;
 		gpio_keys[n_buttons].code = info->event_code;
-		gpio_keys[n_buttons].gpio = gpio;
 		gpio_keys[n_buttons].active_low = info->active_low;
 		gpio_keys[n_buttons].desc = info->name;
 		gpio_keys[n_buttons].wakeup = info->wakeup;
-- 
2.28.0

