Return-Path: <linux-acpi+bounces-4722-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7DE889BD21
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Apr 2024 12:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05AFF1C20EC9
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Apr 2024 10:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA819537E6;
	Mon,  8 Apr 2024 10:29:52 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C155953804;
	Mon,  8 Apr 2024 10:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712572192; cv=none; b=srY1kc/VSJZPG3nr60SPPQDZdZMx5CtQ9KiZglzbIpxxFGKSIRPc+JoivvvFukN0T2iny0qnxuD1YrvPkUHR2sQ6rE6xUQiB74G4O9E23Qs90x8eNgtP6wDm79gBs2CHR/CSIDvSmt72DkbZBENRnLtPf/ZYJGEDlZWsw5ZoXjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712572192; c=relaxed/simple;
	bh=WcJlW0bbCGCnieVzXfQK9uuyv9kCHdVF4tmp7O2B1TA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ezn2RhT9o7WXwTwKOyKoZf5usRQkXnzolLLRog2tn7zpSvDxh1pReuCIQFqwvI7CZNiH8tNTx6Hg650u2H8iiy141/5T39d0Eu7AbnF60OyvgZBqEDqwP6FtMcxW4YITmni7FYP8yy3zLLYOxXCmDX88VeiQNeo/tineN3ZF9tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id DA15E2F2024A; Mon,  8 Apr 2024 10:29:48 +0000 (UTC)
X-Spam-Level: 
Received: from altlinux.malta.altlinux.ru (obninsk.basealt.ru [217.15.195.17])
	by air.basealt.ru (Postfix) with ESMTPSA id 538582F20246;
	Mon,  8 Apr 2024 10:29:43 +0000 (UTC)
From: kovalev@altlinux.org
To: stable@vger.kernel.org
Cc: rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	kovalev@altlinux.org
Subject: [PATCH 6.6.y 2/7] ACPI: resource: Drop .ident values from dmi_system_id tables
Date: Mon,  8 Apr 2024 13:29:35 +0300
Message-Id: <20240408102940.197282-3-kovalev@altlinux.org>
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

commit 424009ab203086288dcd183d3ab48d243eb31268 upstream.

The dmi_system_id.ident values are not used, replace the
.ident = "$ident" lines with /* $ident */ to drop the unused strings
from the text section.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
 drivers/acpi/resource.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index e2f0e29be968da..c8dbe3cc3bbae0 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -392,56 +392,56 @@ EXPORT_SYMBOL_GPL(acpi_dev_get_irq_type);
  */
 static const struct dmi_system_id irq1_level_low_skip_override[] = {
 	{
-		.ident = "MEDION P15651",
+		/* MEDION P15651 */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "MEDION"),
 			DMI_MATCH(DMI_BOARD_NAME, "M15T"),
 		},
 	},
 	{
-		.ident = "MEDION S17405",
+		/* MEDION S17405 */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "MEDION"),
 			DMI_MATCH(DMI_BOARD_NAME, "M17T"),
 		},
 	},
 	{
-		.ident = "MEDION S17413",
+		/* MEDION S17413 */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "MEDION"),
 			DMI_MATCH(DMI_BOARD_NAME, "M1xA"),
 		},
 	},
 	{
-		.ident = "Asus Vivobook K3402ZA",
+		/* Asus Vivobook K3402ZA */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
 			DMI_MATCH(DMI_BOARD_NAME, "K3402ZA"),
 		},
 	},
 	{
-		.ident = "Asus Vivobook K3502ZA",
+		/* Asus Vivobook K3502ZA */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
 			DMI_MATCH(DMI_BOARD_NAME, "K3502ZA"),
 		},
 	},
 	{
-		.ident = "Asus Vivobook S5402ZA",
+		/* Asus Vivobook S5402ZA */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
 			DMI_MATCH(DMI_BOARD_NAME, "S5402ZA"),
 		},
 	},
 	{
-		.ident = "Asus Vivobook S5602ZA",
+		/* Asus Vivobook S5602ZA */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
 			DMI_MATCH(DMI_BOARD_NAME, "S5602ZA"),
 		},
 	},
 	{
-		.ident = "Asus ExpertBook B1402CBA",
+		/* Asus ExpertBook B1402CBA */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
 			DMI_MATCH(DMI_BOARD_NAME, "B1402CBA"),
@@ -455,35 +455,35 @@ static const struct dmi_system_id irq1_level_low_skip_override[] = {
 		},
 	},
 	{
-		.ident = "Asus ExpertBook B1502CBA",
+		/* Asus ExpertBook B1502CBA */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
 			DMI_MATCH(DMI_BOARD_NAME, "B1502CBA"),
 		},
 	},
 	{
-		.ident = "Asus ExpertBook B2402CBA",
+		/* Asus ExpertBook B2402CBA */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
 			DMI_MATCH(DMI_BOARD_NAME, "B2402CBA"),
 		},
 	},
 	{
-		.ident = "Asus ExpertBook B2402FBA",
+		/* Asus ExpertBook B2402FBA */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
 			DMI_MATCH(DMI_BOARD_NAME, "B2402FBA"),
 		},
 	},
 	{
-		.ident = "Asus ExpertBook B2502",
+		/* Asus ExpertBook B2502 */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
 			DMI_MATCH(DMI_BOARD_NAME, "B2502CBA"),
 		},
 	},
 	{
-		.ident = "LG Electronics 17U70P",
+		/* LG Electronics 17U70P */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "LG Electronics"),
 			DMI_MATCH(DMI_BOARD_NAME, "17U70P"),
@@ -499,13 +499,13 @@ static const struct dmi_system_id irq1_level_low_skip_override[] = {
  */
 static const struct dmi_system_id irq1_edge_low_force_override[] = {
 	{
-		.ident = "TongFang GMxRGxx/XMG CORE 15 (M22)/TUXEDO Stellaris 15 Gen4 AMD",
+		/* TongFang GMxRGxx/XMG CORE 15 (M22)/TUXEDO Stellaris 15 Gen4 AMD */
 		.matches = {
 			DMI_MATCH(DMI_BOARD_NAME, "GMxRGxx"),
 		},
 	},
 	{
-		.ident = "MAINGEAR Vector Pro 2 15",
+		/* MAINGEAR Vector Pro 2 15 */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Micro Electronics Inc"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "MG-VCP2-15A3070T"),
@@ -531,7 +531,7 @@ static const struct dmi_system_id irq1_edge_low_force_override[] = {
 		},
 	},
 	{
-		.ident = "MAINGEAR Vector Pro 2 17",
+		/* MAINGEAR Vector Pro 2 17 */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Micro Electronics Inc"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "MG-VCP2-17A3070T"),
-- 
2.33.8


