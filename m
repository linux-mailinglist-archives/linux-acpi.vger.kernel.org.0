Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC5905B9154
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Sep 2022 01:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbiINX7g (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 14 Sep 2022 19:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbiINX7O (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Sep 2022 19:59:14 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4377D89CDC
        for <linux-acpi@vger.kernel.org>; Wed, 14 Sep 2022 16:58:23 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id c4so13676316iof.3
        for <linux-acpi@vger.kernel.org>; Wed, 14 Sep 2022 16:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=rcvDP2WJ+fQZJ5qsY5Dl3GZhszdSslMkj/qO46b14mU=;
        b=kDCQFccX2w7tlX6d2bXrWMrcaaS35CZD/Vo0cp8z8vLHUxNox+MW9MuYtm0sNXoyMy
         bqHFfJsYkqcfgCkg5RQOj0p6TD9nX4rjmahMnQJdT1WPBFPjCIBI5vL1/QoluEsfwB2y
         s7ejhz0ldATLHLOq141U+zdmMdaUc3g9XeRNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=rcvDP2WJ+fQZJ5qsY5Dl3GZhszdSslMkj/qO46b14mU=;
        b=VX65ZGjOuG77bRvgVMQKaGF0yayDp6R1oJfIKb8ByX6Mm/ZAvGxysalO3GB+rpzLrk
         M18RLaY9pXfoqRnWO/vzvoYmWPyavQmz3u1zF5RGsJWZbil+wRGCq8jPgfeEpuB/8gpK
         VpdrzAIaoDHgnyUaORRQe41/DP2TZRQXZ4v6OkXdZO0fcFt5/uWqBIjsPElTCtxCq9rZ
         TVtyZDcJSaobbAgRljQCF/MsR3uGNC7l5+djYZkLZQRuPPEnqkfhPsSWvEn09hOPvBSn
         Vc7sw9Tdo+OBsyrQjpsbsJswN5t5svEBk1pMQln88SSZq/TV/QMjrm2QZUy/R5f4WN9c
         sTAw==
X-Gm-Message-State: ACgBeo2YsjTULI3hV+aweJWLREx0J905ngJaZ4CmRqx2sq8vTFpfj8wI
        UVQWG6yvhJ59xuy3Om66HbadYICdlxcgPRka
X-Google-Smtp-Source: AA6agR7RCrayZe6uYU6txqlWKyIA7Yzw/43TVXUadSMJuymKB6iwV3TNib0B3yWzAVCT8sb/tC8agQ==
X-Received: by 2002:a05:6638:1492:b0:35a:5484:b8db with SMTP id j18-20020a056638149200b0035a5484b8dbmr5460661jak.236.1663199901611;
        Wed, 14 Sep 2022 16:58:21 -0700 (PDT)
Received: from rrangel920.bld.corp.google.com (h24-56-189-219.arvdco.broadband.dynamic.tds.net. [24.56.189.219])
        by smtp.gmail.com with ESMTPSA id a14-20020a027a0e000000b0034c0e8829c0sm353721jac.0.2022.09.14.16.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 16:58:20 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-acpi@vger.kernel.org, linux-input@vger.kernel.org
Cc:     jingle.wu@emc.com.tw, rafael@kernel.org,
        andriy.shevchenko@linux.intel.com, mario.limonciello@amd.com,
        hdegoede@redhat.com, linus.walleij@linaro.org, timvp@google.com,
        dmitry.torokhov@gmail.com, Raul E Rangel <rrangel@chromium.org>,
        Alistair Francis <alistair@alistair23.me>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 09/13] HID: i2c-hid: acpi: Stop setting wakeup_capable
Date:   Wed, 14 Sep 2022 17:57:57 -0600
Message-Id: <20220914155914.v3.9.I2efb7f551e0aa2dc4c53b5fd5bbea91a1cdd9b32@changeid>
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
In-Reply-To: <20220914235801.1731478-1-rrangel@chromium.org>
References: <20220914235801.1731478-1-rrangel@chromium.org>
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

