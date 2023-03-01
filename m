Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF2BE6A6A65
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Mar 2023 11:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjCAKFb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 1 Mar 2023 05:05:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjCAKFb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Mar 2023 05:05:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018813028E
        for <linux-acpi@vger.kernel.org>; Wed,  1 Mar 2023 02:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677665090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F4oR9qoq7oFPa5CQt55AKOgrp32Y0ANkBOZoyGs950E=;
        b=bm+OTC2TUaeLeJOYKYER9AZ/3B3mLnH3ahMMXJI/+CS0u/UyYhats2/o+2J8mN3nXanCud
        fjAPqsw946pQ/FrVlbviw1SYEtAPBmT1goV4BrbkJGtpOzKtqzgjHduALmYfzHl6+O1rx0
        CpRRTn0siUHZJhB0LtvYCJQlAfOquZM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-159-2ltweE0eOW2tobRUQcdUYw-1; Wed, 01 Mar 2023 05:04:47 -0500
X-MC-Unique: 2ltweE0eOW2tobRUQcdUYw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A833985A588;
        Wed,  1 Mar 2023 10:04:46 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.194.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DF42DC15BAD;
        Wed,  1 Mar 2023 10:04:45 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andy@kernel.org>, linux-acpi@vger.kernel.org
Subject: [PATCH v2 1/3] ACPI: x86: Introduce an acpi_quirk_skip_gpio_event_handlers() helper
Date:   Wed,  1 Mar 2023 11:04:34 +0100
Message-Id: <20230301100436.132521-2-hdegoede@redhat.com>
In-Reply-To: <20230301100436.132521-1-hdegoede@redhat.com>
References: <20230301100436.132521-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

x86 ACPI boards which ship with only Android as their factory image usually
have pretty broken ACPI tables, relying on everything being hardcoded in
the factory kernel image and often disabling parts of the ACPI enumeration
kernel code to avoid the broken tables causing issues.

Part of this broken ACPI code is that sometimes these boards have _AEI
ACPI GPIO event handlers which are broken.

So far this has been dealt with in the platform/x86/x86-android-tablets.c
module, which contains various workarounds for these devices, by it calling
acpi_gpiochip_free_interrupts() on gpiochip-s with troublesome handlers to
disable the handlers.

But in some cases this is too late, if the handlers are of the edge type
then gpiolib-acpi.c's code will already have run them at boot.
This can cause issues such as GPIOs ending up as owned by "ACPI:OpRegion",
making them unavailable for drivers which actually need them.

Boards with these broken ACPI tables are already listed in
drivers/acpi/x86/utils.c for e.g. acpi_quirk_skip_i2c_client_enumeration().
Extend the quirks mechanism for a new acpi_quirk_skip_gpio_event_handlers()
helper, this re-uses the DMI-ids rather then having to duplicate the same
DMI table in gpiolib-acpi.c .

Also add the new ACPI_QUIRK_SKIP_GPIO_EVENT_HANDLERS quirk to existing
boards with troublesome ACPI gpio event handlers, so that the current
acpi_gpiochip_free_interrupts() hack can be removed from
x86-android-tablets.c .

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/x86/utils.c    | 24 +++++++++++++++++++++---
 drivers/gpio/gpiolib-acpi.c |  3 +++
 include/acpi/acpi_bus.h     |  5 +++++
 3 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
index 4e816bb402f6..4a6f3a6726d0 100644
--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -262,6 +262,7 @@ bool force_storage_d3(void)
 #define ACPI_QUIRK_UART1_TTY_UART2_SKIP				BIT(1)
 #define ACPI_QUIRK_SKIP_ACPI_AC_AND_BATTERY			BIT(2)
 #define ACPI_QUIRK_USE_ACPI_AC_AND_BATTERY			BIT(3)
