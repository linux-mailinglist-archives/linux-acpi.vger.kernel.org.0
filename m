Return-Path: <linux-acpi+bounces-20165-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AD983D1077D
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Jan 2026 04:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11BAD3031943
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Jan 2026 03:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB83330B53A;
	Mon, 12 Jan 2026 03:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="YEW8x8kF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5690530BF6C;
	Mon, 12 Jan 2026 03:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768188196; cv=none; b=JN6bd+UAzfO/3roPX3yzmPv3Zq3GU3+WY6ex2SLGQbKRsu0MP2+X3yBfayRVaLJXvF1QllTgEcp88GcMl4Y9zpQ5niXYkBGEkwxxy0RTykY/3OcJBjS3aU0ZPzEVpgLNkQW7F0zTLoVw1w2IUazAbXx0rEaTDcCGoqHkrdmDoPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768188196; c=relaxed/simple;
	bh=EjcpfmK2f2mvmeDWsGgcadKj9KbU2YZgp7UQBgHZyok=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R2b7efksu7g2831f55B8TEfJZcoDgxzPb/fpCJdGX/Oo0JgiMNQWcuI/NI/G4CcKabWO96BTf5UwTJo6u78q/HeCRRdO3BTlasvlbhOSr9rqeZd/6R1b5k+FoIsl6Dnq3pVY8MNt0dBSdfZAHYsahpxuaxyGvWm7kAvLGHMV7zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=YEW8x8kF; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768188182; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=9zugfGNREVGm2vbmWwuVDINK5SSXPFOU8BSqDdVEy2U=;
	b=YEW8x8kFVYJGONJ+l/tpis11zeqt1y7ATslw4nhSvQI7CjRq0ym41Ohuv3KIhNMUun4uhHlvldGJFR1PYTaTCE1G31Qxxt36k1KkpLu0vEP6XauEhfV/ea3SzLZECgeb/wAP1tuoO/MLzSkGGldwHwdovS6phCTW+1h7IrlMjss=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WwntGAK_1768188180 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 12 Jan 2026 11:23:01 +0800
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
Subject: [PATCH v3 1/3] ACPI: APEI: GHES: Improve ghes_notify_nmi() status check
Date: Mon, 12 Jan 2026 11:22:37 +0800
Message-Id: <20260112032239.30023-2-xueshuai@linux.alibaba.com>
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


