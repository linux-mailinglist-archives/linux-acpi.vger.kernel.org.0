Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA0C62831D
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Nov 2022 15:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236302AbiKNOqq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 14 Nov 2022 09:46:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235905AbiKNOqk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Nov 2022 09:46:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF59BE37
        for <linux-acpi@vger.kernel.org>; Mon, 14 Nov 2022 06:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668437112;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4r1SO73JXNiY1yhNk5QogmxIUjJ6QS53qM9eFo1IoOo=;
        b=hGP0N3CwaoHMHGwk2U6j5TVJxHwuBuOIBTw2SJchE2XDPaV4OpzCRRqpmltWsEQZY1OlKp
        oR7V3tjZRmXAkGm6ZyltwtMu/tD+waP2kfA0XcPSPNPlKlT81DrrfmCyzw1o/LGeEbROvU
        8EzgFesRCnDVC0kqyD2KoaU4p8XigIc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-549-DUQQT_5-PUif3L3TCW67Xg-1; Mon, 14 Nov 2022 09:45:09 -0500
X-MC-Unique: DUQQT_5-PUif3L3TCW67Xg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A765287B2A0;
        Mon, 14 Nov 2022 14:45:08 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.193.154])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 72EF01415102;
        Mon, 14 Nov 2022 14:45:07 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        linux-acpi@vger.kernel.org,
        "Jasper St . Pierre" <jstpierre@mecheye.net>
Subject: [PATCH 2/7] ACPI: video: Change GIGABYTE GB-BXBT-2807 quirk to force_none
Date:   Mon, 14 Nov 2022 15:44:54 +0100
Message-Id: <20221114144459.455519-3-hdegoede@redhat.com>
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

The GIGABYTE GB-BXBT-2807 DMI quirk was added by
commit 25417185e9b5 ("ACPI: video: Add DMI quirk for GIGABYTE
GB-BXBT-2807") which says the following in its commit message:

"The GIGABYTE GB-BXBT-2807 is a mini-PC which uses off the shelf
components, like an Intel GPU which is meant for mobile systems.
As such, it, by default, has a backlight controller exposed.

Unfortunately, the backlight controller only confuses userspace, which
sees the existence of a backlight device node and has the unrealistic
belief that there is actually a backlight there!

Add a DMI quirk to force the backlight off on this system."

So in essence this quirk was using a video_detect_force_vendor quirk
to disable backlight control. Now a days we have a specific "none"
backlight type for this. Change the quirk to video_detect_force_none
and group it together with the other force_none quirks.

Cc: Jasper St. Pierre <jstpierre@mecheye.net>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/video_detect.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index bb8052fc3fee..a1ac7de186be 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -199,14 +199,6 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "1015CX"),
 		},
 	},
-	{
-	 .callback = video_detect_force_vendor,
-	 /* GIGABYTE GB-BXBT-2807 */
-	 .matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "GIGABYTE"),
-		DMI_MATCH(DMI_PRODUCT_NAME, "GB-BXBT-2807"),
-		},
-	},
 	{
 	 .callback = video_detect_force_vendor,
 	 /* Samsung N150/N210/N220 */
@@ -674,6 +666,14 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex 9020M"),
 		},
 	},
+	{
+	 .callback = video_detect_force_none,
+	 /* GIGABYTE GB-BXBT-2807 */
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "GIGABYTE"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "GB-BXBT-2807"),
+		},
+	},
 	{
 	 .callback = video_detect_force_none,
 	 /* MSI MS-7721 */
-- 
2.37.3

