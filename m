Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0FF5C03E1
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Sep 2022 18:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbiIUQQL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 21 Sep 2022 12:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232555AbiIUQPh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 21 Sep 2022 12:15:37 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42661A8308
        for <linux-acpi@vger.kernel.org>; Wed, 21 Sep 2022 09:00:59 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id u132so6370737pfc.6
        for <linux-acpi@vger.kernel.org>; Wed, 21 Sep 2022 09:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=ETp6lHAE1kwX97QdZzpHEsClO/L2A3yvzqUq+PQbIOE=;
        b=LsTgob0Jg85X+GdHTPCcSKwZ6O2a3L53H9zaPDhgg7JKugVmorz8gKSf5/lX8WCOZp
         nZG53zTr0k8PM19xaliGlOyfRPyeIkAObqICnjZVpcHVWitsKYqlHKu0Vqgxj8H584J/
         O8tm7uzFvYYTJxAeh4rsWifjh+TMPH0GFzoEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ETp6lHAE1kwX97QdZzpHEsClO/L2A3yvzqUq+PQbIOE=;
        b=bPljxAl5kQ9baKGknVaQ+BR4uBckiYZQOrqWQfaGk/gm56L0EAFL7K/9U48h5FhqFj
         HNN7W9hmN6Thn3lg85r1V9RGQk3atbjzbwyEMmS9g/A5i4Nfy5jMSiH2kMGpdXq3dd4J
         ChmQUBuXxCXegOCQ0xc6yMN2GSPgdIOmapdIXWWSU3GOXsyc8WopEdTv6VQDGglaIQeU
         dZFWXTiVUpWeY9MbUSY2yEsrJsKJRh6mcBKNhG++NXT4HYg4M4vWBsKgxZk5KyqDx5s9
         JoEbCtYxhZJFgS8FB1xYBZ9be999oIfA70cU8miOUcMFrPtUFQHlXYcF0Q27NUGBTQfg
         R1oQ==
X-Gm-Message-State: ACrzQf3j2E9UvwJsvBfmdENrkoDK7Fib3s3P2HuSCYj+E2xehu5iTGRN
        jCW5dJK1XFSbRH4fS5vIGRMNjXoXlysCmw==
X-Google-Smtp-Source: AMsMyM4RLve9ZqCpyicxnvvWOvFh7ngh5UCRji7JOVJ7e3ZDfNCacVsOzJ8MXQ+l4aM3Hqtg+W3gOQ==
X-Received: by 2002:a92:ccd0:0:b0:2f6:274c:f564 with SMTP id u16-20020a92ccd0000000b002f6274cf564mr4883656ilq.116.1663775544330;
        Wed, 21 Sep 2022 08:52:24 -0700 (PDT)
Received: from rrangel920.bld.corp.google.com (h24-56-189-219.arvdco.broadband.dynamic.tds.net. [24.56.189.219])
        by smtp.gmail.com with ESMTPSA id c14-20020a023b0e000000b0035a8d644a31sm1148061jaa.117.2022.09.21.08.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 08:52:23 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-acpi@vger.kernel.org, linux-input@vger.kernel.org
Cc:     rafael@kernel.org, timvp@google.com,
        mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com,
        dmitry.torokhov@gmail.com, jingle.wu@emc.com.tw,
        hdegoede@redhat.com, mario.limonciello@amd.com,
        linus.walleij@linaro.org, Raul E Rangel <rrangel@chromium.org>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Guenter Roeck <groeck@chromium.org>,
        Johnny Chuang <johnny.chuang.emc@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 12/13] Input: elants_i2c - Don't set wake_capable and wake_irq
Date:   Wed, 21 Sep 2022 09:52:04 -0600
Message-Id: <20220921094736.v5.12.I031ffbe411e1bae20bf16a1876da5baf444c7928@changeid>
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
In-Reply-To: <20220921155205.1332614-1-rrangel@chromium.org>
References: <20220921155205.1332614-1-rrangel@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The i2c-core will now handle setting the wake_irq and wake capability
for DT and ACPI systems.

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---

(no changes since v1)

 drivers/input/touchscreen/elants_i2c.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/input/touchscreen/elants_i2c.c b/drivers/input/touchscreen/elants_i2c.c
index 80e16b533c452a..3500293bb1d8e1 100644
--- a/drivers/input/touchscreen/elants_i2c.c
+++ b/drivers/input/touchscreen/elants_i2c.c
@@ -1575,22 +1575,6 @@ static int elants_i2c_probe(struct i2c_client *client)
 		return error;
 	}
 
-	/*
-	 * Systems using device tree should set up wakeup via DTS,
-	 * the rest will configure device as wakeup source by default.
-	 */
-	if (!client->dev.of_node)
-		device_init_wakeup(&client->dev, true);
-
-	/*
-	 * The wake IRQ should be declared via device tree instead of assuming
-	 * the IRQ can wake the system. This is here for legacy reasons and
-	 * will be removed once the i2c-core supports querying ACPI for wake
-	 * capabilities.
-	 */
-	if (!client->dev.power.wakeirq)
-		dev_pm_set_wake_irq(&client->dev, client->irq);
-
 	error = devm_device_add_group(&client->dev, &elants_attribute_group);
 	if (error) {
 		dev_err(&client->dev, "failed to create sysfs attributes: %d\n",
-- 
2.37.3.968.ga6b4b080e4-goog

