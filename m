Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD42D79999B
	for <lists+linux-acpi@lfdr.de>; Sat,  9 Sep 2023 18:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbjIIQZY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 9 Sep 2023 12:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbjIIOUN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 9 Sep 2023 10:20:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07963E43
        for <linux-acpi@vger.kernel.org>; Sat,  9 Sep 2023 07:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694269114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H71Ul7/l9XDQeRiP1W3YTZ1vWpoRPOuryOrX9nxlvNU=;
        b=QFd4D3Ztvu43sLUc5Q0jxpgnkbR4P2eB6Ear0T/rNmr6MV/cVT0fu0pRv8RwM/gvSxj1xd
        1RXyHqI+h4VWdjkwhTQfIcijfScSAMUF0i3SDFiLKURIqtN1WFYNJ8B0aQX6CV026rw2QV
        p/5AzpWRFqYLu9S3ebRK5Ms1HmqwR1U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-549-RkePu_QCOxaay6fYA0ud4Q-1; Sat, 09 Sep 2023 10:18:29 -0400
X-MC-Unique: RkePu_QCOxaay6fYA0ud4Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 91DBD8631D8;
        Sat,  9 Sep 2023 14:18:28 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.37])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6C51514171B6;
        Sat,  9 Sep 2023 14:18:27 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH 4/8] platform/x86: x86-android-tablets: Remove invalid_aei_gpiochip support
Date:   Sat,  9 Sep 2023 16:18:12 +0200
Message-ID: <20230909141816.58358-5-hdegoede@redhat.com>
In-Reply-To: <20230909141816.58358-1-hdegoede@redhat.com>
References: <20230909141816.58358-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

x86_dev_info.invalid_aei_gpiochip is no longer used by any boards
and the x86-android-tablets code should not use the gpiolib private
acpi_gpiochip_free_interrupts() function.

Reported-by: Bartosz Golaszewski <brgl@bgdev.pl>
Closes: https://lore.kernel.org/platform-driver-x86/20230905185309.131295-12-brgl@bgdev.pl/
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/x86-android-tablets/core.c   | 15 ---------------
 .../x86/x86-android-tablets/x86-android-tablets.h |  1 -
 2 files changed, 16 deletions(-)

diff --git a/drivers/platform/x86/x86-android-tablets/core.c b/drivers/platform/x86/x86-android-tablets/core.c
index 2fd6060a31bb..ab8cf22ac5da 100644
--- a/drivers/platform/x86/x86-android-tablets/core.c
+++ b/drivers/platform/x86/x86-android-tablets/core.c
@@ -259,7 +259,6 @@ static __init int x86_android_tablet_init(void)
 {
 	const struct x86_dev_info *dev_info;
 	const struct dmi_system_id *id;
-	struct gpio_chip *chip;
 	int i, ret = 0;
 
 	id = dmi_first_match(x86_android_tablet_ids);
@@ -268,20 +267,6 @@ static __init int x86_android_tablet_init(void)
 
 	dev_info = id->driver_data;
 
-	/*
-	 * The broken DSDTs on these devices often also include broken
-	 * _AEI (ACPI Event Interrupt) handlers, disable these.
-	 */
-	if (dev_info->invalid_aei_gpiochip) {
-		chip = gpiochip_find(dev_info->invalid_aei_gpiochip,
-				     gpiochip_find_match_label);
-		if (!chip) {
-			pr_err("error cannot find GPIO chip %s\n", dev_info->invalid_aei_gpiochip);
-			return -ENODEV;
-		}
-		acpi_gpiochip_free_interrupts(chip);
-	}
-
 	/*
 	 * Since this runs from module_init() it cannot use -EPROBE_DEFER,
 	 * instead pre-load any modules which are listed as requirements.
diff --git a/drivers/platform/x86/x86-android-tablets/x86-android-tablets.h b/drivers/platform/x86/x86-android-tablets/x86-android-tablets.h
index e46e1128acc8..bf97fb84c0d4 100644
--- a/drivers/platform/x86/x86-android-tablets/x86-android-tablets.h
+++ b/drivers/platform/x86/x86-android-tablets/x86-android-tablets.h
@@ -66,7 +66,6 @@ struct x86_gpio_button {
 };
 
 struct x86_dev_info {
-	char *invalid_aei_gpiochip;
 	const char * const *modules;
 	const struct software_node *bat_swnode;
 	struct gpiod_lookup_table * const *gpiod_lookup_tables;
-- 
2.41.0

