Return-Path: <linux-acpi+bounces-4744-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7285C89BD5A
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Apr 2024 12:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11D071F23041
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Apr 2024 10:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B286C5A4CC;
	Mon,  8 Apr 2024 10:36:22 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425ED59B6D;
	Mon,  8 Apr 2024 10:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712572582; cv=none; b=bzlLHFpAB6+QoY0P2/DHzozcTFYeyGOIVY+V5tfDxae4IlybeyizvdqL1ovuKz9Oz2RuUXWoDAvW5u0YeA1iGgcgS5knGZTVsbrxADoixpWH3FcDZPMugrbGkyyFglkXko3mgYQxLfqIzma7lBkH2e8nu1fnZfj1yVePFISJnBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712572582; c=relaxed/simple;
	bh=/RvF07PURD/oc3Eshwiuqgr320XHmt9Axd7J83dKiQg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MqLkTzRnOOPILunLxJ0EsqbmyB3EvwhR0YMsWcutW96K9RgHpfKwPpIZmAT91QShwzANwgMW5EequIOKMRSFa7K1jhWtPTcZ9610CdGC/AEUlhBkI+RErDLiAKI9FCxjcSZQgctceKRxwAVDxcvzE34lCgjHx0RgdwGG6bDSNPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id 8DE0A2F20245; Mon,  8 Apr 2024 10:26:51 +0000 (UTC)
X-Spam-Level: 
Received: from altlinux.malta.altlinux.ru (obninsk.basealt.ru [217.15.195.17])
	by air.basealt.ru (Postfix) with ESMTPSA id E397A2F20240;
	Mon,  8 Apr 2024 10:26:42 +0000 (UTC)
From: kovalev@altlinux.org
To: stable@vger.kernel.org
Cc: rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	kovalev@altlinux.org
Subject: [PATCH 6.8.y 1/3] ACPI: resource: Skip IRQ override on ASUS ExpertBook B1502CVA
Date: Mon,  8 Apr 2024 13:26:36 +0300
Message-Id: <20240408102638.197110-2-kovalev@altlinux.org>
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

From: Nicolas Haye <nicolas.haye@proton.me>

commit ca3afc2806046f626a1518f160a564b90f141f95 upstream.

Like many b1502 models,
the b1502CVA keyboard doesn't work because of an ACPI DSDT table that
describes IRQ 1 as ActiveLow while the kernel overrides it to Edge_High.

Signed-off-by: Nicolas Haye <nicolas.haye@proton.me>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
 drivers/acpi/resource.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index c843feb02..a273f9791 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -468,6 +468,13 @@ static const struct dmi_system_id irq1_level_low_skip_override[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "B1502CGA"),
 		},
 	},
+	{
+		/* Asus ExpertBook B1502CVA */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "B1502CVA"),
+		},
+	},
 	{
 		/* Asus ExpertBook B2402CBA */
 		.matches = {
-- 
2.33.8


