Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2485C03EC
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Sep 2022 18:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiIUQSw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 21 Sep 2022 12:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbiIUQS0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 21 Sep 2022 12:18:26 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A56BAB409
        for <linux-acpi@vger.kernel.org>; Wed, 21 Sep 2022 09:03:11 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id x2so3351985ill.10
        for <linux-acpi@vger.kernel.org>; Wed, 21 Sep 2022 09:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=THUFniOK+VEaZvk3WrlhDVy764x1MLYSOQIxcILEvxQ=;
        b=X0gOecgOXbR09B7uWiGNA3l57ZH5gzdV7m2fMkuQmBtbM0SHP5TFh/xGTkWyKMdd6k
         bYpQNI35i3B3pvOfI+0U3gvY9f46t3tfzi3Cngcf2p06SP/YugBowaJzwFQnjtycWsIm
         yvQwRVcp/HB0tQHhH92QQfiTU3aLyBnLZx8zo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=THUFniOK+VEaZvk3WrlhDVy764x1MLYSOQIxcILEvxQ=;
        b=CLEX3gKs2Bt28VQ5n/UNzNPxaMBzZKvbRtIrrF/aPeQfj1CsDZWRYIzNaMy0mIWyOI
         2Zkz84/4BQuiGTi1yniAju7c5L3cd22CrgFRv3+lRgsegdyYMDVVp3QYII4QVu+VJBDV
         BoyjE5Z3FTH8JgINEkrLkjHRWNlnRgebYZbAxj+rCgkuD+nUY+C3HM77M1KBbDU38b9x
         cNul/2miyUEcm8jktN7dWKvzyYYyIq9glFrANapJox6AgC1Iz1KEnoIAnCCTHd3Ql/In
         lpbuBrxgqo+Q8JSeZonBfeH1VdvtE3kDY//EDiL4QyNi58fuQAx/QUU9X7B83dW/QrCA
         eNdw==
X-Gm-Message-State: ACrzQf3bBGuMfYNJ1gFkp8hzBsG48jqjrP/1Z0YTdVLpIDYSbLP+tVAe
        vggS6l5fw9eYIF97eeAunJUzuG9c4AHXlA==
X-Google-Smtp-Source: AMsMyM7Y39hoLqgIounsHo+rfvleaY90wBHu2R1tTiv/+BtlKIZ58AXKbEM8mFWmHFs9E7lq3sofGg==
X-Received: by 2002:a05:6e02:1c48:b0:2f1:db4b:66df with SMTP id d8-20020a056e021c4800b002f1db4b66dfmr12601061ilg.35.1663775541555;
        Wed, 21 Sep 2022 08:52:21 -0700 (PDT)
Received: from rrangel920.bld.corp.google.com (h24-56-189-219.arvdco.broadband.dynamic.tds.net. [24.56.189.219])
        by smtp.gmail.com with ESMTPSA id c14-20020a023b0e000000b0035a8d644a31sm1148061jaa.117.2022.09.21.08.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 08:52:21 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-acpi@vger.kernel.org, linux-input@vger.kernel.org
Cc:     rafael@kernel.org, timvp@google.com,
        mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com,
        dmitry.torokhov@gmail.com, jingle.wu@emc.com.tw,
        hdegoede@redhat.com, mario.limonciello@amd.com,
        linus.walleij@linaro.org, Raul E Rangel <rrangel@chromium.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Alistair Francis <alistair@alistair23.me>,
        Bartosz Szczepanek <bsz@semihalf.com>,
        Jiri Kosina <jikos@kernel.org>, Rob Herring <robh@kernel.org>,
        Yang Li <yang.lee@linux.alibaba.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 10/13] HID: i2c-hid: Don't set wake_capable and wake_irq
Date:   Wed, 21 Sep 2022 09:52:02 -0600
Message-Id: <20220921094736.v5.10.Id22d056440953134d8e8fe2c2aff79c79bc78424@changeid>
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

The i2c-core will now handle setting the wake_irq for DT and ACPI
systems.

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---

Changes in v5:
- Added Acked-by: Benjamin Tissoires

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

