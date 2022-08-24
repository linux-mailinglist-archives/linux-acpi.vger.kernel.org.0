Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4302559F974
	for <lists+linux-acpi@lfdr.de>; Wed, 24 Aug 2022 14:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237452AbiHXMR1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 24 Aug 2022 08:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237379AbiHXMQv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 24 Aug 2022 08:16:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CBF36DAD0
        for <linux-acpi@vger.kernel.org>; Wed, 24 Aug 2022 05:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661343404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ExdwPf7bNKmYW/ELY8Z3mdkN/Wif1pdwMOooFmW67kM=;
        b=OiqLLd2OenIYpXoghKQ2OnKXRmgUcEpsZAhaF89dx1lGVwDDF0NIyvRfT+uHICvvBitTm6
        LyR5L1RFAn+Yd4qtEnObfWeCSJvDCLNjR0cZeYjpzjOHLzBjr+ymIL/jyyIfrIH5fgDlzC
        u0X1gXRbV217ab0tc1V3O4xFBF9xtrM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-171-8Uh5AffgMA-TzrRiXK-z6w-1; Wed, 24 Aug 2022 08:16:39 -0400
X-MC-Unique: 8Uh5AffgMA-TzrRiXK-z6w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D42FF18A01AF;
        Wed, 24 Aug 2022 12:16:37 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.193.103])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1F929C15BBA;
        Wed, 24 Aug 2022 12:16:34 +0000 (UTC)
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
        David Airlie <airlied@linux.ie>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v4 15/31] platform/x86: nvidia-wmi-ec-backlight: Move fw interface definitions to a header (v2)
Date:   Wed, 24 Aug 2022 14:15:07 +0200
Message-Id: <20220824121523.1291269-16-hdegoede@redhat.com>
In-Reply-To: <20220824121523.1291269-1-hdegoede@redhat.com>
References: <20220824121523.1291269-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Move the WMI interface definitions to a header, so that the definitions
can be shared with drivers/acpi/video_detect.c .

Changes in v2:
- Add missing Nvidia copyright header
- Move WMI_BRIGHTNESS_GUID to nvidia-wmi-ec-backlight.h as well

Suggested-by: Daniel Dadap <ddadap@nvidia.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 MAINTAINERS                                   |  1 +
 .../platform/x86/nvidia-wmi-ec-backlight.c    | 68 +----------------
 .../x86/nvidia-wmi-ec-backlight.h             | 76 +++++++++++++++++++
 3 files changed, 78 insertions(+), 67 deletions(-)
 create mode 100644 include/linux/platform_data/x86/nvidia-wmi-ec-backlight.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 9d7f64dc0efe..d6f6b96f51f7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14527,6 +14527,7 @@ M:	Daniel Dadap <ddadap@nvidia.com>
 L:	platform-driver-x86@vger.kernel.org
 S:	Supported
 F:	drivers/platform/x86/nvidia-wmi-ec-backlight.c
+F:	include/linux/platform_data/x86/nvidia-wmi-ec-backlight.h
 
 NVM EXPRESS DRIVER
 M:	Keith Busch <kbusch@kernel.org>
diff --git a/drivers/platform/x86/nvidia-wmi-ec-backlight.c b/drivers/platform/x86/nvidia-wmi-ec-backlight.c
index 61e37194df70..be803e47eac0 100644
--- a/drivers/platform/x86/nvidia-wmi-ec-backlight.c
+++ b/drivers/platform/x86/nvidia-wmi-ec-backlight.c
@@ -7,74 +7,10 @@
 #include <linux/backlight.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/platform_data/x86/nvidia-wmi-ec-backlight.h>
 #include <linux/types.h>
 #include <linux/wmi.h>
 
