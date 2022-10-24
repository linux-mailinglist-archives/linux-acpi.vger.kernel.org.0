Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C2D60A21F
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Oct 2022 13:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbiJXLj2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 24 Oct 2022 07:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbiJXLin (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Oct 2022 07:38:43 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B62F6C756
        for <linux-acpi@vger.kernel.org>; Mon, 24 Oct 2022 04:38:06 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id b11so1811372pjp.2
        for <linux-acpi@vger.kernel.org>; Mon, 24 Oct 2022 04:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YFFtfp5Yc7gM2NHS+gJ21jjQnawzT1tRkxQzo/jBQzs=;
        b=PgRxRL0VweaBpB4MPzFwmQEoLPmtBSUyoflWHPBA/i2qwPwwuqmuLCa/wFO3m2WOgm
         CG5asatEvhtKxzWCslE5iuXyE9qykeCF0sAXWDQWCpNnz1SKFD09I/9ECN3oqaq/n/qH
         8rI5q6sFwwrbf+qrqO6sphSgXh8gDNDUjMeXekyPZD3F/TNfhF9NLgFtp4S/EV7wFVYr
         HIvJzo/gYypH0KtX5FbvkZtyhStclUobYg5s5+qLL1fUloXqGfaHi5da3VFSy44yWKIj
         FIzxJZjW4aIDCrHCB+/3DHZ36YkLWnsHC5PSQR+boNXax+UF0elBwxF4lI1dewR5AYRU
         r3Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YFFtfp5Yc7gM2NHS+gJ21jjQnawzT1tRkxQzo/jBQzs=;
        b=jt56SpH6SdwqFsKTZzhm0saQB2cxRYV87ELRIambIwVOCzUVuL+FWMx4+D0pc8IL2X
         lebfFtqu2TTXDkIVG+9eATCUUdJP+a5h3zbGVSmkJg0tY/RAqfE26QvNzmEOx0ZN9+VN
         CsctoRLhkho9YtqEgcgk6ATpr3fBTfwj2edHHwrM50RCkaCQL83gZxltix9NCBUypI3n
         G09iC/4tu6usrmEhi+b5vCzSPyQBhEhHSUBVYJPgBsnzP2CrWPvXF/nvO7xOviqa+n7R
         iB0Zo1OdNgmvs9vFy9bjqDRvXGjy0byb1WwFNTTAR7/mh8rsi9x7It9GqEkDRnz+4ug1
         Aq1A==
X-Gm-Message-State: ACrzQf2N1+9JpwdMo1grRwKTLtnJSdNnB0ux5nIBqv3mEpDMus2JaWVp
        3dfSTPJkXvmYMSVxmgwG3gzjsg==
X-Google-Smtp-Source: AMsMyM4JFQloaFqr1HCGBSMPdlEtI9GhtTJPxV54Rk0x44r+FJsDYcm4mRiVB5esproJCpQDWLufkw==
X-Received: by 2002:a17:903:11c3:b0:178:aec1:189c with SMTP id q3-20020a17090311c300b00178aec1189cmr32705192plh.136.1666611425291;
        Mon, 24 Oct 2022 04:37:05 -0700 (PDT)
Received: from fedora.flets-east.jp ([2400:4050:c360:8200:8ae8:3c4:c0da:7419])
        by smtp.gmail.com with ESMTPSA id b8-20020a170903228800b001830ed575c3sm19475075plh.117.2022.10.24.04.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 04:37:04 -0700 (PDT)
From:   Akihiko Odaki <akihiko.odaki@daynix.com>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        "Lee, Chun-Yi" <jlee@suse.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Corentin Chary <corentin.chary@gmail.com>,
        Cezary Jackiewicz <cezary.jackiewicz@gmail.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Jonathan Woithe <jwoithe@just42.net>,
        Ike Panhc <ike.pan@canonical.com>,
        Daniel Dadap <ddadap@nvidia.com>,
        Kenneth Chan <kenneth.t.chan@gmail.com>,
        Mattia Dongili <malattia@linux.it>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Azael Avalos <coproscefalo@gmail.com>,
        Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Robert Moore <robert.moore@intel.com>,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        intel-gfx@lists.freedesktop.org,
        platform-driver-x86@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net,
        ibm-acpi-devel@lists.sourceforge.net, linux-fbdev@vger.kernel.org,
        devel@acpica.org, Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH 10/22] platform/x86: ideapad-laptop: Use acpi_video_get_backlight_types()
Date:   Mon, 24 Oct 2022 20:35:01 +0900
Message-Id: <20221024113513.5205-11-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221024113513.5205-1-akihiko.odaki@daynix.com>
References: <20221024113513.5205-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

acpi_video_get_backlight_type() is now deprecated.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 drivers/platform/x86/ideapad-laptop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index abd0c81d62c4..befd5dc24ed6 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -1633,7 +1633,7 @@ static int ideapad_acpi_add(struct platform_device *pdev)
 			dev_info(&pdev->dev, "DYTC interface is not available\n");
 	}
 
-	if (acpi_video_get_backlight_type() == acpi_backlight_vendor) {
+	if ((acpi_video_get_backlight_types() & ACPI_BACKLIGHT_VENDOR)) {
 		err = ideapad_backlight_init(priv);
 		if (err && err != -ENODEV)
 			goto backlight_failed;
-- 
2.37.3

