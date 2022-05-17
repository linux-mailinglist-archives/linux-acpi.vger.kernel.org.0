Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03E7C52A65F
	for <lists+linux-acpi@lfdr.de>; Tue, 17 May 2022 17:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349953AbiEQPYg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 17 May 2022 11:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349828AbiEQPYb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 17 May 2022 11:24:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF6C74F9C7
        for <linux-acpi@vger.kernel.org>; Tue, 17 May 2022 08:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652801063;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MiZqR+nlatrUqoF+Bj6/ALhugHQFjYZid/1UyHSgCow=;
        b=btY5TUQFHMGTEbBfcVqbXdgIY5ukn1msqLGl0ZbAoFzBfOaQ4yDOEdpI63f3YiN7F7rR+V
        A8vWVyoEVNEAPoMGZowcwtd5kxqoMmtXYbSYG+GRAK80PLjkc63f/BgEI+r0praVlXA3qx
        Syc4oZmEjRWwjOxrXr7+LVKHZh7IOE8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-484-Z4O-XODoMBKkphAGc1GIwQ-1; Tue, 17 May 2022 11:24:18 -0400
X-MC-Unique: Z4O-XODoMBKkphAGc1GIwQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7B3703C1E32B;
        Tue, 17 May 2022 15:24:17 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.162])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 07844C15E71;
        Tue, 17 May 2022 15:24:13 +0000 (UTC)
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
Subject: [PATCH 10/14] ACPI: video: Remove code to unregister acpi_video backlight when a native backlight registers
Date:   Tue, 17 May 2022 17:23:27 +0200
Message-Id: <20220517152331.16217-11-hdegoede@redhat.com>
In-Reply-To: <20220517152331.16217-1-hdegoede@redhat.com>
References: <20220517152331.16217-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Remove the code to unregister acpi_video backlight devices when
a native backlight device gets registered later.

Now that the acpi_video backlight device registration is a separate step
which runs later, after the drm/kms driver is done setting up its own
native backlight device, it is no longer necessary to monitor for a
native (BACKLIGHT_RAW) device showing up later and to then unregister
the acpi_video backlight device(s).

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/acpi_video.c   |  2 --
 drivers/acpi/video_detect.c | 36 ------------------------------------
 2 files changed, 38 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 79e75dc86243..20a2638f0ef1 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -89,7 +89,6 @@ static void acpi_video_bus_notify(struct acpi_device *device, u32 event);
 static void acpi_video_bus_register_backlight_work(struct work_struct *ignored);
 static DECLARE_DELAYED_WORK(video_bus_register_backlight_work,
 			    acpi_video_bus_register_backlight_work);
-void acpi_video_detect_exit(void);
 
 /*
  * Indices in the _BCL method response: the first two items are special,
@@ -2345,7 +2344,6 @@ static int __init acpi_video_init(void)
 
 static void __exit acpi_video_exit(void)
 {
-	acpi_video_detect_exit();
 	acpi_video_unregister();
 }
 
diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 6caabdf189c9..3fa79584981e 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -39,10 +39,6 @@
 
 void acpi_video_unregister_backlight(void);
 
-static bool backlight_notifier_registered;
-static struct notifier_block backlight_nb;
-static struct work_struct backlight_notify_work;
-
 static enum acpi_backlight_type acpi_backlight_cmdline = acpi_backlight_undef;
 static enum acpi_backlight_type acpi_backlight_dmi = acpi_backlight_undef;
 
@@ -516,26 +512,6 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 	{ },
 };
 
-/* This uses a workqueue to avoid various locking ordering issues */
-static void acpi_video_backlight_notify_work(struct work_struct *work)
-{
-	if (acpi_video_get_backlight_type(false) != acpi_backlight_video)
-		acpi_video_unregister_backlight();
-}
-
-static int acpi_video_backlight_notify(struct notifier_block *nb,
-				       unsigned long val, void *bd)
-{
-	struct backlight_device *backlight = bd;
-
-	/* A raw bl registering may change video -> native */
-	if (backlight->props.type == BACKLIGHT_RAW &&
-	    val == BACKLIGHT_REGISTERED)
-		schedule_work(&backlight_notify_work);
-
-	return NOTIFY_OK;
-}
-
 /*
  * Determine which type of backlight interface to use on this system,
  * First check cmdline, then dmi quirks, then do autodetect.
@@ -565,12 +541,6 @@ enum acpi_backlight_type acpi_video_get_backlight_type(bool native)
 		acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
 				    ACPI_UINT32_MAX, find_video, NULL,
 				    &video_caps, NULL);
-		INIT_WORK(&backlight_notify_work,
-			  acpi_video_backlight_notify_work);
-		backlight_nb.notifier_call = acpi_video_backlight_notify;
-		backlight_nb.priority = 0;
-		if (backlight_register_notifier(&backlight_nb) == 0)
-			backlight_notifier_registered = true;
 		init_done = true;
 	}
 	if (native)
@@ -606,9 +576,3 @@ void acpi_video_set_dmi_backlight_type(enum acpi_backlight_type type)
 		acpi_video_unregister_backlight();
 }
 EXPORT_SYMBOL(acpi_video_set_dmi_backlight_type);
-
-void __exit acpi_video_detect_exit(void)
-{
-	if (backlight_notifier_registered)
-		backlight_unregister_notifier(&backlight_nb);
-}
-- 
2.36.0

