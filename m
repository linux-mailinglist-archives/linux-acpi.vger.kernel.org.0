Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1185D4E88C3
	for <lists+linux-acpi@lfdr.de>; Sun, 27 Mar 2022 18:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235934AbiC0QPn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 27 Mar 2022 12:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235977AbiC0QPh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 27 Mar 2022 12:15:37 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3E027CFF;
        Sun, 27 Mar 2022 09:13:58 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id h23so17035438wrb.8;
        Sun, 27 Mar 2022 09:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MQ+yXcP+51IZJ4kzpsc4cimxpmVHWzF1xr6D+3HdATY=;
        b=BhwM82qBKXZO5+fqw65QeKhwje18NdeAec7SMOGvtRZxuYSxkGBHoghZDoTsCxb0e1
         scVi6+VlF0r4aTLH4eZ++WQDTB0zC3vBNOV0/X2ogIONIscsAfTuOj1S6LQNiZspcVd1
         ehwEXIB/eqW5e4LN4WGMXCu4Ankjd/eMt9mkjfmIkQi68RovOmYMkrP2lLIhOWgyEtZX
         w4y9lH9pXxrVkqkn6DZidDauzmwsINV6+JQoUXqxgnkdxkicfGWj3mrgkkJEBR3okh8/
         +J5Tqzj/z3wdT/c6Dkhpp/7nGzPJZZ+rZGqMEU7nNxdJd8B5b8OjmnEmRsmhcpCHkZRB
         lM/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MQ+yXcP+51IZJ4kzpsc4cimxpmVHWzF1xr6D+3HdATY=;
        b=f9zaQtJP6K6L/V7rORiH1WY/LgiLi9xhhmZzDUwiKBd6Qq+44oSOI2VnQBwpiTZ82a
         aYUX0A1G0ixnBt4dECXB1YsCxYNlZb6O9TYs07ew3WSYY0bTLiHLnc5NsxC1TYx0WBMp
         J8YCyg23EDEVYvDvlbFe5KOZz+M48e1QYzcC+IMMKvgMdM8ioJpJKfI4MmjYC5/ASAs1
         foBnC0fcTkoLJVH9aGMwLnqawSzjVm8QMCFugUZzNE0BQFCt3SUWZUo9+ogxKDDN+3pO
         pjAXWUORCLVJexMlOE3IIEFZKxyEW0YNx2yBAyDAz8RoT/FzIsKGgNMkNigwvZJb3KqV
         xcQg==
X-Gm-Message-State: AOAM530bDkGtRalmiS70gh2Z+PV8ogxRbQLIG7r/0O1UDF6c1ZgllNMq
        /QPVr4OYCXtSgS3KS94EM9CT72dpjNM=
X-Google-Smtp-Source: ABdhPJwJGeTjMAYrE/BetV3s2BBGxZSrId0jcg8xq9fS+6LiG4xN2hBevdo8fyU+SU2yISPrawB+DA==
X-Received: by 2002:a05:6000:1184:b0:203:ff46:1d72 with SMTP id g4-20020a056000118400b00203ff461d72mr18164519wrx.165.1648397637071;
        Sun, 27 Mar 2022 09:13:57 -0700 (PDT)
Received: from localhost.localdomain (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net. [86.13.91.161])
        by smtp.gmail.com with ESMTPSA id k2-20020a1ca102000000b0038c78fdd59asm13764924wme.39.2022.03.27.09.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Mar 2022 09:13:56 -0700 (PDT)
From:   Daniel Scally <djrscally@gmail.com>
To:     linux-acpi@vger.kernel.org, linux-clk@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Cc:     rafael@kernel.org, lenb@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, hdegoede@redhat.com, markgross@kernel.org,
        robert.moore@intel.com
Subject: [PATCH v2 4/5] platform/x86: int3472: Support multiple gpio lookups in board data
Date:   Sun, 27 Mar 2022 17:13:43 +0100
Message-Id: <20220327161344.50477-5-djrscally@gmail.com>
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
Changes in v2:

	- Added a missing blank line after "int i;"

 drivers/platform/x86/intel/int3472/tps68470.c   | 17 ++++++++++++-----
 drivers/platform/x86/intel/int3472/tps68470.h   |  3 ++-
 .../x86/intel/int3472/tps68470_board_data.c     | 16 ++++++++++++++--
 3 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/intel/int3472/tps68470.c b/drivers/platform/x86/intel/int3472/tps68470.c
index 907a0eb49f12..471b468a8da3 100644
--- a/drivers/platform/x86/intel/int3472/tps68470.c
+++ b/drivers/platform/x86/intel/int3472/tps68470.c
@@ -155,6 +155,7 @@ static int skl_int3472_tps68470_probe(struct i2c_client *client)
 	int n_consumers;
 	int device_type;
 	int ret;
+	int i;
 
 	n_consumers = skl_int3472_fill_clk_pdata(&client->dev, &clk_pdata);
 	if (n_consumers < 0)
@@ -201,15 +202,18 @@ static int skl_int3472_tps68470_probe(struct i2c_client *client)
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
@@ -233,10 +237,13 @@ static int skl_int3472_tps68470_probe(struct i2c_client *client)
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
index f63ae7329cd2..dfb9431e4b1b 100644
--- a/drivers/platform/x86/intel/int3472/tps68470_board_data.c
+++ b/drivers/platform/x86/intel/int3472/tps68470_board_data.c
@@ -85,7 +85,7 @@ static const struct tps68470_regulator_platform_data surface_go_tps68470_pdata =
 	},
 };
 
-static struct gpiod_lookup_table surface_go_tps68470_gpios = {
+static struct gpiod_lookup_table surface_go_int347a_gpios = {
 	.dev_id = "i2c-INT347A:00",
 	.table = {
 		GPIO_LOOKUP("tps68470-gpio", 9, "reset", GPIO_ACTIVE_LOW),
@@ -94,10 +94,22 @@ static struct gpiod_lookup_table surface_go_tps68470_gpios = {
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
 
 static const struct dmi_system_id int3472_tps68470_board_data_table[] = {
-- 
2.25.1

