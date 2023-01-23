Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC9FE677A3F
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Jan 2023 12:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbjAWLin (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 23 Jan 2023 06:38:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbjAWLim (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Jan 2023 06:38:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D574C13530
        for <linux-acpi@vger.kernel.org>; Mon, 23 Jan 2023 03:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674473881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mQdM4P8XMvbCNXWKxTuL1EtGpzdrTbeHsfXFTF4BqXk=;
        b=gBATn4ntQp9NEGLnGhFmPmF2EJBTSzhf/R+JuyF3e21Ulx/A9Sds3YlvBZZYPTwipSRNgy
        bvGIR6MdTbw2ITGlz4JtVjNkFm/QmNksI8OhbbZ5bHKFwOSmNuz4OxFYTdvCMwb948Kv56
        E/wjusFhF3VTj9ni9cro610VzoHUi3A=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-280-3r9eSeASOfGY3BdQMjWyFg-1; Mon, 23 Jan 2023 06:37:55 -0500
X-MC-Unique: 3r9eSeASOfGY3BdQMjWyFg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4CD0829AB3E2;
        Mon, 23 Jan 2023 11:37:55 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.194.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D3525175A2;
        Mon, 23 Jan 2023 11:37:53 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Aditya Garg <gargaditya08@live.com>,
        Mark Gross <mgross@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Lukas Wunner <lukas@wunner.de>, linux-acpi@vger.kernel.org,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH 1/3] platform/x86: apple-gmux: Move port defines to apple-gmux.h
Date:   Mon, 23 Jan 2023 12:37:48 +0100
Message-Id: <20230123113750.462144-2-hdegoede@redhat.com>
In-Reply-To: <20230123113750.462144-1-hdegoede@redhat.com>
References: <20230123113750.462144-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This is a preparation patch for adding a new static inline
apple_gmux_detect() helper which actually checks a supported
gmux is present, rather then only checking an ACPI device with
the HID is there as apple_gmux_present() does.

Fixes: 21245df307cb ("ACPI: video: Add Apple GMUX brightness control detection")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/apple-gmux.c | 23 -----------------------
 include/linux/apple-gmux.h        | 23 +++++++++++++++++++++++
 2 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
index ca33df7ea550..a0af01f6a0fd 100644
--- a/drivers/platform/x86/apple-gmux.c
+++ b/drivers/platform/x86/apple-gmux.c
@@ -64,29 +64,6 @@ struct apple_gmux_data {
 
 static struct apple_gmux_data *apple_gmux_data;
 
-/*
- * gmux port offsets. Many of these are not yet used, but may be in the
- * future, and it's useful to have them documented here anyhow.
- */
-#define GMUX_PORT_VERSION_MAJOR		0x04
-#define GMUX_PORT_VERSION_MINOR		0x05
-#define GMUX_PORT_VERSION_RELEASE	0x06
-#define GMUX_PORT_SWITCH_DISPLAY	0x10
-#define GMUX_PORT_SWITCH_GET_DISPLAY	0x11
-#define GMUX_PORT_INTERRUPT_ENABLE	0x14
-#define GMUX_PORT_INTERRUPT_STATUS	0x16
-#define GMUX_PORT_SWITCH_DDC		0x28
-#define GMUX_PORT_SWITCH_EXTERNAL	0x40
-#define GMUX_PORT_SWITCH_GET_EXTERNAL	0x41
-#define GMUX_PORT_DISCRETE_POWER	0x50
-#define GMUX_PORT_MAX_BRIGHTNESS	0x70
-#define GMUX_PORT_BRIGHTNESS		0x74
-#define GMUX_PORT_VALUE			0xc2
-#define GMUX_PORT_READ			0xd0
-#define GMUX_PORT_WRITE			0xd4
-
-#define GMUX_MIN_IO_LEN			(GMUX_PORT_BRIGHTNESS + 4)
-
 #define GMUX_INTERRUPT_ENABLE		0xff
 #define GMUX_INTERRUPT_DISABLE		0x00
 
diff --git a/include/linux/apple-gmux.h b/include/linux/apple-gmux.h
index ddb10aa67b14..80efaaf89e07 100644
--- a/include/linux/apple-gmux.h
+++ b/include/linux/apple-gmux.h
@@ -11,6 +11,29 @@
 
 #define GMUX_ACPI_HID "APP000B"
 
+/*
+ * gmux port offsets. Many of these are not yet used, but may be in the
+ * future, and it's useful to have them documented here anyhow.
+ */
+#define GMUX_PORT_VERSION_MAJOR		0x04
+#define GMUX_PORT_VERSION_MINOR		0x05
+#define GMUX_PORT_VERSION_RELEASE	0x06
+#define GMUX_PORT_SWITCH_DISPLAY	0x10
+#define GMUX_PORT_SWITCH_GET_DISPLAY	0x11
+#define GMUX_PORT_INTERRUPT_ENABLE	0x14
+#define GMUX_PORT_INTERRUPT_STATUS	0x16
+#define GMUX_PORT_SWITCH_DDC		0x28
+#define GMUX_PORT_SWITCH_EXTERNAL	0x40
+#define GMUX_PORT_SWITCH_GET_EXTERNAL	0x41
+#define GMUX_PORT_DISCRETE_POWER	0x50
+#define GMUX_PORT_MAX_BRIGHTNESS	0x70
+#define GMUX_PORT_BRIGHTNESS		0x74
+#define GMUX_PORT_VALUE			0xc2
+#define GMUX_PORT_READ			0xd0
+#define GMUX_PORT_WRITE			0xd4
+
+#define GMUX_MIN_IO_LEN			(GMUX_PORT_BRIGHTNESS + 4)
+
 #if IS_ENABLED(CONFIG_APPLE_GMUX)
 
 /**
-- 
2.39.0

