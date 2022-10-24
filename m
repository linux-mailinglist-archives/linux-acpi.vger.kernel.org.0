Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E24FF60A220
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Oct 2022 13:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbiJXLj2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 24 Oct 2022 07:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbiJXLi6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Oct 2022 07:38:58 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496216D872
        for <linux-acpi@vger.kernel.org>; Mon, 24 Oct 2022 04:38:14 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id e129so8438379pgc.9
        for <linux-acpi@vger.kernel.org>; Mon, 24 Oct 2022 04:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=28wDlqMofB1pExK+J7NJqLJ5sSPJ8IDYDWuGoZcg4WU=;
        b=zPrE3Z79yDGzLtfx2QawETgF1lUMugvN0C6qQ0CWIaiD5/kUtQIJww0VDJMrkYc3N9
         elYuVucHc32XKow2YGLm3Vr08Z5vsbFCWlv4vq7Nx1QXhYg0jtjzlw0H9CXWI7Ta2vol
         6FUMEN9tnwiBaSCwpYfKwo7U/Mq0MJA9eOTbkI8+uvO7eXR9gmEds/Sy3ur7LFminYR1
         NVY1BZW0FhIWVkiQMHh5J542GVxkeRWv1QNvckPM+a6g8eqefXzkOAt0+7UqdUmERKZa
         J+mLK9mmXa4DfceGk2cEkxou1QrTtBSQu+UKjsPm36wMjvQrtPcLMKbyQMEJWea/JWpP
         WvvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=28wDlqMofB1pExK+J7NJqLJ5sSPJ8IDYDWuGoZcg4WU=;
        b=FeT4dSBx3qaPx0DsfTnLllxpjtcFBUnaPDfTVRE4V57UfKg1bZPRUDnPRbqyrjowLi
         hb/nogWMICxIDPoTGsdy5oC0ALgg0Gvg/BG3FDfqh4wm7yhTL2Ftsldshc2GjGwBTHLv
         +XgrhkW9ydAYQBU5UZ+sJbxxje1GcxLTXw1vUlu1NODn/sWUuR4E6XsduxdO2ZseCtRW
         qr24dKp7m6h+Jj2a7RK8dyLw1i1b0ietuU/agBlL0IF3m2eXSFJTW/KdXxglQVVJM3ii
         2jUzBNvacBjDjRB3EESVOhv6RSWhjoI+P4kh6igyaQtxymPrMPagQmOFOhvlDgnVAt0V
         9rdw==
X-Gm-Message-State: ACrzQf3IEn3mFwthtsZ7IghbvvE3DYg77qR7a/bR8kGRnRpfKCAracZY
        dhAmun2q1AT2H/250ZVZN9O4Cg==
X-Google-Smtp-Source: AMsMyM6SfjrakTfflVuQ8PwvI36ClP4mxWtm2JBvE32zMW6Lo2xtR9eBT667zzx11rUWR7R7KloyFA==
X-Received: by 2002:a63:5702:0:b0:44b:290:f24f with SMTP id l2-20020a635702000000b0044b0290f24fmr27871108pgb.558.1666611399944;
        Mon, 24 Oct 2022 04:36:39 -0700 (PDT)
Received: from fedora.flets-east.jp ([2400:4050:c360:8200:8ae8:3c4:c0da:7419])
        by smtp.gmail.com with ESMTPSA id b8-20020a170903228800b001830ed575c3sm19475075plh.117.2022.10.24.04.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 04:36:39 -0700 (PDT)
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
Subject: [PATCH 07/22] platform/x86: compal-laptop: Use acpi_video_get_backlight_types()
Date:   Mon, 24 Oct 2022 20:34:58 +0900
Message-Id: <20221024113513.5205-8-akihiko.odaki@daynix.com>
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
 drivers/platform/x86/compal-laptop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/compal-laptop.c b/drivers/platform/x86/compal-laptop.c
index e10d2f64dfad..16ced03fa1b7 100644
--- a/drivers/platform/x86/compal-laptop.c
+++ b/drivers/platform/x86/compal-laptop.c
@@ -1043,7 +1043,7 @@ static int __init compal_init(void)
 		return -ENODEV;
 	}
 
-	if (acpi_video_get_backlight_type() == acpi_backlight_vendor) {
+	if ((acpi_video_get_backlight_types() & ACPI_BACKLIGHT_VENDOR)) {
 		struct backlight_properties props;
 		memset(&props, 0, sizeof(struct backlight_properties));
 		props.type = BACKLIGHT_PLATFORM;
-- 
2.37.3

