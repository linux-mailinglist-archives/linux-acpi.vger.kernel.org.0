Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC115E568F
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Sep 2022 01:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiIUXE4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 21 Sep 2022 19:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiIUXEw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 21 Sep 2022 19:04:52 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258EA5303E;
        Wed, 21 Sep 2022 16:04:51 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id d12-20020a05600c3acc00b003b4c12e47f3so233743wms.4;
        Wed, 21 Sep 2022 16:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=ttAPtBvVDayfAZFEAiurM2USRVzwfizzaTOK/jSLWhg=;
        b=YwoFHi5MFH45Q2dqstzKOfXUkAxGKTfIUjXElm7aGdVaJoRXouDkhq6IpGrGOCYekK
         6RDuJYsddop+pX3oDc1tIjFSo4pP8A6PVKhdy5+YQsFuxVPbG7difhHexwqWGsKhbBZi
         16PIbebkkv5l5Roev2tUvg489Vp9BqOfg5y3WKSt1UwHMxc9wC2gl8QSxFxhJ05RZiyj
         4NKroGpGqHUIdHF2T/tUEVBhE4GuQlKAHsYmLk0v+DRJYkDNM0m+O8B/N9rVYo4qdqIL
         KQB2BnuhChmOhxmPL2LPG4P6MbfngYeBgsfYPiAZIkIwMB4S4hQQaUb+2cPf/fM1qPXx
         BfKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ttAPtBvVDayfAZFEAiurM2USRVzwfizzaTOK/jSLWhg=;
        b=B717DmiNSEmw6V5cXIWz9R48pEXyn6WsK0J8bsXlLEsnZed9d9Ef8MircKooXKn9X9
         Xe+3jJrYa8CXWJj02fH+h8mhVQbxnwvzJUfiXtkUM1RcaqFYYfJegOJCmcvrSNRFpDxi
         woUXnLPHZ3mNZ93LMCcswZIPyIFbYjfhrX3/Ps9JtcQz5jQspGDlGG42EkEnvf05GPcG
         AngZy7UBiARqfowr2XDe72VBCaMGdfD7RYddE5wAtcYMXn+3P8sIkSU3D9ewwn9Iwc9m
         mjT9kCxbkCD8u73xR9/pd2cH/pYREaM3ig3pVPt3fPHHRsDsi9lopf2Zi+3w2yqAOMeX
         Swxw==
X-Gm-Message-State: ACrzQf2gUcNjN9wnC6R8JGSStRxy5EwLcep0bdXfuTBJShiIDlL6V8OJ
        BqD6V5qBG0qPRJsXTOWnCUulFbiWs4A=
X-Google-Smtp-Source: AMsMyM7o6+kbEKzggHEmviYKODkwBnuoGY1J1WCIVAZGbsEkxpCJvLN5TWuW+rGqIpzdceToeI/dAw==
X-Received: by 2002:a05:600c:310b:b0:3b4:c618:180d with SMTP id g11-20020a05600c310b00b003b4c618180dmr323922wmo.25.1663801490649;
        Wed, 21 Sep 2022 16:04:50 -0700 (PDT)
Received: from localhost.localdomain (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net. [86.13.91.161])
        by smtp.gmail.com with ESMTPSA id x12-20020adfffcc000000b0022ac672654dsm3519252wrs.58.2022.09.21.16.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 16:04:50 -0700 (PDT)
From:   Daniel Scally <djrscally@gmail.com>
To:     linux-acpi@vger.kernel.org, linux-clk@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Cc:     rafael@kernel.org, lenb@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, hdegoede@redhat.com, markgross@kernel.org,
        robert.moore@intel.com
Subject: [PATCH v3 4/5] platform/x86: int3472: Support multiple gpio lookups in board data
Date:   Thu, 22 Sep 2022 00:04:38 +0100
Message-Id: <20220921230439.768185-5-djrscally@gmail.com>
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

Currently, we only support passing a single gpiod_lookup_table as part
of the board data for the tps68470 driver. This carries the implicit
assumption that each TPS68470 device will only support a single
sensor, which does not hold true.

Extend the code to support the possibility of multiple sensors each
having a gpiod_lookup_table, and opportunistically add the lookup
table for the Surface Go line's IR camera.

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Daniel Scally <djrscally@gmail.com>
---
Changes since v2:

	- None

 drivers/platform/x86/intel/int3472/tps68470.c | 17 ++++++++++-----
 drivers/platform/x86/intel/int3472/tps68470.h |  3 ++-
 .../x86/intel/int3472/tps68470_board_data.c   | 21 ++++++++++++++++---
 3 files changed, 32 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/intel/int3472/tps68470.c b/drivers/platform/x86/intel/int3472/tps68470.c
index 8a684030933d..49fc379fe680 100644
--- a/drivers/platform/x86/intel/int3472/tps68470.c
+++ b/drivers/platform/x86/intel/int3472/tps68470.c
@@ -150,6 +150,7 @@ static int skl_int3472_tps68470_probe(struct i2c_client *client)
 	int n_consumers;
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
@@ -226,10 +230,13 @@ static int skl_int3472_tps68470_probe(struct i2c_client *client)
 static int skl_int3472_tps68470_remove(struct i2c_client *client)
 {
 	const struct int3472_tps68470_board_data *board_data;
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
index 525f09a3b5ff..e6cc8f40f5af 100644
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
@@ -105,16 +105,31 @@ static struct gpiod_lookup_table surface_go_tps68470_gpios = {
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
+	},
 };
 
 static const struct int3472_tps68470_board_data surface_go3_tps68470_board_data = {
 	.dev_name = "i2c-INT3472:01",
-	.tps68470_gpio_lookup_table = &surface_go_tps68470_gpios,
 	.tps68470_regulator_pdata = &surface_go_tps68470_pdata,
+	.n_gpiod_lookups = 1,
+	.tps68470_gpio_lookup_tables = {
+		&surface_go_int347a_gpios
+	},
 };
 
 static const struct dmi_system_id int3472_tps68470_board_data_table[] = {
-- 
2.25.1

