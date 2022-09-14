Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE105B914F
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Sep 2022 01:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiINX7R (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 14 Sep 2022 19:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiINX67 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Sep 2022 19:58:59 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271E58992F
        for <linux-acpi@vger.kernel.org>; Wed, 14 Sep 2022 16:58:19 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id c4so13676233iof.3
        for <linux-acpi@vger.kernel.org>; Wed, 14 Sep 2022 16:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=IrPBaJhayTsmQaagjn3kGBNWcqMGVL6PSHf+mDSmAT8=;
        b=Y1rMEYUcGoMoMTmL0vNyZ/Dgi1ZPxTfb5SvVMCj/7FkWYfPrlBpw1G7bZh6wigSRWv
         dxIFsKThKju72lgMlIwoi+FSFG3YR1VVGwXGinDnM8cT9dAcz0w4yHNOdSLctMO3Nse/
         gxvjDIMcRXW3Gh43U9XEz5nWl2/OCb1LxfEv0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=IrPBaJhayTsmQaagjn3kGBNWcqMGVL6PSHf+mDSmAT8=;
        b=eTV2qnv81XTgV9UHJ7TI6SSmLfrro7OlyQ1vG1wwASKYkuEwhaVtPvXQ+ilmCzdTMl
         B2A8HxtNtMHbGARjIg4sO98weabzMY9URLbdTScjDjjEaUrw+wfrZW0P6f1OA3Rxry0e
         mTVpcf6xeELLDQJHDAdHhAyc1gkPaqplq0IS/RzS1iBoGunzMuTMcCmvS2L76yQ3iGr4
         Y9DqHjKDb0EIVa1gmwufTRX7Ir7WfDSGG6IkvTJvMoKYSjJYtIG4xZw0hLlZ+dlgWXm1
         fQUe9yGj1YguT9l545O9EvuW9Pv9b1fNeU3AoGNQsdGfhJOp7/+Sscf+5H1DFDiSNUPM
         TINg==
X-Gm-Message-State: ACgBeo1fSkkg/jPVjendPAfm/hyPcEwkXpA/D8Hbx5xBn9eb5CTvlyie
        Dsqi5o3BPyxzlxN5sdQOPrLPqE6+Fz1phG18
X-Google-Smtp-Source: AA6agR5OMRFoje682GJ6kTpBwCWXG3yxx27f4f7Npbvq1pC39ftjUh8MPD+aKo/IsYS/pNqhTAlPBQ==
X-Received: by 2002:a02:29c2:0:b0:34a:195e:9574 with SMTP id p185-20020a0229c2000000b0034a195e9574mr20424069jap.79.1663199898203;
        Wed, 14 Sep 2022 16:58:18 -0700 (PDT)
Received: from rrangel920.bld.corp.google.com (h24-56-189-219.arvdco.broadband.dynamic.tds.net. [24.56.189.219])
        by smtp.gmail.com with ESMTPSA id a14-20020a027a0e000000b0034c0e8829c0sm353721jac.0.2022.09.14.16.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 16:58:17 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-acpi@vger.kernel.org, linux-input@vger.kernel.org
Cc:     jingle.wu@emc.com.tw, rafael@kernel.org,
        andriy.shevchenko@linux.intel.com, mario.limonciello@amd.com,
        hdegoede@redhat.com, linus.walleij@linaro.org, timvp@google.com,
        dmitry.torokhov@gmail.com, Raul E Rangel <rrangel@chromium.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 07/13] i2c: acpi: Use ACPI wake capability bit to set wake_irq
Date:   Wed, 14 Sep 2022 17:57:55 -0600
Message-Id: <20220914155914.v3.7.I8af4282adc72eb9f247adcd03676a43893a020a6@changeid>
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

Device tree already has a mechanism to pass the wake_irq. It does this
by looking for the wakeup-source property and setting the
I2C_CLIENT_WAKE flag. This CL adds the ACPI equivalent. It uses the
ACPI interrupt wake flag to determine if the interrupt can be used to
wake the system. Previously the i2c drivers had to make assumptions and
blindly enable the wake IRQ. This can cause spurious wake events. e.g.,
If there is a device with an Active Low interrupt and the device gets
powered off while suspending, the interrupt line will go low since it's
no longer powered and wakes the system. For this reason we should
respect the board designers wishes and honor the wake bit defined on the
interrupt.

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---

Changes in v3:
- Convert wake_capable to bool
- Only update wake_capable pointer once
- Move wake_capable local into local block

Changes in v2:
- Look at wake_cabple bit for IRQ/Interrupt resources

 drivers/i2c/i2c-core-acpi.c | 33 ++++++++++++++++++++++++---------
 drivers/i2c/i2c-core-base.c |  8 +++++++-
 drivers/i2c/i2c-core.h      |  4 ++--
 3 files changed, 33 insertions(+), 12 deletions(-)

diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
index c762a879c4cc6b..b3d68a9659ff4f 100644
--- a/drivers/i2c/i2c-core-acpi.c
+++ b/drivers/i2c/i2c-core-acpi.c
@@ -137,6 +137,11 @@ static const struct acpi_device_id i2c_acpi_ignored_device_ids[] = {
 	{}
 };
 
+struct i2c_acpi_irq_context {
+	int irq;
+	bool wake_capable;
+};
+
 static int i2c_acpi_do_lookup(struct acpi_device *adev,
 			      struct i2c_acpi_lookup *lookup)
 {
@@ -170,11 +175,14 @@ static int i2c_acpi_do_lookup(struct acpi_device *adev,
 
 static int i2c_acpi_add_resource(struct acpi_resource *ares, void *data)
 {
-	int *irq = data;
+	struct i2c_acpi_irq_context *irq_ctx = data;
 	struct resource r;
 
-	if (*irq <= 0 && acpi_dev_resource_interrupt(ares, 0, &r))
-		*irq = i2c_dev_irq_from_resources(&r, 1);
+	if (irq_ctx->irq <= 0 && acpi_dev_resource_interrupt(ares, 0, &r)) {
+		irq_ctx->irq = i2c_dev_irq_from_resources(&r, 1);
+		irq_ctx->wake_capable =
+			!!(r.flags & IORESOURCE_IRQ_WAKECAPABLE);
+	}
 
 	return 1; /* No need to add resource to the list */
 }
@@ -182,31 +190,38 @@ static int i2c_acpi_add_resource(struct acpi_resource *ares, void *data)
 /**
  * i2c_acpi_get_irq - get device IRQ number from ACPI
  * @client: Pointer to the I2C client device
+ * @wake_capable: Set to true if the IRQ is wake capable
  *
  * Find the IRQ number used by a specific client device.
  *
  * Return: The IRQ number or an error code.
  */
-int i2c_acpi_get_irq(struct i2c_client *client)
+int i2c_acpi_get_irq(struct i2c_client *client, bool *wake_capable)
 {
 	struct acpi_device *adev = ACPI_COMPANION(&client->dev);
 	struct list_head resource_list;
-	int irq = -ENOENT;
+	struct i2c_acpi_irq_context irq_ctx = {
+		.irq = -ENOENT,
+	};
 	int ret;
 
 	INIT_LIST_HEAD(&resource_list);
 
 	ret = acpi_dev_get_resources(adev, &resource_list,
-				     i2c_acpi_add_resource, &irq);
+				     i2c_acpi_add_resource, &irq_ctx);
 	if (ret < 0)
 		return ret;
 
 	acpi_dev_free_resource_list(&resource_list);
 
-	if (irq == -ENOENT)
-		irq = acpi_dev_gpio_irq_get(adev, 0);
+	if (irq_ctx.irq == -ENOENT)
+		irq_ctx.irq = acpi_dev_gpio_irq_wake_get(adev, 0,
+							 &irq_ctx.wake_capable);
+
+	if (wake_capable)
+		*wake_capable = irq_ctx.wake_capable;
 
-	return irq;
+	return irq_ctx.irq;
 }
 
 static int i2c_acpi_get_info(struct acpi_device *adev,
diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 91007558bcb260..c4debd46c6340f 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -487,8 +487,14 @@ static int i2c_device_probe(struct device *dev)
 			if (irq == -EINVAL || irq == -ENODATA)
 				irq = of_irq_get(dev->of_node, 0);
 		} else if (ACPI_COMPANION(dev)) {
-			irq = i2c_acpi_get_irq(client);
+			bool wake_capable;
+
+			irq = i2c_acpi_get_irq(client, &wake_capable);
+
+			if (irq > 0 && wake_capable)
+				client->flags |= I2C_CLIENT_WAKE;
 		}
+
 		if (irq == -EPROBE_DEFER) {
 			status = irq;
 			goto put_sync_adapter;
diff --git a/drivers/i2c/i2c-core.h b/drivers/i2c/i2c-core.h
index 87e2c914f1c57b..1247e6e6e97517 100644
--- a/drivers/i2c/i2c-core.h
+++ b/drivers/i2c/i2c-core.h
@@ -61,11 +61,11 @@ static inline int __i2c_check_suspended(struct i2c_adapter *adap)
 #ifdef CONFIG_ACPI
 void i2c_acpi_register_devices(struct i2c_adapter *adap);
 
-int i2c_acpi_get_irq(struct i2c_client *client);
+int i2c_acpi_get_irq(struct i2c_client *client, bool *wake_capable);
 #else /* CONFIG_ACPI */
 static inline void i2c_acpi_register_devices(struct i2c_adapter *adap) { }
 
-static inline int i2c_acpi_get_irq(struct i2c_client *client)
+static inline int i2c_acpi_get_irq(struct i2c_client *client, bool *wake_capable)
 {
 	return 0;
 }
-- 
2.37.3.968.ga6b4b080e4-goog

