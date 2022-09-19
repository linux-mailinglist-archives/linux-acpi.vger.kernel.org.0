Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 791835BD1B2
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Sep 2022 18:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbiISQAb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 19 Sep 2022 12:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbiISP74 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 19 Sep 2022 11:59:56 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55589299
        for <linux-acpi@vger.kernel.org>; Mon, 19 Sep 2022 08:59:30 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id g6so2607641ild.6
        for <linux-acpi@vger.kernel.org>; Mon, 19 Sep 2022 08:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Tzm/qE0nIcj5tRamCrRt6njHA6IRj7QMwAd5TFMNttM=;
        b=DXGmrXM/FAQkex6T1sl2ujol2NIi1taXqx1n31CU5bFYFLfY3foESYyc7JawaMLuUe
         JkzOcFWBF84Xv+d9v0uDpPyRQNl3nQ3oVv4OMuzfaTwJCHh9X7yE64PMItpivc9JGQuQ
         hfdIPTishauaidNJtedqxMS0UDQ30byvm+f4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Tzm/qE0nIcj5tRamCrRt6njHA6IRj7QMwAd5TFMNttM=;
        b=Lb6cbSYAmnbTy8afwggEehjTx4YRtXaih35PFRG+kPuxNKXfF68jDj41c+EaVc1J6j
         UmfZx2IvwizzEJ9KPR/t1H3nQP1ZNUFfAQ2vhaBTu3sfuMIync4X7JFlygmZ4biK/A3g
         euoIIYMeMgDLacrwZYsqvQQiJHY1cksrk/Nz6MdcLsO2HzKJIJOLg7ZZg/YV9YZ9jJsI
         TIGljmSRM2ydmRq3vyxJsfqGC6dTdRDJDYQYbUGuvQiDPs5ZkHxR18rmx/vtMJGDa0wZ
         tsnUakztwC5pnri55XbtufdDK7hNkoHg1WjKjpzQm6FAl3Rr7lh/PfmqskNYvjglMMh4
         lf6g==
X-Gm-Message-State: ACrzQf3LCI+46X0SL+ttJ+erPftw69HfqmtdhxaTxQSL3fffqmrcXkO1
        ThYfZR4UE37IMMxW3u6cRZm44xoFptttxQ==
X-Google-Smtp-Source: AMsMyM78kgf44ZgqtryL6XUD05y/uEDkzeurXXhzG3uc3Z8u/CmJu4l1sMGjiyvxdx7sgwzqpK8OyQ==
X-Received: by 2002:a92:ca4f:0:b0:2f6:1136:e8f6 with SMTP id q15-20020a92ca4f000000b002f61136e8f6mr785287ilo.154.1663603169461;
        Mon, 19 Sep 2022 08:59:29 -0700 (PDT)
Received: from rrangel920.bld.corp.google.com (h24-56-189-219.arvdco.broadband.dynamic.tds.net. [24.56.189.219])
        by smtp.gmail.com with ESMTPSA id t70-20020a025449000000b00349fb9b1abesm5634154jaa.106.2022.09.19.08.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 08:59:29 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-acpi@vger.kernel.org, linux-input@vger.kernel.org
Cc:     timvp@google.com, hdegoede@redhat.com,
        andriy.shevchenko@linux.intel.com, rafael@kernel.org,
        mario.limonciello@amd.com, jingle.wu@emc.com.tw,
        mika.westerberg@linux.intel.com, dmitry.torokhov@gmail.com,
        linus.walleij@linaro.org, Raul E Rangel <rrangel@chromium.org>,
        Angela Czubak <acz@semihalf.com>,
        Bartosz Szczepanek <bsz@semihalf.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Yang Li <yang.lee@linux.alibaba.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 10/13] HID: i2c-hid: Don't set wake_capable and wake_irq
Date:   Mon, 19 Sep 2022 09:59:12 -0600
Message-Id: <20220919095504.v4.10.Id22d056440953134d8e8fe2c2aff79c79bc78424@changeid>
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

The i2c-core will now handle setting the wake_irq for DT and ACPI
systems.

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---

(no changes since v1)

 drivers/hid/i2c-hid/i2c-hid-core.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index a2fa40dec04ea5..65b7a95956866d 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -1036,15 +1036,6 @@ int i2c_hid_core_probe(struct i2c_client *client, struct i2chid_ops *ops,
 	if (ret < 0)
 		goto err_powered;
 
-	/*
-	 * The wake IRQ should be declared via device tree instead of assuming
-	 * the IRQ can wake the system. This is here for legacy reasons and
-	 * will be removed once the i2c-core supports querying ACPI for wake
-	 * capabilities.
-	 */
-	if (!client->dev.power.wakeirq)
-		dev_pm_set_wake_irq(&client->dev, client->irq);
-
 	hid = hid_allocate_device();
 	if (IS_ERR(hid)) {
 		ret = PTR_ERR(hid);
-- 
2.37.3.968.ga6b4b080e4-goog

