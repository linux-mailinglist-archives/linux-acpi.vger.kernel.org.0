Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603DC5EFA44
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Sep 2022 18:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236184AbiI2QVL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 29 Sep 2022 12:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236191AbiI2QTm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 29 Sep 2022 12:19:42 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D007A10D8
        for <linux-acpi@vger.kernel.org>; Thu, 29 Sep 2022 09:19:33 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id j7so945229ilu.7
        for <linux-acpi@vger.kernel.org>; Thu, 29 Sep 2022 09:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9+q7R3sPe7VmgkNvugXIKprRovdD1yE7rr86lSl3yYE=;
        b=hHXdRPsSlArTrcZhEGh+FwbHdpoD0Zz/lT45kQxb7kPLSCF80Rv6xZHpkugsrZ9Y35
         swTaT4ZtNOp2Kzg/MKJ2yAdrzE8mDhhaiaH6ZLWb93lnYEQJqMCKGpq0rAZS6yxAl5FT
         G35obwK/9W2tV2f/4H9kMH79GlQFeG45miAE0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9+q7R3sPe7VmgkNvugXIKprRovdD1yE7rr86lSl3yYE=;
        b=vi3wR+fW+eIsnk9HpA0ShmZNzpQ2zHB3AaoladL+N3Il9B+W30dxA2Of+2pTV+/vL7
         OKcykJQMV8nGs3X9NfFFlTi110xKgVgOR60CSwmYc0QwGfvuc1uAEH6e7C25mt/CYMEN
         v2YiRh1KTe53wnHYvyixjv9MGzfQV+/m1v0ngMXmVLF4tXsaWIuDMAbhqVs7AR4JD9aA
         MZocMkUNJsLIBH9lE7Zfv3fVzgruA41LVq3FEYtTQ4cjhYszQeuC3+QkkBm76tTxLVtI
         +OhlFjWXylbbbuQv+m3NhJeSNOSUg+57E4oZcFKmElUQO/s2+KGoNniLwC9qCDvGntGm
         wZiA==
X-Gm-Message-State: ACrzQf13diFVYnz5ayThhRPtH39QanSMbIgvXsli/JKeZigrQfLmgaHE
        NkMfXGW8i+YaSYMTR3/G8uM164Mf29taMQ==
X-Google-Smtp-Source: AMsMyM4QM6Dhgvi1d7W47z3rRkRJFIEV5fIccG1s7sJeFsnUb8qOsrdfVLW3fQZg2w+pvgbF+MNo1g==
X-Received: by 2002:a05:6e02:1c46:b0:2f8:e9cc:7ed3 with SMTP id d6-20020a056e021c4600b002f8e9cc7ed3mr2031171ilg.69.1664468373068;
        Thu, 29 Sep 2022 09:19:33 -0700 (PDT)
Received: from rrangel920.bld.corp.google.com (h24-56-189-219.arvdco.broadband.dynamic.tds.net. [24.56.189.219])
        by smtp.gmail.com with ESMTPSA id f12-20020a02848c000000b0035aab2f1ab1sm2965451jai.134.2022.09.29.09.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 09:19:32 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-acpi@vger.kernel.org, linux-input@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com, dmitry.torokhov@gmail.com,
        hdegoede@redhat.com, rafael@kernel.org,
        mika.westerberg@linux.intel.com, mario.limonciello@amd.com,
        timvp@google.com, linus.walleij@linaro.org, jingle.wu@emc.com.tw,
        Raul E Rangel <rrangel@chromium.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Alistair Francis <alistair@alistair23.me>,
        Bartosz Szczepanek <bsz@semihalf.com>,
        Jiri Kosina <jikos@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 10/13] HID: i2c-hid: Don't set wake_capable and wake_irq
Date:   Thu, 29 Sep 2022 10:19:14 -0600
Message-Id: <20220929093200.v6.10.Id22d056440953134d8e8fe2c2aff79c79bc78424@changeid>
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

The i2c-core will now handle setting the wake_irq for DT and ACPI
systems.

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---

(no changes since v5)

Changes in v5:
- Added Acked-by: Benjamin Tissoires

 drivers/hid/i2c-hid/i2c-hid-core.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index a2fa40dec04ea59..65b7a95956866d1 100644
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
2.37.3.998.g577e59143f-goog

