Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB2769AE66
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Feb 2023 15:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjBQOw4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 17 Feb 2023 09:52:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjBQOwy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 17 Feb 2023 09:52:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265646E669
        for <linux-acpi@vger.kernel.org>; Fri, 17 Feb 2023 06:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676645530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3XM0s6Py2s9NABNZsjEwB9EJNT03Us1/96JqO8MWWMA=;
        b=VGxNLZu8ItWDxCJLUO9bsBhzYYcY+ZeSnrBIv7pe/jc7DKBbNmDx6NRlrCELgu9TIS4N9h
        yx9qWIlcl1QSvuYf9jFyMpgQLcPYMDK0Zlm/EgunYHdkKleCXWsnj/20L0861ZARI5bl/s
        +vTQvvhg08bGNtWVEeyiHST5fsmcQR4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-387-WRto6BekOkmEzLQhYEfrfQ-1; Fri, 17 Feb 2023 09:52:05 -0500
X-MC-Unique: WRto6BekOkmEzLQhYEfrfQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 456C280280C;
        Fri, 17 Feb 2023 14:52:05 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.193.199])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5A9C5492C3E;
        Fri, 17 Feb 2023 14:52:04 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Sebastian Reichel <sre@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 3/3] power: supply: axp288_charger: Use alt usb-id extcon on some x86 android tablets
Date:   Fri, 17 Feb 2023 15:52:00 +0100
Message-Id: <20230217145200.31821-4-hdegoede@redhat.com>
In-Reply-To: <20230217145200.31821-1-hdegoede@redhat.com>
References: <20230217145200.31821-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

x86 ACPI boards which ship with only Android as their factory image may
have pretty broken ACPI tables. This includes broken _AEI ACPI GPIO event
handlers, which are normally used to listen to the micro-USB ID pin and:

1. Switch the USB-mux to the host / device USB controllers
2. Disable Vbus path before enabling the 5V boost (AXP reg 0x30 bit 7)
3. Turn 5V Vboost on / off

On non broken systems where this is not done through an ACPI GPIO event
handler, there is an ACPI INT3496 device describing the involved GPIOs
which are handled by the extcon-intel-int3496 driver; and axp288-charger.ko
listens to this extcon-device and disables the Vbus path when necessary.

On x86 Android boards, with broken ACPI GPIO event handlers, these are
disabled by acpi_quirk_skip_gpio_event_handlers() and an intel-int3496
extcon device is manually instantiated by x86-android-tablets.ko .

Add support to the axp288-charger code for this setup, so that it
properly disables the Vbus path when necessary. Note this uses
acpi_quirk_skip_gpio_event_handlers() to identify these systems,
to avoid the need to add a separate DMI match table for this.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/axp288_charger.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply/axp288_charger.c
index 15219ed43ce9..b5903193e2f9 100644
--- a/drivers/power/supply/axp288_charger.c
+++ b/drivers/power/supply/axp288_charger.c
@@ -836,6 +836,7 @@ static int axp288_charger_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct axp20x_dev *axp20x = dev_get_drvdata(pdev->dev.parent);
 	struct power_supply_config charger_cfg = {};
+	const char *extcon_name = NULL;
 	unsigned int val;
 
 	/*
@@ -872,8 +873,18 @@ static int axp288_charger_probe(struct platform_device *pdev)
 		return PTR_ERR(info->cable.edev);
 	}
 
-	if (acpi_dev_present(USB_HOST_EXTCON_HID, NULL, -1)) {
-		info->otg.cable = extcon_get_extcon_dev(USB_HOST_EXTCON_NAME);
+	/*
+	 * On devices with broken ACPI GPIO event handlers there also is no ACPI
+	 * "INT3496" (USB_HOST_EXTCON_HID) device. x86-android-tablets.ko
+	 * instantiates an "intel-int3496" extcon on these devs as a workaround.
+	 */
+	if (acpi_quirk_skip_gpio_event_handlers())
+		extcon_name = "intel-int3496";
+	else if (acpi_dev_present(USB_HOST_EXTCON_HID, NULL, -1))
+		extcon_name = USB_HOST_EXTCON_NAME;
+
+	if (extcon_name) {
+		info->otg.cable = extcon_get_extcon_dev(extcon_name);
 		if (IS_ERR(info->otg.cable)) {
 			dev_err_probe(dev, PTR_ERR(info->otg.cable),
 				      "extcon_get_extcon_dev(%s) failed\n",
-- 
2.39.1

