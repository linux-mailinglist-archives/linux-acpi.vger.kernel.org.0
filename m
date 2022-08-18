Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A34C5598BC4
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Aug 2022 20:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345119AbiHRSqB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 18 Aug 2022 14:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345537AbiHRSpH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Aug 2022 14:45:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1417DBB68B
        for <linux-acpi@vger.kernel.org>; Thu, 18 Aug 2022 11:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660848305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5+TG12UqCtmEosjJnkODC6uWWyAm1BJ6u+TpgFhRlew=;
        b=Da+dbMP8eXmqnsgwPzJIfzI+Xva1v2fQk04zM1asEGp3uGy1IKvhiBLPgCCjQ35TuY/YSO
        2eTC2vqelCMZGyQUD7KHQjzTDGO4QlbWggaqKiuTb5sayQel9R3PHLZCtnAOzmw55AW/O7
        JwxUe4ZRnul0Skhq2JpBhMliTpMN1jE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-446-qEUP0MmoMnmXrGU18Njyjg-1; Thu, 18 Aug 2022 14:44:59 -0400
X-MC-Unique: qEUP0MmoMnmXrGU18Njyjg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EAF5B3C0E232;
        Thu, 18 Aug 2022 18:44:57 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 26AE4492C3B;
        Thu, 18 Aug 2022 18:44:54 +0000 (UTC)
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
Subject: [PATCH v3 26/31] platform/x86: samsung-laptop: Move acpi_backlight=[vendor|native] quirks to ACPI video_detect.c
Date:   Thu, 18 Aug 2022 20:42:57 +0200
Message-Id: <20220818184302.10051-27-hdegoede@redhat.com>
In-Reply-To: <20220818184302.10051-1-hdegoede@redhat.com>
References: <20220818184302.10051-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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

Move all the acpi_backlight=[vendor|native] quirks from samsung-laptop to
drivers/acpi/video_detect.c .

Note the X360 -> acpi_backlight=native quirk is not moved because that
already was present in drivers/acpi/video_detect.c .

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/video_detect.c           | 54 +++++++++++++++++
 drivers/platform/x86/samsung-laptop.c | 87 ---------------------------
 2 files changed, 54 insertions(+), 87 deletions(-)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index a871ee69fcb2..66ea650fb45f 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -222,6 +222,33 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "GB-BXBT-2807"),
 		},
 	},
+	{
+	 .callback = video_detect_force_vendor,
+	 /* Samsung N150/N210/N220 */
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "N150/N210/N220"),
+		DMI_MATCH(DMI_BOARD_NAME, "N150/N210/N220"),
+		},
+	},
+	{
+	 .callback = video_detect_force_vendor,
+	 /* Samsung NF110/NF210/NF310 */
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "NF110/NF210/NF310"),
+		DMI_MATCH(DMI_BOARD_NAME, "NF110/NF210/NF310"),
+		},
+	},
+	{
+	 .callback = video_detect_force_vendor,
+	 /* Samsung NC210 */
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "NC210/NC110"),
+		DMI_MATCH(DMI_BOARD_NAME, "NC210/NC110"),
+		},
+	},
 	{
 	.callback = video_detect_force_vendor,
 	/* Sony VPCEH3U1E */
@@ -572,6 +599,33 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "UX303UB"),
 		},
 	},
+	{
+	 .callback = video_detect_force_native,
+	 /* Samsung N150P */
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "N150P"),
+		DMI_MATCH(DMI_BOARD_NAME, "N150P"),
+		},
+	},
+	{
+	 .callback = video_detect_force_native,
+	 /* Samsung N145P/N250P/N260P */
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "N145P/N250P/N260P"),
+		DMI_MATCH(DMI_BOARD_NAME, "N145P/N250P/N260P"),
+		},
+	},
+	{
+	 .callback = video_detect_force_native,
+	 /* Samsung N250P */
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "N250P"),
+		DMI_MATCH(DMI_BOARD_NAME, "N250P"),
+		},
+	},
 	/*
 	 * Clevo NL5xRU and NL5xNU/TUXEDO Aura 15 Gen1 and Gen2 have both a
 	 * working native and video interface. However the default detection
diff --git a/drivers/platform/x86/samsung-laptop.c b/drivers/platform/x86/samsung-laptop.c
index c187dcdf82f0..cc30cf08f32d 100644
--- a/drivers/platform/x86/samsung-laptop.c
+++ b/drivers/platform/x86/samsung-laptop.c
@@ -356,23 +356,13 @@ struct samsung_laptop {
 };
 
 struct samsung_quirks {
-	bool broken_acpi_video;
 	bool four_kbd_backlight_levels;
 	bool enable_kbd_backlight;
-	bool use_native_backlight;
 	bool lid_handling;
 };
 
 static struct samsung_quirks samsung_unknown = {};
 
-static struct samsung_quirks samsung_broken_acpi_video = {
-	.broken_acpi_video = true,
-};
-
-static struct samsung_quirks samsung_use_native_backlight = {
-	.use_native_backlight = true,
-};
-
 static struct samsung_quirks samsung_np740u3e = {
 	.four_kbd_backlight_levels = true,
 	.enable_kbd_backlight = true,
@@ -1540,76 +1530,6 @@ static const struct dmi_system_id samsung_dmi_table[] __initconst = {
 		},
 	},
 	/* Specific DMI ids for laptop with quirks */
