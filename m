Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66075ACE63
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Sep 2022 11:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238033AbiIEJA0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 5 Sep 2022 05:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238000AbiIEJAX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Sep 2022 05:00:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A04F1FCE7
        for <linux-acpi@vger.kernel.org>; Mon,  5 Sep 2022 02:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662368421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uxHQyd6PdA1wT3O9mX6MzXfPKPKJsoT9Pq+1RjqxKc0=;
        b=LNRWBHlJgKtmbCY3x0SC09V6+eUmT+Aho4BAL4Bcq+hVHmTFGC8h0ZQkdJPeeB8oPkAawq
        eFzy1xeF04JCzyJeIj8PxHQ4HAmHRndvHHkUvg5uyEHwvSciWDyYaC84ZaZyFeAJP4VMWH
        oUCo9dHgxx6LCix0ADW0MHu44tE3tJI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-373-Q7UfLr-dPY2q16P5Yn_oug-1; Mon, 05 Sep 2022 05:00:15 -0400
X-MC-Unique: Q7UfLr-dPY2q16P5Yn_oug-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 35A9C1C1BD22;
        Mon,  5 Sep 2022 09:00:15 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.195.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E5935C15BB3;
        Mon,  5 Sep 2022 09:00:12 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Mark Gross <mgross@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Arvid Norlander <lkml@vorpal.se>, linux-acpi@vger.kernel.org,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH 2/2] ACPI: video: Change disable_backlight_sysfs_if quirks to acpi_backlight=native
Date:   Mon,  5 Sep 2022 11:00:05 +0200
Message-Id: <20220905090005.333429-3-hdegoede@redhat.com>
In-Reply-To: <20220905090005.333429-1-hdegoede@redhat.com>
References: <20220905090005.333429-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Some Toshibas have a broken acpi-video interface for brightness control
and need a special firmware call on resume to turn the panel back on.
So far these have been using the disable_backlight_sysfs_if workaround
to deal with this.

The recent x86/acpi backlight refactoring has broken this workaround:
1. This workaround relies on acpi_video_get_backlight_type() returning
   acpi_video so that the acpi_video code actually runs; and
2. this relies on the actual native GPU driver to offer the sysfs
   backlight interface to userspace.

After the refactor this breaks since the native driver will no
longer register its backlight-device if acpi_video_get_backlight_type()
does not return native and making it return native breaks 1.

Keeping the acpi_video backlight handling on resume active, while not
using it to set the brightness, is necessary because it does a _BCM
call on resume which is necessary to turn the panel back on on resume.

Looking at the DSDT shows that this _BCM call results in a Toshiba
HCI_SET HCI_LCD_BRIGHTNESS call, which turns the panel back on.

This kind of special vendor specific handling really belongs in
the vendor specific acpi driver. An earlier patch in this series
modifies toshiba_acpi to make the necessary HCI_SET call on resume
on affected models.

With toshiba_acpi taking care of the HCI_SET call on resume,
the acpi_video code no longer needs to call _BCM on resume.

So instead of using the (now broken) disable_backlight_sysfs_if
workaround, simply setting acpi_backlight=native to disable
the broken apci-video interface is sufficient fix things now.

After this there are no more users of the disable_backlight_sysfs_if
flag and as discussed above the flag also no longer works as intended,
so remove the disable_backlight_sysfs_if flag entirely.

Fixes: b1d36e73cc1c ("drm/i915: Don't register backlight when another backlight should be used (v2)")
Tested-by: Arvid Norlander <lkml@vorpal.se>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/acpi_video.c   | 48 -------------------------------------
 drivers/acpi/video_detect.c | 35 +++++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 48 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index a7c3d11e0dac..99894fbcf4e3 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -47,9 +47,6 @@ module_param(brightness_switch_enabled, bool, 0644);
 static bool allow_duplicates;
 module_param(allow_duplicates, bool, 0644);
 
