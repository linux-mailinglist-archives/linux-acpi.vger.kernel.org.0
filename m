Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C755EFA3D
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Sep 2022 18:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236320AbiI2QVm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 29 Sep 2022 12:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236207AbiI2QTo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 29 Sep 2022 12:19:44 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0050632A
        for <linux-acpi@vger.kernel.org>; Thu, 29 Sep 2022 09:19:37 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id p202so1296509iod.6
        for <linux-acpi@vger.kernel.org>; Thu, 29 Sep 2022 09:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DWObYA2TtwBbzJGrssO5YEYPxOnVZ4pCjCKMQhd93g0=;
        b=U3rIGTmVgdJ7GvqreNNqC0Ws6jBuabrs0OsqDzmY2fYjy6UvTcDXzF9QeKjy4ncJYv
         XpZi2bIJMCeNZDcoY5p1X44jzergr2XPqcvYjuXC5PdQm2Dn+JjvfnBwRqGwRqY3vilx
         j6rTCgKQNbk41Fzwvu2lvtHr/CVndEwxMd0r0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DWObYA2TtwBbzJGrssO5YEYPxOnVZ4pCjCKMQhd93g0=;
        b=II8AjS1QSVI23MC1eHCVx3lKRzl5ddN7nvO6KXL2M66v+wSIsz4toMHo1ccSXDhGvP
         Yrayxy1pHMTi7Wus5LjvLyXW6b4b+giUWL09vbvnNq+JVMOJy8jH/IjkQK9BqA1NSiGD
         n6oozCxMQYOsuBdFld1LNXAD8xntB/+rGH5+TK+mMMM26r2+7feNJM2+KOztZHDaOn5R
         TzbS7Zz+HNCWi48IsvvvpN//Z9ZSNZg3O/9BO93e3V24VIOIKV2/WXvDAHhDkVj6t8LS
         HSnuofkCdl6Z91UfKCXc6kcvlFyKRAIco7d89LLydEImITvddqLOTrVxx4gn9FMDMVbX
         OmSg==
X-Gm-Message-State: ACrzQf0IwUeeJCgqL9Nz5AbZoxX/5A8OgBUWPBiV1Zealsae/Jz/Yk5F
        nHDVVIdYtgoM8lZwpfmsePOO+02mfnWfcw==
X-Google-Smtp-Source: AMsMyM4JleXFGDxGYT3hWAGqXSdT1XJlP2po3hrSGBsUsLx93VozTys8BM85TIYiX2bRXPrfOtUKuA==
X-Received: by 2002:a05:6638:1407:b0:35a:4d1c:10ef with SMTP id k7-20020a056638140700b0035a4d1c10efmr2231570jad.119.1664468376672;
        Thu, 29 Sep 2022 09:19:36 -0700 (PDT)
Received: from rrangel920.bld.corp.google.com (h24-56-189-219.arvdco.broadband.dynamic.tds.net. [24.56.189.219])
        by smtp.gmail.com with ESMTPSA id f12-20020a02848c000000b0035aab2f1ab1sm2965451jai.134.2022.09.29.09.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 09:19:36 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-acpi@vger.kernel.org, linux-input@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com, dmitry.torokhov@gmail.com,
        hdegoede@redhat.com, rafael@kernel.org,
        mika.westerberg@linux.intel.com, mario.limonciello@amd.com,
        timvp@google.com, linus.walleij@linaro.org, jingle.wu@emc.com.tw,
        Raul E Rangel <rrangel@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 13/13] Input: raydium_ts_i2c - Don't set wake_capable and wake_irq
Date:   Thu, 29 Sep 2022 10:19:17 -0600
Message-Id: <20220929093200.v6.13.Ia0b24ab02c22125c5fd686cc25872bd26c27ac23@changeid>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
In-Reply-To: <20220929161917.2348231-1-rrangel@chromium.org>
References: <20220929161917.2348231-1-rrangel@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index 66c5b577b791d4f..88d187dc5d325f6 100644
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
2.37.3.998.g577e59143f-goog

