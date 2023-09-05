Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F466792E84
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Sep 2023 21:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242012AbjIETM3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 5 Sep 2023 15:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242134AbjIETMM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Sep 2023 15:12:12 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4BACDE
        for <linux-acpi@vger.kernel.org>; Tue,  5 Sep 2023 12:11:47 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-31c4d5bd69cso2533007f8f.3
        for <linux-acpi@vger.kernel.org>; Tue, 05 Sep 2023 12:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1693941056; x=1694545856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xc0dHDvz9aPHwfkkXEcmr6XeU35JNlu/HGwkvzCIguI=;
        b=CFMIY9G25PQWa6qcIJDdmZem9BuviK6CUadJb8Y3YgwI5gpIb5o+cC+X1k320UmyRB
         8inGUbgsaw5tRKi9umYsvigWi41UJKxxFuJFOm08b5s4jfXAfjU+mZ4uuhuFKbHuoeS5
         lsHgI8HenP3lOOEdBII3ljg9phS9f7k3Duhc/+tNm+RShtRidhsD4Fqd/airZ6gBuSk3
         MWNHywYTK1X0mOR82TjaGrTYVFXxzGKu5wW+OuV2I3bH45gM0Ii83vtPecHKihCaVYvY
         PxvKlB9djlC162RlAHYLxKZkn5j9Inpf097O/BxzIhCgmlU/srBapSHPaXeSkMEBgxlE
         2CCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693941056; x=1694545856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xc0dHDvz9aPHwfkkXEcmr6XeU35JNlu/HGwkvzCIguI=;
        b=X2HIb9X/xAxA/eCg9K4CN2KyvAgR6grodVegBPIe2S/r4ODQjNYyf9GmLdhmYwQO1N
         BK59xBYmYoa8Rlfkxk5cR9NIGpOf47q2XPMT1toCVUpTFYK9q6y1arIrkDxc2mppllZV
         43OLJt8OY4KBfMqe/seWlVyXM5MgbiywPsVnyTudrG4pIWSCwrv51DDRncIKNly69FoQ
         dPxDvS7xGnGNFSJvNLK3IKyVVbroOkWH6CKdkNQ9CVVKGFmhm4lrGzip7rWGo1XdsU8w
         6Up+ArJx4veuEADa8CXDJGol1CRpdDmV7iFkl/fhvtR7y5sywEFk1k5YE8z5TNbIj696
         dLZw==
X-Gm-Message-State: AOJu0YwkL8qx5YA/leSaGoholTAFjya5CUZdrHg5ZStMRT0ktJB17NBs
        LuE7oSbogYmKisgdOokUeXCyBixrFqCIZYuNnaQ=
X-Google-Smtp-Source: AGHT+IHuUeDvZm0XqMGiNP8BC9POVIvbxw89mmcaJKbgfsfvBj7DplEY4g0IVdJg6twQF2wl+B7cWQ==
X-Received: by 2002:a1c:4c0a:0:b0:400:419c:bbe2 with SMTP id z10-20020a1c4c0a000000b00400419cbbe2mr502889wmf.24.1693940023108;
        Tue, 05 Sep 2023 11:53:43 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:7a54:5dbc:6d09:48b7])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c249100b003fbc30825fbsm17550010wms.39.2023.09.05.11.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 11:53:42 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Dipen Patel <dipenp@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org, timestamp@lists.linux.dev,
        linux-tegra@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [RFT PATCH 14/21] hte: tegra194: don't access struct gpio_chip
Date:   Tue,  5 Sep 2023 20:53:02 +0200
Message-Id: <20230905185309.131295-15-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230905185309.131295-1-brgl@bgdev.pl>
References: <20230905185309.131295-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Using struct gpio_chip is not safe as it will disappear if the
underlying driver is unbound for any reason. Switch to using reference
counted struct gpio_device and its dedicated accessors.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/hte/hte-tegra194.c | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/hte/hte-tegra194.c b/drivers/hte/hte-tegra194.c
index 9fd3c00ff695..d83ef30c9588 100644
--- a/drivers/hte/hte-tegra194.c
+++ b/drivers/hte/hte-tegra194.c
@@ -132,7 +132,7 @@ struct tegra_hte_soc {
 	const struct tegra_hte_data *prov_data;
 	struct tegra_hte_line_data *line_data;
 	struct hte_chip *chip;
-	struct gpio_chip *c;
+	struct gpio_device *gdev;
 	void __iomem *regs;
 };
 
