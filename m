Return-Path: <linux-acpi+bounces-19610-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B009ACC6D2F
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Dec 2025 10:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FF523062BF7
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Dec 2025 09:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B5D33B6D8;
	Wed, 17 Dec 2025 09:33:15 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E05277CAF;
	Wed, 17 Dec 2025 09:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765963995; cv=none; b=ajWwZky9AbUCbwywTDAdS8vGQmjb9MCf1fvociUYyXaNjplA1BjkQlerjhohcWtoE5EEzGLk3PE/1IAI8QJowa15+ezAKAdhZGO2ZZXhsDjJo32u/glUMXAFm8pFKfu0pO3Hxo4Z8KpQg7K93RQycxyErRuDiHUTaVXyJa/UVK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765963995; c=relaxed/simple;
	bh=lhUAAyW2nf5zdVzrWdMqP/A+MUrbyUVRmzZVyRzSO7k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lONDMNGN3Pe9VzWtDBYsc5LKk4QEBOGE6FPvdri36xxoAFYYEh2OC4bJG+j6lIIGKyBF5CUWD3O5wpL1bz2U86Gz0BaIa9cdR9uPEeODRuhLgP5LGwjOj7OY5jEDlNEKZ31ckpAlKxNrJ4bXpOteR6Y4qfLHgv89C6jxEz/fSVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 660e0c0edb2b11f0a38c85956e01ac42-20251217
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:1f1ef67e-943d-4777-b55f-52c99ce21a9e,IP:0,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-5
X-CID-META: VersionHash:a9d874c,CLOUDID:2e41b52dafa57e876e5c1268609958da,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|123|850|898,TC:nil,Content:0|15|50,E
	DM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 660e0c0edb2b11f0a38c85956e01ac42-20251217
X-User: fengchenguang@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <fengchenguang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 172906047; Wed, 17 Dec 2025 17:33:09 +0800
From: fengchenguang@kylinos.cn
To: rafael@kernel.org
Cc: lenb@kernel.org,
	robert.moore@intel.com,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	fengchenguang <fengchenguang@kylinos.cn>,
	k2ci <kernel-bot@kylinos.cn>
Subject: [PATCH] ACPICA: Fix RSDP signature validation to avoid -Wstringop-overread
Date: Wed, 17 Dec 2025 17:33:04 +0800
Message-Id: <20251217093304.116728-1-fengchenguang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: fengchenguang <fengchenguang@kylinos.cn>

The RSDP signature is an 8-byte binary identifier,not a NUL-terminated
C string. Using strncmp() on it triggers a -Wstringop-overread warning
with GCC 8+, because the source operand is smaller than the requested
compare length of 8 bytes.

Replace strncmp() with memcmp() for exact 8-byte binary comparison,
and remove the redundant (sizeof(a) < 8) conditional, as the RSDP
signature field is always 8 bytes per the ACPI specification.

Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: fengchenguang <fengchenguang@kylinos.cn>
---
 include/acpi/actypes.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 8fe893d776dd..3714b197b1dd 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -527,7 +527,7 @@ typedef u64 acpi_integer;
 
 /* Support for the special RSDP signature (8 characters) */
 
-#define ACPI_VALIDATE_RSDP_SIG(a)       (!strncmp (ACPI_CAST_PTR (char, (a)), ACPI_SIG_RSDP, (sizeof(a) < 8) ? ACPI_NAMESEG_SIZE : 8))
+#define ACPI_VALIDATE_RSDP_SIG(a)       (!memcmp(ACPI_CAST_PTR(char, (a)), ACPI_SIG_RSDP, 8))
 #define ACPI_MAKE_RSDP_SIG(dest)        (memcpy (ACPI_CAST_PTR (char, (dest)), ACPI_SIG_RSDP, 8))
 
 /* Support for OEMx signature (x can be any character) */
-- 
2.25.1