+#define ACPI_QUIRK_SKIP_GPIO_EVENT_HANDLERS			BIT(4)
 
 static const struct dmi_system_id acpi_quirk_skip_dmi_ids[] = {
 	/*
@@ -297,7 +298,8 @@ static const struct dmi_system_id acpi_quirk_skip_dmi_ids[] = {
 		},
 		.driver_data = (void *)(ACPI_QUIRK_SKIP_I2C_CLIENTS |
 					ACPI_QUIRK_UART1_TTY_UART2_SKIP |
-					ACPI_QUIRK_SKIP_ACPI_AC_AND_BATTERY),
+					ACPI_QUIRK_SKIP_ACPI_AC_AND_BATTERY |
+					ACPI_QUIRK_SKIP_GPIO_EVENT_HANDLERS),
 	},
 	{
 		.matches = {
@@ -305,7 +307,8 @@ static const struct dmi_system_id acpi_quirk_skip_dmi_ids[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "TF103C"),
 		},
 		.driver_data = (void *)(ACPI_QUIRK_SKIP_I2C_CLIENTS |
-					ACPI_QUIRK_SKIP_ACPI_AC_AND_BATTERY),
+					ACPI_QUIRK_SKIP_ACPI_AC_AND_BATTERY |
+					ACPI_QUIRK_SKIP_GPIO_EVENT_HANDLERS),
 	},
 	{
 		/* Lenovo Yoga Tablet 2 1050F/L */
@@ -347,7 +350,8 @@ static const struct dmi_system_id acpi_quirk_skip_dmi_ids[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "M890BAP"),
 		},
 		.driver_data = (void *)(ACPI_QUIRK_SKIP_I2C_CLIENTS |
-					ACPI_QUIRK_SKIP_ACPI_AC_AND_BATTERY),
+					ACPI_QUIRK_SKIP_ACPI_AC_AND_BATTERY |
+					ACPI_QUIRK_SKIP_GPIO_EVENT_HANDLERS),
 	},
 	{
 		/* Whitelabel (sold as various brands) TM800A550L */
@@ -424,6 +428,20 @@ int acpi_quirk_skip_serdev_enumeration(struct device *controller_parent, bool *s
 	return 0;
 }
 EXPORT_SYMBOL_GPL(acpi_quirk_skip_serdev_enumeration);
+
+bool acpi_quirk_skip_gpio_event_handlers(void)
+{
+	const struct dmi_system_id *dmi_id;
+	long quirks;
+
+	dmi_id = dmi_first_match(acpi_quirk_skip_dmi_ids);
+	if (!dmi_id)
+		return false;
+
+	quirks = (unsigned long)dmi_id->driver_data;
+	return (quirks & ACPI_QUIRK_SKIP_GPIO_EVENT_HANDLERS);
+}
+EXPORT_SYMBOL_GPL(acpi_quirk_skip_gpio_event_handlers);
 #endif
 
 /* Lists of PMIC ACPI HIDs with an (often better) native charger driver */
diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 34ff048e70d0..7c9175619a1d 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -536,6 +536,9 @@ void acpi_gpiochip_request_interrupts(struct gpio_chip *chip)
 	if (ACPI_FAILURE(status))
 		return;
 
+	if (acpi_quirk_skip_gpio_event_handlers())
+		return;
+
 	acpi_walk_resources(handle, METHOD_NAME__AEI,
 			    acpi_gpiochip_alloc_event, acpi_gpio);
 
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index e44be31115a6..d69545cd6a48 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -656,6 +656,7 @@ static inline bool acpi_quirk_skip_acpi_ac_and_battery(void)
 #if IS_ENABLED(CONFIG_X86_ANDROID_TABLETS)
 bool acpi_quirk_skip_i2c_client_enumeration(struct acpi_device *adev);
 int acpi_quirk_skip_serdev_enumeration(struct device *controller_parent, bool *skip);
+bool acpi_quirk_skip_gpio_event_handlers(void);
 #else
 static inline bool acpi_quirk_skip_i2c_client_enumeration(struct acpi_device *adev)
 {
@@ -667,6 +668,10 @@ acpi_quirk_skip_serdev_enumeration(struct device *controller_parent, bool *skip)
 	*skip = false;
 	return 0;
 }
+static inline bool acpi_quirk_skip_gpio_event_handlers(void)
+{
+	return false;
+}
 #endif
 
 #ifdef CONFIG_PM
-- 
2.39.1

