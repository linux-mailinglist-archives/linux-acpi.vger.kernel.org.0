Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACE1B5B6380
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Sep 2022 00:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbiILWP4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 12 Sep 2022 18:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbiILWO6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 12 Sep 2022 18:14:58 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9454F193
        for <linux-acpi@vger.kernel.org>; Mon, 12 Sep 2022 15:14:06 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id z191so8149854iof.10
        for <linux-acpi@vger.kernel.org>; Mon, 12 Sep 2022 15:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=EeZnYFIvpj94PIl9XvhDpXBXZw312Rl74G5MwZ6L5DA=;
        b=D354vVTP9rE3f3TCt+m5kJaP3F3TB2qktc9GaXG6kS/7C8NFdrdmPVGguYWvBXlgv+
         G8vNC9EvxVNJPfVvSSqkhJ503aH4vSRS4d38Ikfw8aY285GH7iqeyK8pjAAv9P979soK
         PDZsj2Y+MLFT912PWWldsnfX3TD8NaLYZM5Wc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=EeZnYFIvpj94PIl9XvhDpXBXZw312Rl74G5MwZ6L5DA=;
        b=zK6DfhTayMm2kGc/rJwVislRNLa0vMYjrPjeJLHVjgMDiBjVr73BBF5HGON7xTE1zn
         2xqepglj0lF0AY4gJRtM3dEv3QXha2z5kUBPej9DX5XRJxQ13flrFbKfpNxYbsUsq0EO
         jyoKG6OlrxZyuQcUep7QWmhcOcbn+tmRYHgvIQBzCzSBpNA9vqJC23AvH19E0qq72oAX
         5QAf9SEqpf60yqhUSPfWjY31uZVag0aE2M45Wb5Bpg4o77I2eqVlxVawgBmdpFgSaeyg
         +P8OTE4xgy7/kK35fEYatAz/2o+uDp6+aYKULUk9kPPPHklVdsaIGTQ3iCtdB78YNM3W
         UP0g==
X-Gm-Message-State: ACgBeo3jiGKfB35FUxzPOBE5XEFsupnFln1Gt0aE+6vFrk0diR4i/Ymy
        GZ4dpjNI8MpWA5l65vv0lwCEtxjHhye5dQ==
X-Google-Smtp-Source: AA6agR7Fmp+THZEHAtck6LZl/LjV8cER0DklBxTYAo7ha/1/rd6o/SbM9WJM8O+WxBGePYPgAebdng==
X-Received: by 2002:a02:904a:0:b0:346:908d:82b8 with SMTP id y10-20020a02904a000000b00346908d82b8mr14166871jaf.225.1663020845670;
        Mon, 12 Sep 2022 15:14:05 -0700 (PDT)
Received: from rrangel920.bld.corp.google.com (h24-56-189-219.arvdco.broadband.dynamic.tds.net. [24.56.189.219])
        by smtp.gmail.com with ESMTPSA id 18-20020a056e020cb200b002f16e7021f6sm4077334ilg.22.2022.09.12.15.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 15:14:05 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-acpi@vger.kernel.org, linux-input@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com, jingle.wu@emc.com.tw,
        mario.limonciello@amd.com, timvp@google.com,
        linus.walleij@linaro.org, hdegoede@redhat.com, rafael@kernel.org,
        Raul E Rangel <rrangel@chromium.org>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 13/13] Input: raydium_ts_i2c - Don't set wake_capable and wake_irq
Date:   Mon, 12 Sep 2022 16:13:17 -0600
Message-Id: <20220912160931.v2.13.Ia0b24ab02c22125c5fd686cc25872bd26c27ac23@changeid>
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

 drivers/input/touchscreen/raydium_i2c_ts.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/input/touchscreen/raydium_i2c_ts.c b/drivers/input/touchscreen/raydium_i2c_ts.c
index 66c5b577b791d4..88d187dc5d325f 100644
--- a/drivers/input/touchscreen/raydium_i2c_ts.c
+++ b/drivers/input/touchscreen/raydium_i2c_ts.c
@@ -1185,15 +1185,6 @@ static int raydium_i2c_probe(struct i2c_client *client,
 		return error;
 	}
 
-	/*
-	 * The wake IRQ should be declared via device tree instead of assuming
-	 * the IRQ can wake the system. This is here for legacy reasons and
-	 * will be removed once the i2c-core supports querying ACPI for wake
-	 * capabilities.
-	 */
-	if (!client->dev.power.wakeirq)
-		dev_pm_set_wake_irq(&client->dev, client->irq);
-
 	error = devm_device_add_group(&client->dev,
 				   &raydium_i2c_attribute_group);
 	if (error) {
-- 
2.37.2.789.g6183377224-goog

