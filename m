Return-Path: <linux-acpi+bounces-1772-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 856C07F5676
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Nov 2023 03:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ACB1280F30
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Nov 2023 02:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26915237
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Nov 2023 02:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EsNUlLAi"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2001810E;
	Wed, 22 Nov 2023 16:35:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N1XvTZfNRcrRd2MuYkCQjMYULBgviYgqvazSUPYrqefJk2mshCQZfkltGr21koZeHBtWnflzfbtnx3SQqP5cs9ZiLIg/A+Euwtg0kxku/u4MzxZs1EokVADGroPLBeEzcWi8YHAEAZlZRiAOkpQJmY1QDUNDLXrZ46VAea4a5AOyyxinZO+N+FkY2vioj6XEUxF4e3UtLxkxqBHYMrdp5HfQGjuxYdpURx/hD895IlbLwnsjMqeh8J9bCdvJ6nK2isSwoKlTGA10I3n/VCPR1mIfhmkLX3w5hjljbcctGZIEC/cDNHFtqodWgc6b07cvJFN/ZQe/PShecUs4JkJU+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j6/Dl8yhwAb5WUiC75w/2oRU4+hYo1CMEdhyj99a+C4=;
 b=Uf9sUYztyLwosFs4qNHNbWDOSpJUETcVD8UFN6orBNPET/3rlo7kV+0WGVRIwkpqfovsGVt6FYDvSAGxQDUSFOPBsmX2I+H1FV8Gh93nf7Ry+/etPxk1ULvMP33BlsamBIfrd3WqFR8vy1LyKER9TVgDTqrsZ0z7N1s6FxBjJex/QmZcZZWVylgVKSrATJdopMlHwJFzS+0Gn//iqWp6g3L8pteR6zBWZgHmyS6Er/kx16GnBLU7nO321qLnSIkPysb+t7Ec11hsPU9Hv0sJwy0N5U3wwE02K6b2rzH7qvykp6uK/9tLkt3n8Egyha40n/dXeEwGWmie2xuKjQjQsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kvack.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j6/Dl8yhwAb5WUiC75w/2oRU4+hYo1CMEdhyj99a+C4=;
 b=EsNUlLAioR+X/4VZA2L0WtRak7R3v0IeW9I/Yjy8PpAWRY/1u3VAgr6CEMCipUvGoJ5/3wx1iY1fKdL9OeaJPrysBNxesjIHl+Gtk+4WMx6of3TQnrPMuyOfrZiogrz8Bb/bpuXvG19LSI3EY7WYnf1Oj04Lz1b7ERzWRpFDkKSeFK6IgHUfagQeawHyZrOhlMqfBKBCEMXKOD0PYgsH3KCOtvmAAPdqc3ALr/mGIW7pKMXFP79HO5EAcWr/UdbJ1J6W/wKZS1z9rsAi1qr8HdvE2T3TE2hSe6lyHdKOBtY/rL8X4LaXYJE8j49vmTsXHK85DYruyJuW9KNOHtqv7A==
