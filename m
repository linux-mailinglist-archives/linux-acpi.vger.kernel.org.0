Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0FB462831A
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Nov 2022 15:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235984AbiKNOqk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 14 Nov 2022 09:46:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235636AbiKNOqi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Nov 2022 09:46:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4946F26FB
        for <linux-acpi@vger.kernel.org>; Mon, 14 Nov 2022 06:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668437114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xHIQBUfqD0ipeTA29MoZZ4xWXf/VHbmW4bpPAmWI8kk=;
        b=Xt/n6+mhQ1G1/nZE3YL7i54iNjEPJFBgIqfVgaWzKzkRrb2/d3OZV8HWTD1Q+qQm/MkgIP
        p/jvvRmiVrkmsbshzvJ/gxBL1vuMxFEJ7NMWgI1wBN4ngt/r+C9X7UGw0004zLTp9VDW/d
        kVQ7nHzNdL/yYc0BF09f7CF3FUiZtQs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-624-BzDQyg3KOiCO0cZRtFbJFg-1; Mon, 14 Nov 2022 09:45:11 -0500
X-MC-Unique: BzDQyg3KOiCO0cZRtFbJFg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A25B687B2A0;
        Mon, 14 Nov 2022 14:45:10 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.193.154])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2AF1B1401C21;
        Mon, 14 Nov 2022 14:45:08 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        linux-acpi@vger.kernel.org
Subject: [PATCH 3/7] ACPI: video: Change Sony Vaio VPCEH3U1E quirk to force_native
Date:   Mon, 14 Nov 2022 15:44:55 +0100
Message-Id: <20221114144459.455519-4-hdegoede@redhat.com>
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

According to: https://bugzilla.kernel.org/show_bug.cgi?id=202401
the Sony Vaio VPCEH3U1E quirk was added to disable the acpi_video0
backlight interface because that was not working, so that userspace
will pick the actually working native nv_backlight interface instead.

With the new kernel behavior of hiding native interfaces unless
acpi_video_get_backlight_type() returns native, the current
video_detect_force_vendor quirk will cause the working nv_backlight
interface will be disabled too.

Change the quirk to video_detect_force_native to get the desired
result of only registering the nv_backlight interface.

After this all currently remaining force_vendor quirks in
video_detect_dmi_table[] are there to prefer a vendor interface over
a non working ACPI video interface, add a comment to document this.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/video_detect.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index a1ac7de186be..327e0967ba54 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -132,6 +132,10 @@ static int video_detect_force_none(const struct dmi_system_id *d)
 }
 
 static const struct dmi_system_id video_detect_dmi_table[] = {
+	/*
+	 * Models which should use the vendor backlight interface,
+	 * because of broken ACPI video backlight control.
+	 */
 	{
 	 /* https://bugzilla.redhat.com/show_bug.cgi?id=1128309 */
 	 .callback = video_detect_force_vendor,
@@ -226,15 +230,6 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_BOARD_NAME, "NC210/NC110"),
 		},
 	},
-	{
-	 /* https://bugzilla.kernel.org/show_bug.cgi?id=202401 */
-	 .callback = video_detect_force_vendor,
-	 /* Sony VPCEH3U1E */
-	 .matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
-		DMI_MATCH(DMI_PRODUCT_NAME, "VPCEH3U1E"),
-		},
-	},
 	{
 	 .callback = video_detect_force_vendor,
 	 /* Xiaomi Mi Pad 2 */
@@ -604,6 +599,15 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_BOARD_NAME, "N250P"),
 		},
 	},
+	{
+	 /* https://bugzilla.kernel.org/show_bug.cgi?id=202401 */
+	 .callback = video_detect_force_native,
+	 /* Sony Vaio VPCEH3U1E */
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "VPCEH3U1E"),
+		},
+	},
 
 	/*
 	 * These Toshibas have a broken acpi-video interface for brightness
-- 
2.37.3

