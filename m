Return-Path: <linux-acpi+bounces-19760-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BAAA5CD562E
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Dec 2025 10:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5EA6A308B84B
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Dec 2025 09:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B083126C8;
	Mon, 22 Dec 2025 09:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="iIA2kEZf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228AF301002;
	Mon, 22 Dec 2025 09:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766396676; cv=none; b=nPc2b40WsENxixE/4HFJzh4x4ebKa3aF4DPOo1cYaODO/VREcG4bv/jZSWSh3YHtQM32bix7uujT6hKyyU+vf3VgQXmRSmxEwjCjKCkrrVIntxPtvvb2Iaqpm1/fqmlzKpuPn3YWBFAoRQDAZDGuCsplM1mkc2vfZB/nEsvVvwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766396676; c=relaxed/simple;
	bh=SO0/560UPK92U6WvkHVzv1MkeC2T9tDsd9Y4GT+sl+s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TzIxvQWIg+iYfpTV8PYLqqHLoCCWXqLrEdvjgxyHGYwBtOugj+KEHfmDVWsxZ7sPEikzaQWY+fzpDN/zYkXfmsMQ54tM7uscaKvY8soEW7c+bmAhhpUCivZEuFTdBW7jZG1NTIrZsITLwZWQ5gbRAidm6ZwhvN6pCLnThYNVe6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=iIA2kEZf; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1766396665; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=72cxXQagokwmA/cZnex2Pm94HvbMxhBEqjUGllZTVzo=;
	b=iIA2kEZfqEB0N+vusbQqkBnO5BonRWHtz21fniMNqnd7PHuOdYjLTnoYYM7X2dsue7coqtgu7uJVo3N//aZA08uE5OspyPN/ENLQnyFu9tIzGptB2tTuwz612a/rRyEbI73tXs4lctwBmtgsEr83lVgzOIJ0nmbJtScjl/Kc2iY=
