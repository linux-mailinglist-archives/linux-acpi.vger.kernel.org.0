Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 720DE5EFA3E
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Sep 2022 18:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236215AbiI2QVp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 29 Sep 2022 12:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236228AbiI2QUB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 29 Sep 2022 12:20:01 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974FCBE04
        for <linux-acpi@vger.kernel.org>; Thu, 29 Sep 2022 09:19:36 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id a2so935711iln.13
        for <linux-acpi@vger.kernel.org>; Thu, 29 Sep 2022 09:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1YwA9OG5h99U5Mh4Bxi4p8qnOV6bB/36joe3czuhguQ=;
        b=f8rp6laB5CllBNN6zmwzHaNksz23qPzNXd3klrxB2Tih5E5FbT+lysIU7wKpaPFQVe
         nHZujXWLGw83SUCABT4xfNixfsQUy/yNPksAaJIujHN1qtOi4kFKYRPwQIcwPJmP9/vE
         4+YxGwkFM97QAiup1JSyAimIHlzWLd/C0dD7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1YwA9OG5h99U5Mh4Bxi4p8qnOV6bB/36joe3czuhguQ=;
        b=mIV1caFKPrHreRlYUmo6cHQBiKfVrEd0Dp7MyyxPV7g3Yc6o96kiG6+5ucMJoaCLL1
         ZmJYQJBg8IcLA4EqftXKe7lUlS+obNiBki/YTQW4nwSjkS73ElvB+wHwPD1cD/Ud5l6F
         QoQMRUSpKBLyXuL752sjcKIfl/NOZQbxMb7qUNaRyYqp91bxe93o9ASZV+7CprR7Pc+q
         iHKko/Lpl7k29UQuSp9sluE8nczhKw93hlgHqZpYzJ845rGiqlR+MrW67Q51PrGzLVCC
         iC5t56RhBUePBQesTpxG/q0hmDXnDBkmYmOOXIgaCqJIXS5dkLhpdt7MRVibYJ+0DmIH
         w43Q==
X-Gm-Message-State: ACrzQf39zNs+G+7SpHmZHGbnP+J41zjimhlzx1vbPGpok8VBN03tusBV
        XTWb/N5+QYH4IOjrvjHxu9s5tgw6QJUJgQ==
X-Google-Smtp-Source: AMsMyM6iP4DREWKSAd7Vdivzy9vt5iZuY7Uipiffs7tMY6MVlQJ2rdRra4Y8EvcR+DshtS/kpDdMdw==
X-Received: by 2002:a92:6811:0:b0:2f8:f381:1bd5 with SMTP id d17-20020a926811000000b002f8f3811bd5mr2149221ilc.145.1664468375544;
        Thu, 29 Sep 2022 09:19:35 -0700 (PDT)
Received: from rrangel920.bld.corp.google.com (h24-56-189-219.arvdco.broadband.dynamic.tds.net. [24.56.189.219])
        by smtp.gmail.com with ESMTPSA id f12-20020a02848c000000b0035aab2f1ab1sm2965451jai.134.2022.09.29.09.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 09:19:35 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-acpi@vger.kernel.org, linux-input@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com, dmitry.torokhov@gmail.com,
        hdegoede@redhat.com, rafael@kernel.org,
        mika.westerberg@linux.intel.com, mario.limonciello@amd.com,
        timvp@google.com, linus.walleij@linaro.org, jingle.wu@emc.com.tw,
        Raul E Rangel <rrangel@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Johnny Chuang <johnny.chuang.emc@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 12/13] Input: elants_i2c - Don't set wake_capable and wake_irq
Date:   Thu, 29 Sep 2022 10:19:16 -0600
Message-Id: <20220929093200.v6.12.I031ffbe411e1bae20bf16a1876da5baf444c7928@changeid>
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

 drivers/input/touchscreen/elants_i2c.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/input/touchscreen/elants_i2c.c b/drivers/input/touchscreen/elants_i2c.c
index 80e16b533c452a0..3500293bb1d8e14 100644
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
2.37.3.998.g577e59143f-goog

