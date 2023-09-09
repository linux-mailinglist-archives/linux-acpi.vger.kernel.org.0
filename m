Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C62D579998F
	for <lists+linux-acpi@lfdr.de>; Sat,  9 Sep 2023 18:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbjIIQZV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 9 Sep 2023 12:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346348AbjIIOT2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 9 Sep 2023 10:19:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B26CF2
        for <linux-acpi@vger.kernel.org>; Sat,  9 Sep 2023 07:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694269111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uhKLN8srrjXbTAcvVQEFoGKbRCm1ME9oMKYTdW32b3E=;
        b=Iy0rQbSE6Ri3CrBV3Sofhjkphe8DiikRrBsD88ht6Rv7110c5L/S/03pXu+dDRWMTbEMsZ
        SY7G9dPFClaRrQGZWhckjUC8baAvpn1coFyl4rcQ289MxZ4hFKzzpyZuY7XYVSfdCtWGYl
        O3WhJ9L6n4CKWzX/GR/T759CHKL+gtk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-496-9lTgI2Y_Mraxbg-ctgLkhQ-1; Sat, 09 Sep 2023 10:18:27 -0400
X-MC-Unique: 9lTgI2Y_Mraxbg-ctgLkhQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3A5F829AA2C2;
        Sat,  9 Sep 2023 14:18:27 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.37])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 21E0814171B6;
        Sat,  9 Sep 2023 14:18:26 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH 3/8] platform/x86: x86-android-tablets: Remove invalid_aei_gpiochip from Peaq C1010
Date:   Sat,  9 Sep 2023 16:18:11 +0200
Message-ID: <20230909141816.58358-4-hdegoede@redhat.com>
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

Remove the invalid_aei_gpiochip setting from the x86_dev_info
for the Peaq C1010.

This is no longer necessary since there now is a quirk to ignore
the "dolby" button GPIO in gpiolib_acpi_quirks[] in
drivers/gpio/gpiolib-acpi.c .

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/x86-android-tablets/other.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/platform/x86/x86-android-tablets/other.c b/drivers/platform/x86/x86-android-tablets/other.c
index e79549c6aae1..621ca1e54d1f 100644
--- a/drivers/platform/x86/x86-android-tablets/other.c
+++ b/drivers/platform/x86/x86-android-tablets/other.c
@@ -505,11 +505,6 @@ static const struct x86_gpio_button peaq_c1010_button __initconst = {
 const struct x86_dev_info peaq_c1010_info __initconst = {
 	.gpio_button = &peaq_c1010_button,
 	.gpio_button_count = 1,
-	/*
-	 * Move the ACPI event handler used by the broken WMI interface out of
-	 * the way. This is the only event handler on INT33FC:00.
-	 */
-	.invalid_aei_gpiochip = "INT33FC:00",
 };
 
 /*
-- 
2.41.0

