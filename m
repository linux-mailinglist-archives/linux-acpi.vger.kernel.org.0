Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2FA1559883
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Jun 2022 13:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbiFXLYM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 24 Jun 2022 07:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbiFXLYH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Jun 2022 07:24:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AD94D7C508
        for <linux-acpi@vger.kernel.org>; Fri, 24 Jun 2022 04:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656069845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JiC2ttPcK4jbIqmWkR/0dSZUmikhtPV7gNuoggW+vR4=;
        b=XMrvSPR3UzaiVBgAM9peM4w0OLbKUSYMAuaiqeAEWxc1qcJKv43n31kr7+aa3cdZmBXc++
        wgiveNhlawGZEV0nD744oHDg8DCZEUt/GeB98z0uDvGfqgbb3ZFmc0RvaOFVWiUvDnSzX8
        cFNCpguS97pmqulyKwp/hXjlbMJebpQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-557-gJuTfcBXPc2vVSr1wTs-ww-1; Fri, 24 Jun 2022 07:23:59 -0400
X-MC-Unique: gJuTfcBXPc2vVSr1wTs-ww-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 48D318032F0;
        Fri, 24 Jun 2022 11:23:59 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.193.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E247E492C3B;
        Fri, 24 Jun 2022 11:23:57 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org,
        Stefan Seyfried <stefan.seyfried@googlemail.com>,
        Kenneth Chan <kenneth.t.chan@gmail.com>,
        platform-driver-x86@vger.kernel.org,
        Stefan Seyfried <seife+kernel@b1-systems.com>
Subject: [PATCH 6/7] platform/x86: panasonic-laptop: filter out duplicate volume up/down/mute keypresses
Date:   Fri, 24 Jun 2022 13:23:39 +0200
Message-Id: <20220624112340.10130-7-hdegoede@redhat.com>
In-Reply-To: <20220624112340.10130-1-hdegoede@redhat.com>
References: <20220624112340.10130-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On some Panasonic models the volume up/down/mute keypresses get
reported both through the Panasonic ACPI HKEY interface as well as
through the atkbd device.

Filter out the atkbd scan-codes for these to avoid reporting presses
twice.

Note normally we would leave the filtering of these to userspace by mapping
the scan-codes to KEY_UNKNOWN through /lib/udev/hwdb.d/60-keyboard.hwdb.
However in this case that would cause regressions since we were filtering
the Panasonic ACPI HKEY events before, so filter these in the kernel.

Fixes: ed83c9171829 ("platform/x86: panasonic-laptop: Resolve hotkey double trigger bug")
Reported-and-tested-by: Stefan Seyfried <seife+kernel@b1-systems.com>
Reported-and-tested-by: Kenneth Chan <kenneth.t.chan@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/Kconfig            |  1 +
 drivers/platform/x86/panasonic-laptop.c | 41 +++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 156cb7e3f422..6e22ac916f7a 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -944,6 +944,7 @@ config PANASONIC_LAPTOP
 	depends on INPUT && ACPI
 	depends on BACKLIGHT_CLASS_DEVICE
 	depends on ACPI_VIDEO=n || ACPI_VIDEO
+	depends on SERIO_I8042 || SERIO_I8042 = n
 	select INPUT_SPARSEKMAP
 	help
 	  This driver adds support for access to backlight control and hotkeys
diff --git a/drivers/platform/x86/panasonic-laptop.c b/drivers/platform/x86/panasonic-laptop.c
index d65e6c2372ca..615e39cbbbf1 100644
--- a/drivers/platform/x86/panasonic-laptop.c
+++ b/drivers/platform/x86/panasonic-laptop.c
@@ -122,6 +122,7 @@
 #include <linux/acpi.h>
 #include <linux/backlight.h>
 #include <linux/ctype.h>
+#include <linux/i8042.h>
 #include <linux/init.h>
 #include <linux/input.h>
 #include <linux/input/sparse-keymap.h>
@@ -129,6 +130,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/seq_file.h>
+#include <linux/serio.h>
 #include <linux/slab.h>
 #include <linux/types.h>
 #include <linux/uaccess.h>
@@ -241,6 +243,42 @@ struct pcc_acpi {
 	struct platform_device	*platform;
 };
 
+/*
+ * On some Panasonic models the volume up / down / mute keys send duplicate
+ * keypress events over the PS/2 kbd interface, filter these out.
+ */
+static bool panasonic_i8042_filter(unsigned char data, unsigned char str,
+				   struct serio *port)
+{
+	static bool extended;
+
+	if (str & I8042_STR_AUXDATA)
+		return false;
+
+	if (data == 0xe0) {
+		extended = true;
+		return true;
+	} else if (extended) {
+		extended = false;
+
+		switch (data & 0x7f) {
+		case 0x20: /* e0 20 / e0 a0, Volume Mute press / release */
+		case 0x2e: /* e0 2e / e0 ae, Volume Down press / release */
+		case 0x30: /* e0 30 / e0 b0, Volume Up press / release */
+			return true;
+		default:
+			/*
+			 * Report the previously filtered e0 before continuing
+			 * with the next non-filtered byte.
+			 */
+			serio_interrupt(port, 0xe0, 0);
+			return false;
+		}
+	}
+
+	return false;
+}
+
 /* method access functions */
 static int acpi_pcc_write_sset(struct pcc_acpi *pcc, int func, int val)
 {
@@ -1006,6 +1044,7 @@ static int acpi_pcc_hotkey_add(struct acpi_device *device)
 		pcc->platform = NULL;
 	}
 
+	i8042_install_filter(panasonic_i8042_filter);
 	return 0;
 
 out_platform:
@@ -1029,6 +1068,8 @@ static int acpi_pcc_hotkey_remove(struct acpi_device *device)
 	if (!device || !pcc)
 		return -EINVAL;
 
+	i8042_remove_filter(panasonic_i8042_filter);
+
 	if (pcc->platform) {
 		device_remove_file(&pcc->platform->dev, &dev_attr_cdpower);
 		platform_device_unregister(pcc->platform);
-- 
2.36.0

