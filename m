Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD3597A2960
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Sep 2023 23:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbjIOVaP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 15 Sep 2023 17:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237617AbjIOVaE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Sep 2023 17:30:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C4B8AB8
        for <linux-acpi@vger.kernel.org>; Fri, 15 Sep 2023 14:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694813352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=VtyMfYzD7xcby6o2/dzP0eRV0+P8SHlRHIxsw7xO7Vo=;
        b=dyZWzDY8+CYHJykmuChXLveq5pfONoiZIoooqtv/YgSCdEIfqmPW+gRyhk8Q3Wv/zCdeI2
        u2JfJYr/DdxZDe07R6R5E+nLL/3t1YkZSzsYskV9KmuBLceyTCViHAo721H9DA+53pfzdv
        C+npa72Bk6E0r9GkLxW4N+KBeYMaMIU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-675-UQKuRmAHPniNH6oCrDMz4Q-1; Fri, 15 Sep 2023 17:29:08 -0400
X-MC-Unique: UQKuRmAHPniNH6oCrDMz4Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 56EC182A620;
        Fri, 15 Sep 2023 21:29:08 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.5])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C01EE2026D4B;
        Fri, 15 Sep 2023 21:29:07 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org
Subject: [PATCH 1/2] ACPI: video: Move Xiaomi Mi Pad 2 quirk to its own section
Date:   Fri, 15 Sep 2023 23:29:01 +0200
Message-ID: <20230915212902.59586-1-hdegoede@redhat.com>
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

The Xiaomi Mi Pad 2 is currently listed under the:
"Models which should use the vendor backlight interface,
because of broken ACPI video backlight control." section.

But this is not 100% correct. The Xiaomi Mi Pad 2 is one of a set of
x86 tablets which shipped with Android as factory OS. These tablets
have a TI LP8557 backlight controller with its PWM input _not_
connected to the PMIC or chipset (LPSS) PWM output.

Instead the backlight can be controlled by configuring the LP8557
for direct control through its brightness I2C register and then
using the lp855x driver.

This setup means that neither i915's native or acpi_video backlight
control works, so a "vendor" quirk is added for these tablets to
disable both the native and acpi_video backlight devices, but these
devices do not use vendor control in the typical meaning of
vendor specific SMBIOS or ACPI calls being used.

This patch is a preparation patch for adding "vendor" quirks
for a couple more such tablet models.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/video_detect.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 442396f6ed1f..889902a4fdfe 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -229,14 +229,6 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_BOARD_NAME, "NC210/NC110"),
 		},
 	},
-	{
-	 .callback = video_detect_force_vendor,
-	 /* Xiaomi Mi Pad 2 */
-	 .matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Xiaomi Inc"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Mipad2"),
-		},
-	},
 
 	/*
 	 * Models which should use the vendor backlight interface,
@@ -799,6 +791,24 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "Vostro 15 3535"),
 		},
 	},
+
+	/*
+	 * x86 android tablets which directly control the backlight through
+	 * an external backlight controller, typically TI's LP8557.
+	 * The backlight is directly controlled by the lp855x driver on these.
+	 * This setup means that neither i915's native nor acpi_video backlight
+	 * control works. Add a "vendor" quirk to disable both. Note these
+	 * devices do not use vendor control in the typical meaning of
+	 * vendor specific SMBIOS or ACPI calls being used.
+	 */
+	{
+	 .callback = video_detect_force_vendor,
+	 /* Xiaomi Mi Pad 2 */
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Xiaomi Inc"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "Mipad2"),
+		},
+	},
 	{ },
 };
 
-- 
2.41.0

