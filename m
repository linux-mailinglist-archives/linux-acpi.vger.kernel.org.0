Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1D44E88C0
	for <lists+linux-acpi@lfdr.de>; Sun, 27 Mar 2022 18:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235990AbiC0QPn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 27 Mar 2022 12:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235985AbiC0QPg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 27 Mar 2022 12:15:36 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9539327FD0;
        Sun, 27 Mar 2022 09:13:57 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id r7so15935520wrc.0;
        Sun, 27 Mar 2022 09:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8JYmQLZ7l5CFQmOpqmcvEeVY3idByiOp0ZNGy/jyeF0=;
        b=nFeUNtJtTeJuRVQ2FgvGMNliN6MLuODvCCD3f7LIwhBj/HHkBHLoUTQq/2CgS2y21U
         FUEm3IQ8sO88bXaUKL1Rvn6hCDVXdKo6bCIm4FqoULxAVww7PYm10w1kQMzi/7BAC3ZS
         mcAbuay9NPxVesfxaTRCASh38Ru9Zymc7+bGDa0YkdKHhz045pukO4T/xrrAFwDzH7XW
         0AgdP2qdOBOn0mbrTFoNOf0ntjwQVKtsbUtuVEZgcEzdIOEftLSYoelxUmGllnmoTvy7
         l+32IS4ywv+4/Qeeqx/uIiBxVDtzSCVzHCGgga1kwPzSQYl6ye8gCqpyhqKPQduNdDp3
         CjCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8JYmQLZ7l5CFQmOpqmcvEeVY3idByiOp0ZNGy/jyeF0=;
        b=Ss+duZEsMxWqHSh1bqE6yT8madkRsXhad/idDZn0v16bLDPvl/Ng9E+pfwZrK8tAOq
         Hxt6lCMhBWvZHw1iETOroFHbQd3lNNYNlx37tTIMtW1UVwXh+JcV3B/PlstN0dVTFNbz
         S+QYpPFFqqGC2zc5lTDTThqBDgFk5/GLD8aRTKNH+CN05J+x9bWOn5z3OlO6Fzg9GCLR
         6UYchgl10hwmmG/g9Fi5FKvYfKuXxIG8ODgWPgxvVozGtLiz5QAVtwT1VUdHsd19Wt9+
         tCvdMIgLIh0IDBqEPQj+vE38dFK1dv19K1PS0pWMDa9MoIaov1wtX/r9oOymg/AzFt3R
         zmSg==
X-Gm-Message-State: AOAM5333GGN+4JLWcNctrXsv8PAPKlGnf8JeKMPg5XLbXDjMfo2F1b0B
        JYsHMiZa5eYQk13YyYJF4LWSR/46YRs=
X-Google-Smtp-Source: ABdhPJxG2GjS0PnP2NJvooingPyIDgMpZFzZq8UhWJylNtbmMe4pg7iF9DWkgo0bax22LbL3p+1SIQ==
X-Received: by 2002:adf:a497:0:b0:203:d9cd:4c94 with SMTP id g23-20020adfa497000000b00203d9cd4c94mr18393957wrb.368.1648397636167;
        Sun, 27 Mar 2022 09:13:56 -0700 (PDT)
Received: from localhost.localdomain (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net. [86.13.91.161])
        by smtp.gmail.com with ESMTPSA id k2-20020a1ca102000000b0038c78fdd59asm13764924wme.39.2022.03.27.09.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Mar 2022 09:13:55 -0700 (PDT)
From:   Daniel Scally <djrscally@gmail.com>
To:     linux-acpi@vger.kernel.org, linux-clk@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Cc:     rafael@kernel.org, lenb@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, hdegoede@redhat.com, markgross@kernel.org,
        robert.moore@intel.com
Subject: [PATCH v2 3/5] platform/x86: int3472: Support multiple clock consumers
Date:   Sun, 27 Mar 2022 17:13:42 +0100
Message-Id: <20220327161344.50477-4-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220327161344.50477-1-djrscally@gmail.com>
References: <20220327161344.50477-1-djrscally@gmail.com>
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

At present, the tps68470.c only supports a single clock consumer when
passing platform data to the clock driver. In some devices multiple
sensors depend on the clock provided by a single TPS68470 and so all
need to be able to acquire the clock. Support passing multiple
consumers as platform data.

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Daniel Scally <djrscally@gmail.com>
---
Changes in v2:

	- None

 drivers/clk/clk-tps68470.c                    | 13 ++--
 drivers/platform/x86/intel/int3472/tps68470.c | 59 ++++++++++++++++---
 include/linux/platform_data/tps68470.h        |  7 ++-
 3 files changed, 67 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/clk-tps68470.c b/drivers/clk/clk-tps68470.c
index 2ad0ac2f4096..c9fe1129c537 100644
--- a/drivers/clk/clk-tps68470.c
+++ b/drivers/clk/clk-tps68470.c
@@ -200,7 +200,9 @@ static int tps68470_clk_probe(struct platform_device *pdev)
 {
 	struct tps68470_clk_platform_data *pdata = pdev->dev.platform_data;
 	struct tps68470_clkdata *tps68470_clkdata;
+	struct tps68470_clk_consumer *consumer;
 	int ret;
+	int i;
 
 	tps68470_clkdata = devm_kzalloc(&pdev->dev, sizeof(*tps68470_clkdata),
 					GFP_KERNEL);
@@ -219,10 +221,13 @@ static int tps68470_clk_probe(struct platform_device *pdev)
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
index 5232dbcd8212..907a0eb49f12 100644
--- a/drivers/platform/x86/intel/int3472/tps68470.c
+++ b/drivers/platform/x86/intel/int3472/tps68470.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Author: Dan Scally <djrscally@gmail.com> */
 
+#include <linux/acpi.h>
 #include <linux/i2c.h>
 #include <linux/mfd/core.h>
 #include <linux/mfd/tps68470.h>
@@ -100,20 +101,64 @@ static int skl_int3472_tps68470_calc_type(struct acpi_device *adev)
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
@@ -149,8 +194,8 @@ static int skl_int3472_tps68470_probe(struct i2c_client *client)
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

