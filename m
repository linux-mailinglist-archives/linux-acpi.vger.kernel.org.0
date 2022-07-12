Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38ABB5726A9
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Jul 2022 21:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233764AbiGLTt5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 Jul 2022 15:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235546AbiGLTsP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Jul 2022 15:48:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2EE99BD68A
        for <linux-acpi@vger.kernel.org>; Tue, 12 Jul 2022 12:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657654866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2WK3kAcxEEkkbv9pOh1xIkmngcweoSFUQNmrVAb4yRo=;
        b=BxMVisVEMGZ/ESkYaoKu/XvCzGFGiY+mz3Yl9CVXTMB8ByzAvL2KvWxDPGmUlZozBC4qgl
        TJixU92GT7GDuL6KOf83AV/DJQgmj8jepgccbu1ztSGvrQ3zXt01LIaUMji48re2jvweSI
        lMa2JFP1VtDCR5HQnXv1lQ0MSroheHI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-147-aKYw3J9FNyiVVAeTYZ7eDw-1; Tue, 12 Jul 2022 15:41:05 -0400
X-MC-Unique: aKYw3J9FNyiVVAeTYZ7eDw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A9C56299E764;
        Tue, 12 Jul 2022 19:41:03 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DEC5840E80E0;
        Tue, 12 Jul 2022 19:40:59 +0000 (UTC)
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
Subject: [PATCH v2 25/29] ACPI: video: Remove acpi_video_set_dmi_backlight_type()
Date:   Tue, 12 Jul 2022 21:39:06 +0200
Message-Id: <20220712193910.439171-26-hdegoede@redhat.com>
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

acpi_video_set_dmi_backlight_type() is troublesome because it may end
up getting called after other backlight drivers have already called
acpi_video_get_backlight_type() resulting in the other drivers
already being registered even though they should not.

In case of the acpi_video backlight, acpi_video_set_dmi_backlight_type()
actually calls acpi_video_unregister_backlight() since that is often
probed earlier, leading to userspace seeing the acpi_video0 class
device being briefly available, leading to races in userspace where
udev probe-rules try to access the device and it is already gone.

All callers have been fixed to no longer call it, so remove
acpi_video_set_dmi_backlight_type() now.

This means we now also no longer need acpi_video_unregister_backlight()
for the remove acpi_video backlight after it was wrongly registered hack,
so remove that too.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/acpi_video.c   | 10 ----------
 drivers/acpi/video_detect.c | 16 ----------------
 include/acpi/video.h        |  4 ----
 3 files changed, 30 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 4fc2a8100865..dc3c037d6313 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -2297,16 +2297,6 @@ void acpi_video_register_backlight(void)
 }
 EXPORT_SYMBOL(acpi_video_register_backlight);
 
-void acpi_video_unregister_backlight(void)
-{
-	struct acpi_video_bus *video;
-
-	mutex_lock(&video_list_lock);
-	list_for_each_entry(video, &video_bus_head, entry)
-		acpi_video_bus_unregister_backlight(video);
-	mutex_unlock(&video_list_lock);
-}
-
 bool acpi_video_handles_brightness_key_presses(void)
 {
 	return has_backlight &&
diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 84dce2c113ef..351bd6335d7a 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -37,8 +37,6 @@
 #include <linux/workqueue.h>
 #include <acpi/video.h>
 
-void acpi_video_unregister_backlight(void);
-
 static enum acpi_backlight_type acpi_backlight_cmdline = acpi_backlight_undef;
 static enum acpi_backlight_type acpi_backlight_dmi = acpi_backlight_undef;
 
@@ -792,17 +790,3 @@ bool acpi_video_backlight_use_native(void)
 	return __acpi_video_get_backlight_type(true) == acpi_backlight_native;
 }
 EXPORT_SYMBOL(acpi_video_backlight_use_native);
-
-/*
- * Set the preferred backlight interface type based on DMI info.
- * This function allows DMI blacklists to be implemented by external
- * platform drivers instead of putting a big blacklist in video_detect.c
- */
-void acpi_video_set_dmi_backlight_type(enum acpi_backlight_type type)
-{
-	acpi_backlight_dmi = type;
-	/* Remove acpi-video backlight interface if it is no longer desired */
-	if (acpi_video_get_backlight_type() != acpi_backlight_video)
-		acpi_video_unregister_backlight();
-}
-EXPORT_SYMBOL(acpi_video_set_dmi_backlight_type);
diff --git a/include/acpi/video.h b/include/acpi/video.h
index dbd48cb8bd23..a275c35e5249 100644
--- a/include/acpi/video.h
+++ b/include/acpi/video.h
@@ -60,7 +60,6 @@ extern int acpi_video_get_edid(struct acpi_device *device, int type,
 			       int device_id, void **edid);
 extern enum acpi_backlight_type acpi_video_get_backlight_type(void);
 extern bool acpi_video_backlight_use_native(void);
-extern void acpi_video_set_dmi_backlight_type(enum acpi_backlight_type type);
 /*
  * Note: The value returned by acpi_video_handles_brightness_key_presses()
  * may change over time and should not be cached.
@@ -86,9 +85,6 @@ static inline bool acpi_video_backlight_use_native(void)
 {
 	return true;
 }
-static inline void acpi_video_set_dmi_backlight_type(enum acpi_backlight_type type)
-{
-}
 static inline bool acpi_video_handles_brightness_key_presses(void)
 {
 	return false;
-- 
2.36.0

