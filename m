Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D488859F97C
	for <lists+linux-acpi@lfdr.de>; Wed, 24 Aug 2022 14:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237227AbiHXMSJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 24 Aug 2022 08:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237447AbiHXMRS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 24 Aug 2022 08:17:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39B771BD4
        for <linux-acpi@vger.kernel.org>; Wed, 24 Aug 2022 05:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661343436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G7V2u4sIjkI2Xs9voopkzPTMZS50TOb7aIMZ6gmEsAI=;
        b=ONQGq1MysLq1XepewAWBlVnsTO0Hl07KxZLqAxzAfdaLUvkz0Nr+Yre51Wdz2ej67nhBfS
        Zi69KiQAjE82bSPX8oY2s7GvJQSYjE3pmOiRkHXjVOXLk7wZbCLXZFagYyr/h8sC/6LCuX
        DsYD4TvqWMQ4i/sfyq/Z5abQkbZwTRg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-425-xB94Y_ajNa28Ax-tzT-LMg-1; Wed, 24 Aug 2022 08:17:12 -0400
X-MC-Unique: xB94Y_ajNa28Ax-tzT-LMg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 208E685A58A;
        Wed, 24 Aug 2022 12:17:11 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.193.103])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 20430C15BB3;
        Wed, 24 Aug 2022 12:17:07 +0000 (UTC)
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
Subject: [PATCH v4 23/31] platform/x86: asus-wmi: Drop DMI chassis-type check from backlight handling
Date:   Wed, 24 Aug 2022 14:15:15 +0200
Message-Id: <20220824121523.1291269-24-hdegoede@redhat.com>
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

Remove this check from the asus-wmi backlight handling:

	/* Some Asus desktop boards export an acpi-video backlight interface,
	   stop this from showing up */
	chassis_type = dmi_get_system_info(DMI_CHASSIS_TYPE);
	if (chassis_type && !strcmp(chassis_type, "3"))
		acpi_video_set_dmi_backlight_type(acpi_backlight_vendor);

This acpi_video_set_dmi_backlight_type(acpi_backlight_vendor) call must be
removed because other changes in this series change the native backlight
drivers to no longer unconditionally register their backlight. Instead
these drivers now do this check:

        if (acpi_video_get_backlight_type(false) != acpi_backlight_native)
                return 0; /* bail */

So leaving this in place can break things on laptops with a broken
DMI chassis-type, which would have GPU native brightness control before
the addition of the acpi_video_get_backlight_type() != native check.

Removing this should be ok now, since the ACPI video code has improved
heuristics for this itself now (which includes a chassis-type check).

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/asus-wmi.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 89b604e04d7f..301166a5697d 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -3553,7 +3553,6 @@ static int asus_wmi_add(struct platform_device *pdev)
 	struct platform_driver *pdrv = to_platform_driver(pdev->dev.driver);
 	struct asus_wmi_driver *wdrv = to_asus_wmi_driver(pdrv);
 	struct asus_wmi *asus;
-	const char *chassis_type;
 	acpi_status status;
 	int err;
 	u32 result;
@@ -3635,12 +3634,6 @@ static int asus_wmi_add(struct platform_device *pdev)
 	if (asus->driver->quirks->wmi_force_als_set)
 		asus_wmi_set_als();
 
-	/* Some Asus desktop boards export an acpi-video backlight interface,
-	   stop this from showing up */
-	chassis_type = dmi_get_system_info(DMI_CHASSIS_TYPE);
-	if (chassis_type && !strcmp(chassis_type, "3"))
-		acpi_video_set_dmi_backlight_type(acpi_backlight_vendor);
-
 	if (asus->driver->quirks->wmi_backlight_power)
 		acpi_video_set_dmi_backlight_type(acpi_backlight_vendor);
 
-- 
2.37.2

