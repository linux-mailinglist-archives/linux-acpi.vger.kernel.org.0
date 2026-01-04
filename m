Return-Path: <linux-acpi+bounces-19943-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E11CF0E12
	for <lists+linux-acpi@lfdr.de>; Sun, 04 Jan 2026 13:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FAEA302515A
	for <lists+linux-acpi@lfdr.de>; Sun,  4 Jan 2026 12:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC1F299947;
	Sun,  4 Jan 2026 12:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="FIOXNJKE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C2A28D8DB;
	Sun,  4 Jan 2026 12:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767528262; cv=none; b=O3mqphIJK0M1CxHPqAvaBA8Z+F2qs0l/3AGOwroS5ZrHA5DsuD2lmH4A/xdnsCkR88joj/N/DJQY3QuifzEZy669Fhz9Dw+TMNly5f8758SpIUK0EAP8UwEdO5wd159Z+TnzKfc4AvTLkfZHrIuMv6k70uDRSxssR9ogLYMwigU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767528262; c=relaxed/simple;
	bh=+yG4ASuQ3wFAiT5Wn8HaJDjCY4lydCVFPIKNxc4A43w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fp4BOS6W1/LBJQ7AYO7sn1Y724lf2ZPq2znTONzbDtH5PlexNTVa7+rC4aJ2KZCYqUtjrECN8O0h1lOl4b1g1qxMGH6BKvJPI9lsKhzPtC16Oq+jLHzaYK/rmyMgxtcqrqKazvRzh/Pdq0yx1d1D+rbguOsImgBdorHYYt2OZek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=FIOXNJKE; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1767528251; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=rA/+4xI3RvOZjVwQ64dz/oUbsz3ktsyt8aBgFuftpK4=;
	b=FIOXNJKETIHA4hWew7q7ucQK3c5ujOWqHAi57rX2RA7lH1UHo/Oa/Q5O0rIT2mkF6uRMebJ+exO02ZBS7c80lB8kBpA7UtJzDBlfSMOteCxMq1hTF/TBjyLXb5nHI91wdI3LiH/ZFY7oXUWIiv/Xh3mTaqi6P3viT26tT1MYSsA=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WwEgE3T_1767528249 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 04 Jan 2026 20:04:10 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: tony.luck@intel.com,
	guohanjun@huawei.com,
	mchehab@kernel.org,
	yazen.ghannam@amd.com
Cc: dave.jiang@intel.com,
	Smita.KoralahalliChannabasappa@amd.com,
	leitao@debian.org,
	pengdonglin@xiaomi.com,
	xueshuai@linux.alibaba.com,
	baolin.wang@linux.alibaba.com,
	benjamin.cheatham@amd.com,
	bp@alien8.de,
	dan.j.williams@intel.com,
	james.morse@arm.com,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rafael@kernel.org,
	zhuo.song@linux.alibaba.com
Subject: [PATCH v2 2/3] ACPI: APEI: GHES: Extract helper functions for error status handling
Date: Sun,  4 Jan 2026 20:04:04 +0800
Message-Id: <20260104120405.51555-3-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260104120405.51555-1-xueshuai@linux.alibaba.com>
References: <20260104120405.51555-1-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactors the GHES driver by extracting common functionality into
reusable helper functions:

1. ghes_has_active_errors() - Checks if any error sources in a given list
   have active errors
2. ghes_map_error_status() - Maps error status address to virtual address
3. ghes_unmap_error_status() - Unmaps error status virtual address

These helpers eliminate code duplication in the NMI path and prepare for
similar usage in the SEA path in a subsequent patch.

No functional change intended.

Tested-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 drivers/acpi/apei/ghes.c | 93 +++++++++++++++++++++++++++++++---------
 1 file changed, 72 insertions(+), 21 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 0e97d50b0240..7600063fe263 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -1406,6 +1406,75 @@ static int ghes_in_nmi_spool_from_list(struct list_head *rcu_list,
 	return ret;
 }
 
