Return-Path: <linux-acpi+bounces-4746-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 908B989BD5E
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Apr 2024 12:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C90628404F
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Apr 2024 10:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEED75BADB;
	Mon,  8 Apr 2024 10:36:22 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4262959B72;
	Mon,  8 Apr 2024 10:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712572582; cv=none; b=aTOoemi8NUHTXbARhUh0MsSA5O45b8YTC+W8R3Q4flNQB0L8C99NYcMhz52CpoBx5n48ox8umrgp5EDqWxgXuwCy+kHO8/otIN4La4yLDIbeiWcKnd8GhoRF5FrIhSrc9+mLLHwac96eVA9b01L6TlUp2hFuwmmK50sGLWcXo7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712572582; c=relaxed/simple;
	bh=gRpktIreKlhN1Yuh8WS2iAJBqwB7/ciuEop8v+CVQeI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eic2EC/eDErFcgWKtw+JtBO/4Mjb/Fasi8LDcTyGdyE4h1WSobiwrz9ivLVoATpPRCBossHVGOwFRJd0AjyOYOKLZIvOJaGtuyMvIR/tHfLDEgNiwTFnWA7ABKciln6rW/ZHjopBgwzvIo4SMgvdsYVngDltojgm4puZkCjDczg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id 5BB8E2F20244; Mon,  8 Apr 2024 10:26:47 +0000 (UTC)
X-Spam-Level: 
Received: from altlinux.malta.altlinux.ru (obninsk.basealt.ru [217.15.195.17])
	by air.basealt.ru (Postfix) with ESMTPSA id 06C6A2F20241;
	Mon,  8 Apr 2024 10:26:43 +0000 (UTC)
From: kovalev@altlinux.org
To: stable@vger.kernel.org
Cc: rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	kovalev@altlinux.org
Subject: [PATCH 6.8.y 2/3] ACPI: resource: Add IRQ override quirk for ASUS ExpertBook B2502FBA
Date: Mon,  8 Apr 2024 13:26:37 +0300
Message-Id: <20240408102638.197110-3-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
In-Reply-To: <20240408102638.197110-1-kovalev@altlinux.org>
References: <20240408102638.197110-1-kovalev@altlinux.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sviatoslav Harasymchuk <sviatoslav.harasymchuk@gmail.com>

commit 0793e511c4c66c38dd26add86f7236bcdc70c3b5 upstream.

In order to fix the keyboard on ASUS ExpertBook B2502FBA, add an IRQ
override quirk for it in analogy with how it was done for other members
of this machine family.

Link: https://lore.kernel.org/linux-acpi/20230411183144.6932-1-pmenzel@molgen.mpg.de
Link: https://bugzilla.kernel.org/show_bug.cgi?id=217323
Signed-off-by: Sviatoslav Harasymchuk <sviatoslav.harasymchuk@gmail.com>
[ rjw: Subject and changelog rewrite, fix broken white space ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
 drivers/acpi/resource.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index a273f9791..4fae9af32 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -496,6 +496,13 @@ static const struct dmi_system_id irq1_level_low_skip_override[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "B2502CBA"),
 		},
 	},
+	{
+		/* Asus ExpertBook B2502FBA */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "B2502FBA"),
+		},
+	},
 	{
 		/* Asus Vivobook E1504GA */
 		.matches = {
-- 
2.33.8


