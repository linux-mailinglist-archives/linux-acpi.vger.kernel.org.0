Return-Path: <linux-acpi+bounces-19498-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B65D4CAF229
	for <lists+linux-acpi@lfdr.de>; Tue, 09 Dec 2025 08:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B9361300C370
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Dec 2025 07:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865CA2868B4;
	Tue,  9 Dec 2025 07:29:20 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD512868AB;
	Tue,  9 Dec 2025 07:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765265360; cv=none; b=ShUR49bUIit85i+t/zOHsrWXDSmSMc0zZJ7/jp8LahRsI/xhvKxOjQzsBocV6351qfMpM9YJvcyruhCuNHz3VEcvR9rbLd1guMbytfxSVOE/GPFjcuqx5qHdezKMR4nOBqFS3IOSrR0jh598NXb6uKfiuJdpbN+gD7yszlO28fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765265360; c=relaxed/simple;
	bh=M//Kglc8Mjqi5Hj01Y3yWTLsrAAhyGA9laPJ2cDVUgA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F2yz/CzwkGdg1MSV9pAKUUMU6AjvMIHJyeva8hvKZjvor/69ghuObOt47h9o3AmspXrebyqGAdhXJOEv5gEPnohld0AXr4cP9mGJ08w/HPEvMy/mO2AiyERuAwBKBvudKBnkkdUSEOEGgkLX8y/gKAK1TSiZimwWGObd4bm3FIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: bfcbc6ded4d011f0a38c85956e01ac42-20251209
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:70b9dc01-c464-4773-b65d-57da3c9e2462,IP:15,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:-30,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:5
X-CID-INFO: VERSION:1.3.6,REQID:70b9dc01-c464-4773-b65d-57da3c9e2462,IP:15,URL
	:0,TC:0,Content:-5,EDM:25,RT:0,SF:-30,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:5
X-CID-META: VersionHash:a9d874c,CLOUDID:d2e1b453e34067f4b6bfc02e2ad16eff,BulkI
	D:251209152908USZPRCNP,BulkQuantity:0,Recheck:0,SF:10|66|78|102|127|850|89
	8,TC:nil,Content:0|15|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil
	,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: bfcbc6ded4d011f0a38c85956e01ac42-20251209
X-User: pengcan@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <pengcan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1852824346; Tue, 09 Dec 2025 15:29:08 +0800
From: Can Peng <pengcan@kylinos.cn>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Can Peng <pengcan@kylinos.cn>
Subject: [PATCH] acpi: use LIST_HEAD for stack-allocated list in acpi_watchdog_init
Date: Tue,  9 Dec 2025 15:27:57 +0800
Message-Id: <20251209072757.3110467-1-pengcan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the separate declaration of 'resource_list' and subsequent
INIT_LIST_HEAD() call with LIST_HEAD(), which declares and initializes
the list head in one idiomatic step. This reduces code verbosity and
aligns with common kernel coding patterns, without functional change.

Signed-off-by: Can Peng <pengcan@kylinos.cn>
---
 drivers/acpi/acpi_watchdog.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/acpi/acpi_watchdog.c b/drivers/acpi/acpi_watchdog.c
index 14b24157799c..709993c535d1 100644
--- a/drivers/acpi/acpi_watchdog.c
+++ b/drivers/acpi/acpi_watchdog.c
@@ -103,7 +103,7 @@ void __init acpi_watchdog_init(void)
 {
 	const struct acpi_wdat_entry *entries;
 	const struct acpi_table_wdat *wdat;
-	struct list_head resource_list;
+	LIST_HEAD(resource_list);
 	struct resource_entry *rentry;
 	struct platform_device *pdev;
 	struct resource *resources;
@@ -125,8 +125,6 @@ void __init acpi_watchdog_init(void)
 	    wdat->pci_device != 0xff || wdat->pci_function != 0xff)
 		goto fail_put_wdat;
 
-	INIT_LIST_HEAD(&resource_list);
-
 	entries = (struct acpi_wdat_entry *)(wdat + 1);
 	for (i = 0; i < wdat->entries; i++) {
 		const struct acpi_generic_address *gas;
-- 
2.25.1