-	{
-	 .callback = samsung_dmi_matched,
-	 .ident = "N150P",
-	 .matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
-		DMI_MATCH(DMI_PRODUCT_NAME, "N150P"),
-		DMI_MATCH(DMI_BOARD_NAME, "N150P"),
-		},
-	 .driver_data = &samsung_use_native_backlight,
-	},
-	{
-	 .callback = samsung_dmi_matched,
-	 .ident = "N145P/N250P/N260P",
-	 .matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
-		DMI_MATCH(DMI_PRODUCT_NAME, "N145P/N250P/N260P"),
-		DMI_MATCH(DMI_BOARD_NAME, "N145P/N250P/N260P"),
-		},
-	 .driver_data = &samsung_use_native_backlight,
-	},
-	{
-	 .callback = samsung_dmi_matched,
-	 .ident = "N150/N210/N220",
-	 .matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
-		DMI_MATCH(DMI_PRODUCT_NAME, "N150/N210/N220"),
-		DMI_MATCH(DMI_BOARD_NAME, "N150/N210/N220"),
-		},
-	 .driver_data = &samsung_broken_acpi_video,
-	},
-	{
-	 .callback = samsung_dmi_matched,
-	 .ident = "NF110/NF210/NF310",
-	 .matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
-		DMI_MATCH(DMI_PRODUCT_NAME, "NF110/NF210/NF310"),
-		DMI_MATCH(DMI_BOARD_NAME, "NF110/NF210/NF310"),
-		},
-	 .driver_data = &samsung_broken_acpi_video,
-	},
-	{
-	 .callback = samsung_dmi_matched,
-	 .ident = "X360",
-	 .matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
-		DMI_MATCH(DMI_PRODUCT_NAME, "X360"),
-		DMI_MATCH(DMI_BOARD_NAME, "X360"),
-		},
-	 .driver_data = &samsung_broken_acpi_video,
-	},
-	{
-	 .callback = samsung_dmi_matched,
-	 .ident = "N250P",
-	 .matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
-		DMI_MATCH(DMI_PRODUCT_NAME, "N250P"),
-		DMI_MATCH(DMI_BOARD_NAME, "N250P"),
-		},
-	 .driver_data = &samsung_use_native_backlight,
-	},
-	{
-	 .callback = samsung_dmi_matched,
-	 .ident = "NC210",
-	 .matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
-		DMI_MATCH(DMI_PRODUCT_NAME, "NC210/NC110"),
-		DMI_MATCH(DMI_BOARD_NAME, "NC210/NC110"),
-		},
-	 .driver_data = &samsung_broken_acpi_video,
-	},
 	{
 	 .callback = samsung_dmi_matched,
 	 .ident = "730U3E/740U3E",
@@ -1654,15 +1574,8 @@ static int __init samsung_init(void)
 	samsung->handle_backlight = true;
 	samsung->quirks = quirks;
 
-#ifdef CONFIG_ACPI
-	if (samsung->quirks->broken_acpi_video)
-		acpi_video_set_dmi_backlight_type(acpi_backlight_vendor);
-	if (samsung->quirks->use_native_backlight)
-		acpi_video_set_dmi_backlight_type(acpi_backlight_native);
-
 	if (acpi_video_get_backlight_type() != acpi_backlight_vendor)
 		samsung->handle_backlight = false;
-#endif
 
 	ret = samsung_platform_init(samsung);
 	if (ret)
-- 
2.37.2

