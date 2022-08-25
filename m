Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 072E25A1468
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Aug 2022 16:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242337AbiHYOlU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 25 Aug 2022 10:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242590AbiHYOkb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Aug 2022 10:40:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2494B7748
        for <linux-acpi@vger.kernel.org>; Thu, 25 Aug 2022 07:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661438339;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F6xVWh0Dc8/uuezucezT0dIDBu1CvpE+lkATuLHa0mA=;
        b=awpVHoe3ej8RfTjZUUBXY4nGpLnT7urywkFrm6vl36yB3m/MZgwhN52lBFdvd2faBWFaog
        0wEME6ytJiCCmvgn3dn3KGhJwjDRmv5sgsMjcJcuyKXV2SOpcgj48eNx8N1Ca5650tmnoz
        S0I+ZAmljNHo7wNK0TJ+sH0HI4D6T0c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-647-VgEcgdOyPoKAC69U3_eqUg-1; Thu, 25 Aug 2022 10:38:58 -0400
X-MC-Unique: VgEcgdOyPoKAC69U3_eqUg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 477F3101E985;
        Thu, 25 Aug 2022 14:38:56 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.193.46])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 755592166B2A;
        Thu, 25 Aug 2022 14:38:52 +0000 (UTC)
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
        platform-driver-x86@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v5 21/31] platform/x86: toshiba_acpi: Stop using acpi_video_set_dmi_backlight_type()
Date:   Thu, 25 Aug 2022 16:37:16 +0200
Message-Id: <20220825143726.269890-22-hdegoede@redhat.com>
In-Reply-To: <20220825143726.269890-1-hdegoede@redhat.com>
References: <20220825143726.269890-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

acpi_video_set_dmi_backlight_type() is troublesome because it may end up
getting called after other backlight drivers have already called
acpi_video_get_backlight_type() resulting in the other drivers
already being registered even though they should not.

In case of the acpi_video backlight, acpi_video_set_dmi_backlight_type()
actually calls acpi_video_unregister_backlight() since that is often
probed earlier, leading to userspace seeing the acpi_video0 class
device being briefly available, leading to races in userspace where
udev probe-rules try to access the device and it is already gone.

In case of toshiba_acpi there are no DMI quirks to move to
acpi/video_detect.c, but it also (ab)uses it for transflective
displays. Adding transflective display support to video_detect.c would
be quite involved. But luckily there are only 2 known models with
a transflective display, so we can just add DMI quirks for those.

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/video_detect.c         | 19 +++++++++++++++++++
 drivers/platform/x86/toshiba_acpi.c | 16 ----------------
 2 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index be2fc43418af..74e2087c8ff0 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -190,6 +190,25 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		},
 	},
 
+	/*
+	 * Toshiba models with Transflective display, these need to use
+	 * the toshiba_acpi vendor driver for proper Transflective handling.
+	 */
+	{
+	 .callback = video_detect_force_vendor,
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "PORTEGE R500"),
+		},
+	},
+	{
+	 .callback = video_detect_force_vendor,
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "PORTEGE R600"),
+		},
+	},
+
 	/*
 	 * These models have a working acpi_video backlight control, and using
 	 * native backlight causes a regression where backlight does not work
diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
index 0fc9e8b8827b..030dc37d50b8 100644
--- a/drivers/platform/x86/toshiba_acpi.c
+++ b/drivers/platform/x86/toshiba_acpi.c
@@ -271,14 +271,6 @@ static const struct key_entry toshiba_acpi_alt_keymap[] = {
 	{ KE_END, 0 },
 };
 
-/*
- * List of models which have a broken acpi-video backlight interface and thus
- * need to use the toshiba (vendor) interface instead.
- */
-static const struct dmi_system_id toshiba_vendor_backlight_dmi[] = {
-	{}
-};
-
 /*
  * Utility
  */
@@ -2881,14 +2873,6 @@ static int toshiba_acpi_setup_backlight(struct toshiba_acpi_dev *dev)
 		return 0;
 	}
 
-	/*
-	 * Tell acpi-video-detect code to prefer vendor backlight on all
-	 * systems with transflective backlight and on dmi matched systems.
-	 */
-	if (dev->tr_backlight_supported ||
-	    dmi_check_system(toshiba_vendor_backlight_dmi))
-		acpi_video_set_dmi_backlight_type(acpi_backlight_vendor);
-
 	if (acpi_video_get_backlight_type() != acpi_backlight_vendor)
 		return 0;
 
-- 
2.37.2

