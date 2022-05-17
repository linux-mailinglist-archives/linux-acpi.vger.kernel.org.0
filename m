Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB06352A639
	for <lists+linux-acpi@lfdr.de>; Tue, 17 May 2022 17:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349977AbiEQPYP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 17 May 2022 11:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349937AbiEQPYC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 17 May 2022 11:24:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 888604F46A
        for <linux-acpi@vger.kernel.org>; Tue, 17 May 2022 08:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652801040;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EzQ0bpfNq/u5CmCRWzwXFCuUS14QmFp9uACdqa5mEOQ=;
        b=AGXJiMLrdYTzB4EfJvbqIKxQ9hKA2U1uKCc8M4nyBMPHwKeaW6Dn3HVE1yXdKpHsljbpZi
        fzRBUpR5Df6qp1Q6FbpGjK7R7c+RZ3GCyZ3sHwS9T2eaGUwzNNs0Jiq2O8l8IZ06jYw4XX
        vJew3us9bt4EtDrFjPz6uuyVIooM24c=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-520-Jn-4oR0_MKSItA1HmnTSUQ-1; Tue, 17 May 2022 11:23:56 -0400
X-MC-Unique: Jn-4oR0_MKSItA1HmnTSUQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 307203817A62;
        Tue, 17 May 2022 15:23:55 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.162])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AF7C6C15D5C;
        Tue, 17 May 2022 15:23:51 +0000 (UTC)
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
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, nouveau@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH 04/14] drm/radeon: Don't register backlight when another backlight should be used
Date:   Tue, 17 May 2022 17:23:21 +0200
Message-Id: <20220517152331.16217-5-hdegoede@redhat.com>
In-Reply-To: <20220517152331.16217-1-hdegoede@redhat.com>
References: <20220517152331.16217-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
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

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/gpu/drm/Kconfig                         | 1 +
 drivers/gpu/drm/radeon/atombios_encoders.c      | 7 +++++++
 drivers/gpu/drm/radeon/radeon_legacy_encoders.c | 7 +++++++
 3 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index ddbeb2124df7..37205953056b 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -258,6 +258,7 @@ config DRM_RADEON
 	select HWMON
 	select BACKLIGHT_CLASS_DEVICE
 	select INTERVAL_TREE
+	select ACPI_VIDEO if ACPI && X86 && INPUT
 	help
 	  Choose this option if you have an ATI Radeon graphics card.  There
 	  are both PCI and AGP versions.  You don't need to choose this to
diff --git a/drivers/gpu/drm/radeon/atombios_encoders.c b/drivers/gpu/drm/radeon/atombios_encoders.c
index 70bd84b7ef2b..f82577dc25e8 100644
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
@@ -211,6 +213,11 @@ void radeon_atom_backlight_init(struct radeon_encoder *radeon_encoder,
 	if (!(rdev->mode_info.firmware_flags & ATOM_BIOS_INFO_BL_CONTROLLED_BY_GPU))
 		return;
 
+	if (acpi_video_get_backlight_type(true) != acpi_backlight_native) {
+		DRM_INFO("Skipping radeon atom DIG backlight registration\n");
+		return;
+	}
+
 	pdata = kmalloc(sizeof(struct radeon_backlight_privdata), GFP_KERNEL);
 	if (!pdata) {
 		DRM_ERROR("Memory allocation failed\n");
diff --git a/drivers/gpu/drm/radeon/radeon_legacy_encoders.c b/drivers/gpu/drm/radeon/radeon_legacy_encoders.c
index 7fdb77d48d6a..d2180f5c80fa 100644
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
@@ -389,6 +391,11 @@ void radeon_legacy_backlight_init(struct radeon_encoder *radeon_encoder,
 		return;
 #endif
 
+	if (acpi_video_get_backlight_type(true) != acpi_backlight_native) {
+		DRM_INFO("Skipping radeon legacy LVDS backlight registration\n");
+		return;
+	}
+
 	pdata = kmalloc(sizeof(struct radeon_backlight_privdata), GFP_KERNEL);
 	if (!pdata) {
 		DRM_ERROR("Memory allocation failed\n");
-- 
2.36.0

