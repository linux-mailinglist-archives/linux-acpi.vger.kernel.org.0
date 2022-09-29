Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F1C5EFA2B
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Sep 2022 18:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236167AbiI2QU7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 29 Sep 2022 12:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236175AbiI2QTm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 29 Sep 2022 12:19:42 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA656BAA
        for <linux-acpi@vger.kernel.org>; Thu, 29 Sep 2022 09:19:32 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id g6so944591ild.6
        for <linux-acpi@vger.kernel.org>; Thu, 29 Sep 2022 09:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B2T8BuI3no24teUYYIo0mu0zp3pTsUlj5QnA0Co7tqM=;
        b=UwPP1YFFYnXM+Ku/9y9p8KGX0YX47OhXCxxVWY5lkFnmxvZJcYEFbJBsCkG0PgO566
         bvD24Zr5UdcNL/cdHYxVmpZTF6SXfmCe+thOLu6AjMnxn5Cd2mu4SpV39hqOI4p48t3o
         svRAwaOXpRJnpwcv4yvarO7idPNktzR5kQUDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B2T8BuI3no24teUYYIo0mu0zp3pTsUlj5QnA0Co7tqM=;
        b=QdXQBYPZmr+jQfL76Ps8sIJ48IZc2wW4Gh4qPpMjQq9GJ6wscsNi1AOWejEVqBIU4P
         XucTSC/V6Icgmy+ehHPzDpA+LH21RqtBVacJFkrjH9eA5G6K7HPeGoxCl1FMg1/QkMGp
         gmjO7EXXktvVgnfOY6cNJibkPI8+sMg0SOPdPql0umJa6bwH1iz0qNfWVj+061rV7/nW
         P9jC47mgAGK4jS9vR60mrHF+L+MqDDPkZ76f/l4x2zh87D67f3pTuvHUfCSRloNO5X7L
         WBL48hcBbU0uK4KIcjSVPIi9NNl8EMTF7ZhgPA7GGA1yl/pb6luLPf0nuVzhbSvX9b3g
         k/Cg==
X-Gm-Message-State: ACrzQf23olNQ4lP788pZvJE2228A5JiTWlbxX/3oqSmvTYKFmFja12Ku
        vhKsrr0G966vclrmL8+xjmHmDMMDwQf3Ig==
X-Google-Smtp-Source: AMsMyM5az6ilUptS6Jcem1rQWz0X20XO2/hi/bE9rH/EA2zlCEfoEO/nwkxfkjunPAyuL5vWVcJHqw==
X-Received: by 2002:a05:6e02:1bcf:b0:2f6:a41b:cc11 with SMTP id x15-20020a056e021bcf00b002f6a41bcc11mr1999439ilv.103.1664468371628;
        Thu, 29 Sep 2022 09:19:31 -0700 (PDT)
Received: from rrangel920.bld.corp.google.com (h24-56-189-219.arvdco.broadband.dynamic.tds.net. [24.56.189.219])
        by smtp.gmail.com with ESMTPSA id f12-20020a02848c000000b0035aab2f1ab1sm2965451jai.134.2022.09.29.09.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 09:19:31 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-acpi@vger.kernel.org, linux-input@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com, dmitry.torokhov@gmail.com,
        hdegoede@redhat.com, rafael@kernel.org,
        mika.westerberg@linux.intel.com, mario.limonciello@amd.com,
        timvp@google.com, linus.walleij@linaro.org, jingle.wu@emc.com.tw,
        Raul E Rangel <rrangel@chromium.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Alistair Francis <alistair@alistair23.me>,
        Jiri Kosina <jikos@kernel.org>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 09/13] HID: i2c-hid: acpi: Stop setting wakeup_capable
Date:   Thu, 29 Sep 2022 10:19:13 -0600
Message-Id: <20220929093200.v6.9.I2efb7f551e0aa2dc4c53b5fd5bbea91a1cdd9b32@changeid>
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

This is now handled by the i2c-core driver.

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---

(no changes since v5)

Changes in v5:
- Added Acked-by: Benjamin Tissoires

 drivers/hid/i2c-hid/i2c-hid-acpi.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-acpi.c b/drivers/hid/i2c-hid/i2c-hid-acpi.c
index b96ae15e0ad917e..375c77c3db74d92 100644
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
2.37.3.998.g577e59143f-goog

