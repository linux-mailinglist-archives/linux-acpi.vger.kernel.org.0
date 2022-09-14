Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10E865B914E
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Sep 2022 01:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbiINX7Q (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 14 Sep 2022 19:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiINX67 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Sep 2022 19:58:59 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740D789938
        for <linux-acpi@vger.kernel.org>; Wed, 14 Sep 2022 16:58:20 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id d8so10597292iof.11
        for <linux-acpi@vger.kernel.org>; Wed, 14 Sep 2022 16:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=F4E89pQ2FrSepPnER/REAyEkKBd4VwJQnWtxeznDInw=;
        b=gIASrLgf9OZ8PhCuu5JVaGjTRHApQbKQ2UubkA8t7hWpqS7r2E/RwDlv7HQWzQ6LKL
         6+JM6MNE9aTtuT9HqVQ6yw1x4Qq5HE5cVQWl+oPEpoTnD1HyKjgxUHHc7TcGO4Yo0txa
         Kr8d3LFOQUiPV7G76rXMBecTPmCqhBTW03g/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=F4E89pQ2FrSepPnER/REAyEkKBd4VwJQnWtxeznDInw=;
        b=Khk2K7pic2RLqgt32ZjS7UYTKGPIPlxCtWHtA/n90JfEpi5LgNExptV+50XE3oa7zn
         a6mTxeMv+LsBHI1yYL0CSF+/h2tOwiGjfoDjmrMquERUUKVLn7Iojg3tk6sYTqXldQno
         i4SOV3qtMG8lCCliMPviMyAhbiFpZXzWVvBMmCJKgXYj/FXF1rM7jP4XdV5A1GEYWOw9
         pBDnwroM2AVVR23YDOmhMeZc6ZVSPfmuO0c55GW1gJE1CaNIthcFmcOn2ErM73G2Sx3v
         NdsQcR+wfOXhQdJ+4oaMdFrJZEIEVVQOYp+O/illebfmYAw1jV1O8AjQjUiVMF9/mWbJ
         K8oA==
X-Gm-Message-State: ACgBeo33CLVyoOyHLslAcJ3WbcigvgsJRLaKY7sB2VRATPt+OBu8EEGj
        1yFmET68gbiP5ZBd1+eUhYMmBZ80AE4xOw==
X-Google-Smtp-Source: AA6agR4JGY5A/brDWXhKfOsB5rBjLJjaRvPL9vy0Xiv7IbO9ITalfAZiHczbd/6pH+4/aoTa1Eicog==
X-Received: by 2002:a05:6602:2a47:b0:689:e971:8e67 with SMTP id k7-20020a0566022a4700b00689e9718e67mr16872002iov.47.1663199899601;
        Wed, 14 Sep 2022 16:58:19 -0700 (PDT)
Received: from rrangel920.bld.corp.google.com (h24-56-189-219.arvdco.broadband.dynamic.tds.net. [24.56.189.219])
        by smtp.gmail.com with ESMTPSA id a14-20020a027a0e000000b0034c0e8829c0sm353721jac.0.2022.09.14.16.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 16:58:19 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-acpi@vger.kernel.org, linux-input@vger.kernel.org
Cc:     jingle.wu@emc.com.tw, rafael@kernel.org,
        andriy.shevchenko@linux.intel.com, mario.limonciello@amd.com,
        hdegoede@redhat.com, linus.walleij@linaro.org, timvp@google.com,
        dmitry.torokhov@gmail.com, Raul E Rangel <rrangel@chromium.org>,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 08/13] ACPI: PM: Take wake IRQ into consideration when entering suspend-to-idle
Date:   Wed, 14 Sep 2022 17:57:56 -0600
Message-Id: <20220914155914.v3.8.I7d9202463f08373feccd6e8fd87482c4f40ece5d@changeid>
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
In-Reply-To: <20220914235801.1731478-1-rrangel@chromium.org>
References: <20220914235801.1731478-1-rrangel@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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
2.37.3.968.ga6b4b080e4-goog

