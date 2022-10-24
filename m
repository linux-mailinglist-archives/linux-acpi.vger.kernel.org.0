Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E01560A206
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Oct 2022 13:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbiJXLiY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 24 Oct 2022 07:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbiJXLhp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Oct 2022 07:37:45 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C624813CDB
        for <linux-acpi@vger.kernel.org>; Mon, 24 Oct 2022 04:37:32 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id e4so4797032pfl.2
        for <linux-acpi@vger.kernel.org>; Mon, 24 Oct 2022 04:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nh284RfbKTKjVZ53xc/BjYmJT2KbUvj6smXua/Y15lg=;
        b=wKxhR+PYREmRgVKkasTw0GfLrz2v/WYReVJQ30eu6x7i4eVQgdnhuAzGFkfXj43osX
         iAXkQ9aOTTvoovjS5IAKs+vGwyfg/3OtbGuKU/dCjSKPeCgfec8HUoDEQ74hMGKLlidw
         xopGpztVbn+H0pgQsRhyf7RQzg47xJ12vGdWkiLpV1wmLs/HSBYTp0CLCI3VpboZfYoK
         OVdGvVz64lio5FjIFDglJN+RSxy4l6GjXQ4rIatNLGAan07rIxYhnoljN8p8kyn4jRRy
         crr47iBoKn1Bk8Y506uKaUb06iRU9mYdDjzttWDNXRDmwZYfgtsJrKYIzOgRriRarrJF
         6iww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nh284RfbKTKjVZ53xc/BjYmJT2KbUvj6smXua/Y15lg=;
        b=hC87GNHB+aqBtCXDAN1G0gqCmfub/8p5jENoJ2EGF0fHZnpUIhOKVriaVpeUYqclas
         2SSQZkq+Ydf7qVdcCQChppivCS1jzfCPYij6onp370NvmoZtDbFDnunIbG6bfO7/AbSs
         nhO18xdTV3MpuOgNli7WtfVbmY2pKDmSs2c2c63JdnPEyPxLfnbi4I0/VDVyPBQtKe4g
         AVUVJaNJ8N+QJbkOe5+XFcFZGSGNRBywOcbGhq2RTs6MyORuLsTYoEl7RKNDDKrZMgct
         asElVt6kVkATRu/AmMEMIvi2nFODNwo97HO4biASwsKwPc6h1inXIVasJHDXuFHWA0PN
         7Hxw==
X-Gm-Message-State: ACrzQf1DaW+dOR6/jOemsfL5RxuKg7zGMyvlMnudS28zdRdxO3ibbDDr
        fBI2FHE2vjcf6TcMdyoCi4/tNw==
X-Google-Smtp-Source: AMsMyM5qFqNKIQCrH6nqN3yVGbGf1IzcRlrs4UvsvzXwRIAC8cYkTRMstnrFzu4g/FRXgW5McIN7zw==
X-Received: by 2002:a05:6a00:114c:b0:528:2c7a:6302 with SMTP id b12-20020a056a00114c00b005282c7a6302mr33351690pfm.37.1666611349588;
        Mon, 24 Oct 2022 04:35:49 -0700 (PDT)
Received: from fedora.flets-east.jp ([2400:4050:c360:8200:8ae8:3c4:c0da:7419])
        by smtp.gmail.com with ESMTPSA id b8-20020a170903228800b001830ed575c3sm19475075plh.117.2022.10.24.04.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 04:35:49 -0700 (PDT)
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
Subject: [PATCH 01/22] drm/i915/opregion: Improve backlight request condition
Date:   Mon, 24 Oct 2022 20:34:52 +0900
Message-Id: <20221024113513.5205-2-akihiko.odaki@daynix.com>
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

asle_set_backlight() needs to accept backlight request only if the
firmware controls the backlight. It used the following expression for
this purpose:
acpi_video_get_backlight_type() == acpi_backlight_native

This expression works well in practice, but has two semantic problems.
One is that it actually determines if a backlight device which directly
modifies hardware registers ("native backlight") exists. It is possible
that a device which does not have backlight at all incorrectly triggers
asle_set_backlight(), and the expression does not cover such a case.

Another problem is that acpi_video_get_backlight_type() always return
acpi_backlight_vendor in reality if CONFIG_ACPI_VIDEO is unset. It
means even its ability to determine the existence of native backlight is
somewhat limited.

This change introduces a new function backlight_device_non_raw_exists(),
which returns if the firmware is controlling the backlight, and is
always available if backlight support is enabled.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 drivers/gpu/drm/i915/display/intel_opregion.c |  3 ++-
 drivers/video/backlight/backlight.c           | 18 ++++++++++++++++++
 include/linux/backlight.h                     |  1 +
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_opregion.c b/drivers/gpu/drm/i915/display/intel_opregion.c
index caa07ef34f21..82ea02ab94c2 100644
--- a/drivers/gpu/drm/i915/display/intel_opregion.c
+++ b/drivers/gpu/drm/i915/display/intel_opregion.c
@@ -26,6 +26,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/backlight.h>
 #include <linux/dmi.h>
 #include <linux/firmware.h>
 #include <acpi/video.h>
@@ -467,7 +468,7 @@ static u32 asle_set_backlight(struct drm_i915_private *dev_priv, u32 bclp)
 
 	drm_dbg(&dev_priv->drm, "bclp = 0x%08x\n", bclp);
 
-	if (acpi_video_get_backlight_type() == acpi_backlight_native) {
+	if (!backlight_device_non_raw_exists()) {
 		drm_dbg_kms(&dev_priv->drm,
 			    "opregion backlight request ignored\n");
 		return 0;
diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
index b788ff3d0f45..4f0ce463e250 100644
--- a/drivers/video/backlight/backlight.c
+++ b/drivers/video/backlight/backlight.c
@@ -516,6 +516,24 @@ struct backlight_device *backlight_device_get_by_name(const char *name)
 }
 EXPORT_SYMBOL(backlight_device_get_by_name);
 
+bool backlight_device_non_raw_exists(void)
+{
+	bool found = false;
+	struct backlight_device *bd;
+
+	mutex_lock(&backlight_dev_list_mutex);
+	list_for_each_entry(bd, &backlight_dev_list, entry) {
+		if (bd->props.type != BACKLIGHT_RAW) {
+			found = true;
+			break;
+		}
+	}
+	mutex_unlock(&backlight_dev_list_mutex);
+
+	return found;
+}
+EXPORT_SYMBOL(backlight_device_non_raw_exists);
+
 /* deprecated - use devm_backlight_device_unregister() */
 void backlight_device_unregister(struct backlight_device *bd)
 {
diff --git a/include/linux/backlight.h b/include/linux/backlight.h
index 614653e07e3a..364ef6f99a9e 100644
--- a/include/linux/backlight.h
+++ b/include/linux/backlight.h
@@ -444,6 +444,7 @@ int backlight_register_notifier(struct notifier_block *nb);
 int backlight_unregister_notifier(struct notifier_block *nb);
 struct backlight_device *backlight_device_get_by_name(const char *name);
 struct backlight_device *backlight_device_get_by_type(enum backlight_type type);
+bool backlight_device_non_raw_exists(void);
 int backlight_device_set_brightness(struct backlight_device *bd,
 				    unsigned long brightness);
 
-- 
2.37.3

