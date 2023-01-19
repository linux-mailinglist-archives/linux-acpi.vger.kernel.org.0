Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 903D8673FD7
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Jan 2023 18:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjASRZi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 19 Jan 2023 12:25:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjASRZh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Jan 2023 12:25:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90869798F9
        for <linux-acpi@vger.kernel.org>; Thu, 19 Jan 2023 09:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674149092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qUbE87rNCTKmfloRnEjFyKB0W2RvyZ90tu9oPE9S/V8=;
        b=LlcLGK4oTJTXCkuOa2X6/bSUnwvAkObVp5AOzHL7paIC9d66NIsWVCbeWZ8x6Xiw422PbS
        oU9Pn8IklfG6Oj8CXRq8qKft8W6lePYlyA2I/GJCVseyfenYqGJUkwPsk6gwzjD2pHqnpm
        LvD9et5ImoycGE1jQ1VxWk/pEi6FARc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-606-AvMF23_sOjGR8O5JoZaSLw-1; Thu, 19 Jan 2023 12:24:51 -0500
X-MC-Unique: AvMF23_sOjGR8O5JoZaSLw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 25F1B3C10EDD;
        Thu, 19 Jan 2023 17:24:51 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.194.158])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 43AF52026D68;
        Thu, 19 Jan 2023 17:24:50 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH] ACPI: video: Add backlight=native DMI quirk for Asus U46E
Date:   Thu, 19 Jan 2023 18:24:41 +0100
Message-Id: <20230119172441.623918-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The Asus U46E backlight tables have a set of interesting problems:

1. Its ACPI tables do make _OSI ("Windows 2012") checks, so
   acpi_osi_is_win8() should return true.

   But the tables have 2 sets of _OSI calls, one from the usual global
   _INI method setting a global OSYS variable and a second set of _OSI
   calls from a MSOS method and the MSOS method is the only one calling
   _OSI ("Windows 2012").

   The MSOS method only gets called in the following cases:
   1. From some Asus specific WMI methods
   2. From _DOD, which only runs after acpi_video_get_backlight_type()
      has already been called by the i915 driver
   3. From other ACPI video bus methods which never run (see below)
   4. From some EC query callbacks

   So when i915 calls acpi_video_get_backlight_type() MSOS has never run
   and acpi_osi_is_win8() returns false, so acpi_video_get_backlight_type()
   returns acpi_video as the desired backlight type, which causes
   the intel_backlight device to not register.

2. _DOD effectively does this:

                    Return (Package (0x01)
                    {
                        0x0400
                    })

   causing acpi_video_device_in_dod() to return false, which causes
   the acpi_video backlight device to not register.

Leaving the user with no backlight device at all. Note that before 6.1.y
the i915 driver would register the intel_backlight device unconditionally
and since that then was the only backlight device userspace would use that.

Add a backlight=native DMI quirk for this special laptop to restore
the old (and working) behavior of the intel_backlight device registering.

Fixes: fb1836c91317 ("ACPI: video: Prefer native over vendor")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/video_detect.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index aa6196e5e574..64eab35037c3 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -610,6 +610,14 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "GA503"),
 		},
 	},
+	{
+	 .callback = video_detect_force_native,
+	 /* Asus U46E */
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK Computer Inc."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "U46E"),
+		},
+	},
 	{
 	 .callback = video_detect_force_native,
 	 /* Asus UX303UB */
-- 
2.39.0

