Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00979598B89
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Aug 2022 20:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344915AbiHRSow (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 18 Aug 2022 14:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344396AbiHRSoQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Aug 2022 14:44:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3088B6D34
        for <linux-acpi@vger.kernel.org>; Thu, 18 Aug 2022 11:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660848254;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+ZRWSzgzGloyQFhitzFMWTbLRjoSfsHn/K0aOUr2Fmo=;
        b=hlOMb22Z+r6N1g+zJLyXU/cj1u19EyuKh0qCil1N9mJ2QvButw1ikyb3uQgmtk9NMRasRn
        6jgk8ctnsf4nAFKV6/o+uhlp+phUXD+TdwjseOXcpXfBodiYGv34UBXvUC6YrW+X9WcT9q
        WywE1UQajSSiE89eSU7C0+U4UJ2T6bg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-639-vw9LsXSbPZKRFgZS-73Y3g-1; Thu, 18 Aug 2022 14:44:11 -0400
X-MC-Unique: vw9LsXSbPZKRFgZS-73Y3g-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3EEF6101A54E;
        Thu, 18 Aug 2022 18:44:10 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9C8F3492C3B;
        Thu, 18 Aug 2022 18:44:06 +0000 (UTC)
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
Subject: [PATCH v3 14/31] drm/radeon: Register ACPI video backlight when skipping radeon backlight registration
Date:   Thu, 18 Aug 2022 20:42:45 +0200
Message-Id: <20220818184302.10051-15-hdegoede@redhat.com>
In-Reply-To: <20220818184302.10051-1-hdegoede@redhat.com>
References: <20220818184302.10051-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Typically the acpi_video driver will initialize before radeon, which
used to cause /sys/class/backlight/acpi_video0 to get registered and then
radeon would register its own radeon_bl# device later. After which
the drivers/acpi/video_detect.c code unregistered the acpi_video0 device
to avoid there being 2 backlight devices.

This means that userspace used to briefly see 2 devices and the
disappearing of acpi_video0 after a brief time confuses the systemd
backlight level save/restore code, see e.g.:
https://bbs.archlinux.org/viewtopic.php?id=269920

To fix this the ACPI video code has been modified to make backlight class
device registration a separate step, relying on the drm/kms driver to
ask for the acpi_video backlight registration after it is done setting up
its native backlight device.

Add a call to the new acpi_video_register_backlight() when radeon skips
registering its own backlight device because of e.g. the firmware_flags
or the acpi_video_get_backlight_type() return value. This ensures that
if the acpi_video backlight device should be used, it will be available
before the radeon drm_device gets registered with userspace.

Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/gpu/drm/radeon/radeon_encoders.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_encoders.c b/drivers/gpu/drm/radeon/radeon_encoders.c
index 46549d5179ee..c1cbebb51be1 100644
--- a/drivers/gpu/drm/radeon/radeon_encoders.c
+++ b/drivers/gpu/drm/radeon/radeon_encoders.c
@@ -30,6 +30,8 @@
 #include <drm/drm_device.h>
 #include <drm/radeon_drm.h>
 
+#include <acpi/video.h>
+
 #include "radeon.h"
 #include "radeon_atombios.h"
 #include "radeon_legacy_encoders.h"
@@ -167,7 +169,7 @@ static void radeon_encoder_add_backlight(struct radeon_encoder *radeon_encoder,
 		return;
 
 	if (radeon_backlight == 0) {
-		return;
+		use_bl = false;
 	} else if (radeon_backlight == 1) {
 		use_bl = true;
 	} else if (radeon_backlight == -1) {
@@ -193,6 +195,13 @@ static void radeon_encoder_add_backlight(struct radeon_encoder *radeon_encoder,
 		else
 			radeon_legacy_backlight_init(radeon_encoder, connector);
 	}
+
+	/*
+	 * If there is no native backlight device (which may happen even when
+	 * use_bl==true) try registering an ACPI video backlight device instead.
+	 */
+	if (!rdev->mode_info.bl_encoder)
+		acpi_video_register_backlight();
 }
 
 void
-- 
2.37.2

