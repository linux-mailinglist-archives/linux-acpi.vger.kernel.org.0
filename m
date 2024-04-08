Return-Path: <linux-acpi+bounces-4741-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCB789BD4D
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Apr 2024 12:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63AD11F214B1
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Apr 2024 10:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2EE95A11C;
	Mon,  8 Apr 2024 10:32:34 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6FC101C6;
	Mon,  8 Apr 2024 10:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712572354; cv=none; b=bhnlsoWfI5nzYkjOMUpAoEJBeYEoxHdvTbeixe0SqhzmZvY4pIoXRZX6Z9abreKArpbEe5VkoO3MHylkBrYZ5Yb0Fd483w/FlOQvPid9b1T8XJ7vg4OYd1smR4Q+Vv2DvDdgNbiqx3+HEjuLgEQFqK8UJs45/tH0h2mxGtQ3Lxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712572354; c=relaxed/simple;
	bh=gJHFBUDlINjXvuU9E8gnt4auKG05LEKIOw1LNr7SZOI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pgVz+kq1/LuN8rLMcswGBhLGaNH5DBqIyAe7WpTK3XsVz5oOHnp7GC39l3skT2/S+HmRfilLTywBeKYMp8gcvQTTYg1d6zCxkGH9IGfxKgDhg8ksimAQeWdG7nwSDMFnl+/ChHIX09imrSDOuqTT0PxL+wMHvfLGeot7Cp4K2+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id 8EDDF2F2027B; Mon,  8 Apr 2024 10:32:31 +0000 (UTC)
X-Spam-Level: 
Received: from altlinux.malta.altlinux.ru (obninsk.basealt.ru [217.15.195.17])
	by air.basealt.ru (Postfix) with ESMTPSA id 0E6D92F20259;
	Mon,  8 Apr 2024 10:32:10 +0000 (UTC)
From: kovalev@altlinux.org
To: stable@vger.kernel.org
Cc: rafael@kernel.org,
	lenb@kernel.org,
	pavel@ucw.cz,
	hdegoede@redhat.com,
	linux-acpi@vger.kernel.org,
	kovalev@altlinux.org
Subject: [PATCH 6.1.y 09/14] ACPI: resource: Add TongFang GM6BGEQ, GM6BG5Q and GM6BG0Q to irq1_edge_low_force_override[]
Date: Mon,  8 Apr 2024 13:32:02 +0300
Message-Id: <20240408103207.197423-10-kovalev@altlinux.org>
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

commit f9b3ea02555e67e2e7bf95219953b88d122bd275 upstream.

The TongFang GM6BGEQ, GM6BG5Q and GM6BG0Q are 3 GPU variants of a TongFang
barebone design which is sold under various brand names.

The ACPI IRQ override for the keyboard IRQ must be used on these AMD Zen
laptops in order for the IRQ to work.

Adjust the pcspecialist_laptop[] DMI match table for this:

1. Drop the sys-vendor match from the existing PCSpecialist Elimina Pro 16
   entry for the GM6BGEQ (RTX3050 GPU) model so that it will also match
   the laptop when sold by other vendors such as hyperbook.pl.

2. Add board-name matches for the GM6BG5Q (RTX4050) and GM6B0Q (RTX4060)
   models.

Note the .ident values of the dmi_system_id structs are left unset
since these are not used.

Suggested-by: August Wikerfors <git@augustwikerfors.se>
Reported-by: Francesco <f.littarru@outlook.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217394
Link: https://laptopparts4less.frl/index.php?route=product/search&filter_name=GM6BG
Link: https://hyperbook.pl/en/content/14-hyperbook-drivers
Link: https://linux-hardware.org/?probe=bfa70344e3
Link: https://bbs.archlinuxcn.org/viewtopic.php?id=13313
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
 drivers/acpi/resource.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index ef5a08c1596031..c8dbe3cc3bbae0 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -538,16 +538,23 @@ static const struct dmi_system_id irq1_edge_low_force_override[] = {
 		},
 	},
 	{
-		.ident = "PCSpecialist Elimina Pro 16 M",
-		/*
-		 * Some models have product-name "Elimina Pro 16 M",
-		 * others "GM6BGEQ". Match on board-name to match both.
-		 */
+		/* TongFang GM6BGEQ / PCSpecialist Elimina Pro 16 M, RTX 3050 */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "PCSpecialist"),
 			DMI_MATCH(DMI_BOARD_NAME, "GM6BGEQ"),
 		},
 	},
+	{
+		/* TongFang GM6BG5Q, RTX 4050 */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "GM6BG5Q"),
+		},
+	},
+	{
+		/* TongFang GM6BG0Q / PCSpecialist Elimina Pro 16 M, RTX 4060 */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "GM6BG0Q"),
+		},
+	},
 	{
 		/* Infinity E15-5A165-BM */
 		.matches = {
-- 
2.33.8


