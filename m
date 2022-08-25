Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B91D75A142A
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Aug 2022 16:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233563AbiHYOkO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 25 Aug 2022 10:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240558AbiHYOje (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Aug 2022 10:39:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177BFB8A6C
        for <linux-acpi@vger.kernel.org>; Thu, 25 Aug 2022 07:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661438312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dxj3lM6sL4g1YMNFDck7Z+TAmgXGPRh+G1kkxRMbO1M=;
        b=BVJbuqEesHV3yhqENlbM70J3oatlFdeNtUFiR0JF6wnMPZt9BvuaMNK1y+EqiFodOAorGq
        jIZJsxO42JscXpucbkEt2zMDa7cyDqwNAEneKgwvnYnzhXXgnACV3dopNATGSbITQ+pKQy
        WacqEkrtokQKyB6kaEnwOq+n/DwSN6w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-nErq3th-PSCzWRvOtpc9jA-1; Thu, 25 Aug 2022 10:38:29 -0400
X-MC-Unique: nErq3th-PSCzWRvOtpc9jA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0D02D85A58A;
        Thu, 25 Aug 2022 14:38:28 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.193.46])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 511452166B26;
        Thu, 25 Aug 2022 14:38:24 +0000 (UTC)
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
Subject: [PATCH v5 14/31] drm/radeon: Register ACPI video backlight when skipping radeon backlight registration
Date:   Thu, 25 Aug 2022 16:37:09 +0200
Message-Id: <20220825143726.269890-15-hdegoede@redhat.com>
In-Reply-To: <20220825143726.269890-1-hdegoede@redhat.com>
References: <20220825143726.269890-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
index 35c535e48b8d..fbc0a2182318 100644
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

