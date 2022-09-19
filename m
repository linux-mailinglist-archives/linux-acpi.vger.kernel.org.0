Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7C3E5BD198
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Sep 2022 17:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbiISP7h (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 19 Sep 2022 11:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbiISP7f (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 19 Sep 2022 11:59:35 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C3BB1E
        for <linux-acpi@vger.kernel.org>; Mon, 19 Sep 2022 08:59:32 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id y9so1348276ily.11
        for <linux-acpi@vger.kernel.org>; Mon, 19 Sep 2022 08:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=ETp6lHAE1kwX97QdZzpHEsClO/L2A3yvzqUq+PQbIOE=;
        b=UpTKBXkuBWM37p9DyTtjrOvCA5z/HMMyaw60WAuOwM2AGoflxz67wKN1++3S9QO/XY
         ld88ESs9ahNQ5nbBu7K822/nSihioMxQNdF7jGpSeNAlQsNzqefjpriFkY+hgBXQRXi8
         0EDGcgYi6MsFd41l26KL3bA4CZk5YkjUtiwBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ETp6lHAE1kwX97QdZzpHEsClO/L2A3yvzqUq+PQbIOE=;
        b=WORT4jv/oGjqIP2zuDN5KVQXCyF2Gk30wtyyNYoFd6lTn58WaRNuEweN8FS5T9uevL
         iWfKgLYFV5JfDfsOwr2cBaLWueyFFKN9UrpH/ALcTbUFMbbfGZVVitSQ3r0rU1WDJEWx
         c6Z4o0lPvTwxw9jVTE7oa0iiz0qOfi7D0AhdCDOkbY27TH1dB923/fXnZHWeTUPgvzVg
         KcJHdB6niOWUdzxzNbGpO/B3FJSZWv3EUwwbcOyMUydNsNFhELBfokjs9QB03N1pZH21
         M6IVn2AkAVYMqsPYrMkyFEs3FH+aLRnOX5wdLmzN52NTIjHaVBTwQeys7uq6A2eiG9sa
         2FRw==
X-Gm-Message-State: ACrzQf25fNSuGdu1MWA9PAWLqHvh/jyjal4TepRiC0pUzbzR22C8l9n6
        kiMvmzkDAicgQSUZCgHY/MnlIblo06EgOw==
X-Google-Smtp-Source: AMsMyM77uHanVzulzDLGYPAqOw6SCgZuMRfCcGe2wbSoa5ZKFhtsIW4OtUwmS3QHXrlmf5Qn6NzCPg==
X-Received: by 2002:a92:b011:0:b0:2ea:ebed:1241 with SMTP id x17-20020a92b011000000b002eaebed1241mr7718925ilh.245.1663603171307;
        Mon, 19 Sep 2022 08:59:31 -0700 (PDT)
Received: from rrangel920.bld.corp.google.com (h24-56-189-219.arvdco.broadband.dynamic.tds.net. [24.56.189.219])
        by smtp.gmail.com with ESMTPSA id t70-20020a025449000000b00349fb9b1abesm5634154jaa.106.2022.09.19.08.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 08:59:31 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-acpi@vger.kernel.org, linux-input@vger.kernel.org
Cc:     timvp@google.com, hdegoede@redhat.com,
        andriy.shevchenko@linux.intel.com, rafael@kernel.org,
        mario.limonciello@amd.com, jingle.wu@emc.com.tw,
        mika.westerberg@linux.intel.com, dmitry.torokhov@gmail.com,
        linus.walleij@linaro.org, Raul E Rangel <rrangel@chromium.org>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Douglas Anderson <dianders@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Johnny Chuang <johnny.chuang.emc@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 12/13] Input: elants_i2c - Don't set wake_capable and wake_irq
Date:   Mon, 19 Sep 2022 09:59:14 -0600
Message-Id: <20220919095504.v4.12.I031ffbe411e1bae20bf16a1876da5baf444c7928@changeid>
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
In-Reply-To: <20220919155916.1044219-1-rrangel@chromium.org>
References: <20220919155916.1044219-1-rrangel@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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

