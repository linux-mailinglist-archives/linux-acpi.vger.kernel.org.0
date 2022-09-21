Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC8A5C0326
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Sep 2022 18:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbiIUQAo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 21 Sep 2022 12:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232597AbiIUQAC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 21 Sep 2022 12:00:02 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16DCA2616
        for <linux-acpi@vger.kernel.org>; Wed, 21 Sep 2022 08:53:26 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id z191so5352225iof.10
        for <linux-acpi@vger.kernel.org>; Wed, 21 Sep 2022 08:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=mgV9GFoD/PnPg8Ox/eIPiRcCrnyz5POWnt5SbHnSSbo=;
        b=EV1UpUr5zy/WnMQgW8qJLc7riVKMxTUd+amem7TJWyzDLmc4OH/r1vgThiXyeOZ7uK
         5jq7Wg8r244cOMvOTabg3It9JHoY2XhrUVybCKLkY640SMg7Q3NKatOO+bRs4YaOlTef
         0M26d83h/GNK7x5GPlX2oaQy7OEjI20Mnyll4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=mgV9GFoD/PnPg8Ox/eIPiRcCrnyz5POWnt5SbHnSSbo=;
        b=SIEZlgxyFf8SYPH9gtHx4DBuIQ/riBEMVD7PAf68EnTFqvtHu4YIJy8fkXUBoZQ6nA
         mRj9dNiBZaXyNPbuBvFrT5dj+H64g+vrh+7uB+fnfWxPU3vT/NQDEpfPY485zZ1uZr+A
         NBSrRvB5J20ytKNT8bkBbAvxFlWWLxZgAIOX0t9NfgRSbBt66YWFJnNdPaqB3w3MuPnW
         t67xZWKZlgmDTwDjMzfkXQ93nyE0i5uQJlhdwTsUZuU2FE3SIxrh8v5Z/ZnPYnbomVHW
         r26icPP4ycXUaoJTv2dqtH79f5RMJqDa14DQ0K1MoCRpf5BnYmaZpJfTWHzK67xVt8H9
         NEkA==
X-Gm-Message-State: ACrzQf1smchc07C1olNNj/Ear/wVBkEvIKYe9qZks/nBa/vOAuRJsV5t
        ztLjbJfSomlMvcUE0Bzkjsaol7C71/1fbQ==
X-Google-Smtp-Source: AA6agR5GlvCTPL8WgGfiM7xhqoa+Nvp6/NTRIoJ9uiI5TX2+EalCVP2SL/LAb4FV9QoLgns+PEN+RQ==
X-Received: by 2002:a05:6638:d0d:b0:35a:186a:b3ef with SMTP id q13-20020a0566380d0d00b0035a186ab3efmr13131871jaj.246.1663775537794;
        Wed, 21 Sep 2022 08:52:17 -0700 (PDT)
Received: from rrangel920.bld.corp.google.com (h24-56-189-219.arvdco.broadband.dynamic.tds.net. [24.56.189.219])
        by smtp.gmail.com with ESMTPSA id c14-20020a023b0e000000b0035a8d644a31sm1148061jaa.117.2022.09.21.08.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 08:52:17 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-acpi@vger.kernel.org, linux-input@vger.kernel.org
Cc:     rafael@kernel.org, timvp@google.com,
        mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com,
        dmitry.torokhov@gmail.com, jingle.wu@emc.com.tw,
        hdegoede@redhat.com, mario.limonciello@amd.com,
        linus.walleij@linaro.org, Raul E Rangel <rrangel@chromium.org>,
        Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 07/13] i2c: acpi: Use ACPI wake capability bit to set wake_irq
Date:   Wed, 21 Sep 2022 09:51:59 -0600
Message-Id: <20220921094736.v5.7.I8af4282adc72eb9f247adcd03676a43893a020a6@changeid>
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
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

---

Changes in v5:
- Check irq return value before updating wake_capable pointer

Changes in v4:
- Removed unnecessary !!
- Removed unrelated whitespace change
- Added Reviewed-by
- Renamed i2c_acpi_add_resource to i2c_acpi_add_irq_resource
- Expanded logic in i2c_acpi_add_i2c_resource to make it easier to read

Changes in v3:
- Convert wake_capable to bool
- Only update wake_capable pointer once
- Move wake_capable local into local block

Changes in v2:
- Look at wake_cabple bit for IRQ/Interrupt resources

 drivers/i2c/i2c-core-acpi.c | 37 +++++++++++++++++++++++++++----------
 drivers/i2c/i2c-core-base.c |  6 +++++-
 drivers/i2c/i2c-core.h      |  4 ++--
 3 files changed, 34 insertions(+), 13 deletions(-)

diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
index c762a879c4cc6b..1618f5619d5ed9 100644
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
@@ -168,13 +173,19 @@ static int i2c_acpi_do_lookup(struct acpi_device *adev,
 	return 0;
 }
 
-static int i2c_acpi_add_resource(struct acpi_resource *ares, void *data)
+static int i2c_acpi_add_irq_resource(struct acpi_resource *ares, void *data)
 {
-	int *irq = data;
+	struct i2c_acpi_irq_context *irq_ctx = data;
 	struct resource r;
 
-	if (*irq <= 0 && acpi_dev_resource_interrupt(ares, 0, &r))
-		*irq = i2c_dev_irq_from_resources(&r, 1);
+	if (irq_ctx->irq > 0)
+		return 1;
+
+	if (!acpi_dev_resource_interrupt(ares, 0, &r))
+		return 1;
+
+	irq_ctx->irq = i2c_dev_irq_from_resources(&r, 1);
+	irq_ctx->wake_capable = r.flags & IORESOURCE_IRQ_WAKECAPABLE;
 
 	return 1; /* No need to add resource to the list */
 }
@@ -182,31 +193,37 @@ static int i2c_acpi_add_resource(struct acpi_resource *ares, void *data)
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
+				     i2c_acpi_add_irq_resource, &irq_ctx);
 	if (ret < 0)
 		return ret;
 
 	acpi_dev_free_resource_list(&resource_list);
 
-	if (irq == -ENOENT)
-		irq = acpi_dev_gpio_irq_get(adev, 0);
+	if (irq_ctx.irq == -ENOENT)
+		irq_ctx.irq = acpi_dev_gpio_irq_wake_get(adev, 0, &irq_ctx.wake_capable);
+
+	if (irq_ctx.irq > 0 && wake_capable)
+		*wake_capable = irq_ctx.wake_capable;
 
-	return irq;
+	return irq_ctx.irq;
 }
 
 static int i2c_acpi_get_info(struct acpi_device *adev,
diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 91007558bcb260..fc4b85fb90b1b7 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -487,7 +487,11 @@ static int i2c_device_probe(struct device *dev)
 			if (irq == -EINVAL || irq == -ENODATA)
 				irq = of_irq_get(dev->of_node, 0);
 		} else if (ACPI_COMPANION(dev)) {
-			irq = i2c_acpi_get_irq(client);
+			bool wake_capable;
+
+			irq = i2c_acpi_get_irq(client, &wake_capable);
+			if (irq > 0 && wake_capable)
+				client->flags |= I2C_CLIENT_WAKE;
 		}
 		if (irq == -EPROBE_DEFER) {
 			status = irq;
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

