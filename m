Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC68C62831F
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Nov 2022 15:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235636AbiKNOqz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 14 Nov 2022 09:46:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235697AbiKNOqn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Nov 2022 09:46:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEAD5E21
        for <linux-acpi@vger.kernel.org>; Mon, 14 Nov 2022 06:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668437118;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TvY9w8CYZaac4npN7JxtQrCbvWhms6Flr5tbiuBECqw=;
        b=LzJ27qEBLe5V63msdj4bykq/Vho4XU8jZc1E9XzUUXMBUf1gi+8UrkDZdBdZmD02qqLYwG
        XvVcNumyLFixRc+sjkRu9an4ChF8/eWgLXbZVa1ETIm0YS0PqF34/uyJe04kUhhpwxMVxK
        qlabEUlcQcW+YaaFK5M4zoD+6vKefrQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-546-TR8JUTGYPa-foAHfK2U3jQ-1; Mon, 14 Nov 2022 09:45:16 -0500
X-MC-Unique: TR8JUTGYPa-foAHfK2U3jQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3EA772A2AD4A;
        Mon, 14 Nov 2022 14:45:16 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.193.154])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 449D41415134;
        Mon, 14 Nov 2022 14:45:15 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        linux-acpi@vger.kernel.org
Subject: [PATCH 7/7] ACPI: video: Prefer native over vendor
Date:   Mon, 14 Nov 2022 15:44:59 +0100
Message-Id: <20221114144459.455519-8-hdegoede@redhat.com>
In-Reply-To: <20221114144459.455519-1-hdegoede@redhat.com>
References: <20221114144459.455519-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index 5da6b1b449d5..a934bbc9dd37 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -776,10 +776,10 @@ static enum acpi_backlight_type __acpi_video_get_backlight_type(bool native)
 		return acpi_backlight_video;
 
 	/* Use native if available */
-	if (native_available && prefer_native_over_acpi_video())
+	if (native_available)
 		return acpi_backlight_native;
 
-	/* No ACPI video (old hw), use vendor specific fw methods. */
+	/* No ACPI video/native (old hw), use vendor specific fw methods. */
 	return acpi_backlight_vendor;
 }
 
@@ -791,18 +791,6 @@ EXPORT_SYMBOL(acpi_video_get_backlight_type);
 
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

