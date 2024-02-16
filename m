Return-Path: <linux-acpi+bounces-3588-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7FCE857CC1
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Feb 2024 13:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F1441F21029
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Feb 2024 12:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C7E768F2;
	Fri, 16 Feb 2024 12:37:19 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from hell.raorn.name (unknown [37.252.9.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECC531A6B
	for <linux-acpi@vger.kernel.org>; Fri, 16 Feb 2024 12:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.252.9.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708087039; cv=none; b=n1d9VwzT8P2TkG4PShFCMqrnMHijPSoPEmWYJpQB/4EoVWjVi3QGUj3KvIi5PLF7OIgu/VcPGeTWi8RCh/9FH7scM3biAH2ODGrc7IpRvAsvUtspZuPtmAqqcROFaQj/uBtVrYCmoiUSeEwecKlFUpwIp2h0C3rvY3BUc2sLvtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708087039; c=relaxed/simple;
	bh=UWZZ1tCSUIgv580uC4dqhqq6gXTMHvsRgFSNV+Sw9y4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bVuctqmYQxquRUo1djctZSheXwCTxNsTsGmxdNZxujuPS5jv1FDDIej6LRfFDWxZRVCs2wx7Lpr1I21qD7YspI79PSwjAlDUt8Ob46B7Gps8gOtiLBFjkOagl0PaKj67ajUzt1eZT7boDT2T2VXWghbKBRiZwBZhH/85Xwj1Y/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=raorn.name; spf=none smtp.mailfrom=hell.raorn.name; arc=none smtp.client-ip=37.252.9.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=raorn.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=hell.raorn.name
Received: by hell.raorn.name (Postfix, from userid 1000)
	id E4770402F6; Fri, 16 Feb 2024 12:30:22 +0000 (UTC)
From: "Alexey I. Froloff" <raorn@raorn.name>
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	"Alexey I. Froloff" <raorn@raorn.name>
Subject: [PATCH] ACPI: resource: Do IRQ override on Lunnen Ground laptops
Date: Fri, 16 Feb 2024 12:30:09 +0000
Message-ID: <20240216123009.3530164-1-raorn@raorn.name>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Lunnen Ground 15 and 16 needs IRQ overriding for the keyboard to
work.

Adding an entries for these laptops to the override_table makes the
internal keyboard functional.

Signed-off-by: Alexey I. Froloff <raorn@raorn.name>
---
 drivers/acpi/resource.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index dacad1d846c0..3ebb74eb768a 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -588,6 +588,20 @@ static const struct dmi_system_id irq1_edge_low_force_override[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "GM5RGEE0016COM"),
 		},
 	},
+	{
+		/* Lunnen Ground 15 / AMD Ryzen 5 5500U */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Lunnen"),
+			DMI_MATCH(DMI_BOARD_NAME, "LLL5DAW"),
+		},
+	},
+	{
+		/* Lunnen Ground 16 / AMD Ryzen 7 5800U */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Lunnen"),
+			DMI_MATCH(DMI_BOARD_NAME, "LL6FA"),
+		},
+	},
 	{ }
 };
 
-- 
2.41.0


