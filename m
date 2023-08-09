Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 488347755F0
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Aug 2023 10:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjHII40 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Aug 2023 04:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbjHII4Y (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Aug 2023 04:56:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6BBA1FCE
        for <linux-acpi@vger.kernel.org>; Wed,  9 Aug 2023 01:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691571335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jh7LjiGp6WQaqELk9dgQUXW17bFjnrA9ZTaHQXUgeqQ=;
        b=T72Kcl6KnjBQfYwruR8nnoyVnuEhd3rkp6fT/Y6HaOtOlsxVFddqvBgaaeTvkyO744miQD
        lL0v673/VhN6w+WCaePhWSL5TwdPLZ0+MCUleTfFudIugustNlgnbAEWtrlBjAxh8HDiX7
        n065ePmubPzT9IRrLtHANpSWl4mkfpI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-556-cHl6x7cqPUuFMBQKqgSf3w-1; Wed, 09 Aug 2023 04:55:31 -0400
X-MC-Unique: cHl6x7cqPUuFMBQKqgSf3w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 63CE58015AA;
        Wed,  9 Aug 2023 08:55:30 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.194.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4DB001121314;
        Wed,  9 Aug 2023 08:55:29 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        August Wikerfors <git@augustwikerfors.se>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        stable@vger.kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org
Subject: [PATCH v3 2/3] ACPI: resource: Always use MADT override IRQ settings for all legacy non i8042 IRQs
Date:   Wed,  9 Aug 2023 10:55:24 +0200
Message-ID: <20230809085526.84913-3-hdegoede@redhat.com>
In-Reply-To: <20230809085526.84913-1-hdegoede@redhat.com>
References: <20230809085526.84913-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

All the cases, were the DSDT IRQ settings should be used instead of
the MADT override, are for IRQ 1 or 12, the PS/2 kbd resp. mouse IRQs.

Simplify things by always honering the override for other legacy IRQs
(for non DMI quirked cases).

This allows removing the DMI quirks to honor the override for
some non i8042 IRQs on some AMD ZEN based Lenovo models.

Fixes: a9c4a912b7dc ("ACPI: resource: Remove "Zen" specific match and quirks")
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
- Also do the ZEN check for IRQ 12 (Reported-by August Wikerfors)
- Move the gsi != 1 && gsi != 12 check to inside the #ifdef CONFIG_X86,
  this being the i8042 IRQs is X86 specific and the "return true;" is
  always done for #ifndef CONFIG_X86 already
---
 drivers/acpi/resource.c | 28 ++++++++--------------------
 1 file changed, 8 insertions(+), 20 deletions(-)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 0800a9d77558..380cda1e86f4 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -470,24 +470,6 @@ static const struct dmi_system_id asus_laptop[] = {
 	{ }
 };
 
-static const struct dmi_system_id lenovo_laptop[] = {
-	{
-		.ident = "LENOVO IdeaPad Flex 5 14ALC7",
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "82R9"),
-		},
-	},
-	{
-		.ident = "LENOVO IdeaPad Flex 5 16ALC7",
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "82RA"),
-		},
-	},
-	{ }
-};
-
 static const struct dmi_system_id tongfang_gm_rg[] = {
 	{
 		.ident = "TongFang GMxRGxx/XMG CORE 15 (M22)/TUXEDO Stellaris 15 Gen4 AMD",
@@ -539,8 +521,6 @@ struct irq_override_cmp {
 static const struct irq_override_cmp override_table[] = {
 	{ medion_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
 	{ asus_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
-	{ lenovo_laptop, 6, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, true },
-	{ lenovo_laptop, 10, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, true },
 	{ tongfang_gm_rg, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true },
 	{ maingear_laptop, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true },
 	{ lg_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
@@ -563,6 +543,14 @@ static bool acpi_dev_irq_override(u32 gsi, u8 triggering, u8 polarity,
 	}
 
 #ifdef CONFIG_X86
+	/*
+	 * Always use the MADT override info, except for the i8042 PS/2 ctrl
+	 * IRQs (1 and 12). For these the DSDT IRQ settings should sometimes
+	 * be used otherwise PS/2 keyboards / mice will not work.
+	 */
+	if (gsi != 1 && gsi != 12)
+		return true;
+
 	/*
 	 * IRQ override isn't needed on modern AMD Zen systems and
 	 * this override breaks active low IRQs on AMD Ryzen 6000 and
-- 
2.41.0

