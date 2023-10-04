Return-Path: <linux-acpi+bounces-421-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C4D7B8553
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Oct 2023 18:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 8D8B72816DD
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Oct 2023 16:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740E11C28A
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Oct 2023 16:32:20 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DD01BDE5
	for <linux-acpi@vger.kernel.org>; Wed,  4 Oct 2023 16:23:40 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0A7CE
	for <linux-acpi@vger.kernel.org>; Wed,  4 Oct 2023 09:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696436618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EDAbJtC3kcIoy3rYY6n3QxcRo3gjBVP/HkKRIxL6zt8=;
	b=UWYZXBEDp+QS5RJJso9873+bSEKljPzYOqHjhEVikiD0XxCy8ctVfeYp+QVAEyf10FENs8
	wFNCNC8neILVgInkVGXqZCFH9XbkSou3XVWLJLWgz7DeooAr0cppl6IygIzhOLdbwjHKzl
	BBJDumzTx1MEkp7gmfq5NC5PgG91nNI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-287-HD7C8yVVPK-Az9-tXUum6Q-1; Wed, 04 Oct 2023 12:23:35 -0400
X-MC-Unique: HD7C8yVVPK-Az9-tXUum6Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9A55718811A7;
	Wed,  4 Oct 2023 16:23:34 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.89])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2E07340C2015;
	Wed,  4 Oct 2023 16:23:33 +0000 (UTC)
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
Subject: [PATCH v3 4/5] platform/x86: int3472: Switch to devm_get_gpiod()
Date: Wed,  4 Oct 2023 18:23:16 +0200
Message-ID: <20231004162317.163488-5-hdegoede@redhat.com>
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
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Switch to devm_get_gpiod() for discrete GPIOs for clks / regulators / LEDs
and let devm do the cleanup for us.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 .../x86/intel/int3472/clk_and_regulator.c     | 23 ++++---------------
 drivers/platform/x86/intel/int3472/discrete.c |  2 +-
 drivers/platform/x86/intel/int3472/led.c      |  7 +-----
 3 files changed, 6 insertions(+), 26 deletions(-)

diff --git a/drivers/platform/x86/intel/int3472/clk_and_regulator.c b/drivers/platform/x86/intel/int3472/clk_and_regulator.c
index 459f96c04ca1..16e36ac0a7b4 100644
--- a/drivers/platform/x86/intel/int3472/clk_and_regulator.c
+++ b/drivers/platform/x86/intel/int3472/clk_and_regulator.c
@@ -177,10 +177,8 @@ int skl_int3472_register_gpio_clock(struct int3472_discrete_device *int3472,
 
 	init.name = kasprintf(GFP_KERNEL, "%s-clk",
 			      acpi_dev_name(int3472->adev));
-	if (!init.name) {
-		ret = -ENOMEM;
-		goto out_put_gpio;
-	}
+	if (!init.name)
+		return -ENOMEM;
 
 	int3472->clock.frequency = skl_int3472_get_clk_frequency(int3472);
 
@@ -206,8 +204,6 @@ int skl_int3472_register_gpio_clock(struct int3472_discrete_device *int3472,
 	clk_unregister(int3472->clock.clk);
 out_free_init_name:
 	kfree(init.name);
-out_put_gpio:
-	gpiod_put(int3472->clock.ena_gpio);
 
 	return ret;
 }
@@ -219,7 +215,6 @@ void skl_int3472_unregister_clock(struct int3472_discrete_device *int3472)
 
 	clkdev_drop(int3472->clock.cl);
 	clk_unregister(int3472->clock.clk);
-	gpiod_put(int3472->clock.ena_gpio);
 }
 
 /*
@@ -266,7 +261,7 @@ int skl_int3472_register_regulator(struct int3472_discrete_device *int3472,
 	struct regulator_config cfg = { };
 	const char *second_sensor = NULL;
 	const struct dmi_system_id *id;
-	int i, j, ret;
+	int i, j;
 
 	id = dmi_first_match(skl_int3472_regulator_second_sensor);
 	if (id)
@@ -309,21 +304,11 @@ int skl_int3472_register_regulator(struct int3472_discrete_device *int3472,
 	int3472->regulator.rdev = regulator_register(int3472->dev,
 						     &int3472->regulator.rdesc,
 						     &cfg);
-	if (IS_ERR(int3472->regulator.rdev)) {
-		ret = PTR_ERR(int3472->regulator.rdev);
-		goto err_free_gpio;
-	}
 
-	return 0;
-
-err_free_gpio:
-	gpiod_put(int3472->regulator.gpio);
-
-	return ret;
+	return PTR_ERR_OR_ZERO(int3472->regulator.rdev);
 }
 
 void skl_int3472_unregister_regulator(struct int3472_discrete_device *int3472)
 {
 	regulator_unregister(int3472->regulator.rdev);
-	gpiod_put(int3472->regulator.gpio);
 }
diff --git a/drivers/platform/x86/intel/int3472/discrete.c b/drivers/platform/x86/intel/int3472/discrete.c
index 0bc7cbefd9ae..07b302e09340 100644
--- a/drivers/platform/x86/intel/int3472/discrete.c
+++ b/drivers/platform/x86/intel/int3472/discrete.c
@@ -119,7 +119,7 @@ skl_int3472_gpiod_get_from_temp_lookup(struct int3472_discrete_device *int3472,
 		return ERR_PTR(ret);
 
 	gpiod_add_lookup_table(lookup);
-	desc = gpiod_get(int3472->dev, func, GPIOD_OUT_LOW);
+	desc = devm_gpiod_get(int3472->dev, func, GPIOD_OUT_LOW);
 	gpiod_remove_lookup_table(lookup);
 
 	return desc;
diff --git a/drivers/platform/x86/intel/int3472/led.c b/drivers/platform/x86/intel/int3472/led.c
index 476cd637fc51..9cbed694e2ca 100644
--- a/drivers/platform/x86/intel/int3472/led.c
+++ b/drivers/platform/x86/intel/int3472/led.c
@@ -39,7 +39,7 @@ int skl_int3472_register_pled(struct int3472_discrete_device *int3472, struct gp
 
 	ret = led_classdev_register(int3472->dev, &int3472->pled.classdev);
 	if (ret)
-		goto err_free_gpio;
+		return ret;
 
 	int3472->pled.lookup.provider = int3472->pled.name;
 	int3472->pled.lookup.dev_id = int3472->sensor_name;
@@ -47,10 +47,6 @@ int skl_int3472_register_pled(struct int3472_discrete_device *int3472, struct gp
 	led_add_lookup(&int3472->pled.lookup);
 
 	return 0;
-
-err_free_gpio:
-	gpiod_put(int3472->pled.gpio);
-	return ret;
 }
 
 void skl_int3472_unregister_pled(struct int3472_discrete_device *int3472)
@@ -60,5 +56,4 @@ void skl_int3472_unregister_pled(struct int3472_discrete_device *int3472)
 
 	led_remove_lookup(&int3472->pled.lookup);
 	led_classdev_unregister(&int3472->pled.classdev);
-	gpiod_put(int3472->pled.gpio);
 }
-- 
2.41.0


