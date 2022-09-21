Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D9F5E568C
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Sep 2022 01:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbiIUXEz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 21 Sep 2022 19:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiIUXEw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 21 Sep 2022 19:04:52 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E44358DF1;
        Wed, 21 Sep 2022 16:04:51 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id n15so5686613wrq.5;
        Wed, 21 Sep 2022 16:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=GU0yOGtUWApdWw1YP5/oReOigylKqhYlPcMjFaOZ1a4=;
        b=hsXXyQG5xjFx5DcN9TQQwZWlZTE4u7OUFESRc0wRInYR3LEPF+MDvgZ245pLCkzHRP
         +qonf0wVh8hXgdzkSsgZm/QaamCwicfL6z3Zq5rfTds5+GDcDPOfeLcD1hmvZy3kcdUR
         CuC6zvUtpaxUZ+qpdAmVnuqJ+kEndUrrr+CxIY4qCRgWd44rTN6gkNVJ9f0LtPhoCUY3
         LcHTIpg0cuxScmK17IMAXj/4+38W7ltTVCwuK90FGKCMmPgLf/qJ8goCpnC9lFSD6PUA
         bo4xgA5INzX0CfHo24NyfrG5Nusxn+TzLXuf9EEqM+DZso2qpHkETuBmLi5txl1pdru3
         Zb+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=GU0yOGtUWApdWw1YP5/oReOigylKqhYlPcMjFaOZ1a4=;
        b=IWFaRiWX154J1Edn1W7WAp1uw8y+zwfTiCycLki07Nkwh0cBG4PekFDFurcBGMGAcc
         N6j2gZyCq6qGDvjYcl9VYUnWW7GLzuBVBBJEWnL/2R68T0mFVLaa4Xnkb6r2vED0Qs0J
         9L/lz66N+rT0ItuOx6qFTV7mXZbNfZsV9v7mNtMKXm1m8Z3xAnTmJDOm1l8N5WkFBKRm
         Qobaa9NBI1zW/8zImy4aq3uvec2umELF1QDPdya0hKSPHiQKHOhlUB42wjhCRJwZ3NtK
         8ne8spySpACoN9Y8ZtwXwSqo9eJbhQKfK0Wd0bmKPl4lI0sBEf+V4yNTo92Qh3pachlv
         Hl1Q==
X-Gm-Message-State: ACrzQf2Oqh2WE/U+dbyA9x+VQjdJvIvzgp4IVN16OJamWqQ7w/I5juK/
        gPrWe9hLQl/YMY5XHGJmxaJbo7soUEg=
X-Google-Smtp-Source: AMsMyM74SGVdqXrkhznuJEBRr++dBPlt1yRbIRAuKUafGwGHaPwT1fT01svctxYz5808sVX5Q6o2OQ==
X-Received: by 2002:a5d:464e:0:b0:228:c179:6b0a with SMTP id j14-20020a5d464e000000b00228c1796b0amr214378wrs.402.1663801489659;
        Wed, 21 Sep 2022 16:04:49 -0700 (PDT)
Received: from localhost.localdomain (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net. [86.13.91.161])
        by smtp.gmail.com with ESMTPSA id x12-20020adfffcc000000b0022ac672654dsm3519252wrs.58.2022.09.21.16.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 16:04:49 -0700 (PDT)
From:   Daniel Scally <djrscally@gmail.com>
To:     linux-acpi@vger.kernel.org, linux-clk@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Cc:     rafael@kernel.org, lenb@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, hdegoede@redhat.com, markgross@kernel.org,
        robert.moore@intel.com
Subject: [PATCH v3 3/5] platform/x86: int3472: Support multiple clock consumers
Date:   Thu, 22 Sep 2022 00:04:37 +0100
Message-Id: <20220921230439.768185-4-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220921230439.768185-1-djrscally@gmail.com>
References: <20220921230439.768185-1-djrscally@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

At present, the tps68470.c only supports a single clock consumer when
passing platform data to the clock driver. In some devices multiple
sensors depend on the clock provided by a single TPS68470 and so all
need to be able to acquire the clock. Support passing multiple
consumers as platform data.

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Daniel Scally <djrscally@gmail.com>
---
Changes since v2:

	- None

 drivers/clk/clk-tps68470.c                    | 13 ++--
 drivers/platform/x86/intel/int3472/tps68470.c | 59 ++++++++++++++++---
 include/linux/platform_data/tps68470.h        |  7 ++-
 3 files changed, 67 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/clk-tps68470.c b/drivers/clk/clk-tps68470.c
index e5fbefd6ac2d..38f44b5b9b1b 100644
--- a/drivers/clk/clk-tps68470.c
+++ b/drivers/clk/clk-tps68470.c
@@ -200,7 +200,9 @@ static int tps68470_clk_probe(struct platform_device *pdev)
 		.flags = CLK_SET_RATE_GATE,
 	};
 	struct tps68470_clkdata *tps68470_clkdata;
+	struct tps68470_clk_consumer *consumer;
 	int ret;
+	int i;
 
 	tps68470_clkdata = devm_kzalloc(&pdev->dev, sizeof(*tps68470_clkdata),
 					GFP_KERNEL);
