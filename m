Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D924C2A29
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Feb 2022 12:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233737AbiBXLDd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 24 Feb 2022 06:03:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233741AbiBXLDb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Feb 2022 06:03:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 233DD28F95B
        for <linux-acpi@vger.kernel.org>; Thu, 24 Feb 2022 03:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645700580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GWEw6H14M1aLtfsyUMXO/aZgUscw6B2S499EVsod82o=;
        b=BT+bqleaA/1+c9toCaVGa7nmTAhHKUVmoSHa1yfaOP230QzW4ggjmK8yfrzObY/keFW6iG
        pgxKaj26e2H21tY0qh73dn7Tds9jVFr4N52/1atroCuj23xebuadJ/nCn+ni+hOv9IWZ5X
        XRwe9yL75OSmn/Kk7padpE9IFxO40Qo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-546-XbmSZSMcONSVyYEcK6YoMg-1; Thu, 24 Feb 2022 06:02:57 -0500
X-MC-Unique: XbmSZSMcONSVyYEcK6YoMg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B349B800496;
        Thu, 24 Feb 2022 11:02:55 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.195.207])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 07B7C7B6F6;
        Thu, 24 Feb 2022 11:02:53 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org,
        linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH 2/2] platform/surface: Remove Surface 3 Button driver
Date:   Thu, 24 Feb 2022 12:02:41 +0100
Message-Id: <20220224110241.9613-3-hdegoede@redhat.com>
In-Reply-To: <20220224110241.9613-1-hdegoede@redhat.com>
References: <20220224110241.9613-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The Surface 3 buttons are now handled by the generic soc_button_array
driver. As part of adding support to soc_button_array the ACPI code
now instantiates a platform_device rather then an i2c_client so there
no longer is an i2c_client for this driver to bind to.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/surface/Kconfig           |   7 -
 drivers/platform/surface/Makefile          |   1 -
 drivers/platform/surface/surface3_button.c | 247 ---------------------
 3 files changed, 255 deletions(-)
 delete mode 100644 drivers/platform/surface/surface3_button.c

diff --git a/drivers/platform/surface/Kconfig b/drivers/platform/surface/Kconfig
index 463f1ec5c14e..eb79fbed8059 100644
--- a/drivers/platform/surface/Kconfig
+++ b/drivers/platform/surface/Kconfig
@@ -28,13 +28,6 @@ config SURFACE3_WMI
 	  To compile this driver as a module, choose M here: the module will
 	  be called surface3-wmi.
 
-config SURFACE_3_BUTTON
-	tristate "Power/home/volume buttons driver for Microsoft Surface 3 tablet"
-	depends on ACPI
-	depends on KEYBOARD_GPIO && I2C
-	help
-	  This driver handles the power/home/volume buttons on the Microsoft Surface 3 tablet.
-
 config SURFACE_3_POWER_OPREGION
 	tristate "Surface 3 battery platform operation region support"
 	depends on ACPI
diff --git a/drivers/platform/surface/Makefile b/drivers/platform/surface/Makefile
index 32889482de55..0fc9cd3e4dd9 100644
--- a/drivers/platform/surface/Makefile
+++ b/drivers/platform/surface/Makefile
@@ -5,7 +5,6 @@
 #
 
 obj-$(CONFIG_SURFACE3_WMI)		+= surface3-wmi.o
-obj-$(CONFIG_SURFACE_3_BUTTON)		+= surface3_button.o
 obj-$(CONFIG_SURFACE_3_POWER_OPREGION)	+= surface3_power.o
 obj-$(CONFIG_SURFACE_ACPI_NOTIFY)	+= surface_acpi_notify.o
 obj-$(CONFIG_SURFACE_AGGREGATOR)	+= aggregator/
