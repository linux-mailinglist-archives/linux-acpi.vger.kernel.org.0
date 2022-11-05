Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1024661DB3D
	for <lists+linux-acpi@lfdr.de>; Sat,  5 Nov 2022 15:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbiKEOyH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 5 Nov 2022 10:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiKEOyG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 5 Nov 2022 10:54:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13C0FCC5
        for <linux-acpi@vger.kernel.org>; Sat,  5 Nov 2022 07:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667659986;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eBC4aHazCnxNLm1iZrJja+2qlVXqVXC8eSWuLhGRw4g=;
        b=BReuKmIDcmd/0jlPA7DO/zlYf/4Sa15qh3KsX4cq2ga+bB/e3laxPVMjuW4IcfRnv7eSLv
        hiNQV79CfNcjrpcE6gRJmrXvJiHNUzbqSHdTg7PEmVAQYE8Ch2EtfLyhsOH+3KrpPi6VIC
        FLMbobHCdXkg6YTTzWRFmkUloHLSK+c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-617-UF5NwfGYNZyWNyP51hb1fg-1; Sat, 05 Nov 2022 10:53:03 -0400
X-MC-Unique: UF5NwfGYNZyWNyP51hb1fg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5793C85A583;
        Sat,  5 Nov 2022 14:53:03 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.69])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8322A477F5E;
        Sat,  5 Nov 2022 14:53:02 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Subject: [RFC 1/2] ACPI: video: Simplify __acpi_video_get_backlight_type()
Date:   Sat,  5 Nov 2022 15:52:57 +0100
Message-Id: <20221105145258.12700-2-hdegoede@redhat.com>
In-Reply-To: <20221105145258.12700-1-hdegoede@redhat.com>
References: <20221105145258.12700-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Simplify __acpi_video_get_backlight_type() removing a nested if which
makes the flow harder to follow.

This also results in having only 1 exit point with
return acpi_backlight_native instead of 2.

Note this drops the (video_caps & ACPI_VIDEO_BACKLIGHT) check from
the if (acpi_osi_is_win8() && native_available) return native path.
Windows 8's hardware certification requirements include that there must
be ACPI video bus backlight control, so the ACPI_VIDEO_BACKLIGHT check
is redundant.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/video_detect.c | 36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index b2a616287638..ec7421a3986f 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -687,6 +687,16 @@ static bool google_cros_ec_present(void)
 	return acpi_dev_found("GOOG0004") || acpi_dev_found("GOOG000C");
 }
 
+/*
+ * Windows 8 and newer no longer use the ACPI video interface, so it often
+ * does not work. So on win8+ systems prefer native brightness control.
+ * Chromebooks should always prefer native backlight control.
+ */
+static bool prefer_native_over_acpi_video(void)
+{
+	return acpi_osi_is_win8() || google_cros_ec_present();
+}
+
 /*
  * Determine which type of backlight interface to use on this system,
  * First check cmdline, then dmi quirks, then do autodetect.
@@ -732,26 +742,14 @@ static enum acpi_backlight_type __acpi_video_get_backlight_type(bool native)
 	if (apple_gmux_present())
 		return acpi_backlight_apple_gmux;
 
-	/* Chromebooks should always prefer native backlight control. */
-	if (google_cros_ec_present() && native_available)
-		return acpi_backlight_native;
+	/* Use ACPI video if available, except when native should be preferred. */
+	if ((video_caps & ACPI_VIDEO_BACKLIGHT) &&
+	     !(native_available && prefer_native_over_acpi_video()))
+		return acpi_backlight_video;
 
-	/* On systems with ACPI video use either native or ACPI video. */
-	if (video_caps & ACPI_VIDEO_BACKLIGHT) {
-		/*
-		 * Windows 8 and newer no longer use the ACPI video interface,
-		 * so it often does not work. If the ACPI tables are written
-		 * for win8 and native brightness ctl is available, use that.
-		 *
-		 * The native check deliberately is inside the if acpi-video
-		 * block on older devices without acpi-video support native
-		 * is usually not the best choice.
-		 */
-		if (acpi_osi_is_win8() && native_available)
-			return acpi_backlight_native;
-		else
-			return acpi_backlight_video;
-	}
+	/* Use native if available */
+	if (native_available && prefer_native_over_acpi_video())
+		return acpi_backlight_native;
 
 	/* No ACPI video (old hw), use vendor specific fw methods. */
 	return acpi_backlight_vendor;
-- 
2.37.3

