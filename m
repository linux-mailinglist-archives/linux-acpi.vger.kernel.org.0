Return-Path: <linux-acpi+bounces-21021-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cA4cBmRlmGmJHgMAu9opvQ
	(envelope-from <linux-acpi+bounces-21021-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Feb 2026 14:45:08 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B663D167F6F
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Feb 2026 14:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 212F33009140
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Feb 2026 13:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF048346FC0;
	Fri, 20 Feb 2026 13:42:57 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672FB347BBD;
	Fri, 20 Feb 2026 13:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771594977; cv=none; b=rYUTx0FNM3XQmQZQq/bm+zQL8WnSh6Ql5KWx7qplzUz3f7+4dgu0zJdQG8OrqfoD2iQhBwybvUIGuNBq6nXoIRosmK9d4iSN9bqtlPt/9wUWqmx0Lv7+sVKS0JzbyBEE6uDoHXfPC8zEcKWwrHykyXaISgjEExnT9xGhZ9q4tUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771594977; c=relaxed/simple;
	bh=N1f4SRYezXSa/uMOQEX8DB2+1/M96GssxRQ1Pvuw15I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H8P+f62+GkiL0qvJS8pnBDy2gvYlIYpcI8YBtuFJMoCrz0qOcRe807eWQBWlr13REX/pCnDb1OGARz4r6qQQjYEO4pvKsJDU5S9dtdhV/1f5PO1tBtlVyfnisbQA21hbmAoN7bObnkcuYx1JU+CkO8gVvByV1KBZoeVMvqgar0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9128F15A1;
	Fri, 20 Feb 2026 05:42:49 -0800 (PST)
Received: from e134710.arm.com (e134710.arm.com [10.33.10.82])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2CABF3F7D8;
	Fri, 20 Feb 2026 05:42:54 -0800 (PST)
From: Ahmed Tiba <ahmed.tiba@arm.com>
Date: Fri, 20 Feb 2026 13:42:20 +0000
Subject: [PATCH v2 02/11] ACPI: APEI: GHES: add ghes_cper.o stub
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-topics-ahmtib01-ras_ffh_arm_internal_review-v2-2-347fa2d7351b@arm.com>
References: <20260220-topics-ahmtib01-ras_ffh_arm_internal_review-v2-0-347fa2d7351b@arm.com>
In-Reply-To: <20260220-topics-ahmtib01-ras_ffh_arm_internal_review-v2-0-347fa2d7351b@arm.com>
To: devicetree@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: Ahmed Tiba <ahmed.tiba@arm.com>, Dmitry.Lamerov@arm.com, 
 catalin.marinas@arm.com, bp@alien8.de, robh@kernel.org, rafael@kernel.org, 
 will@kernel.org, conor@kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-doc@vger.kernel.org, krzk+dt@kernel.org, Michael.Zhao2@arm.com, 
 tony.luck@intel.com
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771594970; l=1802;
 i=ahmed.tiba@arm.com; s=20260219; h=from:subject:message-id;
 bh=N1f4SRYezXSa/uMOQEX8DB2+1/M96GssxRQ1Pvuw15I=;
 b=/FmPQ9RSvf87rZnccFSFp7h8u0bqVpfz2+RjrpY8dLLsykFUXp2Yuy8NV1lzS63ivedYqXewj
 VybkwdzdWuaCXN+lOuUYGpIrfPUYfz3u094l+axdSkycWzHlHDAEAKh
X-Developer-Key: i=ahmed.tiba@arm.com; a=ed25519;
 pk=xVOtd+Qklh/4tuM3tB+BEZD4jj5a6W59C3KCNX6v7OE=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21021-lists,linux-acpi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi,dt];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ahmed.tiba@arm.com,linux-acpi@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.935];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:mid,arm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B663D167F6F
X-Rspamd-Action: no action

Introduce a dedicated ghes_cper translation unit so that follow-on commits
can move helpers out of ghes.c without touching the build logic twice.
This keeps the object in the tree while remaining functionally identical.

Signed-off-by: Ahmed Tiba <ahmed.tiba@arm.com>
---
 drivers/acpi/apei/Makefile    |  2 +-
 drivers/acpi/apei/ghes_cper.c | 26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/Makefile b/drivers/acpi/apei/Makefile
index 1a0b85923cd4..b3774af70883 100644
--- a/drivers/acpi/apei/Makefile
+++ b/drivers/acpi/apei/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_ACPI_APEI)		+= apei.o
-obj-$(CONFIG_ACPI_APEI_GHES)	+= ghes.o
+obj-$(CONFIG_ACPI_APEI_GHES)	+= ghes.o ghes_cper.o
 # clang versions prior to 18 may blow out the stack with KASAN
 ifeq ($(CONFIG_COMPILE_TEST)_$(CONFIG_CC_IS_CLANG)_$(call clang-min-version, 180000),y_y_)
 KASAN_SANITIZE_ghes.o := n
diff --git a/drivers/acpi/apei/ghes_cper.c b/drivers/acpi/apei/ghes_cper.c
new file mode 100644
index 000000000000..63047322a3d9
--- /dev/null
+++ b/drivers/acpi/apei/ghes_cper.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *
+ * APEI GHES CPER helper translation unit - staging file for helper moves
+ *
+ * Copyright (C) 2026 ARM Ltd.
+ * Author: Ahmed Tiba <ahmed.tiba@arm.com>
+ * Based on ACPI APEI GHES driver.
+ *
+ */
+
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/ratelimit.h>
+#include <linux/slab.h>
+
+#include <acpi/apei.h>
+
+#include <asm/fixmap.h>
+#include <asm/tlbflush.h>
+
+#include "apei-internal.h"
+
+/* Helper bodies will be moved here in follow-up commits. */

-- 
2.43.0