@@ -223,10 +225,13 @@ static int tps68470_clk_probe(struct platform_device *pdev)
 		return ret;
 
 	if (pdata) {
-		ret = devm_clk_hw_register_clkdev(&pdev->dev,
-						  &tps68470_clkdata->clkout_hw,
-						  pdata->consumer_con_id,
-						  pdata->consumer_dev_name);
+		for (i = 0; i < pdata->n_consumers; i++) {
+			consumer = &pdata->consumers[i];
+			ret = devm_clk_hw_register_clkdev(&pdev->dev,
+							  &tps68470_clkdata->clkout_hw,
+							  consumer->consumer_con_id,
+							  consumer->consumer_dev_name);
+		}
 	}
 
 	return ret;
diff --git a/drivers/platform/x86/intel/int3472/tps68470.c b/drivers/platform/x86/intel/int3472/tps68470.c
index 22f61b47f9e5..8a684030933d 100644
--- a/drivers/platform/x86/intel/int3472/tps68470.c
+++ b/drivers/platform/x86/intel/int3472/tps68470.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Author: Dan Scally <djrscally@gmail.com> */
 
+#include <linux/acpi.h>
 #include <linux/i2c.h>
 #include <linux/kernel.h>
 #include <linux/mfd/core.h>
@@ -95,20 +96,64 @@ static int skl_int3472_tps68470_calc_type(struct acpi_device *adev)
 	return DESIGNED_FOR_WINDOWS;
 }
 
+/*
+ * Return the size of the flexible array member, because we'll need that later
+ * on to pass .pdata_size to cells.
+ */
+static int
+skl_int3472_fill_clk_pdata(struct device *dev, struct tps68470_clk_platform_data **clk_pdata)
+{
+	struct acpi_device *adev = ACPI_COMPANION(dev);
+	struct acpi_device *consumer;
+	unsigned int n_consumers = 0;
+	const char *sensor_name;
+	unsigned int i = 0;
+
+	for_each_acpi_consumer_dev(adev, consumer)
+		n_consumers++;
+
+	if (!n_consumers) {
+		dev_err(dev, "INT3472 seems to have no dependents\n");
+		return -ENODEV;
+	}
+
+	*clk_pdata = devm_kzalloc(dev, struct_size(*clk_pdata, consumers, n_consumers),
+				  GFP_KERNEL);
+	if (!*clk_pdata)
+		return -ENOMEM;
+
+	(*clk_pdata)->n_consumers = n_consumers;
+	i = 0;
+
+	for_each_acpi_consumer_dev(adev, consumer) {
+		sensor_name = devm_kasprintf(dev, GFP_KERNEL, I2C_DEV_NAME_FORMAT,
+					     acpi_dev_name(consumer));
+		if (!sensor_name)
+			return -ENOMEM;
+
+		(*clk_pdata)->consumers[i].consumer_dev_name = sensor_name;
+		i++;
+	}
+
+	acpi_dev_put(consumer);
+
+	return n_consumers;
+}
+
 static int skl_int3472_tps68470_probe(struct i2c_client *client)
 {
 	struct acpi_device *adev = ACPI_COMPANION(&client->dev);
 	const struct int3472_tps68470_board_data *board_data;
-	struct tps68470_clk_platform_data clk_pdata = {};
+	struct tps68470_clk_platform_data *clk_pdata;
 	struct mfd_cell *cells;
 	struct regmap *regmap;
+	int n_consumers;
 	int device_type;
 	int ret;
 
-	ret = skl_int3472_get_sensor_adev_and_name(&client->dev, NULL,
-						   &clk_pdata.consumer_dev_name);
-	if (ret)
-		return ret;
+	n_consumers = skl_int3472_fill_clk_pdata(&client->dev, &clk_pdata);
+	if (n_consumers < 0)
+		return n_consumers;
 
 	regmap = devm_regmap_init_i2c(client, &tps68470_regmap_config);
 	if (IS_ERR(regmap)) {
@@ -142,8 +187,8 @@ static int skl_int3472_tps68470_probe(struct i2c_client *client)
 		 * the clk + regulators must be ready when this happens.
 		 */
 		cells[0].name = "tps68470-clk";
-		cells[0].platform_data = &clk_pdata;
-		cells[0].pdata_size = sizeof(clk_pdata);
+		cells[0].platform_data = clk_pdata;
+		cells[0].pdata_size = struct_size(clk_pdata, consumers, n_consumers);
 		cells[1].name = "tps68470-regulator";
 		cells[1].platform_data = (void *)board_data->tps68470_regulator_pdata;
 		cells[1].pdata_size = sizeof(struct tps68470_regulator_platform_data);
diff --git a/include/linux/platform_data/tps68470.h b/include/linux/platform_data/tps68470.h
index 126d082c3f2e..e605a2cab07f 100644
--- a/include/linux/platform_data/tps68470.h
+++ b/include/linux/platform_data/tps68470.h
@@ -27,9 +27,14 @@ struct tps68470_regulator_platform_data {
 	const struct regulator_init_data *reg_init_data[TPS68470_NUM_REGULATORS];
 };
 
-struct tps68470_clk_platform_data {
+struct tps68470_clk_consumer {
 	const char *consumer_dev_name;
 	const char *consumer_con_id;
 };
 
+struct tps68470_clk_platform_data {
+	unsigned int n_consumers;
+	struct tps68470_clk_consumer consumers[];
+};
+
 #endif
-- 
2.25.1

