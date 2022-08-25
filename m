Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33E825A13F7
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Aug 2022 16:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241859AbiHYOjC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 25 Aug 2022 10:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242413AbiHYOiT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Aug 2022 10:38:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B393DB775A
        for <linux-acpi@vger.kernel.org>; Thu, 25 Aug 2022 07:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661438272;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ifqshlCTSJ5NXlqXXzhinjFx0ubJqt2GewWv1fX9YDE=;
        b=EIgSIiKPSN4NNFp2Tg3pxum1BND3VJUrjTn8v9RQRPWibfPehn0VTdsqNQrHOGGNFkNPV2
        Ukw0/jyXcJ8jyRoVadO2ipI0ai9xK6q1YQde1sg1xViaVgaIwrCTMP4Diipn4TYUbbr63n
        Qewj0Rw6RJPGoD3Xgiv4PgiSYbBKHFE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-381-2uRZaBEOMj64c7refETtig-1; Thu, 25 Aug 2022 10:37:48 -0400
X-MC-Unique: 2uRZaBEOMj64c7refETtig-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 234C7811E83;
        Thu, 25 Aug 2022 14:37:47 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.193.46])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 771042166B29;
        Thu, 25 Aug 2022 14:37:43 +0000 (UTC)
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
Subject: [PATCH v5 04/31] drm/radeon: Don't register backlight when another backlight should be used (v3)
Date:   Thu, 25 Aug 2022 16:36:59 +0200
Message-Id: <20220825143726.269890-5-hdegoede@redhat.com>
In-Reply-To: <20220825143726.269890-1-hdegoede@redhat.com>
References: <20220825143726.269890-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Before this commit when we want userspace to use the acpi_video backlight
device we register both the GPU's native backlight device and acpi_video's
firmware acpi_video# backlight device. This relies on userspace preferring
firmware type backlight devices over native ones.

Registering 2 backlight devices for a single display really is
undesirable, don't register the GPU's native backlight device when
another backlight device should be used.

Changes in v2:
- To avoid linker errors when amdgpu is builtin and video_detect.c is in
  a module, select ACPI_VIDEO and its deps if ACPI is enabled.
  When ACPI is disabled, ACPI_VIDEO is also always disabled, ensuring
  the stubs from acpi/video.h will be used.

Changes in v3:
- Use drm_info(drm_dev, "...") to log messages
- ACPI_VIDEO can now be enabled on non X86 too,
  adjust the Kconfig changes to match this.

Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/gpu/drm/Kconfig                         | 7 +++++++
 drivers/gpu/drm/radeon/atombios_encoders.c      | 7 +++++++
 drivers/gpu/drm/radeon/radeon_legacy_encoders.c | 7 +++++++
 3 files changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 95ca33938b4a..0471505e951d 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -234,6 +234,13 @@ config DRM_RADEON
 	select HWMON
 	select BACKLIGHT_CLASS_DEVICE
 	select INTERVAL_TREE
+	# radeon depends on ACPI_VIDEO when ACPI is enabled, for select to work
+	# ACPI_VIDEO's dependencies must also be selected.
+	select INPUT if ACPI
+	select ACPI_VIDEO if ACPI
+	# On x86 ACPI_VIDEO also needs ACPI_WMI
+	select X86_PLATFORM_DEVICES if ACPI && X86
+	select ACPI_WMI if ACPI && X86
 	help
 	  Choose this option if you have an ATI Radeon graphics card.  There
 	  are both PCI and AGP versions.  You don't need to choose this to
diff --git a/drivers/gpu/drm/radeon/atombios_encoders.c b/drivers/gpu/drm/radeon/atombios_encoders.c
index 0eae05dfb385..c841c273222e 100644
--- a/drivers/gpu/drm/radeon/atombios_encoders.c
+++ b/drivers/gpu/drm/radeon/atombios_encoders.c
@@ -32,6 +32,8 @@
 #include <drm/drm_file.h>
 #include <drm/radeon_drm.h>
 
+#include <acpi/video.h>
+
 #include "atom.h"
 #include "radeon_atombios.h"
 #include "radeon.h"
@@ -209,6 +211,11 @@ void radeon_atom_backlight_init(struct radeon_encoder *radeon_encoder,
 	if (!(rdev->mode_info.firmware_flags & ATOM_BIOS_INFO_BL_CONTROLLED_BY_GPU))
 		return;
 
+	if (!acpi_video_backlight_use_native()) {
+		drm_info(dev, "Skipping radeon atom DIG backlight registration\n");
+		return;
+	}
+
 	pdata = kmalloc(sizeof(struct radeon_backlight_privdata), GFP_KERNEL);
 	if (!pdata) {
 		DRM_ERROR("Memory allocation failed\n");
diff --git a/drivers/gpu/drm/radeon/radeon_legacy_encoders.c b/drivers/gpu/drm/radeon/radeon_legacy_encoders.c
index 1a66fb969ee7..0cd32c65456c 100644
--- a/drivers/gpu/drm/radeon/radeon_legacy_encoders.c
+++ b/drivers/gpu/drm/radeon/radeon_legacy_encoders.c
@@ -33,6 +33,8 @@
 #include <drm/drm_util.h>
 #include <drm/radeon_drm.h>
 
+#include <acpi/video.h>
+
 #include "radeon.h"
 #include "radeon_asic.h"
 #include "radeon_legacy_encoders.h"
@@ -387,6 +389,11 @@ void radeon_legacy_backlight_init(struct radeon_encoder *radeon_encoder,
 		return;
 #endif
 
+	if (!acpi_video_backlight_use_native()) {
+		drm_info(dev, "Skipping radeon legacy LVDS backlight registration\n");
+		return;
+	}
+
 	pdata = kmalloc(sizeof(struct radeon_backlight_privdata), GFP_KERNEL);
 	if (!pdata) {
 		DRM_ERROR("Memory allocation failed\n");
-- 
2.37.2

