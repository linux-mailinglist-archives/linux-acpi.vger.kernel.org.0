Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92CBB5A1463
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Aug 2022 16:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239695AbiHYOlG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 25 Aug 2022 10:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242580AbiHYOkN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Aug 2022 10:40:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505A4B8F10
        for <linux-acpi@vger.kernel.org>; Thu, 25 Aug 2022 07:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661438333;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NeOiUam8i0iMUrZ+eJUZuSLppU1C5I8c24I/CR/8HBU=;
        b=gWJyzT4nLuadT8959z+iLrDNDAW5nyQ0Gzulb4yB2G8AGLHioX4SzeUap5kvPw4EhwobC3
        XUEMhtxM3D7W99wTNGr/oPUswYHaH3LD+7JK+sp24aaACxFWABkWW4mTPKLG7vGJ9PgXiI
        P3aTzcnsiWKL2oxtu6LSpQ4EQ5IXvSI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-668-LFt7gDFBNlSK4kH4dQMBkA-1; Thu, 25 Aug 2022 10:38:49 -0400
X-MC-Unique: LFt7gDFBNlSK4kH4dQMBkA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4F3E91C004F0;
        Thu, 25 Aug 2022 14:38:48 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.193.46])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 93EAA2166B26;
        Thu, 25 Aug 2022 14:38:44 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Ben Skeggs <bskeggs@redhat.com>, Karol Herbst <kherbst@redhat.com>,
        Lyude <lyude@redhat.com>, Daniel Dadap <ddadap@nvidia.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Pan@vger.kernel.org, Xinhui <Xinhui.Pan@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, nouveau@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@redhat.com>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v5 19/31] platform/x86: nvidia-wmi-ec-backlight: Use acpi_video_get_backlight_type()
Date:   Thu, 25 Aug 2022 16:37:14 +0200
Message-Id: <20220825143726.269890-20-hdegoede@redhat.com>
In-Reply-To: <20220825143726.269890-1-hdegoede@redhat.com>
References: <20220825143726.269890-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add an acpi_video_get_backlight_type() == acpi_backlight_nvidia_wmi_ec
check. This will make nvidia-wmi-ec-backlight properly honor the user
selecting a different backlight driver through the acpi_backlight=...
kernel commandline option.

Since the auto-detect code check for nvidia-wmi-ec-backlight in
drivers/acpi/video_detect.c already checks that the WMI advertised
brightness-source is the embedded controller, this new check makes it
unnecessary for nvidia_wmi_ec_backlight_probe() to check this itself.

Suggested-by: Daniel Dadap <ddadap@nvidia.com>
Reviewed-by: Daniel Dadap <ddadap@nvidia.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/Kconfig                   |  1 +
 drivers/platform/x86/nvidia-wmi-ec-backlight.c | 14 +++-----------
 2 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index f2f98e942cf2..0cc5ac35fc57 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -93,6 +93,7 @@ config PEAQ_WMI
 
 config NVIDIA_WMI_EC_BACKLIGHT
 	tristate "EC Backlight Driver for Hybrid Graphics Notebook Systems"
+	depends on ACPI_VIDEO
 	depends on ACPI_WMI
 	depends on BACKLIGHT_CLASS_DEVICE
 	help
diff --git a/drivers/platform/x86/nvidia-wmi-ec-backlight.c b/drivers/platform/x86/nvidia-wmi-ec-backlight.c
index be803e47eac0..baccdf658538 100644
--- a/drivers/platform/x86/nvidia-wmi-ec-backlight.c
+++ b/drivers/platform/x86/nvidia-wmi-ec-backlight.c
@@ -10,6 +10,7 @@
 #include <linux/platform_data/x86/nvidia-wmi-ec-backlight.h>
 #include <linux/types.h>
 #include <linux/wmi.h>
+#include <acpi/video.h>
 
 /**
  * wmi_brightness_notify() - helper function for calling WMI-wrapped ACPI method
@@ -87,19 +88,10 @@ static int nvidia_wmi_ec_backlight_probe(struct wmi_device *wdev, const void *ct
 {
 	struct backlight_properties props = {};
 	struct backlight_device *bdev;
-	u32 source;
 	int ret;
 
-	ret = wmi_brightness_notify(wdev, WMI_BRIGHTNESS_METHOD_SOURCE,
-	                           WMI_BRIGHTNESS_MODE_GET, &source);
-	if (ret)
-		return ret;
-
-	/*
-	 * This driver is only to be used when brightness control is handled
-	 * by the EC; otherwise, the GPU driver(s) should control brightness.
-	 */
-	if (source != WMI_BRIGHTNESS_SOURCE_EC)
+	/* drivers/acpi/video_detect.c also checks that SOURCE == EC */
+	if (acpi_video_get_backlight_type() != acpi_backlight_nvidia_wmi_ec)
 		return -ENODEV;
 
 	/*
-- 
2.37.2