Received: from localhost(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0WvOT.TX_1766396662 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 22 Dec 2025 17:44:24 +0800
From: Ruidong Tian <tianruidong@linux.alibaba.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	lpieralisi@kernel.org,
	guohanjun@huawei.com,
	sudeep.holla@arm.com,
	xueshuai@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	rafael@kernel.org,
	lenb@kernel.org,
	tony.luck@intel.com,
	bp@alien8.de,
	yazen.ghannam@amd.com,
	misono.tomohiro@fujitsu.com
Cc: tianruidong@linux.alibaba.com
Subject: [PATCH v4 09/17] ras: AEST: Add cpuhp callback
Date: Mon, 22 Dec 2025 17:43:42 +0800
Message-Id: <20251222094351.38792-10-tianruidong@linux.alibaba.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20251222094351.38792-1-tianruidong@linux.alibaba.com>
References: <20251222094351.38792-1-tianruidong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the configuration of interrupts and CE thresholds
into the CPU hotplug callbacks for the per-CPU AEST node.

Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
---
 drivers/ras/aest/aest-core.c | 118 ++++++++++++++++++++++++++++++++++-
 drivers/ras/aest/aest.h      |   5 ++
 include/linux/cpuhotplug.h   |   1 +
 3 files changed, 121 insertions(+), 3 deletions(-)

diff --git a/drivers/ras/aest/aest-core.c b/drivers/ras/aest/aest-core.c
index 5ec0ba38f51b..686dde6f2e68 100644
--- a/drivers/ras/aest/aest-core.c
+++ b/drivers/ras/aest/aest-core.c
@@ -5,6 +5,7 @@
  * Copyright (c) 2025, Alibaba Group.
  */
 
+#include <linux/cpu.h>
 #include <linux/interrupt.h>
 #include <linux/panic.h>
 #include <linux/platform_device.h>
@@ -563,8 +564,6 @@ static int aest_init_record(struct aest_record *record, int i,
 	record->addressing_mode = test_bit(i, node->info->addressing_mode);
 	record->index = i;
 	record->node = node;
-	aest_set_ce_threshold(record);
-	aest_enable_irq(record);
 
 	aest_record_dbg(record, "base: %p, index: %d, address mode: %x\n",
 			record->regs_base, record->index,
@@ -572,9 +571,113 @@ static int aest_init_record(struct aest_record *record, int i,
 	return 0;
 }
 
+static void aest_online_record(struct aest_record *record, void *data)
+{
+	if (record_read(record, ERXFR) & ERR_FR_CE)
+		aest_set_ce_threshold(record);
+
+	aest_enable_irq(record);
+}
+
+static void aest_online_oncore_node(struct aest_node *node)
+{
+	int count;
+
+	count = aest_proc(node);
+	aest_node_dbg(node, "Find %d error on CPU%d before AEST probe\n", count,
+		      smp_processor_id());
+
+	aest_node_foreach_record(aest_online_record, node, NULL,
+				 node->record_implemented);
+
+	aest_node_foreach_record(aest_online_record, node, NULL,
+				 node->status_reporting);
+}
+
+static void aest_online_oncore_dev(void *data)
+{
+	int fhi_irq, eri_irq, i;
+	struct aest_device *adev = this_cpu_ptr(data);
+
+	for (i = 0; i < adev->node_cnt; i++)
+		aest_online_oncore_node(&adev->nodes[i]);
+
+	fhi_irq = adev->irq[ACPI_AEST_NODE_FAULT_HANDLING];
+	if (fhi_irq > 0)
+		enable_percpu_irq(fhi_irq, IRQ_TYPE_NONE);
+	eri_irq = adev->irq[ACPI_AEST_NODE_ERROR_RECOVERY];
+	if (eri_irq > 0)
+		enable_percpu_irq(eri_irq, IRQ_TYPE_NONE);
+}
+
+static void aest_offline_oncore_dev(void *data)
+{
+	int fhi_irq, eri_irq;
+	struct aest_device *adev = this_cpu_ptr(data);
+
+	fhi_irq = adev->irq[ACPI_AEST_NODE_FAULT_HANDLING];
+	if (fhi_irq > 0)
+		disable_percpu_irq(fhi_irq);
+	eri_irq = adev->irq[ACPI_AEST_NODE_ERROR_RECOVERY];
+	if (eri_irq > 0)
+		disable_percpu_irq(eri_irq);
+}
+
+static void aest_online_dev(struct aest_device *adev)
+{
+	int count, i;
+	struct aest_node *node;
+
+	for (i = 0; i < adev->node_cnt; i++) {
+		node = &adev->nodes[i];
+
+		if (!node->name)
+			continue;
+
+		count = aest_proc(node);
+		aest_node_dbg(node, "Find %d error before AEST probe\n", count);
+
+		aest_config_irq(node);
+
+		aest_node_foreach_record(aest_online_record, node, NULL,
+					 node->record_implemented);
+		aest_node_foreach_record(aest_online_record, node, NULL,
+					 node->status_reporting);
+	}
+}
+
+static int aest_starting_cpu(unsigned int cpu)
+{
+	pr_debug("CPU%d starting\n", cpu);
+	aest_online_oncore_dev(&percpu_adev);
+
+	return 0;
+}
+
+static int aest_dying_cpu(unsigned int cpu)
+{
+	pr_debug("CPU%d dying\n", cpu);
+	aest_offline_oncore_dev(&percpu_adev);
+
+	return 0;
+}
+
 static void aest_device_remove(struct platform_device *pdev)
 {
+	struct aest_device *adev = platform_get_drvdata(pdev);
+	int i;
+
 	platform_set_drvdata(pdev, NULL);
+
+	if (adev->type != ACPI_AEST_PROCESSOR_ERROR_NODE)
+		return;
+
+	on_each_cpu(aest_offline_oncore_dev, adev->adev_oncore, 1);
+
+	for (i = 0; i < MAX_GSI_PER_NODE; i++) {
+		if (adev->irq[i])
+			free_percpu_irq(adev->irq[i], adev->adev_oncore);
+	}
 }
 
 static char *alloc_aest_node_name(struct aest_node *node)
@@ -682,7 +785,6 @@ static int aest_init_node(struct aest_device *adev, struct aest_node *node,
 				return -ENOMEM;
 		}
 	}
-	aest_config_irq(node);
 
 	ret = aest_node_set_errgsr(adev, node);
 	if (ret)
@@ -826,6 +928,16 @@ static int aest_device_probe(struct platform_device *pdev)
 		aest_dev_err(adev, "register irq failed\n");
 		return ret;
 	}
+
+	if (aest_dev_is_oncore(adev))
+		ret = cpuhp_setup_state(CPUHP_AP_ARM_AEST_STARTING,
+					"drivers/acpi/arm64/aest:starting",
+					aest_starting_cpu, aest_dying_cpu);
+	else
+		aest_online_dev(adev);
+	if (ret)
+		return ret;
+
 	platform_set_drvdata(pdev, adev);
 
 	aest_dev_dbg(adev, "Node cnt: %x, id: %x\n", adev->node_cnt, adev->id);
diff --git a/drivers/ras/aest/aest.h b/drivers/ras/aest/aest.h
index a5e43b2a2e90..f85e81ff35a6 100644
--- a/drivers/ras/aest/aest.h
+++ b/drivers/ras/aest/aest.h
@@ -339,3 +339,8 @@ static inline void aest_sync(struct aest_node *node)
 	if (node->type == ACPI_AEST_PROCESSOR_ERROR_NODE)
 		isb();
 }
+
+static inline bool aest_dev_is_oncore(struct aest_device *adev)
+{
+	return adev->type == ACPI_AEST_PROCESSOR_ERROR_NODE;
+}
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 62cd7b35a29c..831fe9011943 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -179,6 +179,7 @@ enum cpuhp_state {
 	CPUHP_AP_HYPERV_TIMER_STARTING,
 	/* Must be the last timer callback */
 	CPUHP_AP_DUMMY_TIMER_STARTING,
+	CPUHP_AP_ARM_AEST_STARTING,
 	CPUHP_AP_ARM_XEN_STARTING,
 	CPUHP_AP_ARM_XEN_RUNSTATE_STARTING,
 	CPUHP_AP_ARM_CORESIGHT_STARTING,
-- 
2.51.2.612.gdc70283dfc


