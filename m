Return-Path: <linux-acpi+bounces-422-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 034CA7B8554
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Oct 2023 18:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id A0D272816DD
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Oct 2023 16:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876D01BDD7
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Oct 2023 16:32:25 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FBB1BDEB
	for <linux-acpi@vger.kernel.org>; Wed,  4 Oct 2023 16:23:41 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA797D8
	for <linux-acpi@vger.kernel.org>; Wed,  4 Oct 2023 09:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696436618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J0Q3pxIDzFsfY5Eql/yJyfiJ1oiF174RjtJFIu9b6eY=;
	b=Ynbs7oO4LWzwM9ULqKI9JTn5kbOlShPhfKh5dEbgnsdMTKCkQUajXcTm4xniQz0NYVS0+V
	55JfN/a1AXEhTHm36trW/2ZFoxFzQPC1hcO8UvqiJgQZb9uHxzOIVzcycF1xZVMaBVE2cO
	FL9zVtSsOVzS4s5E1laAdz9538GrUJM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-25-neTCiqYPMmKuAQXD6_B5rg-1; Wed, 04 Oct 2023 12:23:33 -0400
X-MC-Unique: neTCiqYPMmKuAQXD6_B5rg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F0B3B98B727;
	Wed,  4 Oct 2023 16:23:32 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.89])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8246440C2015;
	Wed,  4 Oct 2023 16:23:31 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	platform-driver-x86@vger.kernel.org,
	Daniel Scally <djrscally@gmail.com>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH v3 3/5] platform/x86: int3472: Stop using gpiod_toggle_active_low()
Date: Wed,  4 Oct 2023 18:23:15 +0200
Message-ID: <20231004162317.163488-4-hdegoede@redhat.com>
In-Reply-To: <20231004162317.163488-1-hdegoede@redhat.com>
References: <20231004162317.163488-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Use the new skl_int3472_gpiod_get_from_temp_lookup() helper to get
a gpio to pass to register_gpio_clock(), skl_int3472_register_regulator()
and skl_int3472_register_pled().

This removes all use of the deprecated gpiod_toggle_active_low() and
acpi_get_and_request_gpiod() functions.

Suggested-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 .../x86/intel/int3472/clk_and_regulator.c     | 31 ++-----------
 drivers/platform/x86/intel/int3472/common.h   |  7 ++-
 drivers/platform/x86/intel/int3472/discrete.c | 43 +++++++++++++------
 drivers/platform/x86/intel/int3472/led.c      | 17 ++------
 4 files changed, 40 insertions(+), 58 deletions(-)

