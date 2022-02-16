Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6ED4B942A
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Feb 2022 23:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237855AbiBPWxk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Feb 2022 17:53:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237815AbiBPWxh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Feb 2022 17:53:37 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780AD21FC5F;
        Wed, 16 Feb 2022 14:53:24 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id v12so5851009wrv.2;
        Wed, 16 Feb 2022 14:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jM2+e3zWtETVhAC0+ye2wndY0pyCLLo36eEeA+yW/xs=;
        b=mz1/nQGgoTvZq/YrLsRmhs5tjJTqdq0hIrC931GxWZ3iD6e16ITW2Dt1tpZzycti+s
         idbx2Ok4Mknj3F780sQlICbMyhPxAbzRnMwupoDUdO2wbpgBZP7GC2tZyej9QcCWleAr
         Mz97iPG7KgZ9rVNSO5vcOQw6QZmrXZwsbWjoAOFRYLBkWBkp9QbdlyPErZNRxiKzgMst
         7VPZa5FQoBciLs07ObVIXOcrg+EOgpjeIFtTjMQSAxG79YGS/BYZRTk2Vvx2Tm8/JxX7
         hLXvBIFD9vaar4ZPFXYp5UD2bdXdJ8B9nq6EEJITPM8+WfSSCKouRkHMNguQEyTxj/JR
         ywwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jM2+e3zWtETVhAC0+ye2wndY0pyCLLo36eEeA+yW/xs=;
        b=0vuJ/4KKyqjEoXwFvXNoN9fsn92oAnF2AUS3LN7+X9qVRdV9m5rArYUZELR22PduBZ
         8YwyEoLk59SaFeqnTm+SsOOR3oQ/JXXdtoQo90MjbxxxUTHVjJGxW66EjkLRwmCqCmTF
         46kxWweEXg8gGP7xUZbdsYPlobfcn+E/GWJOZr9Q6/UpPNKmp3KNnsXWkZ6hyPqY7u/z
         cwv6UdsVUnCVjFStLWj+gjxG5sjyDGEo/dyhmUErh4tiTfz5OdzetNvcAPoQE0PamH8D
         Jy+N0f7fwrPEP7GDEWCZUdtrV2wnrebx5URgqXL/8TNmnM5KT+k7xm52TZm1hT5ubLNI
         zfIQ==
X-Gm-Message-State: AOAM533H3+039Os0NtMkJaMS31191q8JX6fdmXjlpaT1cIjlXzq7ArUr
        J0WDMcdj3KtP7XJTxCjNtuVnYm7RuLtKJQ==
X-Google-Smtp-Source: ABdhPJz22xRnoJyoLWLuhcmeozcOKPfSYSd4AIjdwRUHP43spzviTJX3RiPWbxJSqEQwEzrNpoOm0g==
X-Received: by 2002:a5d:5045:0:b0:1e3:3d02:84b3 with SMTP id h5-20020a5d5045000000b001e33d0284b3mr142969wrt.384.1645052003122;
        Wed, 16 Feb 2022 14:53:23 -0800 (PST)
Received: from localhost.localdomain (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net. [86.13.91.161])
        by smtp.gmail.com with ESMTPSA id o125sm182539wme.37.2022.02.16.14.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 14:53:22 -0800 (PST)
From:   Daniel Scally <djrscally@gmail.com>
To:     linux-acpi@vger.kernel.org, linux-clk@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Cc:     rafael@kernel.org, lenb@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, hdegoede@redhat.com, markgross@kernel.org,
        robert.moore@intel.com
Subject: [PATCH 3/6] platform/x86: int3472: Support multiple clock consumers
Date:   Wed, 16 Feb 2022 22:53:01 +0000
Message-Id: <20220216225304.53911-4-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220216225304.53911-1-djrscally@gmail.com>
References: <20220216225304.53911-1-djrscally@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

At present, the int3472-tps68470 only supports a single clock consumer when
passing platform data to the clock driver. In some devices multiple
sensors depend on the clock provided by a single TPS68470 and so all
need to be able to acquire the clock. Support passing multiple
consumers as platform data.

Signed-off-by: Daniel Scally <djrscally@gmail.com>
---
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
index 22f61b47f9e5..b535564712bb 100644
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
+	unsigned int n_consumers;
 	struct mfd_cell *cells;
 	struct regmap *regmap;
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

