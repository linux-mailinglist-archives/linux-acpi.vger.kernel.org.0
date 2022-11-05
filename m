Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB2261DB3E
	for <lists+linux-acpi@lfdr.de>; Sat,  5 Nov 2022 15:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiKEOyN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 5 Nov 2022 10:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiKEOyN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 5 Nov 2022 10:54:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75060FCC3
        for <linux-acpi@vger.kernel.org>; Sat,  5 Nov 2022 07:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667659993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7Cf2E+C2RWDKClUtjfj2eksiWms4XVAtVGQ8UjoyW5s=;
        b=Hzvq7yWDGHnTnl2qfOmLU9xEAmdo2VELxnHCgxYshHdHWSZRpWuYuQ90rW8JeiEfKJ3lzb
        KYyTdR31JRN8cpVjDLLF/o+09FsjcyoqccMkBC0MTG6uPwoBriaHJrIMOmTVJ50pfunwlu
        rNF/hb5p5J5kiKnNWb1z6Xw/gwF71G0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-365-4vlgDC7cMjOsY1CwAAiGNA-1; Sat, 05 Nov 2022 10:53:10 -0400
X-MC-Unique: 4vlgDC7cMjOsY1CwAAiGNA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0A532811E67;
        Sat,  5 Nov 2022 14:53:10 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.69])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8CFF2477F5E;
        Sat,  5 Nov 2022 14:53:03 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Subject: [RFC 2/2] ACPI: video: Prefer native over vendor
Date:   Sat,  5 Nov 2022 15:52:58 +0100
Message-Id: <20221105145258.12700-3-hdegoede@redhat.com>
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

When available prefer native backlight control over vendor backlight
control.

Testing has shown that there are quite a few laptop models which rely
on native backlight control (they don't have ACPI video bus backlight
control) and on which acpi_osi_is_win8() returns false.

Currently __acpi_video_get_backlight_type() returns vendor on these
laptops, leading to an empty /sys/class/backlight.

As a workaround for this acpi_video_backlight_use_native() has been
temporarily changed to always return true.

This re-introduces the problem of having multiple backlight
devices under /sys/class/backlight for a single panel.

Change __acpi_video_get_backlight_type() to prefer native over vendor
when available. So that it returns native on these models.

And change acpi_video_backlight_use_native() back to only return
true when __acpi_video_get_backlight_type() returns native.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/video_detect.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index ec7421a3986f..19e9bc25225d 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -748,10 +748,10 @@ static enum acpi_backlight_type __acpi_video_get_backlight_type(bool native)
 		return acpi_backlight_video;
 
 	/* Use native if available */
-	if (native_available && prefer_native_over_acpi_video())
+	if (native_available)
 		return acpi_backlight_native;
 
-	/* No ACPI video (old hw), use vendor specific fw methods. */
+	/* No ACPI video/native (old hw), use vendor specific fw methods. */
 	return acpi_backlight_vendor;
 }
 
@@ -763,18 +763,6 @@ EXPORT_SYMBOL(acpi_video_get_backlight_type);
 
 bool acpi_video_backlight_use_native(void)
 {
-	/*
-	 * Call __acpi_video_get_backlight_type() to let it know that
-	 * a native backlight is available.
-	 */
-	__acpi_video_get_backlight_type(true);
-
-	/*
-	 * For now just always return true. There is a whole bunch of laptop
-	 * models where (video_caps & ACPI_VIDEO_BACKLIGHT) is false causing
-	 * __acpi_video_get_backlight_type() to return vendor, while these
-	 * models only have a native backlight control.
-	 */
-	return true;
+	return __acpi_video_get_backlight_type(true) == acpi_backlight_native;
 }
 EXPORT_SYMBOL(acpi_video_backlight_use_native);
-- 
2.37.3

