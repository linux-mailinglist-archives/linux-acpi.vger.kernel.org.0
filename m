Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 304346D5EA1
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Apr 2023 13:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234761AbjDDLHg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 4 Apr 2023 07:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234784AbjDDLHX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 4 Apr 2023 07:07:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66294C1F
        for <linux-acpi@vger.kernel.org>; Tue,  4 Apr 2023 04:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680606194;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G0FSvMQYMF9NEhtb5fgB8DgqKTINmYX5EdpO00O3SNU=;
        b=hK4NlHmHmicxpjF5aTlBqDcaZW17OAWkhqMBbGoGDefl96+DPlO/rhw2Tp08LPDBkDvaPR
        BoTz6hSJuhmLuSZ/hwA+qpyA+HUEMj/CFKEea1F8f7xp2SF5MFlosewOKw6Vl7aGMfAxW6
        xnIXxqXvvEDnIi2cPBmQjmExYeeYx7U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-401-GYuK4stoOIGpS7vxOs8F7g-1; Tue, 04 Apr 2023 07:03:13 -0400
X-MC-Unique: GYuK4stoOIGpS7vxOs8F7g-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9F974185A791;
        Tue,  4 Apr 2023 11:03:12 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.74])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B8E6C483EC1;
        Tue,  4 Apr 2023 11:03:11 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Daniel Dadap <ddadap@nvidia.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org
Subject: [PATCH v2 6/6] ACPI: video: Remove desktops without backlight DMI quirks
Date:   Tue,  4 Apr 2023 13:02:51 +0200
Message-Id: <20230404110251.42449-7-hdegoede@redhat.com>
In-Reply-To: <20230404110251.42449-1-hdegoede@redhat.com>
References: <20230404110251.42449-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

After the recent backlight changes acpi_video# backlight devices are only
registered when explicitly requested from the cmdline, by DMI quirk or by
the GPU driver.

This means that we no longer get false-positive backlight control support
advertised on desktop boards.

Remove the 3 DMI quirks for desktop boards where the false-positive issue
was fixed through quirks before. Note many more desktop boards were
affected but we never build a full quirk list for this.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
- Drop no longer used video_detect_force_none() function
---
 drivers/acpi/video_detect.c | 35 -----------------------------------
 1 file changed, 35 deletions(-)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index e85729fc481f..69ef2d9710c2 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -130,12 +130,6 @@ static int video_detect_force_native(const struct dmi_system_id *d)
 	return 0;
 }
 
-static int video_detect_force_none(const struct dmi_system_id *d)
-{
-	acpi_backlight_dmi = acpi_backlight_none;
-	return 0;
-}
-
 static const struct dmi_system_id video_detect_dmi_table[] = {
 	/*
 	 * Models which should use the vendor backlight interface,
@@ -768,35 +762,6 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "Vostro 15 3535"),
 		},
 	},
-
-	/*
-	 * Desktops which falsely report a backlight and which our heuristics
-	 * for this do not catch.
-	 */
-	{
-	 .callback = video_detect_force_none,
-	 /* Dell OptiPlex 9020M */
-	 .matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-		DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex 9020M"),
-		},
-	},
-	{
-	 .callback = video_detect_force_none,
-	 /* GIGABYTE GB-BXBT-2807 */
-	 .matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "GIGABYTE"),
-		DMI_MATCH(DMI_PRODUCT_NAME, "GB-BXBT-2807"),
-		},
-	},
-	{
-	 .callback = video_detect_force_none,
-	 /* MSI MS-7721 */
-	 .matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "MSI"),
-		DMI_MATCH(DMI_PRODUCT_NAME, "MS-7721"),
-		},
-	},
 	{ },
 };
 
-- 
2.39.1

