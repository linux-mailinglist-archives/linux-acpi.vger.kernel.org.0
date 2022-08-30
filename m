Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96555A717D
	for <lists+linux-acpi@lfdr.de>; Wed, 31 Aug 2022 01:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbiH3XQr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 30 Aug 2022 19:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbiH3XQ0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 30 Aug 2022 19:16:26 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D6B58528
        for <linux-acpi@vger.kernel.org>; Tue, 30 Aug 2022 16:16:17 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id l6so5279359ilk.13
        for <linux-acpi@vger.kernel.org>; Tue, 30 Aug 2022 16:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=+Zr3ySvWsAbTk84Odn6RLHHn6wzrbctElmly11wkN94=;
        b=iLHDN+YCP6SEeigDXR6QMVNZFzSVxBxLEqWFEgoiIaApBvqp2Talh4Hx2+dYlXR7Jg
         sKyZE385q5vEsw6K/Q8Fuww3vSMn1euFi9t/lIKKrqqbkqRKE7VJ+YSobkQmze6jdN59
         8uNPyKYMmbP/2VRiezTaqz6binp1k6h3Wm+Ig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=+Zr3ySvWsAbTk84Odn6RLHHn6wzrbctElmly11wkN94=;
        b=7lxVMs0zgkviI97qPzLwteDrZZ36OcE/p9tv14zfPG4OObjgHS/dHe4C4L+0dLFfZg
         S0g2XGtvtS7im/dXXYnb4dwq21yFyMZVMRFsUfKdYN3XEi7NU5s42N+ZWYa7Yh3LiM0d
         bMcHKbYN7coHkdXN06Pz01EykWoNnGuIgQgAqvKv3E/qaMCPEsIm01EieFABsMMHKfD9
         fc9wrjlmnflm69vGU6cYW1kFPT9Tw68SdZFwBY2rYDAeWDUKQPjETeRXngAkUPexorIB
         LGWmU/qSC+K27zuRa5e1rI+yZHlUC1ST8LIMR4pY87ouv3XDBZJIXF8xuy/DM0cIbKsh
         xqGw==
X-Gm-Message-State: ACgBeo0x/eeK1j8VaTtCe1trOb3lOVs6GAcs78L9IhBRh4Fz9c/pUwPs
        jHr0ckYqlGizuaaXpSeWSMKWiVkM7T6kPw==
X-Google-Smtp-Source: AA6agR7EnYpMbsonCArvzFQ6q8M1F4HNUWE8hMQhf14cPNEIMWVzS2p0V6Na5vd2QXE/tx8fjaV4Yg==
X-Received: by 2002:a05:6e02:1a41:b0:2eb:7762:f42e with SMTP id u1-20020a056e021a4100b002eb7762f42emr1374216ilv.151.1661901376420;
        Tue, 30 Aug 2022 16:16:16 -0700 (PDT)
Received: from rrangel920.bld.corp.google.com (h24-56-189-219.arvdco.broadband.dynamic.tds.net. [24.56.189.219])
        by smtp.gmail.com with ESMTPSA id z30-20020a056602081e00b0068b1858c81asm6165821iow.13.2022.08.30.16.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 16:16:16 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-acpi@vger.kernel.org, linux-input@vger.kernel.org
Cc:     hdegoede@redhat.com, mario.limonciello@amd.com, timvp@google.com,
        rafael@kernel.org, Raul E Rangel <rrangel@chromium.org>,
        Alistair Francis <alistair@alistair23.me>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] HID: i2c-hid: acpi: Stop setting wakeup_capable
Date:   Tue, 30 Aug 2022 17:15:38 -0600
Message-Id: <20220830171332.5.I2efb7f551e0aa2dc4c53b5fd5bbea91a1cdd9b32@changeid>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
In-Reply-To: <20220830231541.1135813-1-rrangel@chromium.org>
References: <20220830231541.1135813-1-rrangel@chromium.org>
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

This is now handled by the i2c-core driver.

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---

 drivers/hid/i2c-hid/i2c-hid-acpi.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-acpi.c b/drivers/hid/i2c-hid/i2c-hid-acpi.c
index b96ae15e0ad917..375c77c3db74d9 100644
--- a/drivers/hid/i2c-hid/i2c-hid-acpi.c
+++ b/drivers/hid/i2c-hid/i2c-hid-acpi.c
@@ -105,11 +105,6 @@ static int i2c_hid_acpi_probe(struct i2c_client *client)
 
 	acpi_device_fix_up_power(adev);
 
-	if (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0) {
-		device_set_wakeup_capable(dev, true);
-		device_set_wakeup_enable(dev, false);
-	}
-
 	return i2c_hid_core_probe(client, &ihid_acpi->ops,
 				  hid_descriptor_address, 0);
 }
-- 
2.37.2.672.g94769d06f0-goog

