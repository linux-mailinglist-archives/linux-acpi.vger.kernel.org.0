Return-Path: <linux-acpi+bounces-4733-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1444289BD3D
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Apr 2024 12:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45DA41C2111A
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Apr 2024 10:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655AA57882;
	Mon,  8 Apr 2024 10:32:30 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E5257332;
	Mon,  8 Apr 2024 10:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712572350; cv=none; b=DQ7cbDXW/AANPzkun8wW3lm2IeCyVQvrGhcOEAcxIBCVPUSADabxipdm3YHpsZdi6lWisYgPRvdx+XMt382b0pZKOy0cJPfmHOdTm8c923x8Yr5lkhCtk3aJbLCU3l9moN2WrvB9TG0QSxmGfbTJSV74rrAvdJCPeKy0Y/LtnVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712572350; c=relaxed/simple;
	bh=mndJf29iEej2EkWzUYBmNEMOuaaJfmsB3kDkrrmDq3c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZgaiWVycrqSa9A3sBSVOQQk7m+AqNKJylLbtHpu29olJODFcc1lIkpM2355GhnvLLEKtjHwgHHuGXmBx84sZzblSelGOarGWU6JvygyETVYztjQFhToK5cCJ9/44Q8v4RoB5FvcNyjXLMVZTPk+Y11EwBFAblmmEZhjS8ny9mmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id 7389E2F20272; Mon,  8 Apr 2024 10:32:27 +0000 (UTC)
X-Spam-Level: 
Received: from altlinux.malta.altlinux.ru (obninsk.basealt.ru [217.15.195.17])
	by air.basealt.ru (Postfix) with ESMTPSA id 201EE2F20246;
	Mon,  8 Apr 2024 10:32:10 +0000 (UTC)
From: kovalev@altlinux.org
To: stable@vger.kernel.org
Cc: rafael@kernel.org,
	lenb@kernel.org,
	pavel@ucw.cz,
	hdegoede@redhat.com,
	linux-acpi@vger.kernel.org,
	kovalev@altlinux.org
Subject: [PATCH 6.1.y 10/14] ACPI: resource: Add DMI quirks for ASUS Vivobook E1504GA and E1504GAB
Date: Mon,  8 Apr 2024 13:32:03 +0300
Message-Id: <20240408103207.197423-11-kovalev@altlinux.org>
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

From: Ben Mayo <benny1091@gmail.com>

commit d2aaf19965045f70bb2ece514399cdc6fcce2e73 upstream.

Asus Vivobook E1504GA and E1504GAB notebooks are affected by bug #216158
(DSDT specifies the kbd IRQ as level active-low and using the override
changes this to rising edge, stopping the keyboard from working).

Users of these notebooks do not have a working keyboard unless they add
their DMI information to the struct irq1_level_low_skip_override array
and compile a custom kernel.

Add support for these computers to the Linux kernel without requiring
the end-user to recompile the kernel.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=216158
Signed-off-by: Ben Mayo <benny1091@gmail.com>
[ rjw: Link tag, subject and changelog edits ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
 drivers/acpi/resource.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index c8dbe3cc3bbae0..d5cac22b6b7261 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -482,6 +482,20 @@ static const struct dmi_system_id irq1_level_low_skip_override[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "B2502CBA"),
 		},
 	},
+	{
+		/* Asus Vivobook E1504GA */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "E1504GA"),
+		},
+	},
+	{
+		/* Asus Vivobook E1504GAB */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "E1504GAB"),
+		},
+	},
 	{
 		/* LG Electronics 17U70P */
 		.matches = {
-- 
2.33.8


