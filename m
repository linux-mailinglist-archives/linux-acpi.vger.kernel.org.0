Return-Path: <linux-acpi+bounces-4738-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE6189BD46
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Apr 2024 12:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A18531F22A8B
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Apr 2024 10:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39795A4CC;
	Mon,  8 Apr 2024 10:32:32 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8F057332;
	Mon,  8 Apr 2024 10:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712572352; cv=none; b=UHbCuJpSEWz9TgONgSc0srwkiOpB89P19Iy8lm7+EfbCdvjC1EQK6NJz9qnRuyqa57tqMvi8uoQsa8s6hKMKPxXggFbSxIlCjP09yIc8Cc5zMP6RMTK75fpfDsrsR6FCuIcCd6D8Z6hc2hBq97vHNLGYnyT1MjI6Tz0geLnIa/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712572352; c=relaxed/simple;
	bh=L5PsDvROCzEJTldIxbTQR0ExfypJnOAw9pFOQLdMB80=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cGrlhMNWLzpK3rxWFs8EEi5Anb5gdrOWYSyxbgO63qWNcERklCzxIcrdI3+ImCGWP7oxYUaP3OP47zDMybq2A/u9zXrCpC6Z5ygC6kc7Ds0Vx/g3ZvIM/Q2EiWOUjpLtdxmGCiK2NG3qZezHpfDNEXypHTxFXA/8p46wh/zj5O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id 8A0652F20254; Mon,  8 Apr 2024 10:32:29 +0000 (UTC)
X-Spam-Level: 
Received: from altlinux.malta.altlinux.ru (obninsk.basealt.ru [217.15.195.17])
	by air.basealt.ru (Postfix) with ESMTPSA id E0E542F20257;
	Mon,  8 Apr 2024 10:32:09 +0000 (UTC)
From: kovalev@altlinux.org
To: stable@vger.kernel.org
Cc: rafael@kernel.org,
	lenb@kernel.org,
	pavel@ucw.cz,
	hdegoede@redhat.com,
	linux-acpi@vger.kernel.org,
	kovalev@altlinux.org
Subject: [PATCH 6.1.y 07/14] ACPI: resource: Consolidate IRQ trigger-type override DMI tables
Date: Mon,  8 Apr 2024 13:32:00 +0300
Message-Id: <20240408103207.197423-8-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
In-Reply-To: <20240408103207.197423-1-kovalev@altlinux.org>
References: <20240408103207.197423-1-kovalev@altlinux.org>
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
index a14a1adaac99a0..54bd6919f719c8 100644
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
 		.ident = "PCSpecialist Elimina Pro 16 M",
 		/*
@@ -543,17 +548,6 @@ static const struct dmi_system_id pcspecialist_laptop[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "GM6BGEQ"),
 		},
 	},
-	{ }
-};
-
-static const struct dmi_system_id lg_laptop[] = {
-	{
-		.ident = "LG Electronics 17U70P",
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "LG Electronics"),
-			DMI_MATCH(DMI_BOARD_NAME, "17U70P"),
-		},
-	},
 	{
 		/* Infinity E15-5A165-BM */
 		.matches = {
@@ -600,12 +594,8 @@ struct irq_override_cmp {
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


