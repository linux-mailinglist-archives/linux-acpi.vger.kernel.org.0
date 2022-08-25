Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 236485A1465
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Aug 2022 16:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242120AbiHYOlL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 25 Aug 2022 10:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239092AbiHYOkP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Aug 2022 10:40:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CCEB8F21
        for <linux-acpi@vger.kernel.org>; Thu, 25 Aug 2022 07:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661438336;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C30+JylXoiqfCL1QVhV6xN5vRbXmIR8YpoQkV4jNNtM=;
        b=jLHKpv4Lnkx+Qio0fxOf93gxsqQ03zxYTXsHw/g3D3YUL/DWBtC/N1Gnb7qljxQA0x+GO7
        PiavlNc8nvJ64168qvsTDHl1kKfxcemkSwWfaK3GoBJdpvOkfiqXGkHjY+LhUWfnW0lAHt
        Pg0E8sVVjs+fNZVuzzwyQtKyn+GzQY0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-195-EFVMyU7XOF2abnvZZSK7Ig-1; Thu, 25 Aug 2022 10:38:45 -0400
X-MC-Unique: EFVMyU7XOF2abnvZZSK7Ig-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5E6D71C004F7;
        Thu, 25 Aug 2022 14:38:44 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.193.46])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 962952166B26;
        Thu, 25 Aug 2022 14:38:40 +0000 (UTC)
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
Subject: [PATCH v5 18/31] ACPI: video: Add Apple GMUX brightness control detection
Date:   Thu, 25 Aug 2022 16:37:13 +0200
Message-Id: <20220825143726.269890-19-hdegoede@redhat.com>
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

On Apple laptops with an Apple GMUX using this for brightness control,
should take precedence of any other brightness control methods.

Add apple-gmux detection to acpi_video_get_backlight_type() using
the already existing apple_gmux_present() helper function.

This will allow removig the (ab)use of:

	acpi_video_set_dmi_backlight_type(acpi_backlight_vendor);

Inside the apple-gmux driver.

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/video_detect.c | 4 ++++
 include/acpi/video.h        | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 4dc7fb865083..be2fc43418af 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -28,6 +28,7 @@
 
 #include <linux/export.h>
 #include <linux/acpi.h>
+#include <linux/apple-gmux.h>
 #include <linux/backlight.h>
 #include <linux/dmi.h>
 #include <linux/module.h>
@@ -607,6 +608,9 @@ static enum acpi_backlight_type __acpi_video_get_backlight_type(bool native)
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
2.37.2

