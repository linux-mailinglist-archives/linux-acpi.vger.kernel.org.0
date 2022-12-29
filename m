Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A36E658F38
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Dec 2022 17:46:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233258AbiL2QqW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 29 Dec 2022 11:46:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233585AbiL2Qp5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 29 Dec 2022 11:45:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0C615FE8
        for <linux-acpi@vger.kernel.org>; Thu, 29 Dec 2022 08:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672332306;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=uE1P5Bdwlwa4H9qvumuO6cO/f01N5gt3QNmApvjrJ90=;
        b=LrXXUSysTvsOtDxBhM3j1CSAvnff5xuP4+lZVmUKE19qD2onCvjbamkis41RcE8+eCM2xK
        6ET4Vp76TTJUZ2lhEyeTZQ19CwaGZbpqYUOMF9xcZOJqtrQv8KTMgw2fIH2txrT0c34tlf
        do64fD/5qwV1q3IsGIb10QLYef6KPF8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-612-5iRBfx7aM--DWanDil9SkA-1; Thu, 29 Dec 2022 11:45:04 -0500
X-MC-Unique: 5iRBfx7aM--DWanDil9SkA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0E9C4185A794;
        Thu, 29 Dec 2022 16:45:04 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7FEAE4010D42;
        Thu, 29 Dec 2022 16:45:02 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        "regressions @ lists . linux . dev" <regressions@lists.linux.dev>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH 6.2 regression fix] gpiolib: Fix using uninitialized lookup-flags on ACPI platforms
Date:   Thu, 29 Dec 2022 17:45:01 +0100
Message-Id: <20221229164501.76044-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Commit 8eb1f71e7acc ("gpiolib: consolidate GPIO lookups") refactors
fwnode_get_named_gpiod() and gpiod_get_index() into a unified
gpiod_find_and_request() helper.

The old functions both initialized their local lookupflags variable to
GPIO_LOOKUP_FLAGS_DEFAULT, but the new code leaves it uninitialized.

This is a problem for at least ACPI platforms, where acpi_find_gpio()
only does a bunch of *lookupflags |= GPIO_* statements and thus relies
on the variable being initialized.

The variable not being initialized leads to:

1. Potentially the wrong flags getting used
2. The check for conflicting lookup flags in gpiod_configure_flags():
   "multiple pull-up, pull-down or pull-disable enabled, invalid config"
   sometimes triggering, making the GPIO unavailable

Restore the initialization of lookupflags to GPIO_LOOKUP_FLAGS_DEFAULT
to fix this.

Fixes: 8eb1f71e7acc ("gpiolib: consolidate GPIO lookups")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Note I'm not working and not reading work email until Monday January 9th.
I hit this while doing some hobby stuff and I decided to send this out
right away to avoid others potentially wasting time debugging this, but
I will not see any replies until Monday January 9th.
---
 drivers/gpio/gpiolib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 5a66d9616d7c..939c776b9488 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -3905,8 +3905,8 @@ static struct gpio_desc *gpiod_find_and_request(struct device *consumer,
 						const char *label,
 						bool platform_lookup_allowed)
 {
+	unsigned long lookupflags = GPIO_LOOKUP_FLAGS_DEFAULT;
 	struct gpio_desc *desc = ERR_PTR(-ENOENT);
-	unsigned long lookupflags;
 	int ret;
 
 	if (!IS_ERR_OR_NULL(fwnode))
-- 
2.38.1

