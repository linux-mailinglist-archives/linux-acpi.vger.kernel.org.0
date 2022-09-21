Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC8F65C034B
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Sep 2022 18:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbiIUQCB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 21 Sep 2022 12:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232766AbiIUQA2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 21 Sep 2022 12:00:28 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E53458DDF
        for <linux-acpi@vger.kernel.org>; Wed, 21 Sep 2022 08:53:53 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id i16so333701ilq.0
        for <linux-acpi@vger.kernel.org>; Wed, 21 Sep 2022 08:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=H54d0G6AAErtN9paRV2+6Wo2Il0gAFeOcBLywRUXXa0=;
        b=aPT4P7qoRZWdL5Bmar/LZHlelSGaUIcO+KvnefvZmwjLeCnKyFua9Sdj/jZ3OYL968
         cQxDi+jSWtUu8TdBqWCYELC8kdx3qAM2gxeRYH8iHLqWA9+l0/9xs6ERSCp/n70oZaHw
         z/ZVSYsY35pX3YiNhdheaP4Q62BbzLzk4j470=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=H54d0G6AAErtN9paRV2+6Wo2Il0gAFeOcBLywRUXXa0=;
        b=ym9q8B5otzNYoIy/B0ipApcTN16zreWnFVyVlYt6lEEp11QRkf0yt0CrYIGdPeDNcD
         vGf7LQMxLjIFJbSebfZ3DDkixzv1D8jzxzS1F4/FZes/oqtUd+sz4SLlenY26lOVPnLZ
         /0NTAgr1xNqoaffC+7z8LtJeKIiiYvQicXZWii8rZBj+cjkVl8DfVrdF8SlNuWof6Yox
         v5qRwLVtSab06xnWQORO1RGG/YSiQey2Nvk3e6UgpCUwfJuvHv//5bghgTpagkW14cLs
         kypkhMVKMrnid9RXG0SWz17kwxIhbsTC/PL4qSL1806+/Lil836Y0WQLoV++IYf9kmUF
         sfFQ==
X-Gm-Message-State: ACrzQf1GcJmrxbjbymYatvCPy/bd7ckuPAyVAQr9KVU/hQIfjCtmRvyd
        4u2yQ717+y6rYeHBcwPKP/YiSjtKqxTIzQ==
X-Google-Smtp-Source: AMsMyM7LF80A56RG5rA5mp7cs5aIJCOrf0Zc81Hwi3Jug3DDAhNSylTY9RpImJUvdn25Fw0A8rtlVg==
X-Received: by 2002:a92:c546:0:b0:2f1:ceaf:89f8 with SMTP id a6-20020a92c546000000b002f1ceaf89f8mr12931327ilj.195.1663775542631;
        Wed, 21 Sep 2022 08:52:22 -0700 (PDT)
Received: from rrangel920.bld.corp.google.com (h24-56-189-219.arvdco.broadband.dynamic.tds.net. [24.56.189.219])
        by smtp.gmail.com with ESMTPSA id c14-20020a023b0e000000b0035a8d644a31sm1148061jaa.117.2022.09.21.08.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 08:52:22 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-acpi@vger.kernel.org, linux-input@vger.kernel.org
Cc:     rafael@kernel.org, timvp@google.com,
        mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com,
        dmitry.torokhov@gmail.com, jingle.wu@emc.com.tw,
        hdegoede@redhat.com, mario.limonciello@amd.com,
        linus.walleij@linaro.org, Raul E Rangel <rrangel@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 11/13] Input: elan_i2c - Don't set wake_capable and wake_irq
Date:   Wed, 21 Sep 2022 09:52:03 -0600
Message-Id: <20220921094736.v5.11.I7309b8f322082437b93581c6e2953886eeb998d7@changeid>
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
In-Reply-To: <20220921155205.1332614-1-rrangel@chromium.org>
References: <20220921155205.1332614-1-rrangel@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The i2c-core will now handle setting the wake_irq and wake capability
for DT and ACPI systems.

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---

(no changes since v2)

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
2.37.3.968.ga6b4b080e4-goog

