Return-Path: <linux-acpi+bounces-20220-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB91D17016
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Jan 2026 08:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3AA043036B8A
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Jan 2026 07:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA0E36A010;
	Tue, 13 Jan 2026 07:27:39 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CD529D27D;
	Tue, 13 Jan 2026 07:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768289258; cv=none; b=QsTyHCYl0j/kC/880AsY4Rd4YZJHC8QWvO4RRBScCp5s5KOxdp5KwtR/YoJkbyCpVW/uvoZ06C/rxoxDoJw+MAL7jsbnQ0OWlKKBmaIpqAjPwo0kIf5gGENk4kJKlqya4lTFwpmEo4MSl7DQfgEn88tUN6FFXD6AcQPJjRR0pYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768289258; c=relaxed/simple;
	bh=3YzSrbLp3tdyzRSbOfa5ojt4wQPo9QQYconTrApOeXY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=doc/FIm8KEDnhTjKCnCq9JEh+8NdkS7jVKIN04GB7PTmSQhs+9h6cz73+3Rkqfjey9kS0ezDPdtsrvIwPf/dUvFbTFGF8UCmkn5JFlhffG7Xo5ZBRBit1wUDluwez1YAdCxvMVuu36JbVFefxyUHDFKwNCIef9VvZ5fyQGzxORo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 4ddf78a8f05111f0a38c85956e01ac42-20260113
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:6ddf8585-b307-4c6a-8303-942a827bb13d,IP:0,UR
	L:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:20
X-CID-META: VersionHash:a9d874c,CLOUDID:d6d11361c74c7f87bf0e3847698d3fd1,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|898,TC:nil,Content:0|15|50,EDM:5,IP:
	nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,L
	ES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 4ddf78a8f05111f0a38c85956e01ac42-20260113
X-User: aichao@kylinos.cn
Received: from kylin-pc.. [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <aichao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1051817217; Tue, 13 Jan 2026 15:27:23 +0800
From: Ai Chao <aichao@kylinos.cn>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ai Chao <aichao@kylinos.cn>
Subject: [PATCH] ACPI: resource: Add JWIPC JVC9100 to irq1_level_low_skip_override[]
Date: Tue, 13 Jan 2026 15:27:19 +0800
Message-ID: <20260113072719.4154485-1-aichao@kylinos.cn>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Like the JWIPC JVC9100 has its serial IRQ (10 and 11) described
as ActiveLow in the DSDT, which the kernel overrides to EdgeHigh which
breaks the serial.

irq 10, level, active-low, shared, skip-override
irq 11, level, active-low, shared, skip-override

Add the JVC9100 to the irq1_level_low_skip_override[] quirk table to fix
this.

Signed-off-by: Ai Chao <aichao@kylinos.cn>
---
 drivers/acpi/resource.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index d16906f46484..bc8050d8a6f5 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -532,6 +532,12 @@ static const struct dmi_system_id irq1_level_low_skip_override[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "16T90SP"),
 		},
 	},
+	{
+		/* JWIPC JVC9100 */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "JVC9100"),
+		},
+	},
 	{ }
 };
 
@@ -706,6 +712,8 @@ struct irq_override_cmp {
 
 static const struct irq_override_cmp override_table[] = {
 	{ irq1_level_low_skip_override, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
+	{ irq1_level_low_skip_override, 10, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 1, false },
+	{ irq1_level_low_skip_override, 11, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 1, false },
 	{ irq1_edge_low_force_override, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true },
 };
 
-- 
2.47.1


