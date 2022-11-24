Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66AFC637FF3
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Nov 2022 20:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiKXT7M (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 24 Nov 2022 14:59:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiKXT7J (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Nov 2022 14:59:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F160BFDB
        for <linux-acpi@vger.kernel.org>; Thu, 24 Nov 2022 11:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669319867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7vMfC4eODGr/G7aZBCsosazHm3HF6RAZ7q1rCBxpwOk=;
        b=aW+PYP5Z/ifPJx2A/2k2yjhNeonR79ImMEZMCRfg/lvXvsIXnM6GKHiPr6Hkx+kBb4mZjt
        T4jPz7CPEJTUXaFh+P46gVjfOSwvYnmNX24drL7JWWLKtJbbYsUN3qWtlkNMQ9QZhuxZ1S
        jYY2UDKj+Q01fE6cqIKFYqKR/7GbMJ0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-365-4jQHPmPzN9CrSC-DK0IR0w-1; Thu, 24 Nov 2022 14:57:44 -0500
X-MC-Unique: 4jQHPmPzN9CrSC-DK0IR0w-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8DBCC3C1068D;
        Thu, 24 Nov 2022 19:57:43 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.195.152])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 02A7549BB62;
        Thu, 24 Nov 2022 19:57:42 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org
Subject: [PATCH 3/3] platform/x86: int3472/discrete: Add support for sensor-drivers which expect clken + pled GPIOs
Date:   Thu, 24 Nov 2022 20:57:37 +0100
Message-Id: <20221124195737.390729-4-hdegoede@redhat.com>
In-Reply-To: <20221124195737.390729-1-hdegoede@redhat.com>
References: <20221124195737.390729-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The hm11b1 and ov01a1s sensor drivers shipped with the out of tree IPU6
driver, expect the clk_en GPIO to be modelled as a "clken" GPIO rather
then using the clk framework; and the hm11b1, ov01a1s and ov2740 driver
all 3 expect the privacy-led to be modelled as a "pled" GPIO, rather then
it being turned on/off at the same time as the clk.

Adjust how we handle the GPIOs on these sensors accordingly, for now at
least, so that the out of tree driver can work with standard distro kernels
through e.g. dkms. Otherwise users need to run a patched kernel just for
this small difference.

This of course needs to be revisited when we mainline these sensor drivers,
I can imagine the drivers getting clk-framework support when they are
mainlined and then at that same time their acpi HID can be dropped from
the use_gpio_for_clk_acpi_ids[] array.

Note there already is a mainline driver for the ov2740, but that is not
impacted by this change since atm it uses neither the clk framework nor
a "clken" GPIO.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Maybe we should patch the sensor drivers for sensors supported with
the IPU3 to also expect the privacy-led to always be a separate GPIO?

This way we can also avoid the camera LED briefly going on at boot,
when the driver is powering things up to read the sensor's ID register.

And I have also put looking at making the mainline ov2740 driver suitable
for use with the (out of tree) IPU6 driver on my TODO list.
---
 drivers/platform/x86/intel/int3472/common.h   |  2 +-
 drivers/platform/x86/intel/int3472/discrete.c | 37 +++++++++++++++----
 2 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/intel/int3472/common.h b/drivers/platform/x86/intel/int3472/common.h
index 53270d19c73a..58647d3084b9 100644
--- a/drivers/platform/x86/intel/int3472/common.h
+++ b/drivers/platform/x86/intel/int3472/common.h
@@ -23,7 +23,7 @@
 #define INT3472_GPIO_TYPE_PRIVACY_LED				0x0d
 
 #define INT3472_PDEV_MAX_NAME_LEN				23
-#define INT3472_MAX_SENSOR_GPIOS				3
+#define INT3472_MAX_SENSOR_GPIOS				4
 
 #define GPIO_REGULATOR_NAME_LENGTH				21
 #define GPIO_REGULATOR_SUPPLY_NAME_LENGTH			9
diff --git a/drivers/platform/x86/intel/int3472/discrete.c b/drivers/platform/x86/intel/int3472/discrete.c
index 9159291be28a..bfcf8184db16 100644
--- a/drivers/platform/x86/intel/int3472/discrete.c
+++ b/drivers/platform/x86/intel/int3472/discrete.c
@@ -216,6 +216,26 @@ static const char *int3472_dsm_type_to_func(u8 type)
 	return "unknown";
 }
 
+/*
+ * The hm11b1 and ov01a1s sensor drivers shipped with the out of tree IPU6 driver,
+ * expect the clk_en GPIO to be modelled as a "clken" GPIO rather then as a clk and
+ * the hm11b1, ov01a1s and ov2740 driver all 3 expect the privacy-led to be modelled
+ * as a "pled" GPIO, rather then it being turned on/off at the same time as the clk.
+ *
+ * Note there also is a mainline driver for the ov2740, but that does not use
+ * the clk framework atm either.
+ *
+ * Adjust how we handle the GPIOs on these sensors accordingly, for now at least.
+ * This needs to be revisited when we mainline these sensor drivers / when we merge
+ * the necessary changes in the ov2740 sensor driver so that it can work on the IPU6.
+ */
+static const struct acpi_device_id use_gpio_for_clk_acpi_ids[] = {
+	{ "HIMX11B1" }, /* hm11b1 */
+	{ "OVTI01AS" }, /* ov01a1s */
+	{ "INT3474" },  /* ov2740 */
+	{}
+};
+
 /**
  * skl_int3472_handle_gpio_resources: Map PMIC resources to consuming sensor
  * @ares: A pointer to a &struct acpi_resource
@@ -293,19 +313,22 @@ static int skl_int3472_handle_gpio_resources(struct acpi_resource *ares,
 		(polarity == GPIO_ACTIVE_HIGH) ? "high" : "low");
 
 	switch (type) {
+	case INT3472_GPIO_TYPE_CLK_ENABLE:
+	case INT3472_GPIO_TYPE_PRIVACY_LED:
+		if (!acpi_match_device_ids(int3472->adev, use_gpio_for_clk_acpi_ids)) {
+			ret = skl_int3472_map_gpio_to_clk(int3472, agpio, type);
+			if (ret)
+				err_msg = "Failed to map GPIO to clock\n";
+
+			break;
+		}
+		fallthrough;
 	case INT3472_GPIO_TYPE_RESET:
 	case INT3472_GPIO_TYPE_POWERDOWN:
 		ret = skl_int3472_map_gpio_to_sensor(int3472, agpio, func, polarity);
 		if (ret)
 			err_msg = "Failed to map GPIO pin to sensor\n";
 
-		break;
-	case INT3472_GPIO_TYPE_CLK_ENABLE:
-	case INT3472_GPIO_TYPE_PRIVACY_LED:
-		ret = skl_int3472_map_gpio_to_clk(int3472, agpio, type);
-		if (ret)
-			err_msg = "Failed to map GPIO to clock\n";
-
 		break;
 	case INT3472_GPIO_TYPE_POWER_ENABLE:
 		ret = skl_int3472_register_regulator(int3472, agpio);
-- 
2.38.1

