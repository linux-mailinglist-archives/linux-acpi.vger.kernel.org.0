Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4CDE5726A8
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Jul 2022 21:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233367AbiGLTt4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 Jul 2022 15:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbiGLTs2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Jul 2022 15:48:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2299EBD695
        for <linux-acpi@vger.kernel.org>; Tue, 12 Jul 2022 12:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657654880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y34Q3N/bQs0itC/FjZw5bLtjtq7vmwvRei4ZyvBO8U0=;
        b=dF43P/SuvEb5Hrzo3IrTT8IMiEObogSJwNpz+GWAVEtXiPq8Y/YUNg89P4SuYH+mDu8VPR
        Tj+FMvE4RokKyJoyXshBMXY4iqpu2pIW1jCGrS5xZwW8ZiUdA5kRuelO2pi5YHopw0pT1s
        CBM8ZFWcqXMvJLnf8JC2hpl8/AKQjLo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-312-kVyREIDlM92mySOrfLIbXA-1; Tue, 12 Jul 2022 15:41:16 -0400
X-MC-Unique: kVyREIDlM92mySOrfLIbXA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8A450299E767;
        Tue, 12 Jul 2022 19:41:15 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DB1E240E80E0;
        Tue, 12 Jul 2022 19:41:11 +0000 (UTC)
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
Subject: [PATCH v2 28/29] ACPI: video: Fix indentation of video_detect_dmi_table[] entries
Date:   Tue, 12 Jul 2022 21:39:09 +0200
Message-Id: <20220712193910.439171-29-hdegoede@redhat.com>
In-Reply-To: <20220712193910.439171-1-hdegoede@redhat.com>
References: <20220712193910.439171-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The video_detect_dmi_table[] uses an unusual indentation for
before the ".name = ..." named struct initializers.

Instead of being indented with an extra tab compared to
the previous line's '{' these are indented to with only
a single space to allow for long DMI_MATCH() lines without
wrapping.

But over time some entries did not event have the single space
indent in front of the ".name = ..." lines.

Make things consistent by using a single space indent for these
lines everywhere.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/video_detect.c | 48 ++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 4b9395d1bda7..60d6fb056cac 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -140,17 +140,17 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		},
 	},
 	{
-	.callback = video_detect_force_vendor,
-	/* Asus UL30VT */
-	.matches = {
+	 .callback = video_detect_force_vendor,
+	 /* Asus UL30VT */
+	 .matches = {
 		DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK Computer Inc."),
 		DMI_MATCH(DMI_PRODUCT_NAME, "UL30VT"),
 		},
 	},
 	{
-	.callback = video_detect_force_vendor,
-	/* Asus UL30A */
-	.matches = {
+	 .callback = video_detect_force_vendor,
+	 /* Asus UL30A */
+	 .matches = {
 		DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK Computer Inc."),
 		DMI_MATCH(DMI_PRODUCT_NAME, "UL30A"),
 		},
@@ -196,9 +196,9 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		},
 	},
 	{
-	.callback = video_detect_force_vendor,
-	/* GIGABYTE GB-BXBT-2807 */
-	.matches = {
+	 .callback = video_detect_force_vendor,
+	 /* GIGABYTE GB-BXBT-2807 */
+	 .matches = {
 		DMI_MATCH(DMI_SYS_VENDOR, "GIGABYTE"),
 		DMI_MATCH(DMI_PRODUCT_NAME, "GB-BXBT-2807"),
 		},
@@ -231,17 +231,17 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		},
 	},
 	{
-	.callback = video_detect_force_vendor,
-	/* Sony VPCEH3U1E */
-	.matches = {
+	 .callback = video_detect_force_vendor,
+	 /* Sony VPCEH3U1E */
+	 .matches = {
 		DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
 		DMI_MATCH(DMI_PRODUCT_NAME, "VPCEH3U1E"),
 		},
 	},
 	{
-	.callback = video_detect_force_vendor,
-	/* Xiaomi Mi Pad 2 */
-	.matches = {
+	 .callback = video_detect_force_vendor,
+	 /* Xiaomi Mi Pad 2 */
+	 .matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Xiaomi Inc"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "Mipad2"),
 		},
@@ -541,25 +541,25 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		},
 	},
 	{
-	.callback = video_detect_force_native,
-	/* ASUSTeK COMPUTER INC. GA401 */
-	.matches = {
+	 .callback = video_detect_force_native,
+	 /* ASUSTeK COMPUTER INC. GA401 */
+	 .matches = {
 		DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
 		DMI_MATCH(DMI_PRODUCT_NAME, "GA401"),
 		},
 	},
 	{
-	.callback = video_detect_force_native,
-	/* ASUSTeK COMPUTER INC. GA502 */
-	.matches = {
+	 .callback = video_detect_force_native,
+	 /* ASUSTeK COMPUTER INC. GA502 */
+	 .matches = {
 		DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
 		DMI_MATCH(DMI_PRODUCT_NAME, "GA502"),
 		},
 	},
 	{
-	.callback = video_detect_force_native,
-	/* ASUSTeK COMPUTER INC. GA503 */
-	.matches = {
+	 .callback = video_detect_force_native,
+	 /* ASUSTeK COMPUTER INC. GA503 */
+	 .matches = {
 		DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
 		DMI_MATCH(DMI_PRODUCT_NAME, "GA503"),
 		},
-- 
2.36.0

