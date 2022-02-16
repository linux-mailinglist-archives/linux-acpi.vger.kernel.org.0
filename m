Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A286D4B9428
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Feb 2022 23:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237979AbiBPWxt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Feb 2022 17:53:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237887AbiBPWxk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Feb 2022 17:53:40 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25B129E94C;
        Wed, 16 Feb 2022 14:53:26 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id m126-20020a1ca384000000b0037bb8e379feso4802100wme.5;
        Wed, 16 Feb 2022 14:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H3EsHpNhp7xDtcLSzqZqFyAn4hnHXwIg/PrjPoOf1qk=;
        b=GkSUgIEzuRPOgqrL+SILrwOcVz9QJCS+3QHhJr9EjMPm/ZPQqOV0P30fAr3Sph2xQ4
         b97R0CnAKeaAAeVDJWDnRpLOPL7NPlV6G71fLZ1bEcxRoYQgXJ4PIanYqs/08k8Fz52P
         Ns+2bGWBRH3Nm0nWy13ASWfLHdqEKXa4RwHkBNaJXanl8fezU+kIr7M8p25U6OyvDnVZ
         i9qEN0CP9qI886Ta1wivoqgv2kBlYbtvxz5GEyLci6sCrUXrWyHodIG/yKX0/NSS25X8
         yRBdU43FbqtTYX3Wydk/t3xGIbbSR6/UcAI0ryNt4UTDhmanyWOOwg0D2LQKF7hak1Xb
         CypQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H3EsHpNhp7xDtcLSzqZqFyAn4hnHXwIg/PrjPoOf1qk=;
        b=cr0mosi6wVt8bPmABh1szC+eS/aEd9qsbEuhJbzc27L6IimeMzvB8LgvQKV4Z7gbrT
         cOHYF7qqaZlF6ec8eCxrCrP0cO9oxT2q9iNDm0SoGrpiB1pu50ENesKs7wZoEcMX+yks
         joi9vDtne6bXdn6wJFdftxIg5VXAP/igCMGWe4G4kOLME8Qqy7q3pyIBfMXUmJGrGX+I
         o/C99thofzWzBwf9NU1cA+ikLinIQjQM3ll69EZET/fxwCWKgwcQVPOvgAgbIW8rzc/V
         I17oIMukWeS646zYTN1rEZI01WwgN60/ofmmOB8n9MDNgkUdSmTt2GpuCBf9Mf66+1Me
         Ggxg==
X-Gm-Message-State: AOAM533Tq1YOqs57w+d8wHkKCrytwYIAO8pv8yo7fyO9f99sV6eizrFj
        RpoHe4Mq3+Pvuy0zF0h/zl+w2+1gJ2neEw==
X-Google-Smtp-Source: ABdhPJw12S2rtwIF3utqYZwg3VFok0JH8sMnXDtOWaErrd23bunRbnWDo99Xnc9Z/H3GS+DrZMfYJQ==
X-Received: by 2002:a1c:21c5:0:b0:37d:40d0:94c7 with SMTP id h188-20020a1c21c5000000b0037d40d094c7mr3479774wmh.1.1645052005363;
        Wed, 16 Feb 2022 14:53:25 -0800 (PST)
Received: from localhost.localdomain (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net. [86.13.91.161])
        by smtp.gmail.com with ESMTPSA id o125sm182539wme.37.2022.02.16.14.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 14:53:24 -0800 (PST)
From:   Daniel Scally <djrscally@gmail.com>
To:     linux-acpi@vger.kernel.org, linux-clk@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Cc:     rafael@kernel.org, lenb@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, hdegoede@redhat.com, markgross@kernel.org,
        robert.moore@intel.com
Subject: [PATCH 5/6] platform/x86: int3472: Support multiple gpio lookups in board data
Date:   Wed, 16 Feb 2022 22:53:03 +0000
Message-Id: <20220216225304.53911-6-djrscally@gmail.com>
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

Currently, we only support passing a single gpiod_lookup_table as part
of the board data for the tps68470 driver. This carries the implicit
assumption that each TPS68470 device will only support a single
sensor, which does not hold true.

Extend the code to support the possibility of multiple sensors each
having a gpiod_lookup_table, and opportunistically add the lookup
table for the Surface Go line's IR camera.

Signed-off-by: Daniel Scally <djrscally@gmail.com>
---
 drivers/platform/x86/intel/int3472/tps68470.c | 18 ++++++++++-----
 drivers/platform/x86/intel/int3472/tps68470.h |  3 ++-
 .../x86/intel/int3472/tps68470_board_data.c   | 22 ++++++++++++++++---
 3 files changed, 33 insertions(+), 10 deletions(-)

diff --git a/drivers/platform/x86/intel/int3472/tps68470.c b/drivers/platform/x86/intel/int3472/tps68470.c
index b535564712bb..736480961ec3 100644
--- a/drivers/platform/x86/intel/int3472/tps68470.c
+++ b/drivers/platform/x86/intel/int3472/tps68470.c
@@ -150,6 +150,7 @@ static int skl_int3472_tps68470_probe(struct i2c_client *client)
 	struct regmap *regmap;
 	int device_type;
 	int ret;
+	int i;
 
 	n_consumers = skl_int3472_fill_clk_pdata(&client->dev, &clk_pdata);
 	if (n_consumers < 0)
