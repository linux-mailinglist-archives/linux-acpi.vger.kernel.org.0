Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC01572653
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Jul 2022 21:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232801AbiGLTr3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 Jul 2022 15:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233328AbiGLTrI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Jul 2022 15:47:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DEEB8286C5
        for <linux-acpi@vger.kernel.org>; Tue, 12 Jul 2022 12:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657654772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b8ds0eYvIHUF+n7wI0ZmrEtSIvk/0a0gFALuw8Umig8=;
        b=cmndEQUdx3tFxZsLHfdvJIQkPAfbqFaETJJbqmfIAj5sLslBfQmB5nVar+GCjHd9tzx5pX
        S5SlzgLpPZopDzy75CfDT/7+JOEeYP1xTacMYe87jKEhJAZps8R8dsuyfQdH/VxOfOKFhA
        1DmdrmqQB9s1iDFHtbSrwmyAdlq0CxI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-214-JXasPOhWPeuYmwi7SYCQpQ-1; Tue, 12 Jul 2022 15:39:25 -0400
X-MC-Unique: JXasPOhWPeuYmwi7SYCQpQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B16253C01E16;
        Tue, 12 Jul 2022 19:39:24 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EF28340E80E0;
        Tue, 12 Jul 2022 19:39:20 +0000 (UTC)
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
Subject: [PATCH v2 01/29] ACPI: video: Add acpi_video_backlight_use_native() helper
Date:   Tue, 12 Jul 2022 21:38:42 +0200
Message-Id: <20220712193910.439171-2-hdegoede@redhat.com>
In-Reply-To: <20220712193910.439171-1-hdegoede@redhat.com>
References: <20220712193910.439171-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ATM on x86 laptops where we want userspace to use the acpi_video backlight
device we often register both the GPU's native backlight device and
acpi_video's firmware acpi_video# backlight device. This relies on
userspace preferring firmware type backlight devices over native ones, but
registering 2 backlight devices for a single display really is undesirable.

On x86 laptops where the native GPU backlight device should be used,
the registering of other backlight devices is avoided by their drivers
using acpi_video_get_backlight_type() and only registering their backlight
if the return value matches their type.

acpi_video_get_backlight_type() uses
backlight_device_get_by_type(BACKLIGHT_RAW) to determine if a native
driver is available and will never return native if this returns
false. This means that the GPU's native backlight registering code
cannot just call acpi_video_get_backlight_type() to determine if it
should register its backlight, since acpi_video_get_backlight_type() will
never return native until the native backlight has already registered.

To fix this add a new internal native function parameter to
acpi_video_get_backlight_type(), which when set to true will make
acpi_video_get_backlight_type() behave as if a native backlight has
already been registered.

And add a new acpi_video_backlight_use_native() helper, which sets this
to true, for use in native GPU backlight code.

Changes in v2:
- Replace adding a native parameter to acpi_video_get_backlight_type() with
  adding a new acpi_video_backlight_use_native() helper.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/video_detect.c | 24 ++++++++++++++++++++----
 include/acpi/video.h        |  5 +++++
 2 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index becc198e4c22..4346c990022d 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -17,8 +17,9 @@
  * Otherwise vendor specific drivers like thinkpad_acpi, asus-laptop,
  * sony_acpi,... can take care about backlight brightness.
  *
- * Backlight drivers can use acpi_video_get_backlight_type() to determine
- * which driver should handle the backlight.
+ * Backlight drivers can use acpi_video_get_backlight_type() to determine which
+ * driver should handle the backlight. RAW/GPU-driver backlight drivers must
+ * use the acpi_video_backlight_use_native() helper for this.
  *
  * If CONFIG_ACPI_VIDEO is neither set as "compiled in" (y) nor as a module (m)
  * this file will not be compiled and acpi_video_get_backlight_type() will
@@ -548,9 +549,10 @@ static int acpi_video_backlight_notify(struct notifier_block *nb,
  * Arguably the native on win8 check should be done first, but that would
  * be a behavior change, which may causes issues.
  */
-enum acpi_backlight_type acpi_video_get_backlight_type(void)
+static enum acpi_backlight_type __acpi_video_get_backlight_type(bool native)
 {
 	static DEFINE_MUTEX(init_mutex);
+	static bool native_available;
 	static bool init_done;
 	static long video_caps;
 
@@ -570,6 +572,8 @@ enum acpi_backlight_type acpi_video_get_backlight_type(void)
 			backlight_notifier_registered = true;
 		init_done = true;
 	}
+	if (native)
+		native_available = true;
 	mutex_unlock(&init_mutex);
 
 	if (acpi_backlight_cmdline != acpi_backlight_undef)
@@ -581,13 +585,25 @@ enum acpi_backlight_type acpi_video_get_backlight_type(void)
 	if (!(video_caps & ACPI_VIDEO_BACKLIGHT))
 		return acpi_backlight_vendor;
 
-	if (acpi_osi_is_win8() && backlight_device_get_by_type(BACKLIGHT_RAW))
+	if (acpi_osi_is_win8() &&
+	    (native_available || backlight_device_get_by_type(BACKLIGHT_RAW)))
 		return acpi_backlight_native;
 
 	return acpi_backlight_video;
 }
+
+enum acpi_backlight_type acpi_video_get_backlight_type(void)
+{
+	return __acpi_video_get_backlight_type(false);
+}
 EXPORT_SYMBOL(acpi_video_get_backlight_type);
 
+bool acpi_video_backlight_use_native(void)
+{
+	return __acpi_video_get_backlight_type(true) == acpi_backlight_native;
+}
+EXPORT_SYMBOL(acpi_video_backlight_use_native);
+
 /*
  * Set the preferred backlight interface type based on DMI info.
  * This function allows DMI blacklists to be implemented by external
diff --git a/include/acpi/video.h b/include/acpi/video.h
index db8548ff03ce..4705e339c252 100644
--- a/include/acpi/video.h
+++ b/include/acpi/video.h
@@ -56,6 +56,7 @@ extern void acpi_video_unregister(void);
 extern int acpi_video_get_edid(struct acpi_device *device, int type,
 			       int device_id, void **edid);
 extern enum acpi_backlight_type acpi_video_get_backlight_type(void);
+extern bool acpi_video_backlight_use_native(void);
 extern void acpi_video_set_dmi_backlight_type(enum acpi_backlight_type type);
 /*
  * Note: The value returned by acpi_video_handles_brightness_key_presses()
@@ -77,6 +78,10 @@ static inline enum acpi_backlight_type acpi_video_get_backlight_type(void)
 {
 	return acpi_backlight_vendor;
 }
+static inline bool acpi_video_backlight_use_native(void)
+{
+	return true;
+}
 static inline void acpi_video_set_dmi_backlight_type(enum acpi_backlight_type type)
 {
 }
-- 
2.36.0

