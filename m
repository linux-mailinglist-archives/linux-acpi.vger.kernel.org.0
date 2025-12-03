Return-Path: <linux-acpi+bounces-19410-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A3BC9F0A3
	for <lists+linux-acpi@lfdr.de>; Wed, 03 Dec 2025 14:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C60584E3A29
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Dec 2025 13:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11562ECEA7;
	Wed,  3 Dec 2025 13:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ysRdGBc+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780391F4613;
	Wed,  3 Dec 2025 13:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764766991; cv=none; b=rt+fvTnb6ovjxmxAEo5zFSvMckk0pDu01Rt3F78FVkT/L5CRGu0xxnhjg909rr/RflRs3ZGxUZy3FcXvXMSiF3HiFAePs9D4VvJFd9l7tGhuPyQq1dGbVDbw3xYm9vrZM+OihV56lDMvRHPHOy2DuaP6EDXmVf5tqtsppbUwJyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764766991; c=relaxed/simple;
	bh=HekPj9ZJ+aTnXZNv7KcXz1bFRAFUei6fj0c1849WF1I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ns0R72pO9vrQ+E1ZlyVShgUyhzcuBJMUjOraBubg+DMHn/6xhxlGQtDiklNnj+5i0WvCQtsr1GDDy2poDt6infDwMn89hu+UlVCiSOlUOY68q7DeEj4Sh5qTrsFt77ZTvkiS1xriKcR8wA5H7TP1OebfVziWqmKZbHcnk6aUOFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ysRdGBc+; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1764766978; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=54TNbmxJfXXrbNXvt+UsT4z8DDtKwln1bVNlOrDWgRw=;
	b=ysRdGBc+A8NCNsN5zOewG/tJifYM0so9jTRwZ7rM+ex3YipAE1KxbB4vwaJ/qO1cJcELw7E1fqdM7LD3IrsfR6egF51u6AF2+L0ccNy//WZ43k1rPJzihqMpTL4TeaqdAaWKu26oy4tihz8Xmq6Fhc7UnD+cdI76L68q1sboH78=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Wu.aDv-_1764766977 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 03 Dec 2025 21:02:57 +0800
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
Subject: [PATCH 2/3] ACPI: APEI: GHES: Extract helper functions for error status handling
Date: Wed,  3 Dec 2025 21:02:52 +0800
Message-Id: <20251203130253.73888-3-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251203130253.73888-1-xueshuai@linux.alibaba.com>
References: <20251203130253.73888-1-xueshuai@linux.alibaba.com>
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

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 drivers/acpi/apei/ghes.c | 92 +++++++++++++++++++++++++++++++---------
 1 file changed, 72 insertions(+), 20 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 62713b612865..2c7f3ca6ce50 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -1375,6 +1375,74 @@ static int ghes_in_nmi_spool_from_list(struct list_head *rcu_list,
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
+	ghes->error_status_vaddr =
+		acpi_os_ioremap(paddr, sizeof(ghes->estatus->block_status));
+	if (!ghes->error_status_vaddr)
+		return AE_BAD_ADDRESS;
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
 
@@ -1425,20 +1493,9 @@ static LIST_HEAD(ghes_nmi);
 static int ghes_notify_nmi(unsigned int cmd, struct pt_regs *regs)
 {
 	static DEFINE_RAW_SPINLOCK(ghes_notify_lock_nmi);
-	bool active_error = false;
 	int ret = NMI_DONE;
-	struct ghes *ghes;
 
-	rcu_read_lock();
-	list_for_each_entry_rcu(ghes, &ghes_nmi, list) {
-		if (ghes->error_status_vaddr && readl(ghes->error_status_vaddr)) {
-			active_error = true;
-			break;
-		}
-	}
-	rcu_read_unlock();
-
-	if (!active_error)
+	if (!ghes_has_active_errors(&ghes_nmi))
 		return ret;
 
 	if (!atomic_add_unless(&ghes_in_nmi, 1, 1))
@@ -1455,16 +1512,11 @@ static int ghes_notify_nmi(unsigned int cmd, struct pt_regs *regs)
 
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
-		return AE_BAD_ADDRESS;
 
 	mutex_lock(&ghes_list_mutex);
 	if (list_empty(&ghes_nmi))
@@ -1483,8 +1535,7 @@ static void ghes_nmi_remove(struct ghes *ghes)
 		unregister_nmi_handler(NMI_LOCAL, "ghes");
 	mutex_unlock(&ghes_list_mutex);
 
-	if (ghes->error_status_vaddr)
-		iounmap(ghes->error_status_vaddr);
+	ghes_unmap_error_status(ghes);
 
 	/*
 	 * To synchronize with NMI handler, ghes can only be
@@ -1492,6 +1543,7 @@ static void ghes_nmi_remove(struct ghes *ghes)
 	 */
 	synchronize_rcu();
 }
+
 #else /* CONFIG_HAVE_ACPI_APEI_NMI */
 static inline int ghes_nmi_add(struct ghes *ghes) { return -EINVAL; }
 static inline void ghes_nmi_remove(struct ghes *ghes) { }
-- 
2.39.3


