Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 615F36F195B
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Apr 2023 15:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjD1NZd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 28 Apr 2023 09:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346195AbjD1NZ0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 28 Apr 2023 09:25:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04BD2112
        for <linux-acpi@vger.kernel.org>; Fri, 28 Apr 2023 06:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682688270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=q0j8ApBk/5KiG9NNL+y7EVM7pIGL8ft8WdoGVzfm8SE=;
        b=dofhWt+FY1o1IMixbjxuIoD542TltSHxZczXNnufyFbCGWquIGu555nxzV//Iti8xMsSUI
        gUZvIsag3cfuotTvl1h6qejymLqT5delTwhxQrGOvsZUECTy1B9DmOWM5QGlSVRREypU1i
        hxZ0HZCrAnWnc7VRFNJVmaPkUrDm9ik=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-92-UWh8I716P7mvm0Azhovmrw-1; Fri, 28 Apr 2023 09:24:16 -0400
X-MC-Unique: UWh8I716P7mvm0Azhovmrw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0886A10AF802;
        Fri, 28 Apr 2023 13:23:57 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.194.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 257681458896;
        Fri, 28 Apr 2023 13:23:56 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org,
        =?UTF-8?q?=D0=A0=D1=83=D1=81=D0=B5=D0=B2=20=D0=9F=D1=83=D1=82=D0=B8=D0=BD?= 
        <rockeraliexpress@gmail.com>, stable@vger.kernel.org,
        Daniel Dadap <ddadap@nvidia.com>
Subject: [PATCH] ACPI: video: Remove acpi_backlight=video quirk for Lenovo ThinkPad W530
Date:   Fri, 28 Apr 2023 15:23:50 +0200
Message-Id: <20230428132350.49373-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Remove the acpi_backlight=video quirk for Lenovo ThinkPad W530.

This was intended to help users of the (unsupported) Nvidia binary driver,
but this has been reported to cause backlight control issues for users
who have the gfx configured in hybrid (dual-GPU) mode, so drop this.

The Nvidia binary driver should call acpi_video_register_backlight()
when necessary and this has been reported to Nvidia.

Until this is fixed Nvidia binary driver users can work around this by
passing "acpi_backlight=video" on the kernel commandline (with the latest
6.1.y or newer stable series, kernels < 6.1.y don't need this).

Fixes: a5b2781dcab2 ("ACPI: video: Add acpi_backlight=video quirk for Lenovo ThinkPad W530")
Reported-by: Русев Путин <rockeraliexpress@gmail.com>
Link: https://lore.kernel.org/linux-acpi/CAK4BXn0ngZRmzx1bodAF8nmYj0PWdUXzPGHofRrsyZj8MBpcVA@mail.gmail.com/
Cc: stable@vger.kernel.org
Cc: Daniel Dadap <ddadap@nvidia.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/video_detect.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 69ef2d9710c2..bcc25d457581 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -293,20 +293,6 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		},
 	},
 
-	/*
-	 * Older models with nvidia GPU which need acpi_video backlight
-	 * control and where the old nvidia binary driver series does not
-	 * call acpi_video_register_backlight().
-	 */
-	{
-	 .callback = video_detect_force_video,
-	 /* ThinkPad W530 */
-	 .matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-		DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad W530"),
-		},
-	},
-
 	/*
 	 * These models have a working acpi_video backlight control, and using
 	 * native backlight causes a regression where backlight does not work
-- 
2.39.2

