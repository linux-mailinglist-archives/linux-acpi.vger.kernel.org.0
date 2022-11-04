Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D7861A33D
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Nov 2022 22:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbiKDVWQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Nov 2022 17:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiKDVWP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Nov 2022 17:22:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1113CF61
        for <linux-acpi@vger.kernel.org>; Fri,  4 Nov 2022 14:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667596877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IQbR6gyty1fM3jP+WE1e2ZovFB+ndgkE5PlVrnSA5K0=;
        b=ZucYLdX3VVYjByMrpLMtF1SbLL0BlRGvlWbq42VRW7AMSJR4pxrx7o7krsGhz2vOhNxlGJ
        VYi7C9z5ncIY8ImZH5UUCChJuLkK1A04belmu1nYru9t4r98tAU6oIPyyta5CSraWeCR8E
        26Q+USGl2ob9nftK3072uvOU3KhnEK4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-591-C2zJI3pZPCOmxJ-J_V4Jqw-1; Fri, 04 Nov 2022 17:21:13 -0400
X-MC-Unique: C2zJI3pZPCOmxJ-J_V4Jqw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 69E1E3816EAD;
        Fri,  4 Nov 2022 21:21:13 +0000 (UTC)
Received: from x1.nl (unknown [10.39.192.41])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2E3D02022EA2;
        Fri,  4 Nov 2022 21:21:11 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        linux-acpi@vger.kernel.org,
        "Mr . Chromebox" <mrchromebox@gmail.com>
Subject: [PATCH 1/3] ACPI: video: Improve Chromebook checks
Date:   Fri,  4 Nov 2022 22:21:06 +0100
Message-Id: <20221104212108.73537-2-hdegoede@redhat.com>
In-Reply-To: <20221104212108.73537-1-hdegoede@redhat.com>
References: <20221104212108.73537-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

2 improvements for the Chromebook handling in
acpi_video_get_backlight_type():

1. Also check for the "GOOG000C" ACPI HID used on some models
2. Move the Chromebook check to above the ACPI-video check normally
   Chromebooks don't have ACPI video backlight support, but when
   flashed with upstream coreboot builds they may have ACPI video
   backlight support, but native should still be used/preferred then.

Suggested-by: Mr. Chromebox <mrchromebox@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/video_detect.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 9cd8797d12bb..06aaec2e378b 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -670,7 +670,7 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 
 static bool google_cros_ec_present(void)
 {
-	return acpi_dev_found("GOOG0004");
+	return acpi_dev_found("GOOG0004") || acpi_dev_found("GOOG000C");
 }
 
 /*
@@ -718,6 +718,10 @@ static enum acpi_backlight_type __acpi_video_get_backlight_type(bool native)
 	if (apple_gmux_present())
 		return acpi_backlight_apple_gmux;
 
+	/* Chromebooks should always prefer native backlight control. */
+	if (google_cros_ec_present() && native_available)
+		return acpi_backlight_native;
+
 	/* On systems with ACPI video use either native or ACPI video. */
 	if (video_caps & ACPI_VIDEO_BACKLIGHT) {
 		/*
@@ -735,13 +739,6 @@ static enum acpi_backlight_type __acpi_video_get_backlight_type(bool native)
 			return acpi_backlight_video;
 	}
 
-	/*
-	 * Chromebooks that don't have backlight handle in ACPI table
-	 * are supposed to use native backlight if it's available.
-	 */
-	if (google_cros_ec_present() && native_available)
-		return acpi_backlight_native;
-
 	/* No ACPI video (old hw), use vendor specific fw methods. */
 	return acpi_backlight_vendor;
 }
-- 
2.37.3

