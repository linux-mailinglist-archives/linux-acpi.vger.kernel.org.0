Return-Path: <linux-acpi+bounces-13627-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA52AAF12A
	for <lists+linux-acpi@lfdr.de>; Thu,  8 May 2025 04:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75BEF7BC17A
	for <lists+linux-acpi@lfdr.de>; Thu,  8 May 2025 02:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62638C1E;
	Thu,  8 May 2025 02:30:50 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7831EF1D;
	Thu,  8 May 2025 02:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746671450; cv=none; b=LRzqR6IHmfUeyf9O/i0f1+5fbxhxe/svf6cZko37M0KeSP8INGp9AVjOaMbPe2PXqGWg4Cdh/tXgoPoLnawvo0bwBUtrI0uJhuDBkvI5cI69uN7WuXt+ijSFiqMUyPUzXPhQDyFkprZaycxLnVknkRdIzqmdIPQfDPJ5HsJNGcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746671450; c=relaxed/simple;
	bh=GLeMnowwZZvRZ60BgiiBk1gBJRid4rdu40b029b9ne8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dIJNlE4JoHCJX1Bx7BakOgPJ5eZZmgdaN/F8Ks8hneuIHx3BSHFlSH8E3DqjXgMTYKscB1+D6IUDQLPdeKmOPFaz5Y/UMrB5oeQYNubVLIZF+qDDNO05ixBkE6VONUYdAiMVj6zKY2ldbIB8s/KMGgXmy81rYF2zxSQ+ggoYrJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8ABA3106F;
	Wed,  7 May 2025 19:30:36 -0700 (PDT)
Received: from u200865.usa.arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 97B933F5A1;
	Wed,  7 May 2025 19:30:46 -0700 (PDT)
From: Jeremy Linton <jeremy.linton@arm.com>
To: rafael@kernel.org
Cc: lenb@kernel.org,
	jmeurin@google.com,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sudeep.holla@arm.com,
	Jeremy Linton <jeremy.linton@arm.com>,
	Maximilian Heyne <mheyne@amazon.de>,
	Yicong Yang <yangyicong@hisilicon.com>,
	stable@vger.kernel.org
Subject: [PATCH] ACPI: PPTT: Fix processor subtable walk
Date: Wed,  7 May 2025 21:30:25 -0500
Message-ID: <20250508023025.1301030-1-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The original PPTT code had a bug where the processor subtable length
was not correctly validated when encountering a truncated
acpi_pptt_processor node.

Commit 7ab4f0e37a0f4 ("ACPI PPTT: Fix coding mistakes in a couple of
sizeof() calls") attempted to fix this by validating the size is as
large as the acpi_pptt_processor node structure. This introduced a
regression where the last processor node in the PPTT table is ignored
if it doesn't contain any private resources. That results errors like:

  ACPI PPTT: PPTT table found, but unable to locate core XX (XX)
  ACPI: SPE must be homogeneous

Furthermore, it fail in a common case where the node length isn't
equal to the acpi_pptt_processor structure size, leaving the original
bug in a modified form.

Correct the regression by adjusting the loop termination conditions as
suggested by the bug reporters. An additional check performed after
the subtable node type is detected, validates the acpi_pptt_processor
node is fully contained in the PPTT table. Repeating the check in
acpi_pptt_leaf_node() is largely redundant as the node is already
known to be fully contained in the table.

The case where a final truncated node's parent property is accepted,
but the node itself is rejected should not be considered a bug.

Fixes: 7ab4f0e37a0f4 ("ACPI PPTT: Fix coding mistakes in a couple of sizeof() calls")
Reported-by: Maximilian Heyne <mheyne@amazon.de>
Closes: https://lore.kernel.org/linux-acpi/20250506-draco-taped-15f475cd@mheyne-amazon/
Reported-by: Yicong Yang <yangyicong@hisilicon.com>
Closes: https://lore.kernel.org/linux-acpi/20250507035124.28071-1-yangyicong@huawei.com/
Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
Cc: Jean-Marc Eurin <jmeurin@google.com>
Cc: <stable@vger.kernel.org>
---
 drivers/acpi/pptt.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
index f73ce6e13065..54676e3d82dd 100644
--- a/drivers/acpi/pptt.c
+++ b/drivers/acpi/pptt.c
@@ -231,16 +231,18 @@ static int acpi_pptt_leaf_node(struct acpi_table_header *table_hdr,
 			     sizeof(struct acpi_table_pptt));
 	proc_sz = sizeof(struct acpi_pptt_processor);
 
-	while ((unsigned long)entry + proc_sz < table_end) {
+	/* ignore subtable types that are smaller than a processor node */
+	while ((unsigned long)entry + proc_sz <= table_end) {
 		cpu_node = (struct acpi_pptt_processor *)entry;
+
 		if (entry->type == ACPI_PPTT_TYPE_PROCESSOR &&
 		    cpu_node->parent == node_entry)
 			return 0;
 		if (entry->length == 0)
 			return 0;
+
 		entry = ACPI_ADD_PTR(struct acpi_subtable_header, entry,
 				     entry->length);
-
 	}
 	return 1;
 }
@@ -273,15 +275,18 @@ static struct acpi_pptt_processor *acpi_find_processor_node(struct acpi_table_he
 	proc_sz = sizeof(struct acpi_pptt_processor);
 
 	/* find the processor structure associated with this cpuid */
-	while ((unsigned long)entry + proc_sz < table_end) {
+	while ((unsigned long)entry + proc_sz <= table_end) {
 		cpu_node = (struct acpi_pptt_processor *)entry;
 
 		if (entry->length == 0) {
 			pr_warn("Invalid zero length subtable\n");
 			break;
 		}
+		/* entry->length may not equal proc_sz, revalidate the processor structure length */
 		if (entry->type == ACPI_PPTT_TYPE_PROCESSOR &&
 		    acpi_cpu_id == cpu_node->acpi_processor_id &&
+		    (unsigned long)entry + entry->length <= table_end &&
+		    entry->length == proc_sz + cpu_node->number_of_priv_resources * sizeof(u32) &&
 		     acpi_pptt_leaf_node(table_hdr, cpu_node)) {
 			return (struct acpi_pptt_processor *)entry;
 		}
-- 
2.49.0


