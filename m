Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37BAB673F08
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Jan 2023 17:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjASQiu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 19 Jan 2023 11:38:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjASQiq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Jan 2023 11:38:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48D54DBED
        for <linux-acpi@vger.kernel.org>; Thu, 19 Jan 2023 08:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674146279;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hf32wGeGMUWb2ECD3ha9nC7DIIlevKq9JoTgV9yQNvM=;
        b=AFlnlT37W/YEIugd0zknMVFataHYDChKIPso7MyWyp2d6dsiU8unNJxbig9OtVi0+ag+eF
        6aWEuuDLfoAVwRXzBCeHKOvBAx+ykUQ556PvOjGQB5iVatr23NBi2hrKjMFByLq3epvnO6
        lYrfrVltoM0hdmMCpWAV+yV2aujGIPI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-490-QDtC1KaZNCeJ2PUBuHI5dg-1; Thu, 19 Jan 2023 11:37:56 -0500
X-MC-Unique: QDtC1KaZNCeJ2PUBuHI5dg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E5268858F09;
        Thu, 19 Jan 2023 16:37:55 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.194.158])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0FBA12026D68;
        Thu, 19 Jan 2023 16:37:54 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 2/2] ACPI: video: Add backlight=native DMI quirk for HP EliteBook 8460p
Date:   Thu, 19 Jan 2023 17:37:44 +0100
Message-Id: <20230119163744.548749-3-hdegoede@redhat.com>
In-Reply-To: <20230119163744.548749-1-hdegoede@redhat.com>
References: <20230119163744.548749-1-hdegoede@redhat.com>
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

The HP EliteBook 8460p predates Windows 8, so it defaults to using
acpi_video# for backlight control.

Starting with the 6.1.y kernels the native radeon_bl0 backlight is hidden
in this case instead of relying on userspace preferring acpi_video# over
native backlight devices.

It turns out that for the acpi_video# interface to work on
the HP EliteBook 8460p, the brightness needs to be set at least once
through the native interface, which now no longer is done breaking
backlight control.

The native interface however always works without problems, so add
a quirk to use native backlight on the EliteBook 8460p to fix this.

Fixes: fb1836c91317 ("ACPI: video: Prefer native over vendor")
Link: https://bugzilla.redhat.com/show_bug.cgi?id=2161428
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/video_detect.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index c660dd6f896e..3a2589917648 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -618,6 +618,14 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "UX303UB"),
 		},
 	},
+	{
+	 .callback = video_detect_force_native,
+	 /* HP EliteBook 8460p */
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "HP EliteBook 8460p"),
+		},
+	},
 	{
 	 .callback = video_detect_force_native,
 	 /* HP Pavilion g6-1d80nr / B4U19UA */
-- 
2.39.0

