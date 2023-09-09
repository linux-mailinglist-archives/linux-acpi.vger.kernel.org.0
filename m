Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F64A799980
	for <lists+linux-acpi@lfdr.de>; Sat,  9 Sep 2023 18:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjIIQZQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 9 Sep 2023 12:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346347AbjIIOT2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 9 Sep 2023 10:19:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672E3CF4
        for <linux-acpi@vger.kernel.org>; Sat,  9 Sep 2023 07:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694269111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HzqZJtWejVodVTPKo9Ws7yQdF9+fdIi5BOKy7A68lHY=;
        b=ESOeIR0E79VTkxCw2aXoW+3lxnkE8Sv+L2cmDmZbV2NsYOJZSe3hPlCb/A2O2TfMVURDT1
        DAE1X+qYgmHC0NYfvJE06QzKWkXRYNUowrD/RToF9PjRK0QQsbxNleFncUlSFc7tjnpWYr
        6pv6eDBzBfzeDyM5mrE8v2jv1bUpZhk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-202-xSrNr5BuPkOcRXu1YLRzRA-1; Sat, 09 Sep 2023 10:18:25 -0400
X-MC-Unique: xSrNr5BuPkOcRXu1YLRzRA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 99DBC8ABBC9;
        Sat,  9 Sep 2023 14:18:24 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.37])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8069414171B6;
        Sat,  9 Sep 2023 14:18:23 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH 1/8] gpiolib: acpi: Check if a GPIO is listed in ignore_interrupt earlier
Date:   Sat,  9 Sep 2023 16:18:09 +0200
Message-ID: <20230909141816.58358-2-hdegoede@redhat.com>
In-Reply-To: <20230909141816.58358-1-hdegoede@redhat.com>
References: <20230909141816.58358-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

In some cases where a broken AEI is present for a GPIO and the GPIO
is listed in the ignore_interrupt list to avoid the broken event
handler, the kernel may want to use the GPIO for another purpose.

Before this change trying to use such a GPIO for another purpose would
fail, because the ignore_interrupt list was only checked after
the acpi_request_own_gpiod() call, causing the GPIO to already be
claimed even though it is listed in the ignore_interrupt list.

Fix this by moving the ignore_interrupt list to above
the acpi_request_own_gpiod() call.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/gpio/gpiolib-acpi.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 97496c0f9133..80b9650a2424 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -437,6 +437,11 @@ static acpi_status acpi_gpiochip_alloc_event(struct acpi_resource *ares,
 	if (!handler)
 		return AE_OK;
 
+	if (acpi_gpio_in_ignore_list(ignore_interrupt, dev_name(chip->parent), pin)) {
+		dev_info(chip->parent, "Ignoring interrupt on pin %u\n", pin);
+		return AE_OK;
+	}
+
 	desc = acpi_request_own_gpiod(chip, agpio, 0, "ACPI:Event");
 	if (IS_ERR(desc)) {
 		dev_err(chip->parent,
@@ -461,11 +466,6 @@ static acpi_status acpi_gpiochip_alloc_event(struct acpi_resource *ares,
 		goto fail_unlock_irq;
 	}
 
-	if (acpi_gpio_in_ignore_list(ignore_interrupt, dev_name(chip->parent), pin)) {
-		dev_info(chip->parent, "Ignoring interrupt on pin %u\n", pin);
-		return AE_OK;
-	}
-
 	event = kzalloc(sizeof(*event), GFP_KERNEL);
 	if (!event)
 		goto fail_unlock_irq;
-- 
2.41.0