diff --git a/drivers/platform/x86/intel/int3472/clk_and_regulator.c b/drivers/platform/x86/intel/int3472/clk_and_regulator.c
index ef4b3141efcd..459f96c04ca1 100644
--- a/drivers/platform/x86/intel/int3472/clk_and_regulator.c
+++ b/drivers/platform/x86/intel/int3472/clk_and_regulator.c
@@ -162,9 +162,8 @@ int skl_int3472_register_dsm_clock(struct int3472_discrete_device *int3472)
 }
 
 int skl_int3472_register_gpio_clock(struct int3472_discrete_device *int3472,
-				    struct acpi_resource_gpio *agpio, u32 polarity)
+				    struct gpio_desc *gpio)
 {
-	char *path = agpio->resource_source.string_ptr;
 	struct clk_init_data init = {
 		.ops = &skl_int3472_clock_ops,
 		.flags = CLK_GET_RATE_NOCACHE,
@@ -174,19 +173,7 @@ int skl_int3472_register_gpio_clock(struct int3472_discrete_device *int3472,
 	if (int3472->clock.cl)
 		return -EBUSY;
 
-	int3472->clock.ena_gpio = acpi_get_and_request_gpiod(path, agpio->pin_table[0],
-							     "int3472,clk-enable");
-	if (IS_ERR(int3472->clock.ena_gpio)) {
-		ret = PTR_ERR(int3472->clock.ena_gpio);
-		int3472->clock.ena_gpio = NULL;
-		return dev_err_probe(int3472->dev, ret, "getting clk-enable GPIO\n");
-	}
-
-	if (polarity == GPIO_ACTIVE_LOW)
-		gpiod_toggle_active_low(int3472->clock.ena_gpio);
-
-	/* Ensure the pin is in output mode and non-active state */
-	gpiod_direction_output(int3472->clock.ena_gpio, 0);
+	int3472->clock.ena_gpio = gpio;
 
 	init.name = kasprintf(GFP_KERNEL, "%s-clk",
 			      acpi_dev_name(int3472->adev));
@@ -273,9 +260,8 @@ static const struct dmi_system_id skl_int3472_regulator_second_sensor[] = {
 };
 
 int skl_int3472_register_regulator(struct int3472_discrete_device *int3472,
-				   struct acpi_resource_gpio *agpio)
+				   struct gpio_desc *gpio)
 {
-	char *path = agpio->resource_source.string_ptr;
 	struct regulator_init_data init_data = { };
 	struct regulator_config cfg = { };
 	const char *second_sensor = NULL;
@@ -314,16 +300,7 @@ int skl_int3472_register_regulator(struct int3472_discrete_device *int3472,
 						int3472->regulator.supply_name,
 						&int3472_gpio_regulator_ops);
 
-	int3472->regulator.gpio = acpi_get_and_request_gpiod(path, agpio->pin_table[0],
-							     "int3472,regulator");
-	if (IS_ERR(int3472->regulator.gpio)) {
-		ret = PTR_ERR(int3472->regulator.gpio);
-		int3472->regulator.gpio = NULL;
-		return dev_err_probe(int3472->dev, ret, "getting regulator GPIO\n");
-	}
-
-	/* Ensure the pin is in output mode and non-active state */
-	gpiod_direction_output(int3472->regulator.gpio, 0);
+	int3472->regulator.gpio = gpio;
 
 	cfg.dev = &int3472->adev->dev;
 	cfg.init_data = &init_data;
diff --git a/drivers/platform/x86/intel/int3472/common.h b/drivers/platform/x86/intel/int3472/common.h
index 9f29baa13860..145dec66df64 100644
--- a/drivers/platform/x86/intel/int3472/common.h
+++ b/drivers/platform/x86/intel/int3472/common.h
@@ -117,16 +117,15 @@ int skl_int3472_get_sensor_adev_and_name(struct device *dev,
 					 const char **name_ret);
 
 int skl_int3472_register_gpio_clock(struct int3472_discrete_device *int3472,
-				    struct acpi_resource_gpio *agpio, u32 polarity);
+				    struct gpio_desc *gpio);
 int skl_int3472_register_dsm_clock(struct int3472_discrete_device *int3472);
 void skl_int3472_unregister_clock(struct int3472_discrete_device *int3472);
 
 int skl_int3472_register_regulator(struct int3472_discrete_device *int3472,
-				   struct acpi_resource_gpio *agpio);
+				   struct gpio_desc *gpio);
 void skl_int3472_unregister_regulator(struct int3472_discrete_device *int3472);
 
-int skl_int3472_register_pled(struct int3472_discrete_device *int3472,
-			      struct acpi_resource_gpio *agpio, u32 polarity);
+int skl_int3472_register_pled(struct int3472_discrete_device *int3472, struct gpio_desc *gpio);
 void skl_int3472_unregister_pled(struct int3472_discrete_device *int3472);
 
 #endif
diff --git a/drivers/platform/x86/intel/int3472/discrete.c b/drivers/platform/x86/intel/int3472/discrete.c
index b69ef63f75ab..0bc7cbefd9ae 100644
--- a/drivers/platform/x86/intel/int3472/discrete.c
+++ b/drivers/platform/x86/intel/int3472/discrete.c
@@ -194,6 +194,7 @@ static int skl_int3472_handle_gpio_resources(struct acpi_resource *ares,
 	struct acpi_resource_gpio *agpio;
 	u8 active_value, pin, type;
 	union acpi_object *obj;
+	struct gpio_desc *gpio;
 	const char *err_msg;
 	const char *func;
 	u32 polarity;
@@ -244,22 +245,38 @@ static int skl_int3472_handle_gpio_resources(struct acpi_resource *ares,
 
 		break;
 	case INT3472_GPIO_TYPE_CLK_ENABLE:
-		ret = skl_int3472_register_gpio_clock(int3472, agpio, polarity);
-		if (ret)
-			err_msg = "Failed to register clock\n";
-
-		break;
 	case INT3472_GPIO_TYPE_PRIVACY_LED:
-		ret = skl_int3472_register_pled(int3472, agpio, polarity);
-		if (ret)
-			err_msg = "Failed to register LED\n";
-
-		break;
 	case INT3472_GPIO_TYPE_POWER_ENABLE:
-		ret = skl_int3472_register_regulator(int3472, agpio);
-		if (ret)
-			err_msg = "Failed to map regulator to sensor\n";
+		gpio = skl_int3472_gpiod_get_from_temp_lookup(int3472, agpio, func, polarity);
+		if (IS_ERR(gpio)) {
+			ret = PTR_ERR(gpio);
+			err_msg = "Failed to get GPIO\n";
+			break;
+		}
 
+		switch (type) {
+		case INT3472_GPIO_TYPE_CLK_ENABLE:
+			ret = skl_int3472_register_gpio_clock(int3472, gpio);
+			if (ret)
+				err_msg = "Failed to register clock\n";
+
+			break;
+		case INT3472_GPIO_TYPE_PRIVACY_LED:
+			ret = skl_int3472_register_pled(int3472, gpio);
+			if (ret)
+				err_msg = "Failed to register LED\n";
+
+			break;
+		case INT3472_GPIO_TYPE_POWER_ENABLE:
+			ret = skl_int3472_register_regulator(int3472, gpio);
+			if (ret)
+				err_msg = "Failed to map regulator to sensor\n";
+
+			break;
+		default: /* Never reached */
+			ret = -EINVAL;
+			break;
+		}
 		break;
 	default:
 		dev_warn(int3472->dev,
diff --git a/drivers/platform/x86/intel/int3472/led.c b/drivers/platform/x86/intel/int3472/led.c
index bca1ce7d0d0c..476cd637fc51 100644
--- a/drivers/platform/x86/intel/int3472/led.c
+++ b/drivers/platform/x86/intel/int3472/led.c
@@ -16,26 +16,15 @@ static int int3472_pled_set(struct led_classdev *led_cdev,
 	return 0;
 }
 
-int skl_int3472_register_pled(struct int3472_discrete_device *int3472,
-			      struct acpi_resource_gpio *agpio, u32 polarity)
+int skl_int3472_register_pled(struct int3472_discrete_device *int3472, struct gpio_desc *gpio)
 {
-	char *p, *path = agpio->resource_source.string_ptr;
+	char *p;
 	int ret;
 
 	if (int3472->pled.classdev.dev)
 		return -EBUSY;
 
-	int3472->pled.gpio = acpi_get_and_request_gpiod(path, agpio->pin_table[0],
-							     "int3472,privacy-led");
-	if (IS_ERR(int3472->pled.gpio))
-		return dev_err_probe(int3472->dev, PTR_ERR(int3472->pled.gpio),
-				     "getting privacy LED GPIO\n");
-
-	if (polarity == GPIO_ACTIVE_LOW)
-		gpiod_toggle_active_low(int3472->pled.gpio);
-
-	/* Ensure the pin is in output mode and non-active state */
-	gpiod_direction_output(int3472->pled.gpio, 0);
+	int3472->pled.gpio = gpio;
 
 	/* Generate the name, replacing the ':' in the ACPI devname with '_' */
 	snprintf(int3472->pled.name, sizeof(int3472->pled.name),
-- 
2.41.0


