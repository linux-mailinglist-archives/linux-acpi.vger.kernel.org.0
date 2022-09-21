Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08CC85C03E5
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Sep 2022 18:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbiIUQRK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 21 Sep 2022 12:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232154AbiIUQQk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 21 Sep 2022 12:16:40 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6E7A98E8
        for <linux-acpi@vger.kernel.org>; Wed, 21 Sep 2022 09:01:28 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id e67so247973pgc.12
        for <linux-acpi@vger.kernel.org>; Wed, 21 Sep 2022 09:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=uhn02vEcgNMuC4NDL/sdnIiKkA3NV83noPVamoKM5ng=;
        b=J+m/6s3OweW7a/eo9st4eaQgCj5FBjVxWu4cd0CaPO5cml8TYlNkg/w5YMuvK+r+GQ
         wzhrojO6SeTZXM/fmsxo/ctc7AJ+AoKGqVMF18GQ8VM2foK5SHjyhGHiByVZJBVAX1i1
         obzlAwJ08YXB3oRiWQZ0lmKoLJMRn+Pegtamw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=uhn02vEcgNMuC4NDL/sdnIiKkA3NV83noPVamoKM5ng=;
        b=hN5cD93YQtDh5tXCme5PT4eYj11o3WSn29sMApM2461vW4ta55/fiDPazT8oiKsL3R
         U6Eq+J39XPngVtLZkOcVMrrzG2lzXAZ7FoKTqh0bBdr/67UZ6uUf5onl83Y5MiDd1yIP
         7z0wypoVftP1uI1h394KwyAfn0WY1Ig+n6JPkTP/KeSJCqYMuqOR/nMnuXvEeSv/LxxC
         SHmeXT3ZNGnFw+N6x82EEO967cMNX5pXTAwEkidHQo0wrIX6AEbGrK5z5NUfBT2ncg2L
         Y8AVNKFixpNYcV3RtnTqdcCvNCCi2owiay5kdvqeC0rOU1RVqsKsUrEflA4kOE8pSppn
         D6vw==
X-Gm-Message-State: ACrzQf2jCdVd16o6OmY7AbzVZOHh1QPlsGGFM0O9m81BtlIjhZHXKw0a
        r14ba1f/zzBhF3nmGJoDayjwAKdISZWwuQ==
X-Google-Smtp-Source: AMsMyM5y+0hpMGJsf2ExwaciR2mijAedWncBixNTzl39icNIG8bLyvsSsOzqJ1lKOuRVy46al2qq4w==
X-Received: by 2002:a05:6e02:20ce:b0:2f3:4a1f:3db4 with SMTP id 14-20020a056e0220ce00b002f34a1f3db4mr12919850ilq.278.1663775545355;
        Wed, 21 Sep 2022 08:52:25 -0700 (PDT)
Received: from rrangel920.bld.corp.google.com (h24-56-189-219.arvdco.broadband.dynamic.tds.net. [24.56.189.219])
        by smtp.gmail.com with ESMTPSA id c14-20020a023b0e000000b0035a8d644a31sm1148061jaa.117.2022.09.21.08.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 08:52:25 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-acpi@vger.kernel.org, linux-input@vger.kernel.org
Cc:     rafael@kernel.org, timvp@google.com,
        mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com,
        dmitry.torokhov@gmail.com, jingle.wu@emc.com.tw,
        hdegoede@redhat.com, mario.limonciello@amd.com,
        linus.walleij@linaro.org, Raul E Rangel <rrangel@chromium.org>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 13/13] Input: raydium_ts_i2c - Don't set wake_capable and wake_irq
Date:   Wed, 21 Sep 2022 09:52:05 -0600
Message-Id: <20220921094736.v5.13.Ia0b24ab02c22125c5fd686cc25872bd26c27ac23@changeid>
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
In-Reply-To: <20220921155205.1332614-1-rrangel@chromium.org>
References: <20220921155205.1332614-1-rrangel@chromium.org>
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
2.37.3.968.ga6b4b080e4-goog

