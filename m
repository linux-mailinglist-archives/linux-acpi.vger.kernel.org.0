Return-Path: <linux-acpi+bounces-4721-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F83389BD1F
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Apr 2024 12:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F1671F22C18
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Apr 2024 10:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DF95380D;
	Mon,  8 Apr 2024 10:29:52 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81843537E6;
	Mon,  8 Apr 2024 10:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712572192; cv=none; b=rfYXuwCzDqP5r9OkONxvqgQm12BVXjIdK8nZpsY8QNc5g2ERRgPRprE3HMj2kPx31hFP0zgBxJIZK5S7HT9yb1fIDjtY4iLdvTWJTgCwTwI6aUSfqaLqwrMD4tkh63YwwInmbOyOk9pU3selb2uSyYVNwzmsbtvNbR4hpwRtIUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712572192; c=relaxed/simple;
	bh=1+2N9VD8aWYC8y5MqMhMYEILaIevx0gzV/OF6Mwttf0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P/G8GPo+E1tuSfRpYieWuhyjNECA2C55CBvjsF5Ij45kirj+JUaCvD36DZZJBM01sxzv+dQ2gOLSby2Fgt5lOrQ9/ICUyxim8ZV3yfmzhSjKd0MVP0ZemrepkNpD/2CnYP7EpId7abOnfr3n/J5/RP2IgMOeWf+f6fkXwmS4qvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id 792BC2F2024E; Mon,  8 Apr 2024 10:29:47 +0000 (UTC)
X-Spam-Level: 
Received: from altlinux.malta.altlinux.ru (obninsk.basealt.ru [217.15.195.17])
	by air.basealt.ru (Postfix) with ESMTPSA id AE4FC2F2024A;
	Mon,  8 Apr 2024 10:29:43 +0000 (UTC)
From: kovalev@altlinux.org
To: stable@vger.kernel.org
Cc: rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	kovalev@altlinux.org
Subject: [PATCH 6.6.y 6/7] ACPI: resource: Add IRQ override quirk for ASUS ExpertBook B2502FBA
Date: Mon,  8 Apr 2024 13:29:39 +0300
Message-Id: <20240408102940.197282-7-kovalev@altlinux.org>
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
index a4f245669d24a5..42b594f5127e4a 100644
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


