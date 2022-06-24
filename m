Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54D6B559872
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Jun 2022 13:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbiFXLYG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 24 Jun 2022 07:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbiFXLYE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Jun 2022 07:24:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DBA227C844
        for <linux-acpi@vger.kernel.org>; Fri, 24 Jun 2022 04:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656069841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WIdAzRH//YDBP9niHIfZJUECvvDzS1UevFto9sI81Mg=;
        b=XLtwzG0BAa2EXHU5Xbs9hZwq4PYLlDCtSuBm+Cea52BnmztpA38Eb+9gEt0i2aP5Et+JAL
        Cd6Ob07VDzPhtl++Jal0ox2oVehfIDGllsecPsagDLde+OdxP4SCV+AMNx1m0kerFo9osi
        STFn2hfuBQtd2FdNLNPQQcORRx33wtA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-551-bvDZhF70MjGkgxe1oQfgAA-1; Fri, 24 Jun 2022 07:23:58 -0400
X-MC-Unique: bvDZhF70MjGkgxe1oQfgAA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AC20A29324B0;
        Fri, 24 Jun 2022 11:23:57 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.193.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 34289492C3B;
        Fri, 24 Jun 2022 11:23:56 +0000 (UTC)
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
Subject: [PATCH 5/7] platform/x86: panasonic-laptop: don't report duplicate brightness key-presses
Date:   Fri, 24 Jun 2022 13:23:38 +0200
Message-Id: <20220624112340.10130-6-hdegoede@redhat.com>
In-Reply-To: <20220624112340.10130-1-hdegoede@redhat.com>
References: <20220624112340.10130-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The brightness key-presses might also get reported by the ACPI video bus,
check for this and in this case don't report the presses to avoid reporting
2 presses for a single key-press.

Fixes: ed83c9171829 ("platform/x86: panasonic-laptop: Resolve hotkey double trigger bug")
Reported-and-tested-by: Stefan Seyfried <seife+kernel@b1-systems.com>
Reported-and-tested-by: Kenneth Chan <kenneth.t.chan@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/Kconfig            | 1 +
 drivers/platform/x86/panasonic-laptop.c | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 263082fc5407..156cb7e3f422 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -943,6 +943,7 @@ config PANASONIC_LAPTOP
 	tristate "Panasonic Laptop Extras"
 	depends on INPUT && ACPI
 	depends on BACKLIGHT_CLASS_DEVICE
+	depends on ACPI_VIDEO=n || ACPI_VIDEO
 	select INPUT_SPARSEKMAP
 	help
 	  This driver adds support for access to backlight control and hotkeys
diff --git a/drivers/platform/x86/panasonic-laptop.c b/drivers/platform/x86/panasonic-laptop.c
index 2e6531dd15f9..d65e6c2372ca 100644
--- a/drivers/platform/x86/panasonic-laptop.c
+++ b/drivers/platform/x86/panasonic-laptop.c
@@ -132,6 +132,7 @@
 #include <linux/slab.h>
 #include <linux/types.h>
 #include <linux/uaccess.h>
+#include <acpi/video.h>
 
 MODULE_AUTHOR("Hiroshi Miura <miura@da-cha.org>");
 MODULE_AUTHOR("David Bronaugh <dbronaugh@linuxboxen.org>");
@@ -783,6 +784,13 @@ static void acpi_pcc_generate_keyinput(struct pcc_acpi *pcc)
 					key, 0x80, false);
 	}
 
+	/*
+	 * Don't report brightness key-presses if they are also reported
+	 * by the ACPI video bus.
+	 */
+	if ((key == 1 || key == 2) && acpi_video_handles_brightness_key_presses())
+		return;
+
 	if (!sparse_keymap_report_event(hotk_input_dev, key, updown, false))
 		pr_err("Unknown hotkey event: 0x%04llx\n", result);
 }
-- 
2.36.0