-static int disable_backlight_sysfs_if = -1;
-module_param(disable_backlight_sysfs_if, int, 0444);
-
 #define REPORT_OUTPUT_KEY_EVENTS		0x01
 #define REPORT_BRIGHTNESS_KEY_EVENTS		0x02
 static int report_key_events = -1;
@@ -394,14 +391,6 @@ static int video_set_bqc_offset(const struct dmi_system_id *d)
 	return 0;
 }
 
-static int video_disable_backlight_sysfs_if(
-	const struct dmi_system_id *d)
-{
-	if (disable_backlight_sysfs_if == -1)
-		disable_backlight_sysfs_if = 1;
-	return 0;
-}
-
 static int video_set_device_id_scheme(const struct dmi_system_id *d)
 {
 	device_id_scheme = true;
@@ -474,40 +463,6 @@ static const struct dmi_system_id video_dmi_table[] = {
 		},
 	},
 
-	/*
-	 * Some machines have a broken acpi-video interface for brightness
-	 * control, but still need an acpi_video_device_lcd_set_level() call
-	 * on resume to turn the backlight power on.  We Enable backlight
-	 * control on these systems, but do not register a backlight sysfs
-	 * as brightness control does not work.
-	 */
-	{
-	 /* https://bugzilla.kernel.org/show_bug.cgi?id=21012 */
-	 .callback = video_disable_backlight_sysfs_if,
-	 .ident = "Toshiba Portege R700",
-	 .matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
-		DMI_MATCH(DMI_PRODUCT_NAME, "PORTEGE R700"),
-		},
-	},
-	{
-	 /* https://bugs.freedesktop.org/show_bug.cgi?id=82634 */
-	 .callback = video_disable_backlight_sysfs_if,
-	 .ident = "Toshiba Portege R830",
-	 .matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
-		DMI_MATCH(DMI_PRODUCT_NAME, "PORTEGE R830"),
-		},
-	},
-	{
-	 /* https://bugzilla.kernel.org/show_bug.cgi?id=21012 */
-	 .callback = video_disable_backlight_sysfs_if,
-	 .ident = "Toshiba Satellite R830",
-	 .matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
-		DMI_MATCH(DMI_PRODUCT_NAME, "SATELLITE R830"),
-		},
-	},
 	/*
 	 * Some machine's _DOD IDs don't have bit 31(Device ID Scheme) set
 	 * but the IDs actually follow the Device ID Scheme.
@@ -1770,9 +1725,6 @@ static void acpi_video_dev_register_backlight(struct acpi_video_device *device)
 	if (result)
 		return;
 
-	if (disable_backlight_sysfs_if > 0)
-		return;
-
 	name = kasprintf(GFP_KERNEL, "acpi_video%d", count);
 	if (!name)
 		return;
diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index db2474fe58ac..0d9064a9804c 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -610,6 +610,41 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		},
 	},
 
+	/*
+	 * These Toshibas have a broken acpi-video interface for brightness
+	 * control. They also have an issue where the panel is off after
+	 * suspend until a special firmware call is made to turn it back
+	 * on. This is handled by the toshiba_acpi kernel module, so that
+	 * module must be enabled for these models to work correctly.
+	 */
+	{
+	 /* https://bugzilla.kernel.org/show_bug.cgi?id=21012 */
+	 .callback = video_detect_force_native,
+	 /* Toshiba Portégé R700 */
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "PORTEGE R700"),
+		},
+	},
+	{
+	 /* Portégé: https://bugs.freedesktop.org/show_bug.cgi?id=82634 */
+	 /* Satellite: https://bugzilla.kernel.org/show_bug.cgi?id=21012 */
+	 .callback = video_detect_force_native,
+	 /* Toshiba Satellite/Portégé R830 */
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "R830"),
+		},
+	},
+	{
+	 .callback = video_detect_force_native,
+	 /* Toshiba Satellite/Portégé Z830 */
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "Z830"),
+		},
+	},
+
 	/*
 	 * Desktops which falsely report a backlight and which our heuristics
 	 * for this do not catch.
-- 
2.36.1

