Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D59359F969
	for <lists+linux-acpi@lfdr.de>; Wed, 24 Aug 2022 14:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237024AbiHXMR2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 24 Aug 2022 08:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237457AbiHXMQv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 24 Aug 2022 08:16:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE1C74362
        for <linux-acpi@vger.kernel.org>; Wed, 24 Aug 2022 05:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661343407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mQ93MFygjHtn+pj1JiwZkpRA5Z7Viuv96I2pphNTU0o=;
        b=Hf9jneHdyHtK3znq5UDbk3pbr7QM9e4Wf0+zcLuU8uwyPn5w8jWxjX7pBKW/TrKWBHU2CA
        7deuXaMZydVZbaKP45rF1tqj4PMLYwTrl+46FqaWe1gGGIUzTlawM1+ZtryHlkFXXLouKG
        DJsMOvWg3WMaMdkcUHcxDj88HR/6m98=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-191-Wd3EIa9nNA-RunYaFsaWqA-1; Wed, 24 Aug 2022 08:16:43 -0400
X-MC-Unique: Wd3EIa9nNA-RunYaFsaWqA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E78373C0D879;
        Wed, 24 Aug 2022 12:16:41 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.193.103])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2441AC15BB3;
        Wed, 24 Aug 2022 12:16:38 +0000 (UTC)
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
Subject: [PATCH v4 16/31] ACPI: video: Refactor acpi_video_get_backlight_type() a bit
Date:   Wed, 24 Aug 2022 14:15:08 +0200
Message-Id: <20220824121523.1291269-17-hdegoede@redhat.com>
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

Refactor acpi_video_get_backlight_type() so that the heuristics /
detection steps are stricly in order of descending precedence.

Also move the comments describing the steps to when the various steps are
actually done, to avoid the comments getting out of sync with the code.

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/video_detect.c | 39 ++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index fb49b8f4523a..cc9d0d91e268 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -537,16 +537,6 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 /*
  * Determine which type of backlight interface to use on this system,
  * First check cmdline, then dmi quirks, then do autodetect.
- *
- * The autodetect order is:
- * 1) Is the acpi-video backlight interface supported ->
- *  no, use a vendor interface
- * 2) Is this a win8 "ready" BIOS and do we have a native interface ->
- *  yes, use a native interface
- * 3) Else use the acpi-video interface
- *
- * Arguably the native on win8 check should be done first, but that would
- * be a behavior change, which may causes issues.
  */
 static enum acpi_backlight_type __acpi_video_get_backlight_type(bool native)
 {
@@ -569,19 +559,36 @@ static enum acpi_backlight_type __acpi_video_get_backlight_type(bool native)
 		native_available = true;
 	mutex_unlock(&init_mutex);
 
+	/*
+	 * The below heuristics / detection steps are in order of descending
+	 * presedence. The commandline takes presedence over anything else.
+	 */
 	if (acpi_backlight_cmdline != acpi_backlight_undef)
 		return acpi_backlight_cmdline;
 
+	/* DMI quirks override any autodetection. */
 	if (acpi_backlight_dmi != acpi_backlight_undef)
 		return acpi_backlight_dmi;
 
-	if (!(video_caps & ACPI_VIDEO_BACKLIGHT))
-		return acpi_backlight_vendor;
-
-	if (acpi_osi_is_win8() && native_available)
-		return acpi_backlight_native;
+	/* On systems with ACPI video use either native or ACPI video. */
+	if (video_caps & ACPI_VIDEO_BACKLIGHT) {
+		/*
+		 * Windows 8 and newer no longer use the ACPI video interface,
+		 * so it often does not work. If the ACPI tables are written
+		 * for win8 and native brightness ctl is available, use that.
+		 *
+		 * The native check deliberately is inside the if acpi-video
+		 * block on older devices without acpi-video support native
+		 * is usually not the best choice.
+		 */
+		if (acpi_osi_is_win8() && native_available)
+			return acpi_backlight_native;
+		else
+			return acpi_backlight_video;
+	}
 
-	return acpi_backlight_video;
+	/* No ACPI video (old hw), use vendor specific fw methods. */
+	return acpi_backlight_vendor;
 }
 
 enum acpi_backlight_type acpi_video_get_backlight_type(void)
-- 
2.37.2