@@ -194,15 +195,18 @@ static int skl_int3472_tps68470_probe(struct i2c_client *client)
 		cells[1].pdata_size = sizeof(struct tps68470_regulator_platform_data);
 		cells[2].name = "tps68470-gpio";
 
-		gpiod_add_lookup_table(board_data->tps68470_gpio_lookup_table);
+		for (i = 0; i < board_data->n_gpiod_lookups; i++)
+			gpiod_add_lookup_table(board_data->tps68470_gpio_lookup_tables[i]);
 
 		ret = devm_mfd_add_devices(&client->dev, PLATFORM_DEVID_NONE,
 					   cells, TPS68470_WIN_MFD_CELL_COUNT,
 					   NULL, 0, NULL);
 		kfree(cells);
 
-		if (ret)
-			gpiod_remove_lookup_table(board_data->tps68470_gpio_lookup_table);
+		if (ret) {
+			for (i = 0; i < board_data->n_gpiod_lookups; i++)
+				gpiod_remove_lookup_table(board_data->tps68470_gpio_lookup_tables[i]);
+		}
 
 		break;
 	case DESIGNED_FOR_CHROMEOS:
@@ -226,10 +230,12 @@ static int skl_int3472_tps68470_probe(struct i2c_client *client)
 static int skl_int3472_tps68470_remove(struct i2c_client *client)
 {
 	const struct int3472_tps68470_board_data *board_data;
-
+	int i;
 	board_data = int3472_tps68470_get_board_data(dev_name(&client->dev));
-	if (board_data)
-		gpiod_remove_lookup_table(board_data->tps68470_gpio_lookup_table);
+	if (board_data) {
+		for (i = 0; i < board_data->n_gpiod_lookups; i++)
+			gpiod_remove_lookup_table(board_data->tps68470_gpio_lookup_tables[i]);
+	}
 
 	return 0;
 }
diff --git a/drivers/platform/x86/intel/int3472/tps68470.h b/drivers/platform/x86/intel/int3472/tps68470.h
index cfd33eb62740..35915e701593 100644
--- a/drivers/platform/x86/intel/int3472/tps68470.h
+++ b/drivers/platform/x86/intel/int3472/tps68470.h
@@ -16,8 +16,9 @@ struct tps68470_regulator_platform_data;
 
 struct int3472_tps68470_board_data {
 	const char *dev_name;
-	struct gpiod_lookup_table *tps68470_gpio_lookup_table;
 	const struct tps68470_regulator_platform_data *tps68470_regulator_pdata;
+	unsigned int n_gpiod_lookups;
+	struct gpiod_lookup_table *tps68470_gpio_lookup_tables[];
 };
 
 const struct int3472_tps68470_board_data *int3472_tps68470_get_board_data(const char *dev_name);
diff --git a/drivers/platform/x86/intel/int3472/tps68470_board_data.c b/drivers/platform/x86/intel/int3472/tps68470_board_data.c
index 525f09a3b5ff..442a8a2de224 100644
--- a/drivers/platform/x86/intel/int3472/tps68470_board_data.c
+++ b/drivers/platform/x86/intel/int3472/tps68470_board_data.c
@@ -96,7 +96,7 @@ static const struct tps68470_regulator_platform_data surface_go_tps68470_pdata =
 	},
 };
 
-static struct gpiod_lookup_table surface_go_tps68470_gpios = {
+static struct gpiod_lookup_table surface_go_int347a_gpios = {
 	.dev_id = "i2c-INT347A:00",
 	.table = {
 		GPIO_LOOKUP("tps68470-gpio", 9, "reset", GPIO_ACTIVE_LOW),
@@ -105,16 +105,32 @@ static struct gpiod_lookup_table surface_go_tps68470_gpios = {
 	}
 };
 
+static struct gpiod_lookup_table surface_go_int347e_gpios = {
+	.dev_id = "i2c-INT347E:00",
+	.table = {
+		GPIO_LOOKUP("tps68470-gpio", 5, "enable", GPIO_ACTIVE_HIGH),
+		{ }
+	}
+};
+
 static const struct int3472_tps68470_board_data surface_go_tps68470_board_data = {
 	.dev_name = "i2c-INT3472:05",
-	.tps68470_gpio_lookup_table = &surface_go_tps68470_gpios,
 	.tps68470_regulator_pdata = &surface_go_tps68470_pdata,
+	.n_gpiod_lookups = 2,
+	.tps68470_gpio_lookup_tables = {
+		&surface_go_int347a_gpios,
+		&surface_go_int347e_gpios,
+	}
 };
 
 static const struct int3472_tps68470_board_data surface_go3_tps68470_board_data = {
 	.dev_name = "i2c-INT3472:01",
-	.tps68470_gpio_lookup_table = &surface_go_tps68470_gpios,
 	.tps68470_regulator_pdata = &surface_go_tps68470_pdata,
+	.n_gpiod_lookups = 2,
+	.tps68470_gpio_lookup_tables = {
+		&surface_go_int347a_gpios,
+		&surface_go_int347e_gpios,
+	}
 };
 
 static const struct dmi_system_id int3472_tps68470_board_data_table[] = {
-- 
2.25.1

