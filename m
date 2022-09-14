Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0201C5B915D
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Sep 2022 01:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbiINX7w (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 14 Sep 2022 19:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbiINX7R (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Sep 2022 19:59:17 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C0B8A1C7
        for <linux-acpi@vger.kernel.org>; Wed, 14 Sep 2022 16:58:27 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id e205so9617332iof.1
        for <linux-acpi@vger.kernel.org>; Wed, 14 Sep 2022 16:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=ETp6lHAE1kwX97QdZzpHEsClO/L2A3yvzqUq+PQbIOE=;
        b=Nes0kQOFzscL0Qf9zV4Hrr4MiAQ6+jxqLLdB+8yC192cawXtalPd3EcEcMoBVjRT3Y
         T3/c/9YRh9Io5qmYle40ANr086Sy/CUbJT6RTvzGkEt5GruOugDUvKZtaiUsHzb42/Jy
         2iiVSV5FY+xSEYlohMd4dab/lBKwWtAVu9EU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ETp6lHAE1kwX97QdZzpHEsClO/L2A3yvzqUq+PQbIOE=;
        b=PnDZsdlVzMyCWf7/6o5of7ri0Vav0aLESuscUDFPIg2FsYfv5HPnrSFa0uaOhg8iHn
         JU2tGYBZsD1/3oT+VC+DyoAUnEzwhAxtJY4Q+uBJzLLANrCJ/0YSFcpdsvG6WQPIQ/Yb
         od76O3AapPWWKr+LZOvSg0R/eiwjlj0ZAorCqaAt2tJigVZv5CCdbGqBLOaFSNO4Mo2n
         bTIysNFvERGfmCOQFY6Ah9qpXcj6wfKsSyzjQZzChJLiiM6+hODQrbpObbNFSIMbj67h
         MPl/Dx0sKmPJdW6c7n+3HlPFPKLT0xVbE8GhlQhwCzDcP2RcOL+kNR81dg75jT0sb41/
         4FTw==
X-Gm-Message-State: ACgBeo2asvuexkY14gr4zTi25z3xtX2OZbuqzLqT0vWMpcuq9JgPnPnD
        Y9nwmyoxfvfz8gP5oo02f4mmDDt8dHPlXNPj
X-Google-Smtp-Source: AA6agR5mTcH2fkavtZgo9Ruoe0xjaaOwQFLXmjLNc53nYsPlGtxolxjy0T1nW4+5zCmUvu58MldqKg==
X-Received: by 2002:a05:6602:2e0e:b0:684:e4f9:734a with SMTP id o14-20020a0566022e0e00b00684e4f9734amr16433045iow.200.1663199905827;
        Wed, 14 Sep 2022 16:58:25 -0700 (PDT)
Received: from rrangel920.bld.corp.google.com (h24-56-189-219.arvdco.broadband.dynamic.tds.net. [24.56.189.219])
        by smtp.gmail.com with ESMTPSA id a14-20020a027a0e000000b0034c0e8829c0sm353721jac.0.2022.09.14.16.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 16:58:25 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-acpi@vger.kernel.org, linux-input@vger.kernel.org
Cc:     jingle.wu@emc.com.tw, rafael@kernel.org,
        andriy.shevchenko@linux.intel.com, mario.limonciello@amd.com,
        hdegoede@redhat.com, linus.walleij@linaro.org, timvp@google.com,
        dmitry.torokhov@gmail.com, Raul E Rangel <rrangel@chromium.org>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Douglas Anderson <dianders@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Johnny Chuang <johnny.chuang.emc@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 12/13] Input: elants_i2c - Don't set wake_capable and wake_irq
Date:   Wed, 14 Sep 2022 17:58:00 -0600
Message-Id: <20220914155914.v3.12.I031ffbe411e1bae20bf16a1876da5baf444c7928@changeid>
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
In-Reply-To: <20220914235801.1731478-1-rrangel@chromium.org>
References: <20220914235801.1731478-1-rrangel@chromium.org>
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
2.37.3.968.ga6b4b080e4-goog