diff --git a/drivers/platform/surface/surface3_button.c b/drivers/platform/surface/surface3_button.c
deleted file mode 100644
index 48d77e7aae76..000000000000
--- a/drivers/platform/surface/surface3_button.c
+++ /dev/null
@@ -1,247 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Supports for the button array on the Surface tablets.
- *
- * (C) Copyright 2016 Red Hat, Inc
- *
- * Based on soc_button_array.c:
- *
- * {C} Copyright 2014 Intel Corporation
- */
-
-#include <linux/module.h>
-#include <linux/input.h>
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/i2c.h>
-#include <linux/slab.h>
-#include <linux/acpi.h>
-#include <linux/gpio/consumer.h>
-#include <linux/gpio_keys.h>
-#include <linux/gpio.h>
-#include <linux/platform_device.h>
-
-
-#define SURFACE_BUTTON_OBJ_NAME		"TEV2"
-#define MAX_NBUTTONS			4
-
-/*
- * Some of the buttons like volume up/down are auto repeat, while others
- * are not. To support both, we register two platform devices, and put
- * buttons into them based on whether the key should be auto repeat.
- */
-#define BUTTON_TYPES			2
-
-/*
- * Power button, Home button, Volume buttons support is supposed to
- * be covered by drivers/input/misc/soc_button_array.c, which is implemented
- * according to "Windows ACPI Design Guide for SoC Platforms".
- * However surface 3 seems not to obey the specs, instead it uses
- * device TEV2(MSHW0028) for declaring the GPIOs. The gpios are also slightly
- * different in which the Home button is active high.
- * Compared to surfacepro3_button.c which also handles MSHW0028, the Surface 3
- * is a reduce platform and thus uses GPIOs, not ACPI events.
- * We choose an I2C driver here because we need to access the resources
- * declared under the device node, while surfacepro3_button.c only needs
- * the ACPI companion node.
- */
-static const struct acpi_device_id surface3_acpi_match[] = {
-	{ "MSHW0028", 0 },
-	{ }
-};
-MODULE_DEVICE_TABLE(acpi, surface3_acpi_match);
-
-struct surface3_button_info {
-	const char *name;
-	int acpi_index;
-	unsigned int event_type;
-	unsigned int event_code;
-	bool autorepeat;
-	bool wakeup;
-	bool active_low;
-};
-
-struct surface3_button_data {
-	struct platform_device *children[BUTTON_TYPES];
-};
-
-/*
- * Get the Nth GPIO number from the ACPI object.
- */
-static int surface3_button_lookup_gpio(struct device *dev, int acpi_index)
-{
-	struct gpio_desc *desc;
-	int gpio;
-
-	desc = gpiod_get_index(dev, NULL, acpi_index, GPIOD_ASIS);
-	if (IS_ERR(desc))
-		return PTR_ERR(desc);
-
-	gpio = desc_to_gpio(desc);
-
-	gpiod_put(desc);
-
-	return gpio;
-}
-
-static struct platform_device *
-surface3_button_device_create(struct i2c_client *client,
-			      const struct surface3_button_info *button_info,
-			      bool autorepeat)
-{
-	const struct surface3_button_info *info;
-	struct platform_device *pd;
-	struct gpio_keys_button *gpio_keys;
-	struct gpio_keys_platform_data *gpio_keys_pdata;
-	int n_buttons = 0;
-	int gpio;
-	int error;
-
-	gpio_keys_pdata = devm_kzalloc(&client->dev,
-				       sizeof(*gpio_keys_pdata) +
-				       sizeof(*gpio_keys) * MAX_NBUTTONS,
-				       GFP_KERNEL);
-	if (!gpio_keys_pdata)
-		return ERR_PTR(-ENOMEM);
-
-	gpio_keys = (void *)(gpio_keys_pdata + 1);
-
-	for (info = button_info; info->name; info++) {
-		if (info->autorepeat != autorepeat)
-			continue;
-
-		gpio = surface3_button_lookup_gpio(&client->dev,
-						   info->acpi_index);
-		if (!gpio_is_valid(gpio))
-			continue;
-
-		gpio_keys[n_buttons].type = info->event_type;
-		gpio_keys[n_buttons].code = info->event_code;
-		gpio_keys[n_buttons].gpio = gpio;
-		gpio_keys[n_buttons].active_low = info->active_low;
-		gpio_keys[n_buttons].desc = info->name;
-		gpio_keys[n_buttons].wakeup = info->wakeup;
-		n_buttons++;
-	}
-
-	if (n_buttons == 0) {
-		error = -ENODEV;
-		goto err_free_mem;
-	}
-
-	gpio_keys_pdata->buttons = gpio_keys;
-	gpio_keys_pdata->nbuttons = n_buttons;
-	gpio_keys_pdata->rep = autorepeat;
-
-	pd = platform_device_alloc("gpio-keys", PLATFORM_DEVID_AUTO);
-	if (!pd) {
-		error = -ENOMEM;
-		goto err_free_mem;
-	}
-
-	error = platform_device_add_data(pd, gpio_keys_pdata,
-					 sizeof(*gpio_keys_pdata));
-	if (error)
-		goto err_free_pdev;
-
-	error = platform_device_add(pd);
-	if (error)
-		goto err_free_pdev;
-
-	return pd;
-
-err_free_pdev:
-	platform_device_put(pd);
-err_free_mem:
-	devm_kfree(&client->dev, gpio_keys_pdata);
-	return ERR_PTR(error);
-}
-
-static int surface3_button_remove(struct i2c_client *client)
-{
-	struct surface3_button_data *priv = i2c_get_clientdata(client);
-
-	int i;
-
-	for (i = 0; i < BUTTON_TYPES; i++)
-		if (priv->children[i])
-			platform_device_unregister(priv->children[i]);
-
-	return 0;
-}
-
-static struct surface3_button_info surface3_button_surface3[] = {
-	{ "power", 0, EV_KEY, KEY_POWER, false, true, true },
-	{ "home", 1, EV_KEY, KEY_LEFTMETA, false, true, false },
-	{ "volume_up", 2, EV_KEY, KEY_VOLUMEUP, true, false, true },
-	{ "volume_down", 3, EV_KEY, KEY_VOLUMEDOWN, true, false, true },
-	{ }
-};
-
-static int surface3_button_probe(struct i2c_client *client,
-				 const struct i2c_device_id *id)
-{
-	struct device *dev = &client->dev;
-	struct surface3_button_data *priv;
-	struct platform_device *pd;
-	int i;
-	int error;
-
-	if (strncmp(acpi_device_bid(ACPI_COMPANION(&client->dev)),
-		    SURFACE_BUTTON_OBJ_NAME,
-		    strlen(SURFACE_BUTTON_OBJ_NAME)))
-		return -ENODEV;
-
-	error = gpiod_count(dev, NULL);
-	if (error < 0) {
-		dev_dbg(dev, "no GPIO attached, ignoring...\n");
-		return error;
-	}
-
-	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
-
-	i2c_set_clientdata(client, priv);
-
-	for (i = 0; i < BUTTON_TYPES; i++) {
-		pd = surface3_button_device_create(client,
-						   surface3_button_surface3,
-						   i == 0);
-		if (IS_ERR(pd)) {
-			error = PTR_ERR(pd);
-			if (error != -ENODEV) {
-				surface3_button_remove(client);
-				return error;
-			}
-			continue;
-		}
-
-		priv->children[i] = pd;
-	}
-
-	if (!priv->children[0] && !priv->children[1])
-		return -ENODEV;
-
-	return 0;
-}
-
-static const struct i2c_device_id surface3_id[] = {
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, surface3_id);
-
-static struct i2c_driver surface3_driver = {
-	.probe = surface3_button_probe,
-	.remove = surface3_button_remove,
-	.id_table = surface3_id,
-	.driver = {
-		.name = "surface3",
-		.acpi_match_table = ACPI_PTR(surface3_acpi_match),
-	},
-};
-module_i2c_driver(surface3_driver);
-
-MODULE_AUTHOR("Benjamin Tissoires <benjamin.tissoires@gmail.com>");
-MODULE_DESCRIPTION("surface3 button array driver");
-MODULE_LICENSE("GPL v2");
-- 
2.35.1

