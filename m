Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 742E257268B
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Jul 2022 21:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235362AbiGLTsy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 Jul 2022 15:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235681AbiGLTrz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Jul 2022 15:47:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E0318BBD37
        for <linux-acpi@vger.kernel.org>; Tue, 12 Jul 2022 12:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657654836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DR4mSK2p22rr7gE6zCBqXxHxM86J5JcnORbiwFUpKks=;
        b=hxOTz3V72lNeS2af3oXdHOTl3Zyqj8KX1nLviWLHJkV46TziZnEJsvvIW7BpLfJ0lVkTYt
        hISrAl4BCWZE7BzOz5KZOlhx3VLBgGhQhZxquLLwbzNNZL1Ih7nr57M/tE3dvYMU6C1Q32
        2pe3aAzMOG0GbfPZcqfUidcARUxPGy8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-653-zgPx-jsEMeOhiwhQImEOhA-1; Tue, 12 Jul 2022 15:40:31 -0400
X-MC-Unique: zgPx-jsEMeOhiwhQImEOhA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 57E241C0CE66;
        Tue, 12 Jul 2022 19:40:30 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A184940E80E0;
        Tue, 12 Jul 2022 19:40:26 +0000 (UTC)
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
Subject: [PATCH v2 17/29] ACPI: video: Add Apple GMUX brightness control detection
Date:   Tue, 12 Jul 2022 21:38:58 +0200
Message-Id: <20220712193910.439171-18-hdegoede@redhat.com>
In-Reply-To: <20220712193910.439171-1-hdegoede@redhat.com>
References: <20220712193910.439171-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Apple laptops with an Apple GMUX using this for brightness control,
should take precedence of any other brightness control methods.

Add apple-gmux detection to acpi_video_get_backlight_type() using
the already existing apple_gmux_present() helper function.

This will allow removig the (ab)use of:

	acpi_video_set_dmi_backlight_type(acpi_backlight_vendor);

Inside the apple-gmux driver.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/video_detect.c | 4 ++++
 include/acpi/video.h        | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 7b89dc9a04a2..ce96cd7abe0b 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -28,6 +28,7 @@
 
 #include <linux/export.h>
 #include <linux/acpi.h>
+#include <linux/apple-gmux.h>
 #include <linux/backlight.h>
 #include <linux/dmi.h>
 #include <linux/module.h>
@@ -582,6 +583,9 @@ static enum acpi_backlight_type __acpi_video_get_backlight_type(bool native)
 	if (nvidia_wmi_ec_present)
 		return acpi_backlight_nvidia_wmi_ec;
 
+	if (apple_gmux_present())
+		return acpi_backlight_apple_gmux;
+
 	/* On systems with ACPI video use either native or ACPI video. */
 	if (video_caps & ACPI_VIDEO_BACKLIGHT) {
 		/*
diff --git a/include/acpi/video.h b/include/acpi/video.h
index 91578e77ac4e..dbd48cb8bd23 100644
--- a/include/acpi/video.h
+++ b/include/acpi/video.h
@@ -49,6 +49,7 @@ enum acpi_backlight_type {
 	acpi_backlight_vendor,
 	acpi_backlight_native,
 	acpi_backlight_nvidia_wmi_ec,
+	acpi_backlight_apple_gmux,
 };
 
 #if IS_ENABLED(CONFIG_ACPI_VIDEO)
-- 
2.36.0

