Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77BEFA2B3F
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Aug 2019 02:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbfH3ACA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 29 Aug 2019 20:02:00 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45864 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbfH3ACA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 29 Aug 2019 20:02:00 -0400
Received: by mail-pf1-f194.google.com with SMTP id w26so3228581pfq.12
        for <linux-acpi@vger.kernel.org>; Thu, 29 Aug 2019 17:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=typeblog-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IldQxyej46YU/SkHEEsnjl/LzmCcMggIbONwXFCSCKE=;
        b=X0Az8igVrc/4gMnl5ADWTxShGaQFNupE1xbuCezN4YHWmi1aCOQeQyNrfkUh91vEC/
         Jnjy2Zvmwn316YjWnNmofhEJ1/MO3Q+vKCkvxCw4RdMjeiegd9ABp5z9r3LQzHhoF/Sr
         JSHn7bApaXUDGs0DvnqQgDtSNIdofrDOPfJe1tm2UV2HV6lp4kMRyBP4i7nCJag/dJvp
         r25V44aCqJvk25M6ytooHD9n+xecEEW0Jpn8seM5m4nvbLouIRt3wmhUH4TZ7QbiueqE
         nYJykgKYmcPoVqu7s78+gPF/ldglPJAbnZ/daCR/4Db90NrT3UrhNC6HvqaEF5zCzZTb
         zT4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IldQxyej46YU/SkHEEsnjl/LzmCcMggIbONwXFCSCKE=;
        b=k93fiP+th2ACcKZgyoR3CaBEAsqCHb0uCnNhuielEC80stKxE126XEMo1bjv22Lxi/
         wisVc70NrtopSzZAKgmA7NWQvgqaNnJe2Rx53PcSG/gm0wLQB71PmRG+Xjx2BFL0yvRr
         3uVndRZWXUWeWVGjzFTwlQefPExI4mudomYZCbNQoSNkOVRZIlLTim86KwtskjB3hQx/
         cnd7qZwMeBQcFJgl+CpGBOXzl55lx4hzoRc34yrkUrMlZXhJn4oZl0Py/IpjR5mdAk0w
         JP7Nzn6kdkbKDJwpRzlOjTM/dV7FJjM9FBklgnYoeSe0q2uVvH/skFzoDvPpUaEocvzD
         5S0w==
X-Gm-Message-State: APjAAAX4zN3CeaUcHKZoefHNgCELXC0swZSReboe1U1p1Tkk2q9Eg9KM
        UY5s9LItGGbGsphLM8jAW/LPOg==
X-Google-Smtp-Source: APXvYqwjKLpuXVkSR1nIUL4L0503S/Jm0MrmR+DtmeNp33276pQCiT6zEVNp+Gbr2ogFQbHDmXmnfg==
X-Received: by 2002:a63:4c5c:: with SMTP id m28mr11229487pgl.333.1567123319576;
        Thu, 29 Aug 2019 17:01:59 -0700 (PDT)
Received: from peter-pc.home ([91.207.174.229])
        by smtp.gmail.com with ESMTPSA id g2sm4369819pfm.32.2019.08.29.17.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 17:01:58 -0700 (PDT)
From:   Peter Cai <peter@typeblog.net>
Cc:     Peter Cai <peter@typeblog.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Bastien Nocera <hadess@hadess.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: [PATCH 2/2] touchscreen: goodix: define GPIO mapping for GPD P2 Max
Date:   Fri, 30 Aug 2019 08:00:24 +0800
Message-Id: <20190830000024.20384-2-peter@typeblog.net>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190830000024.20384-1-peter@typeblog.net>
References: <20190830000024.20384-1-peter@typeblog.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The firmware of GPD P2 Max could not handle panel resets although code
is present in DSDT. The kernel needs to take on this job instead, but
the DSDT does not provide _DSD, rendering kernel helpless when trying to
find the respective GPIO pins.

Fortunately, this time GPD has proper DMI vendor / product strings that
we could match against. We simply apply an acpi_gpio_mapping table when
GPD P2 Max is matched.

Additionally, the DSDT definition of the irq pin specifies a wrong
polarity. The new quirk introduced in the previous patch
(ACPI_GPIO_QUIRK_OVERRIDE_POLARITY) is applied to correct this.

Signed-off-by: Peter Cai <peter@typeblog.net>
---
 drivers/input/touchscreen/goodix.c | 37 ++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index 5178ea8b5f30..65b8d04b6dcf 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -144,6 +144,34 @@ static const struct dmi_system_id rotated_screen[] = {
 	{}
 };
 
+#ifdef CONFIG_ACPI
+static const struct acpi_gpio_params irq_gpios_default = { 0, 0, false };
+static const struct acpi_gpio_params reset_gpios_default = { 1, 0, false };
+static const struct acpi_gpio_mapping gpio_mapping_force_irq_active_high[] = {
+	{ "irq-gpios", &irq_gpios_default, 1,
+		ACPI_GPIO_QUIRK_OVERRIDE_POLARITY },
+	{ "reset-gpios", &reset_gpios_default, 1 },
+	{}
+};
+
+/*
+ * Devices that need acpi_gpio_mapping to function correctly
+ */
+static const struct dmi_system_id need_gpio_mapping[] = {
+#if defined(CONFIG_DMI) && defined(CONFIG_X86)
+	{
+		.ident = "GPD P2 Max",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "GPD"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "P2 MAX")
+		},
+		.driver_data = &gpio_mapping_force_irq_active_high
+	},
+#endif
+	{}
+};
+#endif
+
 /**
  * goodix_i2c_read - read data from a register of the i2c slave device.
  *
@@ -796,6 +824,15 @@ static int goodix_ts_probe(struct i2c_client *client,
 	struct goodix_ts_data *ts;
 	int error;
 
+#ifdef CONFIG_ACPI
+	struct dmi_system_id *dmi_match;
+
+	dmi_match = dmi_first_match(need_gpio_mapping);
+	if (dmi_match)
+		devm_acpi_dev_add_driver_gpios(&client->dev,
+					       dmi_match->driver_data);
+#endif
+
 	dev_dbg(&client->dev, "I2C Address: 0x%02x\n", client->addr);
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
-- 
2.23.0

