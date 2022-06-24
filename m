Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA76559884
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Jun 2022 13:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiFXLYK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 24 Jun 2022 07:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbiFXLYH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Jun 2022 07:24:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 927F57A6F3
        for <linux-acpi@vger.kernel.org>; Fri, 24 Jun 2022 04:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656069845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7RSyoX5JF+fiCC6pwzkKD/3FMsAKUa5ol13lBYRFfEw=;
        b=JiGU3GeuUws00Yo50wS1BiUgWSv4M9ghh8NbuisUFZv0kC3Ih/yxGzZVnyGuBHboq2Q4L+
        9J/yc2NkLMOGvttR5xfVUcahRvHNXSuv7+MWnGBYWRyMZPjXRkgAjflKz3PfILShJuSnIj
        9CNmCf95NUjXqrPsM8qVCJeimathcVw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-632-rGdbMChIMEKb5wBRSiQG_g-1; Fri, 24 Jun 2022 07:24:01 -0400
X-MC-Unique: rGdbMChIMEKb5wBRSiQG_g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DD291801E67;
        Fri, 24 Jun 2022 11:24:00 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.193.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 80187492C3B;
        Fri, 24 Jun 2022 11:23:59 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org,
        Stefan Seyfried <stefan.seyfried@googlemail.com>,
        Kenneth Chan <kenneth.t.chan@gmail.com>,
        platform-driver-x86@vger.kernel.org,
        Stefan Seyfried <seife+kernel@b1-systems.com>
Subject: [PATCH 7/7] platform/x86: panasonic-laptop: Use acpi_video_get_backlight_type()
Date:   Fri, 24 Jun 2022 13:23:40 +0200
Message-Id: <20220624112340.10130-8-hdegoede@redhat.com>
In-Reply-To: <20220624112340.10130-1-hdegoede@redhat.com>
References: <20220624112340.10130-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Use acpi_video_get_backlight_type() to determine if we should register
the panasonic specific backlight interface. To avoid registering this
on systems where the ACPI or GPU native backlight control methods
should be used instead.

Tested-by: Stefan Seyfried <seife+kernel@b1-systems.com>
Tested-by: Kenneth Chan <kenneth.t.chan@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/panasonic-laptop.c | 28 ++++++++++++++-----------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/platform/x86/panasonic-laptop.c b/drivers/platform/x86/panasonic-laptop.c
index 615e39cbbbf1..d9a095d2c0eb 100644
--- a/drivers/platform/x86/panasonic-laptop.c
+++ b/drivers/platform/x86/panasonic-laptop.c
@@ -998,19 +998,23 @@ static int acpi_pcc_hotkey_add(struct acpi_device *device)
 		pr_err("Couldn't retrieve BIOS data\n");
 		goto out_input;
 	}
-	/* initialize backlight */
-	memset(&props, 0, sizeof(struct backlight_properties));
-	props.type = BACKLIGHT_PLATFORM;
-	props.max_brightness = pcc->sinf[SINF_AC_MAX_BRIGHT];
-	pcc->backlight = backlight_device_register("panasonic", NULL, pcc,
-						   &pcc_backlight_ops, &props);
-	if (IS_ERR(pcc->backlight)) {
-		result = PTR_ERR(pcc->backlight);
-		goto out_input;
-	}
 
-	/* read the initial brightness setting from the hardware */
-	pcc->backlight->props.brightness = pcc->sinf[SINF_AC_CUR_BRIGHT];
+	if (acpi_video_get_backlight_type() == acpi_backlight_vendor) {
+		/* initialize backlight */
+		memset(&props, 0, sizeof(struct backlight_properties));
+		props.type = BACKLIGHT_PLATFORM;
+		props.max_brightness = pcc->sinf[SINF_AC_MAX_BRIGHT];
+
+		pcc->backlight = backlight_device_register("panasonic", NULL, pcc,
+							   &pcc_backlight_ops, &props);
+		if (IS_ERR(pcc->backlight)) {
+			result = PTR_ERR(pcc->backlight);
+			goto out_input;
+		}
+
+		/* read the initial brightness setting from the hardware */
+		pcc->backlight->props.brightness = pcc->sinf[SINF_AC_CUR_BRIGHT];
+	}
 
 	/* Reset initial sticky key mode since the hardware register state is not consistent */
 	acpi_pcc_write_sset(pcc, SINF_STICKY_KEY, 0);
-- 
2.36.0

