Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7856225DE54
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Sep 2020 17:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbgIDPtR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Sep 2020 11:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbgIDPrD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Sep 2020 11:47:03 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BCAFC0619C5
        for <linux-acpi@vger.kernel.org>; Fri,  4 Sep 2020 08:46:48 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id c15so7167154wrs.11
        for <linux-acpi@vger.kernel.org>; Fri, 04 Sep 2020 08:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BFcXvT/mBks59Nbsnk6JiwVK+tMFpXxn+PeH1sXkPcs=;
        b=BmXQtsk/lNSK1NhzOpnVddLfxGsT8P0H9ClEgPxJpE8hkw4Ul/zwqczzS70BALZS8n
         vUW5AfqeO8+ikYrSu/35Ybp7/e/CjukugK16RO2+ZRrxjWbQ+6bTdhe0MJedMJxCczcx
         87b+KiHycu6GRF+fkYgMryzrI/mI+X58xNIT8iWekGrHZrpJ5hLX9OnjMr4cj4t3eUxX
         wSZUpjgrh5l+Uhnbt4iDGr0J5la/xLfUcYhiu+0lj8jj61KujeIQqqZRmaS/rdRnkhUi
         77/rijdpdD7LjPcI3LBVuEcAx0/sSZUJi07rSLSpvBU48UQsIdpK7sjEORTMAhaUC1ZA
         29Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BFcXvT/mBks59Nbsnk6JiwVK+tMFpXxn+PeH1sXkPcs=;
        b=jPrsNffbQ5kWDczlO0E2B5FAL2xjT6StWnjUcFxsxGEtUSOSoFQSbxKmzbu5edryB5
         QahDqBCP3Q4hdCK31wnOl0942EQIUGygZ4C2n5LAabLhWw4+F+6rbAiZTrSWGPDoVI0j
         UJljYfZwQ+SBF+7U7M8AaGbkFgUFgLnNYCPXgkQv40yhQ4xjYH+r+lec7N/4ez33EAg1
         VIqL2yzm/Ps8/JlToo42jubOrxRK+zzgQ3+8j7fZPTNNg+Wua2SIBXNbbFfuXdqXSAhv
         mNumDqTkgHXwAsBm/Lnt5PXOJjAyxwLgt54tTklzTubzrdUXZTFW4zF+tecXQz5sA2eJ
         pU/A==
X-Gm-Message-State: AOAM5311RnckSmJhh65RVnoENs2fAClfGbI/X2ghANT57Hho4XtNqdT+
        AzfislA/rl+ohKn2giXAcTq41Q==
X-Google-Smtp-Source: ABdhPJxqVtqimUn/AOziI4okr5k6W+CeptUTEmSCRZWc/9G1FoORHyIyNXxgkGRVZJUKwoP2mlGlAw==
X-Received: by 2002:adf:9ed4:: with SMTP id b20mr8360307wrf.206.1599234406494;
        Fri, 04 Sep 2020 08:46:46 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id q4sm11983375wru.65.2020.09.04.08.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 08:46:46 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 13/23] gpio: mockup: pass the chip label as device property
Date:   Fri,  4 Sep 2020 17:45:37 +0200
Message-Id: <20200904154547.3836-14-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200904154547.3836-1-brgl@bgdev.pl>
References: <20200904154547.3836-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

While we do check the "chip-name" property in probe(), we never actually
use it. Let's pass the chip label to the driver using device properties
as we'll want to allow users to define their own once dynamically
created chips are supported.

The property is renamed to "chip-label" to not cause any confusion with
the actual chip name which is of the form: "gpiochipX".

If the "chip-label" property is missing, let's do what most devices in
drivers/gpio/ do and use dev_name().

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpio-mockup.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
index e8a19a28ed13..ce83f1df1933 100644
--- a/drivers/gpio/gpio-mockup.c
+++ b/drivers/gpio/gpio-mockup.c
@@ -433,21 +433,14 @@ static int gpio_mockup_probe(struct platform_device *pdev)
 	if (rv)
 		return rv;
 
-	rv = device_property_read_string(dev, "chip-name", &name);
+	rv = device_property_read_string(dev, "chip-label", &name);
 	if (rv)
-		name = NULL;
+		name = dev_name(dev);
 
 	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
 	if (!chip)
 		return -ENOMEM;
 
-	if (!name) {
-		name = devm_kasprintf(dev, GFP_KERNEL,
-				      "%s-%c", pdev->name, pdev->id + 'A');
-		if (!name)
-			return -ENOMEM;
-	}
-
 	mutex_init(&chip->lock);
 
 	gc = &chip->gc;
@@ -534,6 +527,7 @@ static void gpio_mockup_unregister_devices(void)
 static int __init gpio_mockup_init(void)
 {
 	struct property_entry properties[GPIO_MOCKUP_MAX_PROP];
+	char chip_label[GPIO_MOCKUP_LABEL_SIZE];
 	struct gpio_mockup_device *mockup_dev;
 	int i, prop, num_chips, err = 0, base;
 	struct platform_device_info pdevinfo;
@@ -570,6 +564,11 @@ static int __init gpio_mockup_init(void)
 		memset(&pdevinfo, 0, sizeof(pdevinfo));
 		prop = 0;
 
+		snprintf(chip_label, sizeof(chip_label),
+			 "gpio-mockup-%c", i + 'A');
+		properties[prop++] = PROPERTY_ENTRY_STRING("chip-label",
+							   chip_label);
+
 		base = gpio_mockup_range_base(i);
 		if (base >= 0)
 			properties[prop++] = PROPERTY_ENTRY_U32("gpio-base",
-- 
2.26.1

