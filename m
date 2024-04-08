Return-Path: <linux-acpi+bounces-4727-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE1D89BD31
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Apr 2024 12:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C6EB1C2127A
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Apr 2024 10:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFCBC56464;
	Mon,  8 Apr 2024 10:32:23 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6968555C07;
	Mon,  8 Apr 2024 10:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712572343; cv=none; b=DjXQX0phgEG0GWOYGCMKqbfeh/bYCpgQ5sqzBUPFJCq3UMHyIFx1MvF/UOnG7KRlRvO5fqk928gj1vMgmE8igPh9Xojtx1mVslS/kTokZvAhX5t4j/Cu1wLqlw+XpqoaztePD0s0VXeFRqHmpTiNWgHzEOQ5heMSrBNq4rhQWcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712572343; c=relaxed/simple;
	bh=yoTDhlWQfE6S6gLckI5sPJKv73dejU/mHkcxeFKARsY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dSzvN5ZpvomtUL+Zqf/eGPfYyHVSfuU8ZiwQVx7Lm+3Nmc3hxufk0YDByIDo0MW+LFfMgvin+Z386Xy36a/WPie0It6k8PvQyVoQZIBqD8RBP8+XfW84ioWy6yaKlCPPcAGy3HlwehFHMMd2kLlVr3EFXD20Q8bDqtHV6Pwdkh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id ED0082F2024A; Mon,  8 Apr 2024 10:32:20 +0000 (UTC)
X-Spam-Level: 
Received: from altlinux.malta.altlinux.ru (obninsk.basealt.ru [217.15.195.17])
	by air.basealt.ru (Postfix) with ESMTPSA id 94EDD2F20253;
	Mon,  8 Apr 2024 10:32:09 +0000 (UTC)
From: kovalev@altlinux.org
To: stable@vger.kernel.org
Cc: rafael@kernel.org,
	lenb@kernel.org,
	pavel@ucw.cz,
	hdegoede@redhat.com,
	linux-acpi@vger.kernel.org,
	kovalev@altlinux.org
Subject: [PATCH 6.1.y 03/14] ACPI: resource: Always use MADT override IRQ settings for all legacy non i8042 IRQs
Date: Mon,  8 Apr 2024 13:31:56 +0300
Message-Id: <20240408103207.197423-4-kovalev@altlinux.org>
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

commit 9728ac221160c5ea111879125a7694bb81364720 upstream.

All the cases, were the DSDT IRQ settings should be used instead of
the MADT override, are for IRQ 1 or 12, the PS/2 kbd resp. mouse IRQs.

Simplify things by always honering the override for other legacy IRQs
(for non DMI quirked cases).

This allows removing the DMI quirks to honor the override for
some non i8042 IRQs on some AMD ZEN based Lenovo models.

Fixes: a9c4a912b7dc ("ACPI: resource: Remove "Zen" specific match and quirks")
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
 drivers/acpi/resource.c | 28 ++++++++--------------------
 1 file changed, 8 insertions(+), 20 deletions(-)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 548fd63ed26927..2a3b8bf58b7ac4 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -484,24 +484,6 @@ static const struct dmi_system_id asus_laptop[] = {
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
@@ -605,8 +587,6 @@ struct irq_override_cmp {
 static const struct irq_override_cmp override_table[] = {
 	{ medion_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
 	{ asus_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
-	{ lenovo_laptop, 6, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, true },
-	{ lenovo_laptop, 10, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, true },
 	{ tongfang_gm_rg, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true },
 	{ maingear_laptop, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true },
 	{ lg_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
@@ -629,6 +609,14 @@ static bool acpi_dev_irq_override(u32 gsi, u8 triggering, u8 polarity,
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
2.33.8


