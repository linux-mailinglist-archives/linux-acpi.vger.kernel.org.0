Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21E416D4D1C
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Apr 2023 18:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbjDCQEy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 3 Apr 2023 12:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233156AbjDCQEl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Apr 2023 12:04:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783B62103
        for <linux-acpi@vger.kernel.org>; Mon,  3 Apr 2023 09:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680537826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WwKNpHdk6yYFfjh5jC43+CS29ijftEYs1VExDljmGBc=;
        b=ADlBm8TrAQ9EVcHY0v9zYLMj/DnM62F8fkOZrb7IncF7tfFztgjOX31wqCoqyPSAmQZXxk
        2HjKtquXK0y0QCo81a/0qZ7z2CkKSe9AS0pLPPlmP92niDLb+QmJjusIXVh4mNNovlitu8
        EnhnR7L8+5yDE4oglMdbWcxD06WxFUk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-629-p9nM_DhdPV6fqruUum4p9A-1; Mon, 03 Apr 2023 12:03:45 -0400
X-MC-Unique: p9nM_DhdPV6fqruUum4p9A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 998C9811E7C;
        Mon,  3 Apr 2023 16:03:44 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.126])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 90A952166B29;
        Mon,  3 Apr 2023 16:03:43 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Daniel Dadap <ddadap@nvidia.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org
Subject: [PATCH 5/6] ACPI: video: Remove register_backlight_delay module option and code
Date:   Mon,  3 Apr 2023 18:03:28 +0200
Message-Id: <20230403160329.707176-6-hdegoede@redhat.com>
In-Reply-To: <20230403160329.707176-1-hdegoede@redhat.com>
References: <20230403160329.707176-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Since commit 5aa9d943e9b6 ("ACPI: video: Don't enable fallback path for
creating ACPI backlight by default"), the delayed registerering of
acpi_video# backlight devices has been disabled by default.

The few bugreports where this option was used as a workaround were all
cases where the GPU driver did not call acpi_video_register_backlight()
and the workaround was to pass video.register_backlight_delay=1.

With the recent "ACPI: video: Make acpi_backlight=video work independent
from GPU driver" changes acpi_backlight=video can be used to achieve
the same result. So there is no need for the register_backlight_delay
option + code anymore.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/acpi_video.c                     | 38 -------------------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  4 --
 include/acpi/video.h                          |  2 -
 3 files changed, 44 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index c7a6d0b69dab..62f4364e4460 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -70,12 +70,6 @@ module_param(device_id_scheme, bool, 0444);
 static int only_lcd = -1;
 module_param(only_lcd, int, 0444);
 
-static int register_backlight_delay;
-module_param(register_backlight_delay, int, 0444);
-MODULE_PARM_DESC(register_backlight_delay,
-	"Delay in seconds before doing fallback (non GPU driver triggered) "
-	"backlight registration, set to 0 to disable.");
-
 static bool may_report_brightness_keys;
 static int register_count;
 static DEFINE_MUTEX(register_count_mutex);
@@ -84,9 +78,6 @@ static LIST_HEAD(video_bus_head);
 static int acpi_video_bus_add(struct acpi_device *device);
 static void acpi_video_bus_remove(struct acpi_device *device);
 static void acpi_video_bus_notify(struct acpi_device *device, u32 event);
-static void acpi_video_bus_register_backlight_work(struct work_struct *ignored);
-static DECLARE_DELAYED_WORK(video_bus_register_backlight_work,
-			    acpi_video_bus_register_backlight_work);
 
 /*
  * Indices in the _BCL method response: the first two items are special,
@@ -2096,11 +2087,6 @@ static void acpi_video_bus_remove(struct acpi_device *device)
 	kfree(video);
 }
 
-static void acpi_video_bus_register_backlight_work(struct work_struct *ignored)
-{
-	acpi_video_register_backlight();
-}
-
 static int __init is_i740(struct pci_dev *dev)
 {
 	if (dev->device == 0x00D1)
@@ -2183,17 +2169,6 @@ static bool should_check_lcd_flag(void)
 	return false;
 }
 
-/*
- * At least one graphics driver has reported that no LCD is connected
- * via the native interface. cancel the registration for fallback acpi_video0.
- * If another driver still deems this necessary, it can explicitly register it.
- */
-void acpi_video_report_nolcd(void)
-{
-	cancel_delayed_work(&video_bus_register_backlight_work);
-}
-EXPORT_SYMBOL(acpi_video_report_nolcd);
-
 int acpi_video_register(void)
 {
 	int ret = 0;
@@ -2222,18 +2197,6 @@ int acpi_video_register(void)
 	 */
 	register_count = 1;
 
-	/*
-	 * acpi_video_bus_add() skips registering the userspace visible
-	 * backlight_device. The intend is for this to be registered by the
-	 * drm/kms driver calling acpi_video_register_backlight() *after* it is
-	 * done setting up its own native backlight device. The delayed work
-	 * ensures that acpi_video_register_backlight() always gets called
-	 * eventually, in case there is no drm/kms driver or it is disabled.
-	 */
-	if (register_backlight_delay)
-		schedule_delayed_work(&video_bus_register_backlight_work,
-				      register_backlight_delay * HZ);
-
 leave:
 	mutex_unlock(&register_count_mutex);
 	return ret;
@@ -2244,7 +2207,6 @@ void acpi_video_unregister(void)
 {
 	mutex_lock(&register_count_mutex);
 	if (register_count) {
-		cancel_delayed_work_sync(&video_bus_register_backlight_work);
 		acpi_bus_unregister_driver(&acpi_video_bus);
 		register_count = 0;
 		may_report_brightness_keys = false;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 7c96faa73426..d832f9ac43d4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4436,10 +4436,6 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 		amdgpu_set_panel_orientation(&aconnector->base);
 	}
 
-	/* If we didn't find a panel, notify the acpi video detection */
-	if (dm->adev->flags & AMD_IS_APU && dm->num_of_edps == 0)
-		acpi_video_report_nolcd();
-
 	/* Software is initialized. Now we can register interrupt handlers. */
 	switch (adev->asic_type) {
 #if defined(CONFIG_DRM_AMD_DC_SI)
diff --git a/include/acpi/video.h b/include/acpi/video.h
index ff5a8da5d883..4230392b5b0b 100644
--- a/include/acpi/video.h
+++ b/include/acpi/video.h
@@ -53,7 +53,6 @@ enum acpi_backlight_type {
 };
 
 #if IS_ENABLED(CONFIG_ACPI_VIDEO)
-extern void acpi_video_report_nolcd(void);
 extern int acpi_video_register(void);
 extern void acpi_video_unregister(void);
 extern void acpi_video_register_backlight(void);
@@ -81,7 +80,6 @@ static inline bool acpi_video_backlight_use_native(void)
 	return __acpi_video_get_backlight_type(true, NULL) == acpi_backlight_native;
 }
 #else
-static inline void acpi_video_report_nolcd(void) { return; };
 static inline int acpi_video_register(void) { return -ENODEV; }
 static inline void acpi_video_unregister(void) { return; }
 static inline void acpi_video_register_backlight(void) { return; }
-- 
2.39.1

