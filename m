Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA7E5B6376
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Sep 2022 00:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbiILWPl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 12 Sep 2022 18:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbiILWOx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 12 Sep 2022 18:14:53 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328A44DB6F
        for <linux-acpi@vger.kernel.org>; Mon, 12 Sep 2022 15:14:03 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id 62so8153730iov.5
        for <linux-acpi@vger.kernel.org>; Mon, 12 Sep 2022 15:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=EQhgOD8GYWZ1C12FLxwAVFm3LB8u519tluS0AqRal5c=;
        b=luy4LMQbtHGSyG48mCLw3/o39De3GHlrAz2inQPg5tI0TXYopdCg7YW3MlpNvuU4J4
         6GCaVJiBJ3qbwS9sTZDbF/dTPw+g0+zGARl23BvBHkK4ZhlwysJSHli+MTBqpYHwkrpk
         NCLnfh5IWJ1stSUvfpbl/nAm49r9CJA8YLz4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=EQhgOD8GYWZ1C12FLxwAVFm3LB8u519tluS0AqRal5c=;
        b=hBaRiUGZ5tLQT0xTXnbh8YFURjxgjgpHd7mwRTsSL7wDmlIot2CDtgJ3dae3dImQyq
         e8qH80M1JM8wIU9iuzb52qlICNjuLCq4eqKK+3yBYAZ/RjUuTqlc+ZcfBoeZ7z/tm3bI
         tuFjwN/+7elheIAbtKmDpA+XPmVG3LD/mTIY39ASkyexZRHUTcMBORmSe5OhN3IDIBFN
         vwmZKLUQMFuV74oC8JCKrSYowQYmaqfGpjzT9fDlerBIYN54CTqvjiW7gZ3XSdzhJaP0
         lxTJTrG4QrcceWprzXA2dI89Kb7ULrR5I7U+yGN+mxP8qjGCmOy2OdUp1+HvRIHO7UfL
         7ghA==
X-Gm-Message-State: ACgBeo3g1ZNQEKqUDXP37+DDaPB0miJV8TwHwqz5D4Ul9Wlw+me3mY/L
        Yobce5RHxQxc6PJdwXPL/tfMylnRWRuCgg==
X-Google-Smtp-Source: AA6agR6iJzUQR9oNTiGIrkfGz9fdMPtIY1eX0BkVLvaoRA3TVkRx3hbF8WFE/68VpV4H/qXtmZTy1A==
X-Received: by 2002:a05:6638:4107:b0:358:4a01:e1e3 with SMTP id ay7-20020a056638410700b003584a01e1e3mr11233312jab.189.1663020842286;
        Mon, 12 Sep 2022 15:14:02 -0700 (PDT)
Received: from rrangel920.bld.corp.google.com (h24-56-189-219.arvdco.broadband.dynamic.tds.net. [24.56.189.219])
        by smtp.gmail.com with ESMTPSA id 18-20020a056e020cb200b002f16e7021f6sm4077334ilg.22.2022.09.12.15.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 15:14:01 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-acpi@vger.kernel.org, linux-input@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com, jingle.wu@emc.com.tw,
        mario.limonciello@amd.com, timvp@google.com,
        linus.walleij@linaro.org, hdegoede@redhat.com, rafael@kernel.org,
        Raul E Rangel <rrangel@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/13] Input: elan_i2c - Don't set wake_capable and wake_irq
Date:   Mon, 12 Sep 2022 16:13:15 -0600
Message-Id: <20220912160931.v2.11.I7309b8f322082437b93581c6e2953886eeb998d7@changeid>
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

The i2c-core will now handle setting the wake_irq and wake capability
for DT and ACPI systems.

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---

Changes in v2:
- I chose not to keep the legacy code around since systems without DT or ACPI should be rare.

 drivers/input/mouse/elan_i2c_core.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index 3947474e93d16a..b25b94aba3e88e 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -1332,22 +1332,6 @@ static int elan_probe(struct i2c_client *client,
 		}
 	}
 
-	/*
-	 * Systems using device tree should set up wakeup via DTS,
-	 * the rest will configure device as wakeup source by default.
-	 */
-	if (!dev->of_node)
-		device_init_wakeup(dev, true);
-
-	/*
-	 * The wake IRQ should be declared via device tree instead of assuming
-	 * the IRQ can wake the system. This is here for legacy reasons and
-	 * will be removed once the i2c-core supports querying ACPI for wake
-	 * capabilities.
-	 */
-	if (!dev->power.wakeirq)
-		dev_pm_set_wake_irq(dev, client->irq);
-
 	return 0;
 }
 
-- 
2.37.2.789.g6183377224-goog

