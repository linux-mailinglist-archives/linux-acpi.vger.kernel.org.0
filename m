Return-Path: <linux-acpi+bounces-4720-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E686589BD1D
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Apr 2024 12:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 999CE282CB2
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Apr 2024 10:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75D4537E0;
	Mon,  8 Apr 2024 10:29:49 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13F9537E6;
	Mon,  8 Apr 2024 10:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712572189; cv=none; b=Up0so4wEq7Y4y25S1sSpug5gsPQ7vjh73u79msTfNk4jFg1msWpiSvjK4dGc8E8U3PqR5aywR434sY4GlpWMgrUCMGLjLCJ5UL5fG/OfzkTVMjsXBMU2B8DtC/kGiZLyEW75OfOWBoSxBOp+mRFg9hQST5Dw+96YSjloleByjTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712572189; c=relaxed/simple;
	bh=PTFvMVvDYhnb7HmN7pbIN0kGHgOz00AaY6aN2z6ykac=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dJ5AAfIs1ulQsIWa0LAGEjXDE9boj7vb2GALUSOXfhKhcF0K3LBO/dTPJe6w/JQhyhXObAfPEoPY55C9SZr0OM2/8u2YCHam8BnJNzspVf6TcERIAkbuXBKuvtzZpEjvQs5MnqYKClMFAKiILcZtJStm6Ms3BqAoI8WkovJEF8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id 3B5E82F2024D; Mon,  8 Apr 2024 10:29:46 +0000 (UTC)
X-Spam-Level: 
Received: from altlinux.malta.altlinux.ru (obninsk.basealt.ru [217.15.195.17])
	by air.basealt.ru (Postfix) with ESMTPSA id 08D612F20240;
	Mon,  8 Apr 2024 10:29:43 +0000 (UTC)
From: kovalev@altlinux.org
To: stable@vger.kernel.org
Cc: rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	kovalev@altlinux.org
Subject: [PATCH 6.6.y 1/7] ACPI: resource: Consolidate IRQ trigger-type override DMI tables
Date: Mon,  8 Apr 2024 13:29:34 +0300
Message-Id: <20240408102940.197282-2-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
In-Reply-To: <20240408102940.197282-1-kovalev@altlinux.org>
References: <20240408102940.197282-1-kovalev@altlinux.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hans de Goede <hdegoede@redhat.com>

commit d37273af0e428e95a34841c1ade16b172db6c2b5 upstream.

Before this patch there were 6 dmi_system_id tables. While looking at
the override_table[] there are only 2 cases:

 1. irq 1, level, active-low, not-shared, skip-override
 2. irq 1, edge, activ-low, shared, force-override

Merge the dmi_system_id tables for identical cases together,
going from 6 dmi_system_id tables and 6 override_table[] entries
to just 2, one for each case.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
 drivers/acpi/resource.c | 52 +++++++++++++++++------------------------
 1 file changed, 21 insertions(+), 31 deletions(-)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index b9d219ac4e6bd7..e2f0e29be968da 100644
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
@@ -481,20 +482,28 @@ static const struct dmi_system_id asus_laptop[] = {
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
@@ -528,10 +537,6 @@ static const struct dmi_system_id maingear_laptop[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "MG-VCP2-17A3070T"),
 		},
 	},
-	{ }
-};
-
-static const struct dmi_system_id pcspecialist_laptop[] = {
 	{
 		/* TongFang GM6BGEQ / PCSpecialist Elimina Pro 16 M, RTX 3050 */
 		.matches = {
@@ -586,17 +591,6 @@ static const struct dmi_system_id pcspecialist_laptop[] = {
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
@@ -607,12 +601,8 @@ struct irq_override_cmp {
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
2.33.8


