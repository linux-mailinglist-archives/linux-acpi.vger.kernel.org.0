Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 134E17A2961
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Sep 2023 23:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236136AbjIOVaP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 15 Sep 2023 17:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237661AbjIOVaF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Sep 2023 17:30:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 908D5D3
        for <linux-acpi@vger.kernel.org>; Fri, 15 Sep 2023 14:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694813352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ypC7TunqhPR9LA3kHH9j8UJiBD/IM4h7QMuAD//yM+k=;
        b=ephiOgu8YXuiz6kZmZeJw+qh2nON5N/6TASp9TTE/cugz0tNbJNOQmkpV/Q1L/NGQMnJqn
        aJsss1K39QXPIKddsIVVO9Zo0ZKuEYzwtpv/u/qq5hOLmRjI2ml8xZaEIWOoDDGEJ+4yfN
        C6h0zpY7HVoJMvpb3Ra/EqP3+SvtYog=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-689-OClMHuQFM9G1xGMfeyiyqg-1; Fri, 15 Sep 2023 17:29:09 -0400
X-MC-Unique: OClMHuQFM9G1xGMfeyiyqg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1D3C9811E7B;
        Fri, 15 Sep 2023 21:29:09 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.5])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 883982026D4B;
        Fri, 15 Sep 2023 21:29:08 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org
Subject: [PATCH 2/2] ACPI: video: Add "vendor" quirks for 3 Lenovo x86 Android tablets
Date:   Fri, 15 Sep 2023 23:29:02 +0200
Message-ID: <20230915212902.59586-2-hdegoede@redhat.com>
In-Reply-To: <20230915212902.59586-1-hdegoede@redhat.com>
References: <20230915212902.59586-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Like the Xiaomi Mi Pad 2 these 3 Lenovo x86 Android tablet models also
use a TI LP8557 backlight controller in direct I2C brightness register
control mode.

Add "vendor" quirks for these 3 models to disable the non-working
native / acpi_video backlight devices.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/video_detect.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 889902a4fdfe..67aa160c6b76 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -801,6 +801,38 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 	 * devices do not use vendor control in the typical meaning of
 	 * vendor specific SMBIOS or ACPI calls being used.
 	 */
+	{
+	 .callback = video_detect_force_vendor,
+	 /* Lenovo Yoga Book X90F / X90L */
+	 .matches = {
+		DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Intel Corporation"),
+		DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "CHERRYVIEW D1 PLATFORM"),
+		DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "YETI-11"),
+		},
+	},
+	{
+	 .callback = video_detect_force_vendor,
+	 /*
+	  * Lenovo Yoga Tablet 2 830F/L or 1050F/L (The 8" and 10"
+	  * Lenovo Yoga Tablet 2 use the same mainboard)
+	  */
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Intel Corp."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "VALLEYVIEW C0 PLATFORM"),
+		DMI_MATCH(DMI_BOARD_NAME, "BYT-T FFD8"),
+		/* Partial match on beginning of BIOS version */
+		DMI_MATCH(DMI_BIOS_VERSION, "BLADE_21"),
+		},
+	},
+	{
+	 .callback = video_detect_force_vendor,
+	 /* Lenovo Yoga Tab 3 Pro YT3-X90F */
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Intel Corporation"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "CHERRYVIEW D1 PLATFORM"),
+		DMI_MATCH(DMI_PRODUCT_VERSION, "Blade3-10A-001"),
+		},
+	},
 	{
 	 .callback = video_detect_force_vendor,
 	 /* Xiaomi Mi Pad 2 */
-- 
2.41.0