@@ -421,7 +421,7 @@ static int tegra_hte_line_xlate(struct hte_chip *gc,
 	 * HTE/GTE namespace.
 	 */
 	if (gs->prov_data->type == HTE_TEGRA_TYPE_GPIO && !args) {
-		line_id = desc->attr.line_id - gs->c->base;
+		line_id = desc->attr.line_id - gpio_device_get_base(gs->gdev);
 		map = gs->prov_data->map;
 		map_sz = gs->prov_data->map_sz;
 	} else if (gs->prov_data->type == HTE_TEGRA_TYPE_GPIO && args) {
@@ -643,12 +643,15 @@ static irqreturn_t tegra_hte_isr(int irq, void *dev_id)
 static bool tegra_hte_match_from_linedata(const struct hte_chip *chip,
 					  const struct hte_ts_desc *hdesc)
 {
+	struct gpio_device *gdev __free(gpio_device_put) = NULL;
 	struct tegra_hte_soc *hte_dev = chip->data;
 
 	if (!hte_dev || (hte_dev->prov_data->type != HTE_TEGRA_TYPE_GPIO))
 		return false;
 
-	return hte_dev->c == gpiod_to_chip(hdesc->attr.line_data);
+	gdev = gpiod_to_device(hdesc->attr.line_data);
+
+	return hte_dev->gdev == gdev;
 }
 
 static const struct of_device_id tegra_hte_of_match[] = {
@@ -676,16 +679,18 @@ static void tegra_gte_disable(void *data)
 	tegra_hte_writel(gs, HTE_TECTRL, 0);
 }
 
-static int tegra_get_gpiochip_from_name(struct gpio_chip *chip, void *data)
-{
-	return !strcmp(chip->label, data);
-}
-
 static int tegra_gpiochip_match(struct gpio_chip *chip, void *data)
 {
 	return chip->fwnode == of_node_to_fwnode(data);
 }
 
+static void tegra_hte_put_gpio_device(void *data)
+{
+	struct gpio_device *gdev = data;
+
+	gpio_device_put(gdev);
+}
+
 static int tegra_hte_probe(struct platform_device *pdev)
 {
 	int ret;
@@ -763,8 +768,8 @@ static int tegra_hte_probe(struct platform_device *pdev)
 
 		if (of_device_is_compatible(dev->of_node,
 					    "nvidia,tegra194-gte-aon")) {
-			hte_dev->c = gpiochip_find("tegra194-gpio-aon",
-						tegra_get_gpiochip_from_name);
+			hte_dev->gdev =
+				gpio_device_find_by_label("tegra194-gpio-aon");
 		} else {
 			gpio_ctrl = of_parse_phandle(dev->of_node,
 						     "nvidia,gpio-controller",
@@ -775,14 +780,19 @@ static int tegra_hte_probe(struct platform_device *pdev)
 				return -ENODEV;
 			}
 
-			hte_dev->c = gpiochip_find(gpio_ctrl,
-						   tegra_gpiochip_match);
+			hte_dev->gdev = gpio_device_find(gpio_ctrl,
+							 tegra_gpiochip_match);
 			of_node_put(gpio_ctrl);
 		}
 
-		if (!hte_dev->c)
+		if (!hte_dev->gdev)
 			return dev_err_probe(dev, -EPROBE_DEFER,
 					     "wait for gpio controller\n");
+
+		ret = devm_add_action_or_reset(dev, tegra_hte_put_gpio_device,
+					       hte_dev->gdev);
+		if (ret)
+			return ret;
 	}
 
 	hte_dev->chip = gc;
-- 
2.39.2

