Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E2960A25D
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Oct 2022 13:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbiJXLmF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 24 Oct 2022 07:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbiJXLlp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Oct 2022 07:41:45 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25EE8A474
        for <linux-acpi@vger.kernel.org>; Mon, 24 Oct 2022 04:39:25 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 3-20020a17090a0f8300b00212d5cd4e5eso7020851pjz.4
        for <linux-acpi@vger.kernel.org>; Mon, 24 Oct 2022 04:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jiSdINSVFRYviECfxwDXkA1dnuYyyTGGZx7DJKOoYJs=;
        b=iGtXR8pxJeARtYM65YtWK/rMT1cGkHNCbn5om85YN4tLiOmmeq2/FBvx3pSpv/m1Sr
         Va9GHFdP0chf3eQTUSVDangVFZ/dqZDSfu19hibg9oS2kk/KlgfVT6JFeQ68GHunlhzC
         se1sWoi2z1fTcKdw8FOIcyCxwwKqRbZobTBVM7iGls36LCpZ3DZIX0Tfn7Kb0gOkShSW
         pNe8W3N4rMeldUr8oUAlIfVjHR6cNauEMm0EGdVKOdZI/PPmhyAtOJqcxE6jGzxL2wA6
         7MgNHiUTVhnxOnZse4TBGZUhOboi/UB4XI8imIbLRZSiYGhvYc8SoFkFpIFpQvLUOsh+
         Hp+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jiSdINSVFRYviECfxwDXkA1dnuYyyTGGZx7DJKOoYJs=;
        b=rB5tc5RXIFuLPQxJDCabhZZzHIkYvX4/KoqV0RRJrY5jE1rXqZv2XYSJOcSwrdxkKV
         LlfeEq+ZCofteKnWr8bbAW/Qy3j/Qt9dWvoLZzvglMGoRaHRYE1/SCbv2+DOvQmHFwEl
         BmYSpLEXdKoHitN3q0CvDQH+JXhEPi8H5FoiJ/eLSyRb46qkPrSeY0EH3gSid6xtSrtp
         oZRP6s7aeV+wiwWAOqIOih5MT6ErxM99RUSqr2hlIyhr2qlyLzIFAoC5ZsmHfBS8t8IJ
         DOiugggtbMcoOkdXsV3ogKhJiuZVZUrau8Vjf9cjBpW70kyujn3EBeEPPhavrUozWnqb
         dzfA==
X-Gm-Message-State: ACrzQf20Kuh2s2lyAD+NmBQZ864DnWnpPIinIVZy7JjPE2Gtn8mLAsoQ
        WZHHfKQ7Lq4SDeULoDtnnl1Bw/hE/BEcoSMM
X-Google-Smtp-Source: AMsMyM7XYF0/Ljt4MGKz/TruSqF/tNgb9whiXQXnKj0J8NH8HwiMDdKOolztUet8v/T3k84ugzg6BQ==
X-Received: by 2002:a17:902:7297:b0:17f:93b5:5ecc with SMTP id d23-20020a170902729700b0017f93b55eccmr32624764pll.93.1666611467259;
        Mon, 24 Oct 2022 04:37:47 -0700 (PDT)
Received: from fedora.flets-east.jp ([2400:4050:c360:8200:8ae8:3c4:c0da:7419])
        by smtp.gmail.com with ESMTPSA id b8-20020a170903228800b001830ed575c3sm19475075plh.117.2022.10.24.04.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 04:37:46 -0700 (PDT)
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
Subject: [PATCH 15/22] platform/x86: samsung-laptop: Use acpi_video_get_backlight_types()
Date:   Mon, 24 Oct 2022 20:35:06 +0900
Message-Id: <20221024113513.5205-16-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221024113513.5205-1-akihiko.odaki@daynix.com>
References: <20221024113513.5205-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

acpi_video_get_backlight_type() is now deprecated.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 drivers/platform/x86/samsung-laptop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/samsung-laptop.c b/drivers/platform/x86/samsung-laptop.c
index b4aa8ba35d2d..8ba377df73e8 100644
--- a/drivers/platform/x86/samsung-laptop.c
+++ b/drivers/platform/x86/samsung-laptop.c
@@ -1574,7 +1574,7 @@ static int __init samsung_init(void)
 	samsung->handle_backlight = true;
 	samsung->quirks = quirks;
 
-	if (acpi_video_get_backlight_type() != acpi_backlight_vendor)
+	if (!(acpi_video_get_backlight_types() & ACPI_BACKLIGHT_VENDOR))
 		samsung->handle_backlight = false;
 
 	ret = samsung_platform_init(samsung);
-- 
2.37.3