Received: from CH0PR08CA0026.namprd08.prod.outlook.com (2603:10b6:610:33::31)
 by DM4PR12MB6011.namprd12.prod.outlook.com (2603:10b6:8:6b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19; Thu, 23 Nov
 2023 00:35:51 +0000
Received: from DS3PEPF000099D9.namprd04.prod.outlook.com
 (2603:10b6:610:33:cafe::62) by CH0PR08CA0026.outlook.office365.com
 (2603:10b6:610:33::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19 via Frontend
 Transport; Thu, 23 Nov 2023 00:35:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099D9.mail.protection.outlook.com (10.167.17.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.12 via Frontend Transport; Thu, 23 Nov 2023 00:35:50 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 22 Nov
 2023 16:35:33 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 22 Nov
 2023 16:35:33 -0800
Received: from sgarnayak-dt.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Wed, 22 Nov 2023 16:35:24 -0800
From: <ankita@nvidia.com>
To: <ankita@nvidia.com>, <jgg@nvidia.com>, <alex.williamson@redhat.com>,
	<naoya.horiguchi@nec.com>, <akpm@linux-foundation.org>,
	<tony.luck@intel.com>, <bp@alien8.de>, <linmiaohe@huawei.com>,
	<rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
	<shiju.jose@huawei.com>, <bhelgaas@google.com>, <pabeni@redhat.com>,
	<yishaih@nvidia.com>, <shameerali.kolothum.thodi@huawei.com>,
	<kevin.tian@intel.com>
CC: <aniketa@nvidia.com>, <cjia@nvidia.com>, <kwankhede@nvidia.com>,
	<targupta@nvidia.com>, <vsethi@nvidia.com>, <acurrid@nvidia.com>,
	<apopple@nvidia.com>, <anuaggarwal@nvidia.com>, <jhubbard@nvidia.com>,
	<danw@nvidia.com>, <mochs@nvidia.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mm@kvack.org>, <linux-edac@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>
Subject: [PATCH v2 1/4] mm: handle poisoning of pfn without struct pages
Date: Thu, 23 Nov 2023 06:05:09 +0530
Message-ID: <20231123003513.24292-2-ankita@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231123003513.24292-1-ankita@nvidia.com>
References: <20231123003513.24292-1-ankita@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D9:EE_|DM4PR12MB6011:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c990266-acb1-4995-7e7f-08dbebbc24ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	24NfJhTCUFQAal3Xh2u6sGkfZWGJeRA61QvKfoNw8sElSyYinVcqAcX4jmPG/ffMpziaKOaoFwsmoO8Vw0xwT0peb2vwUyLH5uwxh/Y3WgUvQCOVVetN3Y4AOOkB4VxX8u5BBzulrtENXpZGSf/fneZS4jRatFGpF8Pb99vv67LqcPTC98d5HsBvdBCtizALIv731J4KOVEWYB7uGgrrQAeoHCaVk/skuM867YVAQtCciKtlOeHA2ugAktfSu+N/MGZCYZWWsINBfTUU/hfetoY1bD8kyrv0xWxzCriSgROvROslAdAX0yafc9979iQMARASTEZqrfFMTz3dZBotdXqhfeq1CA1gzClndrM16FXb667snesj28XfjiLnjP+hfFU9ZWQ1NIcPSnNNRz7iSVFuG0Jv0zuDGwv+IRjiDmC6XPP89U2A6o/jM3/wOgS65cuxaaoswN30lYe0iZSnqhnS/fD1G9LRvRznt5b8781363LASMhu07XphrdtQ8D1ZhdGgIMK18qI+eZUoe2q+vkVDVy+pRzsJCiEA2011JD6EDA4c/rumT4lXWrDl+5dbR5q40gC9BO2ayVaLxiFktRjamnB3qBCC9iBxvUa2oBG8IpSo8MvcRFU4AYGTdHCPKp1+VE1S+PBC/H+MX1ycsa3Ta3dmAV06vIheWF6ESS6x/9Lp6lnyx2eznhezGVhCZM/Va478wc3+zXsKD7woTOjLs6fgMlI+nvhOVGUd3ruUmWc2topAT9DbPYG0YpwAHDvm7sVW8slSZCD+gkFBg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(346002)(396003)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(82310400011)(1800799012)(40470700004)(36840700001)(46966006)(40460700003)(1076003)(26005)(83380400001)(6666004)(7696005)(2616005)(36860700001)(47076005)(4326008)(8676002)(5660300002)(8936002)(41300700001)(478600001)(2906002)(2876002)(7416002)(30864003)(316002)(336012)(54906003)(110136005)(70586007)(70206006)(86362001)(426003)(36756003)(82740400003)(356005)(7636003)(921008)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 00:35:50.5386
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c990266-acb1-4995-7e7f-08dbebbc24ce
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6011

From: Ankit Agrawal <ankita@nvidia.com>

The kernel MM currently does not handle ECC errors / poison on a memory
region that is not backed by struct pages. If a memory region is mapped
using remap_pfn_range(), but not added to the kernel, MM will not have
associated struct pages. Add a new mechanism to handle memory failure
on such memory.

Make kernel MM expose a function to allow modules managing the device
memory to register a failure function and the physical address space
associated with the device memory. MM maintains this information as
interval tree. The registered memory failure function is used by MM to
notify the kernel module managing the PFN, so that the module may take
any required action. The module for example may use the information
to track the poisoned pages.

In this implementation, kernel MM follows the following sequence similar
(mostly) to the memory_failure() handler for struct page backed memory:
1. memory_failure() is triggered on reception of a poison error. An
absence of struct page is detected and consequently memory_failure_pfn()
is executed.
2. memory_failure_pfn() call the newly introduced failure handler exposed
by the module managing the poisoned memory to notify it of the problematic
PFN.
3. memory_failure_pfn() unmaps the stage-2 mapping to the PFN.
4. memory_failure_pfn() collects the processes mapped to the PFN.
5. memory_failure_pfn() sends SIGBUS (BUS_MCEERR_AO) to all the processes
mapping the faulty PFN using kill_procs().
6. An access to the faulty PFN by an operation in VM at a later point
is trapped and user_mem_abort() is called.
7. The vma ops fault function gets called due to the absence of Stage-2
mapping. It is expected to return VM_FAULT_HWPOISON on the PFN.
8. __gfn_to_pfn_memslot() then returns KVM_PFN_ERR_HWPOISON, which cause
the poison with SIGBUS (BUS_MCEERR_AR) to be sent to the QEMU process
through kvm_send_hwpoison_signal().

Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
---
 include/linux/memory-failure.h |  22 +++++
 include/linux/mm.h             |   1 +
 include/ras/ras_event.h        |   1 +
 mm/Kconfig                     |   1 +
 mm/memory-failure.c            | 146 +++++++++++++++++++++++++++------
 5 files changed, 146 insertions(+), 25 deletions(-)
 create mode 100644 include/linux/memory-failure.h

diff --git a/include/linux/memory-failure.h b/include/linux/memory-failure.h
new file mode 100644
index 000000000000..9a579960972a
--- /dev/null
+++ b/include/linux/memory-failure.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_MEMORY_FAILURE_H
+#define _LINUX_MEMORY_FAILURE_H
+
+#include <linux/interval_tree.h>
+
+struct pfn_address_space;
+
+struct pfn_address_space_ops {
+	void (*failure)(struct pfn_address_space *pfn_space, unsigned long pfn);
+};
+
+struct pfn_address_space {
+	struct interval_tree_node node;
+	const struct pfn_address_space_ops *ops;
+	struct address_space *mapping;
+};
+
+int register_pfn_address_space(struct pfn_address_space *pfn_space);
+void unregister_pfn_address_space(struct pfn_address_space *pfn_space);
+
+#endif /* _LINUX_MEMORY_FAILURE_H */
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 418d26608ece..82b90e890b4b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4007,6 +4007,7 @@ enum mf_action_page_type {
 	MF_MSG_BUDDY,
 	MF_MSG_DAX,
 	MF_MSG_UNSPLIT_THP,
+	MF_MSG_PFN_MAP,
 	MF_MSG_UNKNOWN,
 };
 
diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
index cbd3ddd7c33d..05c3e6f6bd02 100644
--- a/include/ras/ras_event.h
+++ b/include/ras/ras_event.h
@@ -373,6 +373,7 @@ TRACE_EVENT(aer_event,
 	EM ( MF_MSG_BUDDY, "free buddy page" )				\
 	EM ( MF_MSG_DAX, "dax page" )					\
 	EM ( MF_MSG_UNSPLIT_THP, "unsplit thp" )			\
+	EM ( MF_MSG_PFN_MAP, "non struct page pfn" )			\
 	EMe ( MF_MSG_UNKNOWN, "unknown page" )
 
 /*
diff --git a/mm/Kconfig b/mm/Kconfig
index 89971a894b60..4f9533422887 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -774,6 +774,7 @@ config MEMORY_FAILURE
 	depends on ARCH_SUPPORTS_MEMORY_FAILURE
 	bool "Enable recovery from hardware memory errors"
 	select MEMORY_ISOLATION
+	select INTERVAL_TREE
 	select RAS
 	help
 	  Enables code to recover from some memory failures on systems
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 660c21859118..4f7672775486 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -38,6 +38,7 @@
 
 #include <linux/kernel.h>
 #include <linux/mm.h>
+#include <linux/memory-failure.h>
 #include <linux/page-flags.h>
 #include <linux/sched/signal.h>
 #include <linux/sched/task.h>
@@ -60,6 +61,7 @@
 #include <linux/pagewalk.h>
 #include <linux/shmem_fs.h>
 #include <linux/sysctl.h>
+#include <linux/pfn_t.h>
 #include "swap.h"
 #include "internal.h"
 #include "ras/ras_event.h"
@@ -144,6 +146,10 @@ static struct ctl_table memory_failure_table[] = {
 	{ }
 };
 
+static struct rb_root_cached pfn_space_itree = RB_ROOT_CACHED;
+
+static DEFINE_MUTEX(pfn_space_lock);
+
 /*
  * Return values:
  *   1:   the page is dissolved (if needed) and taken off from buddy,
@@ -422,15 +428,16 @@ static unsigned long dev_pagemap_mapping_shift(struct vm_area_struct *vma,
  * Schedule a process for later kill.
  * Uses GFP_ATOMIC allocations to avoid potential recursions in the VM.
  *
- * Note: @fsdax_pgoff is used only when @p is a fsdax page and a
- * filesystem with a memory failure handler has claimed the
- * memory_failure event. In all other cases, page->index and
- * page->mapping are sufficient for mapping the page back to its
- * corresponding user virtual address.
+ * Notice: @pgoff is used when:
+ * a. @p is a fsdax page and a filesystem with a memory failure handler
+ * has claimed the memory_failure event.
+ * b. pgoff is not backed by struct page.
+ * In all other cases, page->index and page->mapping are sufficient
+ * for mapping the page back to its corresponding user virtual address.
  */
 static void __add_to_kill(struct task_struct *tsk, struct page *p,
 			  struct vm_area_struct *vma, struct list_head *to_kill,
-			  unsigned long ksm_addr, pgoff_t fsdax_pgoff)
+			  unsigned long ksm_addr, pgoff_t pgoff)
 {
 	struct to_kill *tk;
 
@@ -440,13 +447,19 @@ static void __add_to_kill(struct task_struct *tsk, struct page *p,
 		return;
 	}
 
-	tk->addr = ksm_addr ? ksm_addr : page_address_in_vma(p, vma);
-	if (is_zone_device_page(p)) {
-		if (fsdax_pgoff != FSDAX_INVALID_PGOFF)
-			tk->addr = vma_pgoff_address(fsdax_pgoff, 1, vma);
-		tk->size_shift = dev_pagemap_mapping_shift(vma, tk->addr);
-	} else
-		tk->size_shift = page_shift(compound_head(p));
+	/* Check for pgoff not backed by struct page */
+	if (!(pfn_valid(pgoff)) && (vma->vm_flags | PFN_MAP)) {
+		tk->addr = vma_pgoff_address(pgoff, 1, vma);
+		tk->size_shift = PAGE_SHIFT;
+	} else {
+		tk->addr = ksm_addr ? ksm_addr : page_address_in_vma(p, vma);
+		if (is_zone_device_page(p)) {
+			if (pgoff != FSDAX_INVALID_PGOFF)
+				tk->addr = vma_pgoff_address(pgoff, 1, vma);
+			tk->size_shift = dev_pagemap_mapping_shift(vma, tk->addr);
+		} else
+			tk->size_shift = page_shift(compound_head(p));
+	}
 
 	/*
 	 * Send SIGKILL if "tk->addr == -EFAULT". Also, as
@@ -459,8 +472,8 @@ static void __add_to_kill(struct task_struct *tsk, struct page *p,
 	 * has a mapping for the page.
 	 */
 	if (tk->addr == -EFAULT) {
-		pr_info("Unable to find user space address %lx in %s\n",
-			page_to_pfn(p), tsk->comm);
+		pr_info("Unable to find address %lx in %s\n",
+			pfn_valid(pgoff) ? page_to_pfn(p) : pgoff, tsk->comm);
 	} else if (tk->size_shift == 0) {
 		kfree(tk);
 		return;
@@ -666,8 +679,7 @@ static void collect_procs_file(struct page *page, struct list_head *to_kill,
 	i_mmap_unlock_read(mapping);
 }
 
-#ifdef CONFIG_FS_DAX
-static void add_to_kill_fsdax(struct task_struct *tsk, struct page *p,
+static void add_to_kill_pgoff(struct task_struct *tsk, struct page *p,
 			      struct vm_area_struct *vma,
 			      struct list_head *to_kill, pgoff_t pgoff)
 {
@@ -675,11 +687,12 @@ static void add_to_kill_fsdax(struct task_struct *tsk, struct page *p,
 }
 
 /*
- * Collect processes when the error hit a fsdax page.
+ * Collect processes when the error hit a fsdax page or a PFN not backed by
+ * struct page.
  */
-static void collect_procs_fsdax(struct page *page,
-		struct address_space *mapping, pgoff_t pgoff,
-		struct list_head *to_kill)
+static void collect_procs_pgoff(struct page *page,
+				struct address_space *mapping, pgoff_t pgoff,
+				struct list_head *to_kill)
 {
 	struct vm_area_struct *vma;
 	struct task_struct *tsk;
@@ -693,13 +706,12 @@ static void collect_procs_fsdax(struct page *page,
 			continue;
 		vma_interval_tree_foreach(vma, &mapping->i_mmap, pgoff, pgoff) {
 			if (vma->vm_mm == t->mm)
-				add_to_kill_fsdax(t, page, vma, to_kill, pgoff);
+				add_to_kill_pgoff(t, page, vma, to_kill, pgoff);
 		}
 	}
 	rcu_read_unlock();
 	i_mmap_unlock_read(mapping);
 }
-#endif /* CONFIG_FS_DAX */
 
 /*
  * Collect the processes who have the corrupted page mapped to kill.
@@ -893,6 +905,7 @@ static const char * const action_page_types[] = {
 	[MF_MSG_BUDDY]			= "free buddy page",
 	[MF_MSG_DAX]			= "dax page",
 	[MF_MSG_UNSPLIT_THP]		= "unsplit thp",
+	[MF_MSG_PFN_MAP]		= "non struct page pfn",
 	[MF_MSG_UNKNOWN]		= "unknown page",
 };
 
@@ -1324,7 +1337,8 @@ static int action_result(unsigned long pfn, enum mf_action_page_type type,
 
 	num_poisoned_pages_inc(pfn);
 
-	update_per_node_mf_stats(pfn, result);
+	if (type != MF_MSG_PFN_MAP)
+		update_per_node_mf_stats(pfn, result);
 
 	pr_err("%#lx: recovery action for %s: %s\n",
 		pfn, action_page_types[type], action_name[result]);
@@ -1808,7 +1822,7 @@ int mf_dax_kill_procs(struct address_space *mapping, pgoff_t index,
 
 		SetPageHWPoison(page);
 
-		collect_procs_fsdax(page, mapping, index, &to_kill);
+		collect_procs_pgoff(page, mapping, index, &to_kill);
 		unmap_and_kill(&to_kill, page_to_pfn(page), mapping,
 				index, mf_flags);
 unlock:
@@ -2147,6 +2161,83 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
 	return rc;
 }
 
+int register_pfn_address_space(struct pfn_address_space *pfn_space)
+{
+	if (!pfn_space)
+		return -EINVAL;
+
+	if (!request_mem_region(pfn_space->node.start << PAGE_SHIFT,
+		(pfn_space->node.last - pfn_space->node.start + 1) << PAGE_SHIFT, ""))
+		return -EBUSY;
+
+	mutex_lock(&pfn_space_lock);
+	interval_tree_insert(&pfn_space->node, &pfn_space_itree);
+	mutex_unlock(&pfn_space_lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(register_pfn_address_space);
+
+void unregister_pfn_address_space(struct pfn_address_space *pfn_space)
+{
+	if (!pfn_space)
+		return;
+
+	mutex_lock(&pfn_space_lock);
+	interval_tree_remove(&pfn_space->node, &pfn_space_itree);
+	mutex_unlock(&pfn_space_lock);
+	release_mem_region(pfn_space->node.start << PAGE_SHIFT,
+		(pfn_space->node.last - pfn_space->node.start + 1) << PAGE_SHIFT);
+}
+EXPORT_SYMBOL_GPL(unregister_pfn_address_space);
+
+static int memory_failure_pfn(unsigned long pfn, int flags)
+{
+	struct interval_tree_node *node;
+	int res = MF_FAILED;
+	LIST_HEAD(tokill);
+
+	mutex_lock(&pfn_space_lock);
+	/*
+	 * Modules registers with MM the address space mapping to the device memory they
+	 * manage. Iterate to identify exactly which address space has mapped to this
+	 * failing PFN.
+	 */
+	for (node = interval_tree_iter_first(&pfn_space_itree, pfn, pfn); node;
+	     node = interval_tree_iter_next(node, pfn, pfn)) {
+		struct pfn_address_space *pfn_space =
+			container_of(node, struct pfn_address_space, node);
+		/*
+		 * Modules managing the device memory need to be conveyed about the
+		 * memory failure so that the poisoned PFN can be tracked.
+		 */
+		if (pfn_space->ops)
+			pfn_space->ops->failure(pfn_space, pfn);
+
+		collect_procs_pgoff(NULL, pfn_space->mapping, pfn, &tokill);
+
+		unmap_mapping_range(pfn_space->mapping, pfn << PAGE_SHIFT,
+				    PAGE_SIZE, 0);
+
+		res = MF_RECOVERED;
+	}
+	mutex_unlock(&pfn_space_lock);
+
+	if (res == MF_FAILED)
+		return action_result(pfn, MF_MSG_PFN_MAP, res);
+
+	/*
+	 * Unlike System-RAM there is no possibility to swap in a different
+	 * physical page at a given virtual address, so all userspace
+	 * consumption of direct PFN memory necessitates SIGBUS (i.e.
+	 * MF_MUST_KILL)
+	 */
+	flags |= MF_ACTION_REQUIRED | MF_MUST_KILL;
+	kill_procs(&tokill, true, false, pfn, flags);
+
+	return action_result(pfn, MF_MSG_PFN_MAP, MF_RECOVERED);
+}
+
 /**
  * memory_failure - Handle memory failure of a page.
  * @pfn: Page Number of the corrupted page
@@ -2186,6 +2277,11 @@ int memory_failure(unsigned long pfn, int flags)
 	if (!(flags & MF_SW_SIMULATED))
 		hw_memory_failure = true;
 
+	if (!pfn_valid(pfn) && !arch_is_platform_page(PFN_PHYS(pfn))) {
+		res = memory_failure_pfn(pfn, flags);
+		goto unlock_mutex;
+	}
+
 	p = pfn_to_online_page(pfn);
 	if (!p) {
 		res = arch_memory_failure(pfn, flags);
-- 
2.17.1


