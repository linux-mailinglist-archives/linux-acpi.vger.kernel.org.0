Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05DCD677A43
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Jan 2023 12:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbjAWLiu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 23 Jan 2023 06:38:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbjAWLit (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Jan 2023 06:38:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D5313528
        for <linux-acpi@vger.kernel.org>; Mon, 23 Jan 2023 03:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674473883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MNzc25uGL7BsCYJpNSpdvNknf+ICKTyzCI2BrVBa1nY=;
        b=cnFL7woKlfLrCWN0m8aaOKdl3vu2M/F3wEwxPbbjuxxMLM/beBdYOl09M0ScSC7TSl1Ptd
        46mNZ47X8epArS06w2tmgiBk+77UgVpkcdi+K6MJBuT5OmDd2usc5gOX3j6fgvYmksEuhf
        LIwu9qgihrIpcajCAKmvCKRs56j4jII=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-588-clU8VTfhNrKGNHmsz_RwZQ-1; Mon, 23 Jan 2023 06:38:00 -0500
X-MC-Unique: clU8VTfhNrKGNHmsz_RwZQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8FBA01C04333;
        Mon, 23 Jan 2023 11:37:59 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.194.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9F978175A2;
        Mon, 23 Jan 2023 11:37:57 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Aditya Garg <gargaditya08@live.com>,
        Mark Gross <mgross@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Lukas Wunner <lukas@wunner.de>, linux-acpi@vger.kernel.org,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH 3/3] ACPI: video: Fix apple gmux detection
Date:   Mon, 23 Jan 2023 12:37:50 +0100
Message-Id: <20230123113750.462144-4-hdegoede@redhat.com>
In-Reply-To: <20230123113750.462144-1-hdegoede@redhat.com>
References: <20230123113750.462144-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Some apple laptop models have an ACPI device with a HID of APP000B
and that device has an IO resource (so it does not describe the new
unsupported MMIO based gmux type), but there actually is no gmux
in the laptop at all.

The gmux_probe() function of the actual apple-gmux driver has code
to detect this, this code has been factored out into a new
apple_gmux_detect() helper in apple-gmux.h.

Use this new function to fix acpi_video_get_backlight_type() wrongly
returning apple_gmux as type on these new laptops.

Fixes: 21245df307cb ("ACPI: video: Add Apple GMUX brightness control detection")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/video_detect.c | 24 +++---------------------
 1 file changed, 3 insertions(+), 21 deletions(-)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 64eab35037c3..a8c02608dde4 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -110,26 +110,6 @@ static bool nvidia_wmi_ec_supported(void)
 }
 #endif
 
-static bool apple_gmux_backlight_present(void)
-{
-	struct acpi_device *adev;
-	struct device *dev;
-
-	adev = acpi_dev_get_first_match_dev(GMUX_ACPI_HID, NULL, -1);
-	if (!adev)
-		return false;
-
-	dev = acpi_get_first_physical_node(adev);
-	if (!dev)
-		return false;
-
-	/*
-	 * drivers/platform/x86/apple-gmux.c only supports old style
-	 * Apple GMUX with an IO-resource.
-	 */
-	return pnp_get_resource(to_pnp_dev(dev), IORESOURCE_IO, 0) != NULL;
-}
-
 /* Force to use vendor driver when the ACPI device is known to be
  * buggy */
 static int video_detect_force_vendor(const struct dmi_system_id *d)
@@ -791,6 +771,7 @@ static enum acpi_backlight_type __acpi_video_get_backlight_type(bool native)
 {
 	static DEFINE_MUTEX(init_mutex);
 	static bool nvidia_wmi_ec_present;
+	static bool apple_gmux_present;
 	static bool native_available;
 	static bool init_done;
 	static long video_caps;
@@ -804,6 +785,7 @@ static enum acpi_backlight_type __acpi_video_get_backlight_type(bool native)
 				    ACPI_UINT32_MAX, find_video, NULL,
 				    &video_caps, NULL);
 		nvidia_wmi_ec_present = nvidia_wmi_ec_supported();
+		apple_gmux_present = apple_gmux_detect(NULL, NULL);
 		init_done = true;
 	}
 	if (native)
@@ -825,7 +807,7 @@ static enum acpi_backlight_type __acpi_video_get_backlight_type(bool native)
 	if (nvidia_wmi_ec_present)
 		return acpi_backlight_nvidia_wmi_ec;
 
-	if (apple_gmux_backlight_present())
+	if (apple_gmux_present)
 		return acpi_backlight_apple_gmux;
 
 	/* Use ACPI video if available, except when native should be preferred. */
-- 
2.39.0

