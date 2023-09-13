Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C9779E67A
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Sep 2023 13:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239937AbjIMLUy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 13 Sep 2023 07:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239921AbjIMLUy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Sep 2023 07:20:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 101971BFE
        for <linux-acpi@vger.kernel.org>; Wed, 13 Sep 2023 04:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694604004;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=tjOymgKqDRYNzY2Dtis0EaBZIJIkiSL7Ryl5retnI0g=;
        b=gnydJCv66v10GSvey5qsRFak8YZmtXGmCRyTsOFDAd+LFvPZeHfv39V+3FIiTWzor7VWIZ
        EQDuSGLbgYQOMh9hc1H4oFkTbVtHB013V06PDeBmkmtZroMWyg4qe9qjylaw34EeTLPvMp
        4Xek6bqXyJ0zLXm8/mvFN9QV4ln+gxo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-690-xTN9z2B_NEu7qSKlcbrDpw-1; Wed, 13 Sep 2023 07:20:00 -0400
X-MC-Unique: xTN9z2B_NEu7qSKlcbrDpw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8D81C811738;
        Wed, 13 Sep 2023 11:20:00 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.194.191])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 043152026D4B;
        Wed, 13 Sep 2023 11:19:59 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org
Subject: [PATCH 1/2] ACPI: resource: Consolidate IRQ trigger-type override DMI tables
Date:   Wed, 13 Sep 2023 13:19:50 +0200
Message-ID: <20230913111951.30414-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Before this patch there were 6 dmi_system_id tables. While looking at
the override_table[] there are only 2 cases:
1. irq 1, level, active-low, not-shared, skip-override
2. irq 1, edge, activ-low, shared, force-override

Merge the dmi_system_id tables for identical cases together,
going from 6 dmi_system_id tables and 6 override_table[] entries
to just 2, one for each case.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Note this applies on top of my recent quirk submission for
the ASUS ExpertBook B1402CBA:
https://lore.kernel.org/linux-acpi/20230912100827.303590-1-hdegoede@redhat.com/
---
 drivers/acpi/resource.c | 52 +++++++++++++++++------------------------
 1 file changed, 21 insertions(+), 31 deletions(-)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 8116b55b6c98..c6bb28db8f30 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -385,7 +385,12 @@ unsigned int acpi_dev_get_irq_type(int triggering, int polarity)
 }
 EXPORT_SYMBOL_GPL(acpi_dev_get_irq_type);
 
-static const struct dmi_system_id medion_laptop[] = {
+/*
+ * DMI matches for boards where the DSDT specifies the kbd IRQ as
+ * level active-low and using the override changes this to rising edge,
+ * stopping the keyboard from working.
+ */
+static const struct dmi_system_id irq1_level_low_skip_override[] = {
 	{
 		.ident = "MEDION P15651",
 		.matches = {
@@ -407,10 +412,6 @@ static const struct dmi_system_id medion_laptop[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "M1xA"),
 		},
 	},
-	{ }
-};
-
-static const struct dmi_system_id asus_laptop[] = {
 	{
 		.ident = "Asus Vivobook K3402ZA",
 		.matches = {
@@ -474,20 +475,28 @@ static const struct dmi_system_id asus_laptop[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "B2502CBA"),
 		},
 	},
+	{
+		.ident = "LG Electronics 17U70P",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LG Electronics"),
+			DMI_MATCH(DMI_BOARD_NAME, "17U70P"),
+		},
+	},
 	{ }
 };
 
-static const struct dmi_system_id tongfang_gm_rg[] = {
+/*
+ * DMI matches for AMD Zen boards where the DSDT specifies the kbd IRQ
+ * as falling edge and this must be overridden to rising edge,
+ * to have a working keyboard.
+ */
+static const struct dmi_system_id irq1_edge_low_force_override[] = {
 	{
 		.ident = "TongFang GMxRGxx/XMG CORE 15 (M22)/TUXEDO Stellaris 15 Gen4 AMD",
 		.matches = {
 			DMI_MATCH(DMI_BOARD_NAME, "GMxRGxx"),
 		},
 	},
-	{ }
-};
-
-static const struct dmi_system_id maingear_laptop[] = {
 	{
 		.ident = "MAINGEAR Vector Pro 2 15",
 		.matches = {
@@ -502,10 +511,6 @@ static const struct dmi_system_id maingear_laptop[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "MG-VCP2-17A3070T"),
 		},
 	},
-	{ }
-};
-
-static const struct dmi_system_id pcspecialist_laptop[] = {
 	{
 		.ident = "PCSpecialist Elimina Pro 16 M",
 		/*
@@ -520,17 +525,6 @@ static const struct dmi_system_id pcspecialist_laptop[] = {
 	{ }
 };
 
-static const struct dmi_system_id lg_laptop[] = {
-	{
-		.ident = "LG Electronics 17U70P",
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "LG Electronics"),
-			DMI_MATCH(DMI_BOARD_NAME, "17U70P"),
-		},
-	},
-	{ }
-};
-
 struct irq_override_cmp {
 	const struct dmi_system_id *system;
 	unsigned char irq;
@@ -541,12 +535,8 @@ struct irq_override_cmp {
 };
 
 static const struct irq_override_cmp override_table[] = {
-	{ medion_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
-	{ asus_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
-	{ tongfang_gm_rg, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true },
-	{ maingear_laptop, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true },
-	{ pcspecialist_laptop, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true },
-	{ lg_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
+	{ irq1_level_low_skip_override, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
+	{ irq1_edge_low_force_override, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true },
 };
 
 static bool acpi_dev_irq_override(u32 gsi, u8 triggering, u8 polarity,
-- 
2.41.0

