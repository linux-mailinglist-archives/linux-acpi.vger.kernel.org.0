Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1846F2428
	for <lists+linux-acpi@lfdr.de>; Sat, 29 Apr 2023 12:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbjD2Kjl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 29 Apr 2023 06:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjD2Kjj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 29 Apr 2023 06:39:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C819C1FC3
        for <linux-acpi@vger.kernel.org>; Sat, 29 Apr 2023 03:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682764731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=FMC6uCEvFdBZotxj83agPMBA6bOn48Tj6FuN66MXwS4=;
        b=PQOR/1cjfa+SkNL3xxukJbdtWfbIlohW7d4SfIWGDjl0CeTTVbjoj6ng26DnHOILPi4DeQ
        UWiAo0R8w8aYnVyxLa2ecL1dZTxL+Gb1m6EDJyatoB//lKP3HzjJyt9p1UBg7ugrhj0swe
        V3/XSugrVokSZrsO7wTJ9JthmlwQIVE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-398-928BXJnHPz22_Bf1JYSvyQ-1; Sat, 29 Apr 2023 06:38:48 -0400
X-MC-Unique: 928BXJnHPz22_Bf1JYSvyQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CCB1B29AA387;
        Sat, 29 Apr 2023 10:38:47 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4412A492C13;
        Sat, 29 Apr 2023 10:38:47 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org
Subject: [PATCH 1/2] ACPI / x86: Add skip i2c clients quirk for Nextbook Ares 8A
Date:   Sat, 29 Apr 2023 12:38:40 +0200
Message-Id: <20230429103841.6988-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The Nextbook Ares 8A is a x86 ACPI tablet which ships with Android x86
as factory OS. Its DSDT contains a bunch of I2C devices which are not
actually there (the Android x86 kernel fork ignores I2C devices described
in the DSDT).

On this specific model this just not cause resource conflicts, one of
the probe() calls for the non existing i2c_clients actually ends up
toggling a GPIO or executing a _PS3 after a failed probe which turns
the tablet off.

Add a ACPI_QUIRK_SKIP_I2C_CLIENTS for the Nextbook Ares 8 to the
acpi_quirk_skip_dmi_ids table to avoid the bogus i2c_clients and
to fix the tablet turning off during boot because of this.

Also add the "10EC5651" HID for the RealTek ALC5651 codec used
in this tablet to the list of HIDs for which not to skipi2c_client
instantiation, since the Intel SST sound driver relies on
the codec being instantiated through ACPI.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/x86/utils.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
index 9c2d6f35f88a..4cfee2da0675 100644
--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -365,7 +365,7 @@ static const struct dmi_system_id acpi_quirk_skip_dmi_ids[] = {
 					ACPI_QUIRK_SKIP_ACPI_AC_AND_BATTERY),
 	},
 	{
-		/* Nextbook Ares 8 */
+		/* Nextbook Ares 8 (BYT version)*/
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Insyde"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "M890BAP"),
@@ -374,6 +374,16 @@ static const struct dmi_system_id acpi_quirk_skip_dmi_ids[] = {
 					ACPI_QUIRK_SKIP_ACPI_AC_AND_BATTERY |
 					ACPI_QUIRK_SKIP_GPIO_EVENT_HANDLERS),
 	},
+	{
+		/* Nextbook Ares 8A (CHT version)*/
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Insyde"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "CherryTrail"),
+			DMI_MATCH(DMI_BIOS_VERSION, "M882"),
+		},
+		.driver_data = (void *)(ACPI_QUIRK_SKIP_I2C_CLIENTS |
+					ACPI_QUIRK_SKIP_ACPI_AC_AND_BATTERY),
+	},
 	{
 		/* Whitelabel (sold as various brands) TM800A550L */
 		.matches = {
@@ -392,6 +402,7 @@ static const struct dmi_system_id acpi_quirk_skip_dmi_ids[] = {
 #if IS_ENABLED(CONFIG_X86_ANDROID_TABLETS)
 static const struct acpi_device_id i2c_acpi_known_good_ids[] = {
 	{ "10EC5640", 0 }, /* RealTek ALC5640 audio codec */
+	{ "10EC5651", 0 }, /* RealTek ALC5651 audio codec */
 	{ "INT33F4", 0 },  /* X-Powers AXP288 PMIC */
 	{ "INT33FD", 0 },  /* Intel Crystal Cove PMIC */
 	{ "INT34D3", 0 },  /* Intel Whiskey Cove PMIC */
-- 
2.39.2

