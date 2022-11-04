Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A70161A33F
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Nov 2022 22:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiKDVWU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Nov 2022 17:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiKDVWR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Nov 2022 17:22:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99C26402
        for <linux-acpi@vger.kernel.org>; Fri,  4 Nov 2022 14:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667596879;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r6WCBUlGuzKPRwbKs5N8I4ZTyzJcWrkTNmEe9sIorhs=;
        b=Jp7BFvgIQeA42O3vfe+3B/c9Q/1T1u7O03G9wAMs68g+Su3GIp1TZ+nIVX+JlAWbQpw2bm
        AvhDdb4iAJ2JgjoBvKF5WZLrJjWcWCwPLw6tiJ7hOdfYKMt0Sye2/GlpCyceRXOoKqJGJv
        +yagYYfTwUj6BLh2ZNB1PqwJCS/EEb8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-621-k0_X-SODPYGBhh8bjgLV2w-1; Fri, 04 Nov 2022 17:21:16 -0400
X-MC-Unique: k0_X-SODPYGBhh8bjgLV2w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 17B65185A78F;
        Fri,  4 Nov 2022 21:21:16 +0000 (UTC)
Received: from x1.nl (unknown [10.39.192.41])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CAF0A2022EA2;
        Fri,  4 Nov 2022 21:21:13 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        linux-acpi@vger.kernel.org, Iris <pawel.js@protonmail.com>,
        John Warriner <taijitu@cox.net>,
        Scott Ostrander <sos12_3@hotmail.com>,
        Matthias Rampke <matthias.rampke@googlemail.com>
Subject: [PATCH 2/3] ACPI: video: Make acpi_video_backlight_use_native() always return true
Date:   Fri,  4 Nov 2022 22:21:07 +0100
Message-Id: <20221104212108.73537-3-hdegoede@redhat.com>
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

Testing has shown that there are quite a few laptop models which rely
on native backlight control and which do not support ACPI video bus
backlight control, causing __acpi_video_get_backlight_type() to return
vendor. Known Windows laptop models affected by this are:

Acer Aspire 1640
HP Compaq nc6120
IBM ThinkPad X40
System76 Starling Star1

and the following MacBook models are affected too:

Apple MacBook 2.1
Apple MacBook 4.1
Apple MacBook Pro 7.1

the list of affected Windows laptop models is likely just the top of
the iceberg. So for now lets undo the change to not register native
backlight class devices when __acpi_video_get_backlight_type() != native.

Since as part of the backlight-detect refactor the detection code now
relies on the GPU drivers calling acpi_video_backlight_use_native() to
learn that native backlight support is available we cannot just remove
the acpi_video_backlight_use_native() calls from the GPU drivers.

Instead modify acpi_video_backlight_use_native() to always return true
for now. This is meant as a temporary work-around, which will be removed
again when the heuristics from __acpi_video_get_backlight_type() have
been improved so that they will return native on affected models.

Reported-by: Matthew Garrett <mjg59@srcf.ucam.org>
Reported-by: Iris <pawel.js@protonmail.com>
Reported-by: John Warriner <taijitu@cox.net>
Reported-by: Scott Ostrander <sos12_3@hotmail.com>
Reported-by: Matthias Rampke <matthias.rampke@googlemail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/video_detect.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 06aaec2e378b..c02e960cdbe3 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -751,6 +751,18 @@ EXPORT_SYMBOL(acpi_video_get_backlight_type);
 
 bool acpi_video_backlight_use_native(void)
 {
-	return __acpi_video_get_backlight_type(true) == acpi_backlight_native;
+	/*
+	 * Call __acpi_video_get_backlight_type() to let it know that
+	 * a native backlight is available.
+	 */
+	__acpi_video_get_backlight_type(true);
+
+	/*
+	 * For now just always return true. There is a whole bunch of laptop
+	 * models where (video_caps & ACPI_VIDEO_BACKLIGHT) is false causing
+	 * __acpi_video_get_backlight_type() to return vendor, while these
+	 * models only have a native backlight control.
+	 */
+	return true;
 }
 EXPORT_SYMBOL(acpi_video_backlight_use_native);
-- 
2.37.3

