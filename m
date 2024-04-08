Return-Path: <linux-acpi+bounces-4724-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E573D89BD25
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Apr 2024 12:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1743282D0C
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Apr 2024 10:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50033537E8;
	Mon,  8 Apr 2024 10:29:57 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FFE535DC;
	Mon,  8 Apr 2024 10:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712572197; cv=none; b=n03FJr8y/NpoceJiPEWkDDAb+bMFPz5zTfJF0kgHexppszIKfKLSSdxUcSM/uiL+ljdO/yGld5daysX6FwYQh8Q0nShHi9kx4ly8eAs5LrQIHj2KgcDQWgCflMkFbyr3CElFrIcRHvClq3pWKKniYZLoTvg2KgAo6ZfJhOrOqaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712572197; c=relaxed/simple;
	bh=+cN7o7hPhIAUl5sTEHnd8z150qQKCMpzIJpmLSl2Lyo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b2+TcvSHwgnsAyR4UpX1TNQwBRipbpge1EBnkKdFm567oo5yIN0xxlqiIOLYI9XmDJWle2/d3qohw9vh4iE0ydEtM9wFi8sJfUw5QrDW4AI52w9yPsLvbiUYPggkiPCztnt1VGpZfcJR84hvWtPpqpBDj0Z75slJrbcFlhMsgDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id 2D5F42F20240; Mon,  8 Apr 2024 10:29:53 +0000 (UTC)
X-Spam-Level: 
Received: from altlinux.malta.altlinux.ru (obninsk.basealt.ru [217.15.195.17])
	by air.basealt.ru (Postfix) with ESMTPSA id 8C3922F20248;
	Mon,  8 Apr 2024 10:29:43 +0000 (UTC)
From: kovalev@altlinux.org
To: stable@vger.kernel.org
Cc: rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	kovalev@altlinux.org
Subject: [PATCH 6.6.y 4/7] ACPI: resource: Skip IRQ override on ASUS ExpertBook B1502CGA
Date: Mon,  8 Apr 2024 13:29:37 +0300
Message-Id: <20240408102940.197282-5-kovalev@altlinux.org>
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

From: Michael Maltsev <mekosko@projectyo.network>

commit e315e8692f7922cd1b2a26bd7a1741cc8ce77085 upstream.

Like the ASUS ExpertBook B1502CBA and various ASUS laptops, the
ASUS ExpertBook B1502CGA has an ACPI DSDT table that describes IRQ 1 as
ActiveLow while the kernel overrides it to Edge_High.

	$ sudo dmesg | grep DMI
	[    0.000000] DMI: ASUSTeK COMPUTER INC. ASUS EXPERTBOOK B1502CGA_B1502CGA/B1502CGA, BIOS B1502CGA.303 06/05/2023
	$ grep -A 40 PS2K dsdt.dsl | grep IRQ -A 1
	                IRQ (Level, ActiveLow, Exclusive, )
	                    {1}

This prevents the keyboard from working. To fix this issue, add this laptop
to the skip_override_table so that the kernel does not override IRQ 1.

Signed-off-by: Michael Maltsev <mekosko@projectyo.network>
[ rjw: rebase, replace .ident field with a comment ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
 drivers/acpi/resource.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index d5cac22b6b7261..5697ccf902184e 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -461,6 +461,13 @@ static const struct dmi_system_id irq1_level_low_skip_override[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "B1502CBA"),
 		},
 	},
+	{
+		/* Asus ExpertBook B1502CGA */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "B1502CGA"),
+		},
+	},
 	{
 		/* Asus ExpertBook B2402CBA */
 		.matches = {
-- 
2.33.8


