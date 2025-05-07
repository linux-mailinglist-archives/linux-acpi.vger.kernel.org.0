Return-Path: <linux-acpi+bounces-13520-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39659AAD43F
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 05:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 557241BC5781
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 03:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493E21B4223;
	Wed,  7 May 2025 03:51:45 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D041157E6B
	for <linux-acpi@vger.kernel.org>; Wed,  7 May 2025 03:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746589905; cv=none; b=cb8LoycI1aHN0NABaSRFsTDeaZ5Or2jgFnzuYsIUVrpooeeT/RRVUfGu3QyJVYFvZHJTSXTwCwkY0FxQ3k6gp1twQwiMV3+EHF8lnJZziS/2FB0DjlB3dD5v5HZO1KqL3C5WVbQdadjeVrhNShxd2mjE0xaxhMxFEX+P+hG5iQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746589905; c=relaxed/simple;
	bh=HssFPwJnOXialEig7OqZyca96au6ThznNufArh2iC5c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rmAKWAc3y2fa0uBsoP2CSR8XfIP4NrYsW8aNB7mn2MmNwcxR3eeUoiBxR8e/fW213h5xGTkpS8OOgxZhm44NBTuY68Bi3sedtsh4EYsafJFbvA3omYGZ82OOCI/RqiHDg/CFxlwRFt4pjs2tu7j15qmIcUBTjprlkNpasRJ3D/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Zsh763nFbz12LYZ;
	Wed,  7 May 2025 11:48:02 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id 48FCF18006C;
	Wed,  7 May 2025 11:51:38 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 7 May 2025 11:51:37 +0800
From: Yicong Yang <yangyicong@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>, <linux-acpi@vger.kernel.org>
CC: <jmeurin@google.com>, <jeremy.linton@arm.com>,
	<jonathan.cameron@huawei.com>, <zhanjie9@hisilicon.com>,
	<prime.zeng@hisilicon.com>, <yangyicong@hisilicon.com>, <linuxarm@huawei.com>
Subject: [PATCH] ACPI: PPTT: Fix table length check when parsing processor nodes
Date: Wed, 7 May 2025 11:51:24 +0800
Message-ID: <20250507035124.28071-1-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd200014.china.huawei.com (7.221.188.8)

From: Yicong Yang <yangyicong@hisilicon.com>

Below error is met on my board and QEMU VM on SMT or non-SMT machine:
  ACPI PPTT: PPTT table found, but unable to locate core 31 (31)

This is because the processor node is found by iterating the PPTT
table under condition (for both acpi_find_processor_node() and
acpi_pptt_leaf_node()):
  while (entry + proc_sz < table_end)
    [parse the processor node]

If the last processor node is happened to be the last node in the
PPTT table, above condition will always be false since
entry + proc_sz == table_end. Thus the last CPU is not parsed.
Fix the loop condition to resolve the issue.

This issue is exposed by [1] but the root cause is explained above.
Before [1] entry + proc_sz is always smaller than table_end.

[1] 7ab4f0e37a0f ("ACPI PPTT: Fix coding mistakes in a couple of sizeof() calls")
Fixes: 2bd00bcd73e5 ("ACPI/PPTT: Add Processor Properties Topology Table parsing")
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/acpi/pptt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
index f73ce6e13065..4364da90902e 100644
--- a/drivers/acpi/pptt.c
+++ b/drivers/acpi/pptt.c
@@ -231,7 +231,7 @@ static int acpi_pptt_leaf_node(struct acpi_table_header *table_hdr,
 			     sizeof(struct acpi_table_pptt));
 	proc_sz = sizeof(struct acpi_pptt_processor);
 
-	while ((unsigned long)entry + proc_sz < table_end) {
+	while ((unsigned long)entry + proc_sz <= table_end) {
 		cpu_node = (struct acpi_pptt_processor *)entry;
 		if (entry->type == ACPI_PPTT_TYPE_PROCESSOR &&
 		    cpu_node->parent == node_entry)
@@ -273,7 +273,7 @@ static struct acpi_pptt_processor *acpi_find_processor_node(struct acpi_table_he
 	proc_sz = sizeof(struct acpi_pptt_processor);
 
 	/* find the processor structure associated with this cpuid */
-	while ((unsigned long)entry + proc_sz < table_end) {
+	while ((unsigned long)entry + proc_sz <= table_end) {
 		cpu_node = (struct acpi_pptt_processor *)entry;
 
 		if (entry->length == 0) {
-- 
2.24.0