+/**
+ * ghes_has_active_errors - Check if there are active errors in error sources
+ * @ghes_list: List of GHES entries to check for active errors
+ *
+ * This function iterates through all GHES entries in the given list and
+ * checks if any of them has active error status by reading the error
+ * status register.
+ *
+ * Return: true if at least one source has active error, false otherwise.
+ */
+static bool __maybe_unused ghes_has_active_errors(struct list_head *ghes_list)
+{
+	bool active_error = false;
+	struct ghes *ghes;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(ghes, ghes_list, list) {
+		if (ghes->error_status_vaddr &&
+		    readl(ghes->error_status_vaddr)) {
+			active_error = true;
+			break;
+		}
+	}
+	rcu_read_unlock();
+
+	return active_error;
+}
+
+/**
+ * ghes_map_error_status - Map error status address to virtual address
+ * @ghes: pointer to GHES structure
+ *
+ * Reads the error status address from ACPI HEST table and maps it to a virtual
+ * address that can be accessed by the kernel.
+ *
+ * Return: 0 on success, error code on failure.
+ */
+static int __maybe_unused ghes_map_error_status(struct ghes *ghes)
+{
+	struct acpi_hest_generic *g = ghes->generic;
+	u64 paddr;
+	int rc;
+
+	rc = apei_read(&paddr, &g->error_status_address);
+	if (rc)
+		return rc;
+
+	ghes->error_status_vaddr =
+		acpi_os_ioremap(paddr, sizeof(ghes->estatus->block_status));
+	if (!ghes->error_status_vaddr)
+		return -EINVAL;
+
+	return 0;
+}
+
+/**
+ * ghes_unmap_error_status - Unmap error status virtual address
+ * @ghes: pointer to GHES structure
+ *
+ * Unmaps the error status address if it was previously mapped.
+ */
+static void __maybe_unused ghes_unmap_error_status(struct ghes *ghes)
+{
+	if (ghes->error_status_vaddr) {
+		iounmap(ghes->error_status_vaddr);
+		ghes->error_status_vaddr = NULL;
+	}
+}
+
 #ifdef CONFIG_ACPI_APEI_SEA
 static LIST_HEAD(ghes_sea);
 
@@ -1456,20 +1525,9 @@ static LIST_HEAD(ghes_nmi);
 static int ghes_notify_nmi(unsigned int cmd, struct pt_regs *regs)
 {
 	static DEFINE_RAW_SPINLOCK(ghes_notify_lock_nmi);
-	bool active_error = false;
 	int ret = NMI_DONE;
-	struct ghes *ghes;
-
-	rcu_read_lock();
-	list_for_each_entry_rcu(ghes, &ghes_nmi, list) {
-		if (ghes->error_status_vaddr && readl(ghes->error_status_vaddr)) {
-			active_error = true;
-			break;
-		}
-	}
-	rcu_read_unlock();
 
-	if (!active_error)
+	if (!ghes_has_active_errors(&ghes_nmi))
 		return ret;
 
 	if (!atomic_add_unless(&ghes_in_nmi, 1, 1))
@@ -1486,18 +1544,12 @@ static int ghes_notify_nmi(unsigned int cmd, struct pt_regs *regs)
 
 static int ghes_nmi_add(struct ghes *ghes)
 {
-	struct acpi_hest_generic *g = ghes->generic;
-	u64 paddr;
 	int rc;
 
-	rc = apei_read(&paddr, &g->error_status_address);
+	rc = ghes_map_error_status(ghes);
 	if (rc)
 		return rc;
 
-	ghes->error_status_vaddr = acpi_os_ioremap(paddr, sizeof(ghes->estatus->block_status));
-	if (!ghes->error_status_vaddr)
-		return -EINVAL;
-
 	mutex_lock(&ghes_list_mutex);
 	if (list_empty(&ghes_nmi))
 		register_nmi_handler(NMI_LOCAL, ghes_notify_nmi, 0, "ghes");
@@ -1515,8 +1567,7 @@ static void ghes_nmi_remove(struct ghes *ghes)
 		unregister_nmi_handler(NMI_LOCAL, "ghes");
 	mutex_unlock(&ghes_list_mutex);
 
-	if (ghes->error_status_vaddr)
-		iounmap(ghes->error_status_vaddr);
+	ghes_unmap_error_status(ghes);
 
 	/*
 	 * To synchronize with NMI handler, ghes can only be
-- 
2.39.3


