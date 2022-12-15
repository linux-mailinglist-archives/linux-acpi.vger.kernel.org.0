Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E490C64D8C9
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Dec 2022 10:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbiLOJmc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 15 Dec 2022 04:42:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbiLOJma (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 15 Dec 2022 04:42:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCE82BF2
        for <linux-acpi@vger.kernel.org>; Thu, 15 Dec 2022 01:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671097309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=1BG7uuSnGPV79muqIARaa573ojSEFReXOVoQVHexFwI=;
        b=XfZID8WCsjc6V5lUaOh5pGf47lmHybYQscnMJn/Ikao1wbXlsOdrtkl6fZZKVPW0V7AjoL
        IZ7hnjngC7j6a0sKUjVMeZZAG67wF9A2DQqbDWcNoES/OPIeiI8y7EgP8G/IJetMJGvrl4
        ZRlHM9vuZDNzCh/2eKR9Ov99dxKL5Zw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-372-CTPDtuV8OTOv598Mvja6Hg-1; Thu, 15 Dec 2022 04:41:47 -0500
X-MC-Unique: CTPDtuV8OTOv598Mvja6Hg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E3C8886C14C;
        Thu, 15 Dec 2022 09:41:46 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.193.128])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1860B14171BE;
        Thu, 15 Dec 2022 09:41:45 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        Aditya Garg <gargaditya08@live.com>
Subject: [PATCH] ACPI: video: Fix Apple GMUX backlight detection
Date:   Thu, 15 Dec 2022 10:41:38 +0100
Message-Id: <20221215094138.7120-1-hdegoede@redhat.com>
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

The apple-gmux driver only binds to old GMUX devices which have an
IORESOURCE_IO resource (using inb()/outb()) rather then memory-mapped
IO (IORESOURCE_MEM).

T2 MacBooks use the new style GMUX devices (with IORESOURCE_MEM access),
so these are not supported by the apple-gmux driver. This is not a problem
since they have working ACPI video backlight support.

But the apple_gmux_present() helper only checks if an ACPI device with
the "APP000B" HID is present, causing acpi_video_get_backlight_type()
to return acpi_backlight_apple_gmux disabling the acpi_video backlight
device.

Add a new apple_gmux_backlight_present() helper which checks that
the "APP000B" device actually is an old GMUX device with an IORESOURCE_IO
resource.

This fixes the acpi_video0 backlight no longer registering on T2 MacBooks.

Note people are working to add support for the new style GMUX to Linux:
https://github.com/kekrby/linux-t2/commits/wip/hybrid-graphics

Once this lands this patch should be reverted so that
acpi_video_get_backlight_type() also prefers the gmux on new style GMUX
MacBooks, but for now this is necessary to avoid regressing backlight
control on T2 Macs.

Fixes: 21245df307cb ("ACPI: video: Add Apple GMUX brightness control detection")
Reported-and-tested-by: Aditya Garg <gargaditya08@live.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/video_detect.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index a934bbc9dd37..1b78c7434492 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -34,6 +34,7 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/platform_data/x86/nvidia-wmi-ec-backlight.h>
+#include <linux/pnp.h>
 #include <linux/types.h>
 #include <linux/workqueue.h>
 #include <acpi/video.h>
@@ -105,6 +106,26 @@ static bool nvidia_wmi_ec_supported(void)
 }
 #endif
 
+static bool apple_gmux_backlight_present(void)
+{
+	struct acpi_device *adev;
+	struct device *dev;
+
+	adev = acpi_dev_get_first_match_dev(GMUX_ACPI_HID, NULL, -1);
+	if (!adev)
+		return false;
+
+	dev = acpi_get_first_physical_node(adev);
+	if (!dev)
+		return false;
+
+	/*
+	 * drivers/platform/x86/apple-gmux.c only supports old style
+	 * Apple GMUX with an IO-resource.
+	 */
+	return pnp_get_resource(to_pnp_dev(dev), IORESOURCE_IO, 0) != NULL;
+}
+
 /* Force to use vendor driver when the ACPI device is known to be
  * buggy */
 static int video_detect_force_vendor(const struct dmi_system_id *d)
@@ -767,7 +788,7 @@ static enum acpi_backlight_type __acpi_video_get_backlight_type(bool native)
 	if (nvidia_wmi_ec_present)
 		return acpi_backlight_nvidia_wmi_ec;
 
-	if (apple_gmux_present())
+	if (apple_gmux_backlight_present())
 		return acpi_backlight_apple_gmux;
 
 	/* Use ACPI video if available, except when native should be preferred. */
-- 
2.38.1

