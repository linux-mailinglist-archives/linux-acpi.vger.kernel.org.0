Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A47915B6374
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Sep 2022 00:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbiILWPp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 12 Sep 2022 18:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbiILWO6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 12 Sep 2022 18:14:58 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB214E87F
        for <linux-acpi@vger.kernel.org>; Mon, 12 Sep 2022 15:14:05 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id b23so8019834iof.2
        for <linux-acpi@vger.kernel.org>; Mon, 12 Sep 2022 15:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=dzeM+708wZszK2Fkz1LVc25O65T8yCXY3mmoP+m77t0=;
        b=O2iNT6FJFBRBZms1zl29VZQblO9I34kQ+U6FRaavxK1KOfyIsrNTO3SfaX/i+w8DGD
         2V0y4GzZ1OgwEmJAf/cMyHJhKTl0of8atPNFND8J545OnISU2V8GKeEKN/ife9A+hxgn
         5eXUs6te/ek4lef/dJ8DzkfyyzD71mZpnmedU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=dzeM+708wZszK2Fkz1LVc25O65T8yCXY3mmoP+m77t0=;
        b=1p/DeihDhdNFmzrqJp8ZNjMmagSDrlAo1zqd8rctlHrExxFwiHk2lN5iEGzRha6NL1
         FMl0WTlqpDFIEzQwQT5M5XTi/BTbO1/GCfWCkC5MpGi2NylFs22otasWMSNFHEHNG3mj
         pjeEELrR0HxcJUi9+DN+GdLydWGFRo+glP/WAhSocq8JGFZp2zJ2VREaHJ0uNmiMpmoD
         N9JUZTWlN4p3hPF4fd8MDrtOAuwCz7Gtbvdz6NTFWi4qPiHr2sRycbQHnLes5sgKmfKY
         EwrAY8hAPTxd3SqBPF5cCF3iGODEUvup9gYbzf0RniGDv+q+hmQrH+6E5PS0567zL0UX
         wPfA==
X-Gm-Message-State: ACgBeo0YYKSpBaLL9D3gdQRJeyQIW/Yb3xNW1XhcdTFIK29Jl8a4JFeL
        hnRG5LpxZ+oY9I1jwJ3wa2FwGAxzzYx8eA==
X-Google-Smtp-Source: AA6agR5bWvgDCtA7HkFBk73M7IxfVaEkBwT9ECnKRnTGkpQA3Wt/6YDW52j0WDVP0lWH9cGiwykLRA==
X-Received: by 2002:a05:6638:1c17:b0:35a:151b:c726 with SMTP id ca23-20020a0566381c1700b0035a151bc726mr7069922jab.66.1663020844367;
        Mon, 12 Sep 2022 15:14:04 -0700 (PDT)
Received: from rrangel920.bld.corp.google.com (h24-56-189-219.arvdco.broadband.dynamic.tds.net. [24.56.189.219])
        by smtp.gmail.com with ESMTPSA id 18-20020a056e020cb200b002f16e7021f6sm4077334ilg.22.2022.09.12.15.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 15:14:03 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-acpi@vger.kernel.org, linux-input@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com, jingle.wu@emc.com.tw,
        mario.limonciello@amd.com, timvp@google.com,
        linus.walleij@linaro.org, hdegoede@redhat.com, rafael@kernel.org,
        Raul E Rangel <rrangel@chromium.org>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Guenter Roeck <groeck@chromium.org>,
        Johnny Chuang <johnny.chuang.emc@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 12/13] Input: elants_i2c - Don't set wake_capable and wake_irq
Date:   Mon, 12 Sep 2022 16:13:16 -0600
Message-Id: <20220912160931.v2.12.I031ffbe411e1bae20bf16a1876da5baf444c7928@changeid>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220912221317.2775651-1-rrangel@chromium.org>
References: <20220912221317.2775651-1-rrangel@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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
2.37.2.789.g6183377224-goog

