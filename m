Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 765CC5BD1AD
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Sep 2022 18:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbiISQAS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 19 Sep 2022 12:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbiISP7l (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 19 Sep 2022 11:59:41 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CCF91F2
        for <linux-acpi@vger.kernel.org>; Mon, 19 Sep 2022 08:59:29 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id d8so20184455iof.11
        for <linux-acpi@vger.kernel.org>; Mon, 19 Sep 2022 08:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=rcvDP2WJ+fQZJ5qsY5Dl3GZhszdSslMkj/qO46b14mU=;
        b=NBIMcgibUAu7oZkRHm1OvOAcydfmYYjd1S5xzmOpGf/VJKkYGlPabymaNhIKlJ2E/R
         6tMkUYfFxArvt8MhQfp3ktkLQBRcUioW/nEIq8xMjZyZpKa5AiVqgkecXAXM1m4VsFzW
         NNGMZtX0WPdVXbCeoj7jZjzQjds6ezgbRtmN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=rcvDP2WJ+fQZJ5qsY5Dl3GZhszdSslMkj/qO46b14mU=;
        b=U0ZXk1xyx8/I3xn6sH3C+3j3zPzG3fx8ZWXkWsduSPRuY/tkre16z3TEzNb5glQkus
         TymOErRSac0gIzKEy2ZPoTSC/NP5FrDe0EVvTdY6nDbw1sYH01XzFfCCkZ05IZNjuQ4h
         Pr97CwBQWBoeeMeDwpGw5l4NGV8lO3HfJMBZzNFULdmbtRd5neK0qAK5/rmk9ATx4qhd
         UD0/xdYw92z5+LMeyKoFBxqkheV4itDQkq3WsDPrlSlvdMOdba81F7oIizjrRk3xQD3O
         fkMGabGYA/v3VrZuRivIAxhcs8i1eWKhWBv8mjPFfTnZoH4nLtSFm6BVFttfz7LSd5DE
         +Hrg==
X-Gm-Message-State: ACrzQf2H+KmE3yViviwuKciHXCUBUKFUlAeYPpJnC/hG+tmyZ+l3X8XG
        v/MFkRTvyfaLJgkmY1zZnI9/k5tFEocuqw==
X-Google-Smtp-Source: AMsMyM7x63qHthDCA1vjb9vUh/2k6fjHLP2VBwI9FyxoBwKo9+qvXH5rzrEA+EuROITUQac55CEqrg==
X-Received: by 2002:a05:6638:3398:b0:35a:3da9:fc7a with SMTP id h24-20020a056638339800b0035a3da9fc7amr8443874jav.87.1663603168481;
        Mon, 19 Sep 2022 08:59:28 -0700 (PDT)
Received: from rrangel920.bld.corp.google.com (h24-56-189-219.arvdco.broadband.dynamic.tds.net. [24.56.189.219])
        by smtp.gmail.com with ESMTPSA id t70-20020a025449000000b00349fb9b1abesm5634154jaa.106.2022.09.19.08.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 08:59:28 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-acpi@vger.kernel.org, linux-input@vger.kernel.org
Cc:     timvp@google.com, hdegoede@redhat.com,
        andriy.shevchenko@linux.intel.com, rafael@kernel.org,
        mario.limonciello@amd.com, jingle.wu@emc.com.tw,
        mika.westerberg@linux.intel.com, dmitry.torokhov@gmail.com,
        linus.walleij@linaro.org, Raul E Rangel <rrangel@chromium.org>,
        Alistair Francis <alistair@alistair23.me>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 09/13] HID: i2c-hid: acpi: Stop setting wakeup_capable
Date:   Mon, 19 Sep 2022 09:59:11 -0600
Message-Id: <20220919095504.v4.9.I2efb7f551e0aa2dc4c53b5fd5bbea91a1cdd9b32@changeid>
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

This is now handled by the i2c-core driver.

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---

(no changes since v1)

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
2.37.3.968.ga6b4b080e4-goog

