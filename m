Return-Path: <linux-acpi+bounces-19941-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE36CF0E0C
	for <lists+linux-acpi@lfdr.de>; Sun, 04 Jan 2026 13:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F5C1300E3C9
	for <lists+linux-acpi@lfdr.de>; Sun,  4 Jan 2026 12:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBA128DF2D;
	Sun,  4 Jan 2026 12:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="a9jneK2a"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B7828CF66;
	Sun,  4 Jan 2026 12:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767528261; cv=none; b=Pgeh2Tq2Hc/LjK02jaa/e0KE6mrRWGQ7+qjK1zSI+F4JzMjJBc53fmSzRJxc7IwAbinIri2teDnO45KTjGrU8gtqGZ0KwqiPGpIhufGctKZUJqjqEJ3xRtJJnV7POuuZhnYTxURG7ciddLp17WfvAVi8ZxAVyMk1avB5BEEdU2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767528261; c=relaxed/simple;
	bh=EjcpfmK2f2mvmeDWsGgcadKj9KbU2YZgp7UQBgHZyok=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VGtrt8atHut/ZIysxGyUz5uu9vkKRsN71K3v+wn9+GBcI3sQNuSRjdj1NRDstfRL4STpMpHxCjbzp5IbKdLqoyZDkU83NzwIxLuJIS5X4rO/xKI6O3lXbEzvXeDX4GXgGiylOa/hJ1qgFfH3K3dC4CW4pycKM6iH5A864p1Wsh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=a9jneK2a; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1767528250; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=9zugfGNREVGm2vbmWwuVDINK5SSXPFOU8BSqDdVEy2U=;
	b=a9jneK2aO6BLw3gATasMrYrhI2f35a5lLKJh+CETw8dgHfasoM9/sYYFMdZwkLmx5oSv/SWOk8eY+ZKjMqEV+AKDRZLhw4Gmk58n7kUFsPBrUsHGkYsRvXdieiNJqApXSsKgdoos3YBDrgLO8hQZc7gJmKBJ7I9t1l2AwlcpjBc=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WwEgE2C_1767528248 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 04 Jan 2026 20:04:09 +0800
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
Subject: [PATCH v2 1/3] ACPI: APEI: GHES: Improve ghes_notify_nmi() status check
Date: Sun,  4 Jan 2026 20:04:03 +0800
Message-Id: <20260104120405.51555-2-xueshuai@linux.alibaba.com>
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

From: Tony Luck <tony.luck@intel.com>

ghes_notify_nmi() is called for every NMI and must check whether the NMI was
generated because an error was signalled by platform firmware.

This check is very expensive as for each registered GHES NMI source it reads
from the acpi generic address attached to this error source to get the physical
address of the acpi_hest_generic_status block.  It then checks the "block_status"
to see if an error was logged.

The ACPI/APEI code must create virtual mappings for each of those physical
addresses, and tear them down afterwards. On an Icelake system this takes around
15,000 TSC cycles. Enough to disturb efforts to profile system performance.

If that were not bad enough, there are some atomic accesses in the code path
that will cause cache line bounces between CPUs. A problem that gets worse as
the core count increases.

But BIOS changes neither the acpi generic address nor the physical address of
the acpi_hest_generic_status block. So this walk can be done once when the NMI is
registered to save the virtual address (unmapping if the NMI is ever unregistered).
The "block_status" can be checked directly in the NMI handler. This can be done
without any atomic accesses.

Resulting time to check that there is not an error record is around 900 cycles.

Reported-by: Andi Kleen <andi.kleen@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Tested-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 drivers/acpi/apei/ghes.c | 40 +++++++++++++++++++++++++++++++++++++---
 include/acpi/ghes.h      |  1 +
 2 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 0dc767392a6c..0e97d50b0240 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -1456,7 +1456,21 @@ static LIST_HEAD(ghes_nmi);
 static int ghes_notify_nmi(unsigned int cmd, struct pt_regs *regs)
 {
 	static DEFINE_RAW_SPINLOCK(ghes_notify_lock_nmi);
+	bool active_error = false;
 	int ret = NMI_DONE;
+	struct ghes *ghes;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(ghes, &ghes_nmi, list) {
+		if (ghes->error_status_vaddr && readl(ghes->error_status_vaddr)) {
+			active_error = true;
+			break;
+		}
+	}
+	rcu_read_unlock();
+
+	if (!active_error)
+		return ret;
 
 	if (!atomic_add_unless(&ghes_in_nmi, 1, 1))
 		return ret;
@@ -1470,13 +1484,27 @@ static int ghes_notify_nmi(unsigned int cmd, struct pt_regs *regs)
 	return ret;
 }
 
-static void ghes_nmi_add(struct ghes *ghes)
+static int ghes_nmi_add(struct ghes *ghes)
 {
+	struct acpi_hest_generic *g = ghes->generic;
+	u64 paddr;
+	int rc;
+
+	rc = apei_read(&paddr, &g->error_status_address);
+	if (rc)
+		return rc;
+
+	ghes->error_status_vaddr = acpi_os_ioremap(paddr, sizeof(ghes->estatus->block_status));
+	if (!ghes->error_status_vaddr)
+		return -EINVAL;
+
 	mutex_lock(&ghes_list_mutex);
 	if (list_empty(&ghes_nmi))
 		register_nmi_handler(NMI_LOCAL, ghes_notify_nmi, 0, "ghes");
 	list_add_rcu(&ghes->list, &ghes_nmi);
 	mutex_unlock(&ghes_list_mutex);
+
+	return 0;
 }
 
 static void ghes_nmi_remove(struct ghes *ghes)
@@ -1486,6 +1514,10 @@ static void ghes_nmi_remove(struct ghes *ghes)
 	if (list_empty(&ghes_nmi))
 		unregister_nmi_handler(NMI_LOCAL, "ghes");
 	mutex_unlock(&ghes_list_mutex);
+
+	if (ghes->error_status_vaddr)
+		iounmap(ghes->error_status_vaddr);
+
 	/*
 	 * To synchronize with NMI handler, ghes can only be
 	 * freed after NMI handler finishes.
@@ -1493,7 +1525,7 @@ static void ghes_nmi_remove(struct ghes *ghes)
 	synchronize_rcu();
 }
 #else /* CONFIG_HAVE_ACPI_APEI_NMI */
-static inline void ghes_nmi_add(struct ghes *ghes) { }
+static inline int ghes_nmi_add(struct ghes *ghes) { return -EINVAL; }
 static inline void ghes_nmi_remove(struct ghes *ghes) { }
 #endif /* CONFIG_HAVE_ACPI_APEI_NMI */
 
@@ -1661,7 +1693,9 @@ static int ghes_probe(struct platform_device *ghes_dev)
 		ghes_sea_add(ghes);
 		break;
 	case ACPI_HEST_NOTIFY_NMI:
-		ghes_nmi_add(ghes);
+		rc = ghes_nmi_add(ghes);
+		if (rc)
+			goto err;
 		break;
 	case ACPI_HEST_NOTIFY_SOFTWARE_DELEGATED:
 		rc = apei_sdei_register_ghes(ghes);
diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
index ebd21b05fe6e..58655d313a1f 100644
--- a/include/acpi/ghes.h
+++ b/include/acpi/ghes.h
@@ -29,6 +29,7 @@ struct ghes {
 	};
 	struct device *dev;
 	struct list_head elist;
+	void __iomem *error_status_vaddr;
 };
 
 struct ghes_estatus_node {
-- 
2.39.3


