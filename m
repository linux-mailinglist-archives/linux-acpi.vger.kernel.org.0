Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 083F2799992
	for <lists+linux-acpi@lfdr.de>; Sat,  9 Sep 2023 18:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbjIIQZU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 9 Sep 2023 12:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346379AbjIIOUN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 9 Sep 2023 10:20:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E63E44
        for <linux-acpi@vger.kernel.org>; Sat,  9 Sep 2023 07:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694269114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CdsDqz0zPOy7jhgwrTpUp+gZgwT9fxcigX67K+/zeIs=;
        b=DTDxvr2Tas5fzdnNVgAeOSXMtRr+JU1TkrVxqwuEMTDmBYV2vQxENwRWG2q9MtgoJdlkUB
        WTWcOVnKfwTgkgYuTxQTOyr5mp8V4DOtxStMIWgVYGtDvzVgNxAUW6jRC42uzxiQ9gz8yy
        c7hPL+4b0FvvTITeahEDAWh0hVCGTUo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-655-R4Sy07_2OC6hoH4Ca72KFQ-1; Sat, 09 Sep 2023 10:18:33 -0400
X-MC-Unique: R4Sy07_2OC6hoH4Ca72KFQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7C1F2380671E;
        Sat,  9 Sep 2023 14:18:32 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.37])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 632A614171B6;
        Sat,  9 Sep 2023 14:18:31 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH 7/8] platform/x86: x86-android-tablets: Use platform-device as gpio-keys parent
Date:   Sat,  9 Sep 2023 16:18:15 +0200
Message-ID: <20230909141816.58358-8-hdegoede@redhat.com>
In-Reply-To: <20230909141816.58358-1-hdegoede@redhat.com>
References: <20230909141816.58358-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Use the new x86-android-tablets platform-device as gpio-keys parent
to make it clear that this gpio-keys device was instantiated by
the x86-android-tablets driver.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/x86-android-tablets/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/x86-android-tablets/core.c b/drivers/platform/x86/x86-android-tablets/core.c
index 673f3a14941b..b72bb0376fe5 100644
--- a/drivers/platform/x86/x86-android-tablets/core.c
+++ b/drivers/platform/x86/x86-android-tablets/core.c
@@ -378,7 +378,7 @@ static __init int x86_android_tablet_probe(struct platform_device *pdev)
 		pdata.buttons = buttons;
 		pdata.nbuttons = dev_info->gpio_button_count;
 
-		pdevs[pdev_count] = platform_device_register_data(NULL, "gpio-keys",
+		pdevs[pdev_count] = platform_device_register_data(&pdev->dev, "gpio-keys",
 								  PLATFORM_DEVID_AUTO,
 								  &pdata, sizeof(pdata));
 		if (IS_ERR(pdevs[pdev_count])) {
-- 
2.41.0

