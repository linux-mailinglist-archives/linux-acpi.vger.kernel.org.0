Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA4DC5B6377
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Sep 2022 00:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbiILWPZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 12 Sep 2022 18:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbiILWOW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 12 Sep 2022 18:14:22 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49BAE4E850
        for <linux-acpi@vger.kernel.org>; Mon, 12 Sep 2022 15:14:00 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id c4so8164675iof.3
        for <linux-acpi@vger.kernel.org>; Mon, 12 Sep 2022 15:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=QR2B9XFP7hD0eI+LTrzBg0C3/y+mm4K/iJoQKs9pnMo=;
        b=Fk6ctCFzMECh1bY3XWsqkS3WXaKaOph6+Oc5x/qYlRnVrgHZy4y/LeVm4E1Hd/ZYcA
         2EQYrTbljtNkWKW4+YTHqfR9GNifArz/K7DjWIZtD7dli+ywJjilvGbl1+9sqAv1P82Q
         eOHZjt7HFn7wPNJLOPzFKu47XSI3OsZQqT2QI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=QR2B9XFP7hD0eI+LTrzBg0C3/y+mm4K/iJoQKs9pnMo=;
        b=jLzZIfRdM+iIzrHsGhheBDc9hRC2f6sfrzeSQJ0ycECsCCABkELJ46T3pi9k+M5C8o
         mp0c90/lZeUuOSiYaBFxrcn5OBynA/dtdf11J9up4phN0wcbpgcBd+nPsM+ml6/RjKYd
         VM9doTFZdjeeIkgCRVxZmiqt3irPFJzfUPFE99vVbFmHDTWZC6S87m5BJc+AhR0ESSni
         Gg9M9TopXNQNlR0ekEslktN3/UJKSpiJ7EdkyoydfHFcIP/lfDFbXLrdM6c1vokSG6Hc
         PX2QnwfawmjZf1xAEIDc22uayhwfRPQ9/L/eDmKr2Emef7R0416DA567uBPECf3HVmOk
         8Qpw==
X-Gm-Message-State: ACgBeo2H+fGI9SRqVJmPVh1hJ1w8UoYck10bdPxuwOaLWAM/ntIZyB44
        K4BqMNuYARXW7tCyBzvsqNDR909c9aS2JuB9
X-Google-Smtp-Source: AA6agR5siZavkQ3Y+x9ZBdSihGgx0LG2wkfUKmKWO1QvkMQnu9M8KGMknizwsPMY/ICY79eLUTSM7Q==
X-Received: by 2002:a05:6602:2cca:b0:657:c59b:f336 with SMTP id j10-20020a0566022cca00b00657c59bf336mr12970833iow.141.1663020839497;
        Mon, 12 Sep 2022 15:13:59 -0700 (PDT)
Received: from rrangel920.bld.corp.google.com (h24-56-189-219.arvdco.broadband.dynamic.tds.net. [24.56.189.219])
        by smtp.gmail.com with ESMTPSA id 18-20020a056e020cb200b002f16e7021f6sm4077334ilg.22.2022.09.12.15.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 15:13:58 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-acpi@vger.kernel.org, linux-input@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com, jingle.wu@emc.com.tw,
        mario.limonciello@amd.com, timvp@google.com,
        linus.walleij@linaro.org, hdegoede@redhat.com, rafael@kernel.org,
        Raul E Rangel <rrangel@chromium.org>,
        Alistair Francis <alistair@alistair23.me>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/13] HID: i2c-hid: acpi: Stop setting wakeup_capable
Date:   Mon, 12 Sep 2022 16:13:13 -0600
Message-Id: <20220912160931.v2.9.I2efb7f551e0aa2dc4c53b5fd5bbea91a1cdd9b32@changeid>
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
2.37.2.789.g6183377224-goog

