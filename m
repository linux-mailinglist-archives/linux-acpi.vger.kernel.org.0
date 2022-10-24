Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09BCF60A23D
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Oct 2022 13:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbiJXLjw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 24 Oct 2022 07:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbiJXLjJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Oct 2022 07:39:09 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E51C6E2E7
        for <linux-acpi@vger.kernel.org>; Mon, 24 Oct 2022 04:38:29 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id s22-20020a17090a075600b002130d2ad62aso2040058pje.2
        for <linux-acpi@vger.kernel.org>; Mon, 24 Oct 2022 04:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zZ4fJ8ClD76WOV59defp1HNsujn8j/wysmVCUMoMFP0=;
        b=UR+PH3NVHkn0NXOqzrKguYWXOraM6vc+YMLhwexhonJG8F77DnrNQYz/9Oi32n6IZY
         hZlL47vjA7//LH91lqAnjQLn97I5Vo+uQOT2Mmd2Dn63q/EMVrrHlQ7z/zyp6JLWsxqs
         lxvzOwrP2RQb+dCGiNci0WZm/2NZcPqe1IwnSjthC31l/f7IFTIDv5x71IwBvf93+VC0
         KH/KMjo1itzSNE11bqoR8Syfpkg0shlSYQXBydHoh4+awRZYdMObrO029QbuDisy7sll
         ElVT/CB4tnxnE4FbCm2I0ONWyIQVGy4aFDiuXCQlrYYt0qq7o8pOl51CC0lnDxCtkS9Y
         1uNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zZ4fJ8ClD76WOV59defp1HNsujn8j/wysmVCUMoMFP0=;
        b=lc28rbDDBI8pdWLKOnp0ujyPD1J+Af+1q3A3Y8fSsfvl+DtVZIWNEeCFHnLF1gL0Fn
         WjVrSKNB8hHyV/pLSQkb6lRTpRMxqUxT3c0kzIRFMG9Pv8R4JObgCt2xRDg71ZnmqaRY
         dmNBHeWkl7j3QgJI1l5hCpuai0zvs6ikdv3uC4t2/4nxbBr0bWMx+mdvP9cvaIHEgREW
         tVVCn/CnPeiFkGft/q6mnKbl6WKAsHMnpjQgZ0Sga5EId4KOn7zEQCUjA+iuPEgf+qEG
         neXb7mhvc2TsZR9WJOUz9TA0/pC7B+SiV8ysd+LAVoAlC8veL7EYM65nxq9ZmjoXc/1J
         omIg==
X-Gm-Message-State: ACrzQf23Oh6wXDAbf3FwJPci/dgZlk5pCJlXJWQf+d4YWM3QhpzIwiKi
        9+93wQAxhPiFyZI2sWhr6pNEew==
X-Google-Smtp-Source: AMsMyM4YfAwJenYaMcKn2Z30J0g5OpRvkV9SVYpt/sZWnDEmVOCLuqCwHN7ebOLB73LDTWz/IU7ezA==
X-Received: by 2002:a17:90b:2317:b0:213:26a3:246f with SMTP id mt23-20020a17090b231700b0021326a3246fmr1763172pjb.148.1666611450483;
        Mon, 24 Oct 2022 04:37:30 -0700 (PDT)
Received: from fedora.flets-east.jp ([2400:4050:c360:8200:8ae8:3c4:c0da:7419])
        by smtp.gmail.com with ESMTPSA id b8-20020a170903228800b001830ed575c3sm19475075plh.117.2022.10.24.04.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 04:37:29 -0700 (PDT)
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
Subject: [PATCH 13/22] platform/x86: nvidia-wmi-ec-backlight: Use acpi_video_get_backlight_types()
Date:   Mon, 24 Oct 2022 20:35:04 +0900
Message-Id: <20221024113513.5205-14-akihiko.odaki@daynix.com>
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
 drivers/platform/x86/nvidia-wmi-ec-backlight.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/nvidia-wmi-ec-backlight.c b/drivers/platform/x86/nvidia-wmi-ec-backlight.c
index baccdf658538..a42e3914c73d 100644
--- a/drivers/platform/x86/nvidia-wmi-ec-backlight.c
+++ b/drivers/platform/x86/nvidia-wmi-ec-backlight.c
@@ -91,7 +91,7 @@ static int nvidia_wmi_ec_backlight_probe(struct wmi_device *wdev, const void *ct
 	int ret;
 
 	/* drivers/acpi/video_detect.c also checks that SOURCE == EC */
-	if (acpi_video_get_backlight_type() != acpi_backlight_nvidia_wmi_ec)
+	if (!(acpi_video_get_backlight_types() & ACPI_BACKLIGHT_NVIDIA_WMI_EC))
 		return -ENODEV;
 
 	/*
-- 
2.37.3