-/**
- * enum wmi_brightness_method - WMI method IDs
- * @WMI_BRIGHTNESS_METHOD_LEVEL:  Get/Set EC brightness level status
- * @WMI_BRIGHTNESS_METHOD_SOURCE: Get/Set EC Brightness Source
- */
-enum wmi_brightness_method {
-	WMI_BRIGHTNESS_METHOD_LEVEL = 1,
-	WMI_BRIGHTNESS_METHOD_SOURCE = 2,
-	WMI_BRIGHTNESS_METHOD_MAX
-};
-
-/**
- * enum wmi_brightness_mode - Operation mode for WMI-wrapped method
- * @WMI_BRIGHTNESS_MODE_GET:            Get the current brightness level/source.
- * @WMI_BRIGHTNESS_MODE_SET:            Set the brightness level.
- * @WMI_BRIGHTNESS_MODE_GET_MAX_LEVEL:  Get the maximum brightness level. This
- *                                      is only valid when the WMI method is
- *                                      %WMI_BRIGHTNESS_METHOD_LEVEL.
- */
-enum wmi_brightness_mode {
-	WMI_BRIGHTNESS_MODE_GET = 0,
-	WMI_BRIGHTNESS_MODE_SET = 1,
-	WMI_BRIGHTNESS_MODE_GET_MAX_LEVEL = 2,
-	WMI_BRIGHTNESS_MODE_MAX
-};
-
-/**
- * enum wmi_brightness_source - Backlight brightness control source selection
- * @WMI_BRIGHTNESS_SOURCE_GPU: Backlight brightness is controlled by the GPU.
- * @WMI_BRIGHTNESS_SOURCE_EC:  Backlight brightness is controlled by the
- *                             system's Embedded Controller (EC).
- * @WMI_BRIGHTNESS_SOURCE_AUX: Backlight brightness is controlled over the
- *                             DisplayPort AUX channel.
- */
-enum wmi_brightness_source {
-	WMI_BRIGHTNESS_SOURCE_GPU = 1,
-	WMI_BRIGHTNESS_SOURCE_EC = 2,
-	WMI_BRIGHTNESS_SOURCE_AUX = 3,
-	WMI_BRIGHTNESS_SOURCE_MAX
-};
-
-/**
- * struct wmi_brightness_args - arguments for the WMI-wrapped ACPI method
- * @mode:    Pass in an &enum wmi_brightness_mode value to select between
- *           getting or setting a value.
- * @val:     In parameter for value to set when using %WMI_BRIGHTNESS_MODE_SET
- *           mode. Not used in conjunction with %WMI_BRIGHTNESS_MODE_GET or
- *           %WMI_BRIGHTNESS_MODE_GET_MAX_LEVEL mode.
- * @ret:     Out parameter returning retrieved value when operating in
- *           %WMI_BRIGHTNESS_MODE_GET or %WMI_BRIGHTNESS_MODE_GET_MAX_LEVEL
- *           mode. Not used in %WMI_BRIGHTNESS_MODE_SET mode.
- * @ignored: Padding; not used. The ACPI method expects a 24 byte params struct.
- *
- * This is the parameters structure for the WmiBrightnessNotify ACPI method as
- * wrapped by WMI. The value passed in to @val or returned by @ret will be a
- * brightness value when the WMI method ID is %WMI_BRIGHTNESS_METHOD_LEVEL, or
- * an &enum wmi_brightness_source value with %WMI_BRIGHTNESS_METHOD_SOURCE.
- */
-struct wmi_brightness_args {
-	u32 mode;
-	u32 val;
-	u32 ret;
-	u32 ignored[3];
-};
-
 /**
  * wmi_brightness_notify() - helper function for calling WMI-wrapped ACPI method
  * @w:    Pointer to the struct wmi_device identified by %WMI_BRIGHTNESS_GUID
@@ -191,8 +127,6 @@ static int nvidia_wmi_ec_backlight_probe(struct wmi_device *wdev, const void *ct
 	return PTR_ERR_OR_ZERO(bdev);
 }
 
-#define WMI_BRIGHTNESS_GUID "603E9613-EF25-4338-A3D0-C46177516DB7"
-
 static const struct wmi_device_id nvidia_wmi_ec_backlight_id_table[] = {
 	{ .guid_string = WMI_BRIGHTNESS_GUID },
 	{ }
diff --git a/include/linux/platform_data/x86/nvidia-wmi-ec-backlight.h b/include/linux/platform_data/x86/nvidia-wmi-ec-backlight.h
new file mode 100644
index 000000000000..23d60130272c
--- /dev/null
+++ b/include/linux/platform_data/x86/nvidia-wmi-ec-backlight.h
@@ -0,0 +1,76 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2020, NVIDIA CORPORATION.  All rights reserved.
+ */
+
+#ifndef __PLATFORM_DATA_X86_NVIDIA_WMI_EC_BACKLIGHT_H
+#define __PLATFORM_DATA_X86_NVIDIA_WMI_EC_BACKLIGHT_H
+
+#define WMI_BRIGHTNESS_GUID "603E9613-EF25-4338-A3D0-C46177516DB7"
+
+/**
+ * enum wmi_brightness_method - WMI method IDs
+ * @WMI_BRIGHTNESS_METHOD_LEVEL:  Get/Set EC brightness level status
+ * @WMI_BRIGHTNESS_METHOD_SOURCE: Get/Set EC Brightness Source
+ */
+enum wmi_brightness_method {
+	WMI_BRIGHTNESS_METHOD_LEVEL = 1,
+	WMI_BRIGHTNESS_METHOD_SOURCE = 2,
+	WMI_BRIGHTNESS_METHOD_MAX
+};
+
+/**
+ * enum wmi_brightness_mode - Operation mode for WMI-wrapped method
+ * @WMI_BRIGHTNESS_MODE_GET:            Get the current brightness level/source.
+ * @WMI_BRIGHTNESS_MODE_SET:            Set the brightness level.
+ * @WMI_BRIGHTNESS_MODE_GET_MAX_LEVEL:  Get the maximum brightness level. This
+ *                                      is only valid when the WMI method is
+ *                                      %WMI_BRIGHTNESS_METHOD_LEVEL.
+ */
+enum wmi_brightness_mode {
+	WMI_BRIGHTNESS_MODE_GET = 0,
+	WMI_BRIGHTNESS_MODE_SET = 1,
+	WMI_BRIGHTNESS_MODE_GET_MAX_LEVEL = 2,
+	WMI_BRIGHTNESS_MODE_MAX
+};
+
+/**
+ * enum wmi_brightness_source - Backlight brightness control source selection
+ * @WMI_BRIGHTNESS_SOURCE_GPU: Backlight brightness is controlled by the GPU.
+ * @WMI_BRIGHTNESS_SOURCE_EC:  Backlight brightness is controlled by the
+ *                             system's Embedded Controller (EC).
+ * @WMI_BRIGHTNESS_SOURCE_AUX: Backlight brightness is controlled over the
+ *                             DisplayPort AUX channel.
+ */
+enum wmi_brightness_source {
+	WMI_BRIGHTNESS_SOURCE_GPU = 1,
+	WMI_BRIGHTNESS_SOURCE_EC = 2,
+	WMI_BRIGHTNESS_SOURCE_AUX = 3,
+	WMI_BRIGHTNESS_SOURCE_MAX
+};
+
+/**
+ * struct wmi_brightness_args - arguments for the WMI-wrapped ACPI method
+ * @mode:    Pass in an &enum wmi_brightness_mode value to select between
+ *           getting or setting a value.
+ * @val:     In parameter for value to set when using %WMI_BRIGHTNESS_MODE_SET
+ *           mode. Not used in conjunction with %WMI_BRIGHTNESS_MODE_GET or
+ *           %WMI_BRIGHTNESS_MODE_GET_MAX_LEVEL mode.
+ * @ret:     Out parameter returning retrieved value when operating in
+ *           %WMI_BRIGHTNESS_MODE_GET or %WMI_BRIGHTNESS_MODE_GET_MAX_LEVEL
+ *           mode. Not used in %WMI_BRIGHTNESS_MODE_SET mode.
+ * @ignored: Padding; not used. The ACPI method expects a 24 byte params struct.
+ *
+ * This is the parameters structure for the WmiBrightnessNotify ACPI method as
+ * wrapped by WMI. The value passed in to @val or returned by @ret will be a
+ * brightness value when the WMI method ID is %WMI_BRIGHTNESS_METHOD_LEVEL, or
+ * an &enum wmi_brightness_source value with %WMI_BRIGHTNESS_METHOD_SOURCE.
+ */
+struct wmi_brightness_args {
+	u32 mode;
+	u32 val;
+	u32 ret;
+	u32 ignored[3];
+};
+
+#endif
-- 
2.37.2

