Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C03455B6371
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Sep 2022 00:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbiILWPM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 12 Sep 2022 18:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbiILWOL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 12 Sep 2022 18:14:11 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D984E639
        for <linux-acpi@vger.kernel.org>; Mon, 12 Sep 2022 15:13:58 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id y15so4794234iof.13
        for <linux-acpi@vger.kernel.org>; Mon, 12 Sep 2022 15:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=voPhsoaHT770bZnSxaOidypoc2wPeBFAreupfLjJEw0=;
        b=Inhtl0nBvTwwMMQkeB+30lBb3w7BnKQMzlRF90y/59z/Laj3751CdVOlt820XPfxI4
         2mOFNQEYq3gGqaMigySGpLd5UXSvrTlpfT39gFPUCsd1Cf3P6HNLBY+Xh+IcZdRGIyVf
         2BlDn7tOU4M5HrB5tqjwrAMJtfye7mR5OJTQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=voPhsoaHT770bZnSxaOidypoc2wPeBFAreupfLjJEw0=;
        b=XaxE0kD38toatyXPkY3iP1JbzreNm8A8SQn09f4Sg9JUMGQn2YxyHhpamAZuIY7GzJ
         Tg6J85dA0ndgPsnha0q9MVjLDvp3uJJCZzsh6gg9kSGAEBTc2NWJ3PDanqXajulxoxto
         BlfC3v9lK/uBoCJvbHDjh067RnvrTRJjiKde4/kNUnltGngf7/1rEHk8XweOFQ0tyNWN
         dpbnHppQBPWGRIJyT5Ac1fDd2e5+ZPU/FC37obei4jGtMSmi3jT5uP4dkG+S3Q87pl8y
         jo5hNdOflHUmcOxySFjINgxogsqDgQo6hXfp0l9yrA9nXv8jp7eJsXpcsp/EwgMMHNnw
         mL0Q==
X-Gm-Message-State: ACgBeo0bGbnF5gG3LKWjZ5gwraxg3EwzL4rFQRqoCI1FKiEBCJ3gF0kV
        CW2fzZxqrqmQKdSj7gZcGz16Izs3F+BicA==
X-Google-Smtp-Source: AA6agR5D1AVvH2kkuflK8l+Rg/N+BNYFqxo59H5yFAw8LkZQlmKDXiuh0/SYfadlNmkzxI64kSbtOw==
X-Received: by 2002:a05:6638:3802:b0:351:d8a5:6d58 with SMTP id i2-20020a056638380200b00351d8a56d58mr15378011jav.206.1663020837468;
        Mon, 12 Sep 2022 15:13:57 -0700 (PDT)
Received: from rrangel920.bld.corp.google.com (h24-56-189-219.arvdco.broadband.dynamic.tds.net. [24.56.189.219])
        by smtp.gmail.com with ESMTPSA id 18-20020a056e020cb200b002f16e7021f6sm4077334ilg.22.2022.09.12.15.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 15:13:56 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-acpi@vger.kernel.org, linux-input@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com, jingle.wu@emc.com.tw,
        mario.limonciello@amd.com, timvp@google.com,
        linus.walleij@linaro.org, hdegoede@redhat.com, rafael@kernel.org,
        Raul E Rangel <rrangel@chromium.org>,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/13] ACPI: PM: Take wake IRQ into consideration when entering suspend-to-idle
Date:   Mon, 12 Sep 2022 16:13:12 -0600
Message-Id: <20220912160931.v2.8.I7d9202463f08373feccd6e8fd87482c4f40ece5d@changeid>
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

This change adds support for ACPI devices that use ExclusiveAndWake or
SharedAndWake in their _CRS GpioInt definition (instead of using _PRW),
and also provide power resources. Previously the ACPI subsystem had no
idea if the device had a wake capable interrupt armed. This resulted
in the ACPI device PM system placing the device into D3Cold, and thus
cutting power to the device. With this change we will now query the
_S0W method to figure out the appropriate wake capable D-state.

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---

(no changes since v1)

 drivers/acpi/device_pm.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
index 9dce1245689ca2..6bc81f525d5160 100644
--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -681,8 +681,23 @@ static int acpi_dev_pm_get_state(struct device *dev, struct acpi_device *adev,
 		d_min = ret;
 		wakeup = device_may_wakeup(dev) && adev->wakeup.flags.valid
 			&& adev->wakeup.sleep_state >= target_state;
-	} else {
-		wakeup = adev->wakeup.flags.valid;
+	} else if (acpi_device_can_wakeup(adev)) {
+		/* ACPI GPE from specified by _PRW. */
+		wakeup = true;
+	} else if (device_may_wakeup(dev) && dev->power.wakeirq) {
+		/*
+		 * The ACPI subsystem doesn't manage the wake bit for IRQs
+		 * defined with ExclusiveAndWake and SharedAndWake. Instead we
+		 * expect them to be managed via the PM subsystem. Drivers
+		 * should call dev_pm_set_wake_irq to register an IRQ as a wake
+		 * source.
+		 *
+		 * If a device has a wake IRQ attached we need to check the
+		 * _S0W method to get the correct wake D-state. Otherwise we
+		 * end up putting the device into D3Cold which will more than
+		 * likely disable wake functionality.
+		 */
+		wakeup = true;
 	}
 
 	/*
-- 
2.37.2.789.g6183377224-goog

