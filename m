Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F666598BCA
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Aug 2022 20:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344917AbiHRSpd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 18 Aug 2022 14:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345471AbiHRSo7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Aug 2022 14:44:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33F8BA9DB
        for <linux-acpi@vger.kernel.org>; Thu, 18 Aug 2022 11:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660848298;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RAgFYE2wIOC+L0ShaxbDIGk5W0n1hVBowVTc99T+JT8=;
        b=F9FPWtIaSMs2yb3bePTtGb3zd5ZwbxwjuDmt2CQajuJF80VTXZkv3C5TVtetxU0iV2VjXt
        gIK90qqQF7i0vtqmv0978nuOA/UOjozhpsVruY7Gzh5EH5hq4QsH/F5lyfCuHaznDYpSkn
        btVYAA7Vju+XBtjF/eBH5FcfmJUoHAg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-203-2czJgbVIObeZLRcCai-gPA-1; Thu, 18 Aug 2022 14:44:51 -0400
X-MC-Unique: 2czJgbVIObeZLRcCai-gPA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ED6D83815D2F;
        Thu, 18 Aug 2022 18:44:49 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3ED89492C3B;
        Thu, 18 Aug 2022 18:44:46 +0000 (UTC)
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
Subject: [PATCH v3 24/31] platform/x86: asus-wmi: Move acpi_backlight=vendor quirks to ACPI video_detect.c
Date:   Thu, 18 Aug 2022 20:42:55 +0200
Message-Id: <20220818184302.10051-25-hdegoede@redhat.com>
In-Reply-To: <20220818184302.10051-1-hdegoede@redhat.com>
References: <20220818184302.10051-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Remove the asus-wmi quirk_entry.wmi_backlight_power quirk-flag, which
called acpi_video_set_dmi_backlight_type(acpi_backlight_vendor) and replace
it with acpi/video_detect.c video_detect_dmi_table[] entries using the
video_detect_force_vendor callback.

acpi_video_set_dmi_backlight_type() is troublesome because it may end up
getting called after other backlight drivers have already called
acpi_video_get_backlight_type() resulting in the other drivers
already being registered even though they should not.

Note no entries are dropped from the dmi_system_id table in asus-nb-wmi.c.
This is because the entries using the removed wmi_backlight_power flag
also use other model specific quirks from the asus-wmi quirk_entry struct.
So the quirk_asus_x55u struct and the entries pointing to it cannot be
dropped.

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/video_detect.c        | 40 ++++++++++++++++++++++++++++++
 drivers/platform/x86/asus-nb-wmi.c |  7 ------
 drivers/platform/x86/asus-wmi.c    |  3 ---
 drivers/platform/x86/asus-wmi.h    |  1 -
 drivers/platform/x86/eeepc-wmi.c   | 25 +------------------
 5 files changed, 41 insertions(+), 35 deletions(-)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 4545f9f1a5b1..1574ff837e31 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -174,6 +174,46 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "UL30A"),
 		},
 	},
+	{
+	 .callback = video_detect_force_vendor,
+	 /* Asus X55U */
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "X55U"),
+		},
+	},
+	{
+	 .callback = video_detect_force_vendor,
+	 /* Asus X101CH */
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "X101CH"),
+		},
+	},
+	{
+	 .callback = video_detect_force_vendor,
+	 /* Asus X401U */
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "X401U"),
+		},
+	},
+	{
+	 .callback = video_detect_force_vendor,
+	 /* Asus X501U */
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "X501U"),
+		},
+	},
+	{
+	 .callback = video_detect_force_vendor,
+	 /* Asus 1015CX */
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "1015CX"),
+		},
+	},
 	{
 	.callback = video_detect_force_vendor,
 	/* GIGABYTE GB-BXBT-2807 */
diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
index 478dd300b9c9..810a94557a85 100644
--- a/drivers/platform/x86/asus-nb-wmi.c
+++ b/drivers/platform/x86/asus-nb-wmi.c
@@ -79,12 +79,10 @@ static struct quirk_entry quirk_asus_q500a = {
 
 /*
  * For those machines that need software to control bt/wifi status
- * and can't adjust brightness through ACPI interface
  * and have duplicate events(ACPI and WMI) for display toggle
  */
 static struct quirk_entry quirk_asus_x55u = {
 	.wapf = 4,
-	.wmi_backlight_power = true,
 	.wmi_backlight_set_devstate = true,
 	.no_display_toggle = true,
 };
@@ -147,11 +145,6 @@ static const struct dmi_system_id asus_quirks[] = {
 			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK Computer Inc."),
 			DMI_MATCH(DMI_PRODUCT_NAME, "U32U"),
 		},
-		/*
-		 * Note this machine has a Brazos APU, and most Brazos Asus
-		 * machines need quirk_asus_x55u / wmi_backlight_power but
-		 * here acpi-video seems to work fine for backlight control.
-		 */
 		.driver_data = &quirk_asus_wapf4,
 	},
 	{
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 301166a5697d..5cf9d9aff164 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -3634,9 +3634,6 @@ static int asus_wmi_add(struct platform_device *pdev)
 	if (asus->driver->quirks->wmi_force_als_set)
 		asus_wmi_set_als();
 
-	if (asus->driver->quirks->wmi_backlight_power)
-		acpi_video_set_dmi_backlight_type(acpi_backlight_vendor);
-
 	if (asus->driver->quirks->wmi_backlight_native)
 		acpi_video_set_dmi_backlight_type(acpi_backlight_native);
 
diff --git a/drivers/platform/x86/asus-wmi.h b/drivers/platform/x86/asus-wmi.h
index b302415bf1d9..30770e411301 100644
--- a/drivers/platform/x86/asus-wmi.h
+++ b/drivers/platform/x86/asus-wmi.h
@@ -29,7 +29,6 @@ struct quirk_entry {
 	bool hotplug_wireless;
 	bool scalar_panel_brightness;
 	bool store_backlight_power;
-	bool wmi_backlight_power;
 	bool wmi_backlight_native;
 	bool wmi_backlight_set_devstate;
 	bool wmi_force_als_set;
diff --git a/drivers/platform/x86/eeepc-wmi.c b/drivers/platform/x86/eeepc-wmi.c
index ce86d84ee796..32d9f0ba6be3 100644
--- a/drivers/platform/x86/eeepc-wmi.c
+++ b/drivers/platform/x86/eeepc-wmi.c
@@ -96,11 +96,6 @@ static struct quirk_entry quirk_asus_et2012_type3 = {
 	.store_backlight_power = true,
 };
 
-static struct quirk_entry quirk_asus_x101ch = {
-	/* We need this when ACPI function doesn't do this well */
-	.wmi_backlight_power = true,
-};
-
 static struct quirk_entry *quirks;
 
 static void et2012_quirks(void)
@@ -151,25 +146,7 @@ static const struct dmi_system_id asus_quirks[] = {
 		},
 		.driver_data = &quirk_asus_unknown,
 	},
-	{
-		.callback = dmi_matched,
-		.ident = "ASUSTeK Computer INC. X101CH",
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "X101CH"),
-		},
-		.driver_data = &quirk_asus_x101ch,
-	},
-	{
-		.callback = dmi_matched,
-		.ident = "ASUSTeK Computer INC. 1015CX",
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "1015CX"),
-		},
-		.driver_data = &quirk_asus_x101ch,
-	},
-	{},
+	{}
 };
 
 static void eeepc_wmi_key_filter(struct asus_wmi_driver *asus_wmi, int *code,
-- 
2.37.2

