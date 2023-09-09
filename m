Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D5679998D
	for <lists+linux-acpi@lfdr.de>; Sat,  9 Sep 2023 18:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbjIIQZT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 9 Sep 2023 12:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346376AbjIIOUN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 9 Sep 2023 10:20:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1A8CCA
        for <linux-acpi@vger.kernel.org>; Sat,  9 Sep 2023 07:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694269119;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V9w02tjgg+rCW2IRt1y+039+nKLy7RT6uNR25PwjTMs=;
        b=I8/zP6LUtAMczXLfBV+sjgKEjCXkgzregJMbxD3eB65JAVnGG+Qc/LD73orI/hqSK1cN1o
        dtUcI+TiwqvGcG+p/LlEP+9p1fOEPyjWrobtjdPjmIl31nl3COS2pOVm5U6TEPQ/f8zZhH
        MkQY1LKb33+HngvqiCExqYgRyEBp/8Q=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-138-diEMnHx0OOSxA39h2iSYQw-1; Sat, 09 Sep 2023 10:18:34 -0400
X-MC-Unique: diEMnHx0OOSxA39h2iSYQw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C4D9A3803909;
        Sat,  9 Sep 2023 14:18:33 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.37])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AD4441460FE5;
        Sat,  9 Sep 2023 14:18:32 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH 8/8] platform/x86: x86-android-tablets: Drop "linux,power-supply-name" from lenovo_yt3_bq25892_0_props[]
Date:   Sat,  9 Sep 2023 16:18:16 +0200
Message-ID: <20230909141816.58358-9-hdegoede@redhat.com>
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

The "linux,power-supply-name" property is a left-over from an earlier
attempt to allow properties to specify the power_supply class-device name.

The patch to read this property never made it upstream (and is no longer
necessary). Drop the unused property.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/x86-android-tablets/lenovo.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/platform/x86/x86-android-tablets/lenovo.c b/drivers/platform/x86/x86-android-tablets/lenovo.c
index 35aa2968d726..5c803cdb5586 100644
--- a/drivers/platform/x86/x86-android-tablets/lenovo.c
+++ b/drivers/platform/x86/x86-android-tablets/lenovo.c
@@ -565,7 +565,6 @@ static const struct software_node fg_bq25890_1_supply_node = {
 /* bq25892 charger settings for the flat lipo battery behind the screen */
 static const struct property_entry lenovo_yt3_bq25892_0_props[] = {
 	PROPERTY_ENTRY_STRING_ARRAY("supplied-from", lenovo_yt3_bq25892_0_suppliers),
-	PROPERTY_ENTRY_STRING("linux,power-supply-name", "bq25892-second-chrg"),
 	PROPERTY_ENTRY_U32("linux,iinlim-percentage", 40),
 	PROPERTY_ENTRY_BOOL("linux,skip-reset"),
 	/* Values taken from Android Factory Image */
-- 
2.41.0

