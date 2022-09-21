Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 066285C03E9
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Sep 2022 18:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbiIUQSD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 21 Sep 2022 12:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232386AbiIUQRe (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 21 Sep 2022 12:17:34 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF60AA3F4
        for <linux-acpi@vger.kernel.org>; Wed, 21 Sep 2022 09:02:36 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id f26so4398381qto.11
        for <linux-acpi@vger.kernel.org>; Wed, 21 Sep 2022 09:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=FeCM68gkQ9FF2bI4ULoqKrlayWCcShzPlt5I44au1/c=;
        b=GtmCk56HIqS2j7htWOn/zd2QgPTD1TYRl91W0+5vL/qucf8cUNggcbH51MiyegyUPJ
         A9CmJif3svdMmc0fGZYnepR08XJ2LAeeHufyL8dvufUYu+LQLUF4QeT/9obZ4+t/Kzwi
         tiV1uf63qtX/4WZCyIbo4VS4rbeUYscBntzyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=FeCM68gkQ9FF2bI4ULoqKrlayWCcShzPlt5I44au1/c=;
        b=VDBR0gUY4LQyVMSY5Z4140/0ITlrJir2Cc3yK4Q+wt2BF5P1n/CAYrIc1wzJFsuEj0
         eThd8dRhRAGcQZPltqFiiR6s5KV/E90kovr1IOxcOofl3ZZIUYDfSFwWL1zyizr2m0S4
         RYxlJuIAgcGG4RX/fTOGZ5do5dVFpNEF0Xw/DB2ufc4ii8eoco3pWVV/e/1OEoYGqIkF
         NM6BYDNuGououeaigvuAGzvpPzws+NY7A29xbpL+JXbyzOmJNACkBQtC0fM+1fLysYPS
         gFXO3Ng3cs5jUkAH+sCGJhO4C0tvLohrNfPyOnERYTJlj4njXSHGAb8swjcHWgT845hr
         VJsA==
X-Gm-Message-State: ACrzQf0Nb8EiXPBWpNcJeZGb54n5msWLqbfu9KHI0BOo8+bgDMXsSwX3
        s4N6NmlxpUHqRO7BW4owo50DIZUEuvwiJA==
X-Google-Smtp-Source: AMsMyM51AVUJbQY3PPH4vR13sh6JHTTSpHiCRizwFXEe4R+ue1vv4/RVAHvxMTPRddIJjnBApDIYUg==
X-Received: by 2002:a05:6638:2595:b0:35a:5433:d7a9 with SMTP id s21-20020a056638259500b0035a5433d7a9mr13085111jat.320.1663775531648;
        Wed, 21 Sep 2022 08:52:11 -0700 (PDT)
Received: from rrangel920.bld.corp.google.com (h24-56-189-219.arvdco.broadband.dynamic.tds.net. [24.56.189.219])
        by smtp.gmail.com with ESMTPSA id c14-20020a023b0e000000b0035a8d644a31sm1148061jaa.117.2022.09.21.08.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 08:52:10 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-acpi@vger.kernel.org, linux-input@vger.kernel.org
Cc:     rafael@kernel.org, timvp@google.com,
        mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com,
        dmitry.torokhov@gmail.com, jingle.wu@emc.com.tw,
        hdegoede@redhat.com, mario.limonciello@amd.com,
        linus.walleij@linaro.org, Raul E Rangel <rrangel@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 02/13] Input: elan_i2c - Use PM subsystem to manage wake irq
Date:   Wed, 21 Sep 2022 09:51:54 -0600
Message-Id: <20220921094736.v5.2.Id022caf53d01112188308520915798f08a33cd3e@changeid>
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

The Elan I2C touchpad driver is currently manually managing the wake
IRQ. This change removes the explicit enable_irq_wake/disable_irq_wake
and instead relies on the PM subsystem. This is done by calling
dev_pm_set_wake_irq.

i2c_device_probe already calls dev_pm_set_wake_irq when using device
tree, and i2c_device_remove also already calls dev_pm_clear_wake_irq.
There could be some device tree systems that have incorrectly declared
`wake` capabilities, so this change will set the wake irq if one is
missing. This matches the previous behavior.

I tested this on an ACPI system where the touchpad doesn't have _PRW
defined. I verified I can still wake the system and that the wake source
was the touchpad IRQ GPIO.

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---

(no changes since v2)

Changes in v2:
- Set the wake_irq when not configured by the i2c-core. This is
  different than v1, where the wake_irq was only set for non DT systems.

 drivers/input/mouse/elan_i2c_core.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index e1758d5ffe4218..3947474e93d16a 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -33,6 +33,7 @@
 #include <linux/jiffies.h>
 #include <linux/completion.h>
 #include <linux/of.h>
+#include <linux/pm_wakeirq.h>
 #include <linux/property.h>
 #include <linux/regulator/consumer.h>
 #include <asm/unaligned.h>
@@ -86,8 +87,6 @@ struct elan_tp_data {
 	u16			fw_page_size;
 	u32			fw_signature_address;
 
-	bool			irq_wake;
-
 	u8			min_baseline;
 	u8			max_baseline;
 	bool			baseline_ready;
@@ -1340,6 +1339,15 @@ static int elan_probe(struct i2c_client *client,
 	if (!dev->of_node)
 		device_init_wakeup(dev, true);
 
+	/*
+	 * The wake IRQ should be declared via device tree instead of assuming
+	 * the IRQ can wake the system. This is here for legacy reasons and
+	 * will be removed once the i2c-core supports querying ACPI for wake
+	 * capabilities.
+	 */
+	if (!dev->power.wakeirq)
+		dev_pm_set_wake_irq(dev, client->irq);
+
 	return 0;
 }
 
@@ -1362,8 +1370,6 @@ static int __maybe_unused elan_suspend(struct device *dev)
 
 	if (device_may_wakeup(dev)) {
 		ret = elan_sleep(data);
-		/* Enable wake from IRQ */
-		data->irq_wake = (enable_irq_wake(client->irq) == 0);
 	} else {
 		ret = elan_set_power(data, false);
 		if (ret)
@@ -1394,9 +1400,6 @@ static int __maybe_unused elan_resume(struct device *dev)
 			dev_err(dev, "error %d enabling regulator\n", error);
 			goto err;
 		}
-	} else if (data->irq_wake) {
-		disable_irq_wake(client->irq);
-		data->irq_wake = false;
 	}
 
 	error = elan_set_power(data, true);
-- 
2.37.3.968.ga6b4b080e4-goog

