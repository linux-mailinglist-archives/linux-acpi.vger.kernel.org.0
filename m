Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F00B05A1480
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Aug 2022 16:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242481AbiHYOmH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 25 Aug 2022 10:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242426AbiHYOlD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Aug 2022 10:41:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7CFADCF1
        for <linux-acpi@vger.kernel.org>; Thu, 25 Aug 2022 07:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661438373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NbidEuEmj0ip+acThUaZ1lCAqpjH/7g5iKO2PKg0/CQ=;
        b=Tm6JQYXtf0c7VmopByxp1ZP99x8JaM6gGboMomG/N4K52tgByif/u1zCm3r5mJ3JINLToh
        VG7IMed7wGrPmCVG8k9q6Nddv9eGFhrUUhXRXi7oMLzbjIPGyZicmc940OdYbFJ4AgWH3B
        HoXxKX1ZJjhlzGksM+g2TVMVBQQ9MOE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-489-7bohGBz7NumuyYWcGXRMjw-1; Thu, 25 Aug 2022 10:39:30 -0400
X-MC-Unique: 7bohGBz7NumuyYWcGXRMjw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D2971811E76;
        Thu, 25 Aug 2022 14:39:28 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.193.46])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CA3812166B29;
        Thu, 25 Aug 2022 14:39:24 +0000 (UTC)
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
        Werner Sembach <wse@tuxedocomputers.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v5 29/31] ACPI: video: Drop NL5x?U, PF4NU1F and PF5?U?? acpi_backlight=native quirks
Date:   Thu, 25 Aug 2022 16:37:24 +0200
Message-Id: <20220825143726.269890-30-hdegoede@redhat.com>
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

acpi_backlight=native is the default for these, but as the comment
explains the quirk was still necessary because even briefly registering
the acpi_video0 backlight; and then unregistering it once the native
driver showed up, was leading to issues.

After the "ACPI: video: Make backlight class device registration
a separate step" patch from earlier in this patch-series, we no
longer briefly register the acpi_video0 backlight on systems where
the native driver should be used.

So this is no longer an issue an the quirks are no longer needed.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=215683
Tested-by: Werner Sembach <wse@tuxedocomputers.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/video_detect.c | 92 +------------------------------------
 1 file changed, 1 insertion(+), 91 deletions(-)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index af2833b57b8b..789d5913c178 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -609,97 +609,7 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_BOARD_NAME, "N250P"),
 		},
 	},
-	/*
-	 * Clevo NL5xRU and NL5xNU/TUXEDO Aura 15 Gen1 and Gen2 have both a
-	 * working native and video interface. However the default detection
-	 * mechanism first registers the video interface before unregistering
-	 * it again and switching to the native interface during boot. This
-	 * results in a dangling SBIOS request for backlight change for some
-	 * reason, causing the backlight to switch to ~2% once per boot on the
-	 * first power cord connect or disconnect event. Setting the native
-	 * interface explicitly circumvents this buggy behaviour, by avoiding
-	 * the unregistering process.
-	 */
-	{
-	.callback = video_detect_force_native,
-	.ident = "Clevo NL5xRU",
-	.matches = {
-		DMI_MATCH(DMI_BOARD_NAME, "NL5xRU"),
-		},
-	},
-	{
-	.callback = video_detect_force_native,
-	.ident = "Clevo NL5xRU",
-	.matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
-		DMI_MATCH(DMI_BOARD_NAME, "AURA1501"),
-		},
-	},
-	{
-	.callback = video_detect_force_native,
-	.ident = "Clevo NL5xRU",
-	.matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
-		DMI_MATCH(DMI_BOARD_NAME, "EDUBOOK1502"),
-		},
-	},
-	{
-	.callback = video_detect_force_native,
-	.ident = "Clevo NL5xNU",
-	.matches = {
-		DMI_MATCH(DMI_BOARD_NAME, "NL5xNU"),
-		},
-	},
-	/*
-	 * The TongFang PF5PU1G, PF4NU1F, PF5NU1G, and PF5LUXG/TUXEDO BA15 Gen10,
-	 * Pulse 14/15 Gen1, and Pulse 15 Gen2 have the same problem as the Clevo
-	 * NL5xRU and NL5xNU/TUXEDO Aura 15 Gen1 and Gen2. See the description
-	 * above.
-	 */
-	{
-	.callback = video_detect_force_native,
-	.ident = "TongFang PF5PU1G",
-	.matches = {
-		DMI_MATCH(DMI_BOARD_NAME, "PF5PU1G"),
-		},
-	},
-	{
-	.callback = video_detect_force_native,
-	.ident = "TongFang PF4NU1F",
-	.matches = {
-		DMI_MATCH(DMI_BOARD_NAME, "PF4NU1F"),
-		},
-	},
-	{
-	.callback = video_detect_force_native,
-	.ident = "TongFang PF4NU1F",
-	.matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
-		DMI_MATCH(DMI_BOARD_NAME, "PULSE1401"),
-		},
-	},
-	{
-	.callback = video_detect_force_native,
-	.ident = "TongFang PF5NU1G",
-	.matches = {
-		DMI_MATCH(DMI_BOARD_NAME, "PF5NU1G"),
-		},
-	},
-	{
-	.callback = video_detect_force_native,
-	.ident = "TongFang PF5NU1G",
-	.matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
-		DMI_MATCH(DMI_BOARD_NAME, "PULSE1501"),
-		},
-	},
-	{
-	.callback = video_detect_force_native,
-	.ident = "TongFang PF5LUXG",
-	.matches = {
-		DMI_MATCH(DMI_BOARD_NAME, "PF5LUXG"),
-		},
-	},
+
 	/*
 	 * Desktops which falsely report a backlight and which our heuristics
 	 * for this do not catch.
-- 
2.37.2

