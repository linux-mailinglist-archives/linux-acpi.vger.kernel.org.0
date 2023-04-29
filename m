Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DADFF6F255B
	for <lists+linux-acpi@lfdr.de>; Sat, 29 Apr 2023 18:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbjD2Qf6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 29 Apr 2023 12:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjD2Qf6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 29 Apr 2023 12:35:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390781BFD
        for <linux-acpi@vger.kernel.org>; Sat, 29 Apr 2023 09:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682786109;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=6rxGomi8wUPB1AozuPYRcTHTsagQ5myQ7KqtwfTTkFw=;
        b=CXgypKE6PbK9ymOh4hzZPkbwQ9TtHj1TyKhbqMIyB+1HZty4DMDljSH9vmtM1o3G36XEqn
        h6JVymSNHpj7EYAlIkxo6g31VO7thhyabhRXyy8ddnyQ6E+hkI+9AkJVDxLFqwtER4E2vY
        QsAGJRlfp1rPK6sgDXKMj+e9dNnyEoY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-615-1dyuMfIXNVSn3lHFjWwUvA-1; Sat, 29 Apr 2023 12:35:07 -0400
X-MC-Unique: 1dyuMfIXNVSn3lHFjWwUvA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 647D085A5A3;
        Sat, 29 Apr 2023 16:35:07 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D03C9463ECB;
        Sat, 29 Apr 2023 16:35:06 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org
Subject: [PATCH] ACPI / x86: Add ACPI_QUIRK_UART1_SKIP for Lenovo Yoga Book yb1-x90f/l
Date:   Sat, 29 Apr 2023 18:34:58 +0200
Message-Id: <20230429163458.73479-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The Lenovo Yoga Book yb1-x90f/l 2-in-1 which ships with Android as
Factory OS has (another) bug in its DSDT where the UART resource for
the BTH0 ACPI device contains "\\_SB.PCIO.URT1" as path to the UART.

Note that is with a letter 'O' instead of the number '0' which is wrong.

This causes Linux to instantiate a standard /dev/ttyS? device for
the UART instead of a /sys/bus/serial device, which in turn causes
bluetooth to not work.

Similar DSDT bugs have been encountered before and to work around those
the acpi_quirk_skip_serdev_enumeration() helper exists.

Previous devices had the broken resource pointing to the first UART, while
the BT HCI was on the second UART, which ACPI_QUIRK_UART1_TTY_UART2_SKIP
deals with. Add a new ACPI_QUIRK_UART1_SKIP quirk for skipping enumeration
of UART1 instead for the Yoga Book case and add this quirk to the
existing DMI quirk table entry for the yb1-x90f/l .

This leaves the UART1 controller unbound allowing the x86-android-tablets
module to manually instantiate a serdev for it fixing bluetooth.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/x86/utils.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
index 4cfee2da0675..c2b925f8cd4e 100644
--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -259,10 +259,11 @@ bool force_storage_d3(void)
  * drivers/platform/x86/x86-android-tablets.c kernel module.
  */
 #define ACPI_QUIRK_SKIP_I2C_CLIENTS				BIT(0)
-#define ACPI_QUIRK_UART1_TTY_UART2_SKIP				BIT(1)
-#define ACPI_QUIRK_SKIP_ACPI_AC_AND_BATTERY			BIT(2)
-#define ACPI_QUIRK_USE_ACPI_AC_AND_BATTERY			BIT(3)
-#define ACPI_QUIRK_SKIP_GPIO_EVENT_HANDLERS			BIT(4)
+#define ACPI_QUIRK_UART1_SKIP					BIT(1)
+#define ACPI_QUIRK_UART1_TTY_UART2_SKIP				BIT(2)
+#define ACPI_QUIRK_SKIP_ACPI_AC_AND_BATTERY			BIT(3)
+#define ACPI_QUIRK_USE_ACPI_AC_AND_BATTERY			BIT(4)
+#define ACPI_QUIRK_SKIP_GPIO_EVENT_HANDLERS			BIT(5)
 
 static const struct dmi_system_id acpi_quirk_skip_dmi_ids[] = {
 	/*
@@ -319,6 +320,7 @@ static const struct dmi_system_id acpi_quirk_skip_dmi_ids[] = {
 			DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "YETI-11"),
 		},
 		.driver_data = (void *)(ACPI_QUIRK_SKIP_I2C_CLIENTS |
+					ACPI_QUIRK_UART1_SKIP |
 					ACPI_QUIRK_SKIP_ACPI_AC_AND_BATTERY |
 					ACPI_QUIRK_SKIP_GPIO_EVENT_HANDLERS),
 	},
@@ -449,6 +451,9 @@ int acpi_quirk_skip_serdev_enumeration(struct device *controller_parent, bool *s
 	if (dmi_id)
 		quirks = (unsigned long)dmi_id->driver_data;
 
+	if ((quirks & ACPI_QUIRK_UART1_SKIP) && uid == 1)
+		*skip = true;
+
 	if (quirks & ACPI_QUIRK_UART1_TTY_UART2_SKIP) {
 		if (uid == 1)
 			return -ENODEV; /* Create tty cdev instead of serdev */
-- 
2.39.2

