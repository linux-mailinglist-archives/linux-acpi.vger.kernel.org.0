Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D9379C254
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Sep 2023 04:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237228AbjILCIX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 11 Sep 2023 22:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240586AbjILCEA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 11 Sep 2023 22:04:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2335213E0E8
        for <linux-acpi@vger.kernel.org>; Mon, 11 Sep 2023 18:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694482483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=bAPz8m/VkDlfUDMl2zD484Yw31orYH7HidP19B5iZ2M=;
        b=EdK/cDqzlnafK+R8pX5kzkRkZXRVI2NLyK47Msxjb5Apm/Eaa/v4Aclrj9rd2fY4QYl1aS
        YfeO9ohvyT7lGGSfhN9AUV7p+BuqL+Jtf2gO5Ism0cniUy604m283kxjFhbyhykEiJtxjE
        eFTQxrsaYOqilcYAWUTAcn2lS2NqTWM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-398-aeZ12NPdNoKULG9PfZzQ3Q-1; Mon, 11 Sep 2023 17:09:39 -0400
X-MC-Unique: aeZ12NPdNoKULG9PfZzQ3Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E4C5780379F;
        Mon, 11 Sep 2023 21:09:37 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C8FA840C2064;
        Mon, 11 Sep 2023 21:09:36 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH] platform/x86: x86-android-tablets: Add a comment about x86_android_tablet_get_gpiod()
Date:   Mon, 11 Sep 2023 23:09:28 +0200
Message-ID: <20230911210928.264908-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add a comment explaining why the special x86_android_tablet_get_gpiod()
helper is necessary for some of the GPIOs used in the x86-android-tablets;
and that for normal GPIO lookups this example should not be followed.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/x86-android-tablets/core.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/platform/x86/x86-android-tablets/core.c b/drivers/platform/x86/x86-android-tablets/core.c
index 8a1f22aaac00..b55957bde034 100644
--- a/drivers/platform/x86/x86-android-tablets/core.c
+++ b/drivers/platform/x86/x86-android-tablets/core.c
@@ -24,6 +24,21 @@
 
 static struct platform_device *x86_android_tablet_device;
 
+/*
+ * This helper allows getting a gpio_desc *before* the actual device consuming
+ * the GPIO has been instantiated. This function _must_ only be used to handle
+ * this special case such as e.g. :
+ *
+ * 1. Getting an IRQ from a GPIO for i2c_board_info.irq which is passed to
+ * i2c_client_new() to instantiate i2c_client-s; or
+ * 2. Calling desc_to_gpio() to get an old style GPIO number for gpio_keys
+ * platform_data which still uses old style GPIO numbers.
+ *
+ * Since the consuming device has not been instatiated yet a dynamic lookup
+ * is generated using the special x86_android_tablet dev for dev_id.
+ *
+ * For normal GPIO lookups a standard static gpiod_lookup_table _must_ be used.
+ */
 int x86_android_tablet_get_gpiod(const char *chip, int pin, const char *con_id,
 				 bool active_low, enum gpiod_flags dflags,
 				 struct gpio_desc **desc)
-- 
2.41.0

