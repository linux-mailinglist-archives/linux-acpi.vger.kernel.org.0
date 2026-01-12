Return-Path: <linux-acpi+bounces-20166-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B040D107BC
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Jan 2026 04:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 98CDC3046D9D
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Jan 2026 03:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7F930BBA6;
	Mon, 12 Jan 2026 03:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="YX0r1cG2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE5930BF70;
	Mon, 12 Jan 2026 03:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768188507; cv=none; b=HFbBXh/kCBCzOoo/Pd59yOyO8bRvduB8T6TMtrUZw4h276k7MfmaMv538r+TmMAv4iI4dAViRtvm9j/fbykPcCbmoHxcpgvGyIj2rkzjy9Equ/Wd+ZI0ANSvuKt3a4BKPt/UsFSrI59Xao4dP2nWUNHyQcIyhJyxkSA9Xvov7GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768188507; c=relaxed/simple;
	bh=/+7RyikOx6Y8xjff3hsTk+7cmhFUEZwzKAELI86nzJk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pAUbuqWxypqB8E8H4cIJ6KgKb9V0b9PfO7dQLKOm0qwMApFF+UA9wF7iya/6AtF4MscwYG32ilxypWWRMjZXtZB0XxXmjndO6S9g6U8SaITvouGl0sqrIy5DqXCHeN/6lOOVimjETwsyl2bGWYWqvir1s9VP75Bo1it/cKxYAdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=YX0r1cG2; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768188503; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=jVXbu33Rox+JP+16U3/i/HczkmRcLEypOGPZGgVqn7s=;
	b=YX0r1cG2UM8YF5GiU/XyAOHTjx7X3edDmzwQi0o2TUq4jgWbO65gBK4r1lQ6aL3QUDI4ZmGwwrVQsHJblKIYyvadUnKLYjVOiKy3WHjqXlkpvOXvtp17xjl61PWX0hNNLEZJa3N6JY/kBVBZ0R7lM8Jpy0lkKgRc0x0q3rSraN8=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WwntGBr_1768188181 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 12 Jan 2026 11:23:03 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: tony.luck@intel.com,
	guohanjun@huawei.com,
	mchehab@kernel.org,
	dolinux.peng@gmail.com,
	yazen.ghannam@amd.com,
	rafael@kernel.org
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
	zhuo.song@linux.alibaba.com
Subject: [PATCH v3 2/3] ACPI: APEI: GHES: Extract helper functions for error status handling
Date: Mon, 12 Jan 2026 11:22:38 +0800
Message-Id: <20260112032239.30023-3-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260112032239.30023-1-xueshuai@linux.alibaba.com>
References: <20260112032239.30023-1-xueshuai@linux.alibaba.com>
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
4. Use `guard(rcu)()` instead of explicit `rcu_read_lock()`/`rcu_read_unlock()`.

These helpers eliminate code duplication in the NMI path and prepare for
similar usage in the SEA path in a subsequent patch.

No functional change intended.

Tested-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 drivers/acpi/apei/ghes.c | 89 ++++++++++++++++++++++++++++++----------
 1 file changed, 68 insertions(+), 21 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 0e97d50b0240..b2f06bb96450 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -1406,6 +1406,71 @@ static int ghes_in_nmi_spool_from_list(struct list_head *rcu_list,
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
+	struct ghes *ghes;
+
+	guard(rcu)();
+	list_for_each_entry_rcu(ghes, ghes_list, list) {
+		if (ghes->error_status_vaddr &&
+		    readl(ghes->error_status_vaddr))
+			return true;
+	}
+
+	return false;
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
 
@@ -1456,20 +1521,9 @@ static LIST_HEAD(ghes_nmi);
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
@@ -1486,18 +1540,12 @@ static int ghes_notify_nmi(unsigned int cmd, struct pt_regs *regs)
 
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
@@ -1515,8 +1563,7 @@ static void ghes_nmi_remove(struct ghes *ghes)
 		unregister_nmi_handler(NMI_LOCAL, "ghes");
 	mutex_unlock(&ghes_list_mutex);
 
-	if (ghes->error_status_vaddr)
-		iounmap(ghes->error_status_vaddr);
+	ghes_unmap_error_status(ghes);
 
 	/*
 	 * To synchronize with NMI handler, ghes can only be
-- 
2.39.3


