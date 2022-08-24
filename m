Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC47759F98C
	for <lists+linux-acpi@lfdr.de>; Wed, 24 Aug 2022 14:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237329AbiHXMSl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 24 Aug 2022 08:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237184AbiHXMRh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 24 Aug 2022 08:17:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199077434E
        for <linux-acpi@vger.kernel.org>; Wed, 24 Aug 2022 05:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661343454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZSViiSuhKNAdrLrYepEenjnf4H0dVHKO/KroQUbHaXc=;
        b=OOshX7GZysT7fhUNP5nVLDlGgrKum3UuQbdU+fQhhQRyQhQI6FSFRVLYHM832Jq8wI738+
        RZqxcGnfQBnQUeqnHh3QDkQzvPP2O2zqOvvtvlUxhyjFhbmD5v0wrtmH03pLJiwPZS1q3u
        ylFKit53wHzyOx1s/MCxohJV9FROPsY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-615-to2AtxuzOZ6Gl5uI9NhjYg-1; Wed, 24 Aug 2022 08:17:30 -0400
X-MC-Unique: to2AtxuzOZ6Gl5uI9NhjYg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DD9A98041BE;
        Wed, 24 Aug 2022 12:17:28 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.193.103])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EFFBCC15BBA;
        Wed, 24 Aug 2022 12:17:24 +0000 (UTC)
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
        platform-driver-x86@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v4 27/31] ACPI: video: Remove acpi_video_set_dmi_backlight_type()
Date:   Wed, 24 Aug 2022 14:15:19 +0200
Message-Id: <20220824121523.1291269-28-hdegoede@redhat.com>
In-Reply-To: <20220824121523.1291269-1-hdegoede@redhat.com>
References: <20220824121523.1291269-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/acpi_video.c   | 10 ----------
 drivers/acpi/video_detect.c | 16 ----------------
 include/acpi/video.h        |  4 ----
 3 files changed, 30 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index d1e41f30c004..a7c3d11e0dac 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -2296,16 +2296,6 @@ void acpi_video_register_backlight(void)
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
 	return may_report_brightness_keys &&
diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 3861d4121172..67a0211c07b4 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -38,8 +38,6 @@
 #include <linux/workqueue.h>
 #include <acpi/video.h>
 
-void acpi_video_unregister_backlight(void);
-
 static enum acpi_backlight_type acpi_backlight_cmdline = acpi_backlight_undef;
 static enum acpi_backlight_type acpi_backlight_dmi = acpi_backlight_undef;
 
@@ -817,17 +815,3 @@ bool acpi_video_backlight_use_native(void)
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
2.37.2

