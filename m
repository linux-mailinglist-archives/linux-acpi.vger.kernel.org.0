Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F37D597DAE
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Aug 2019 16:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbfHUOxb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 21 Aug 2019 10:53:31 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5182 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727864AbfHUOxb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 21 Aug 2019 10:53:31 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B35C041EFBB7AE0B4B9E;
        Wed, 21 Aug 2019 22:53:16 +0800 (CST)
Received: from lhrphicprd00229.huawei.com (10.123.41.22) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Wed, 21 Aug 2019 22:53:08 +0800
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-mm@kvack.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Keith Busch <keith.busch@intel.com>, <jglisse@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, <linuxarm@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 3/4] x86: Support Generic Initiator only proximity domains
Date:   Wed, 21 Aug 2019 22:52:41 +0800
Message-ID: <20190821145242.2330-4-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190821145242.2330-1-Jonathan.Cameron@huawei.com>
References: <20190821145242.2330-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.123.41.22]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Done in a somewhat different fashion to arm64.
Here the infrastructure for memoryless domains was already
in place.  That infrastruture applies just as well to
domains that also don't have a CPU, hence it works for
Generic Initiator Domains.

In common with memoryless domains we only register GI domains
if the proximity node is not online. If a domain is already
a memory containing domain, or a memoryless domain there is
nothing to do just because it also contains a Generic Initiator.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 arch/x86/include/asm/numa.h |  2 ++
 arch/x86/kernel/setup.c     |  1 +
 arch/x86/mm/numa.c          | 14 ++++++++++++++
 3 files changed, 17 insertions(+)

diff --git a/arch/x86/include/asm/numa.h b/arch/x86/include/asm/numa.h
index bbfde3d2662f..f631467272a3 100644
--- a/arch/x86/include/asm/numa.h
+++ b/arch/x86/include/asm/numa.h
@@ -62,12 +62,14 @@ extern void numa_clear_node(int cpu);
 extern void __init init_cpu_to_node(void);
 extern void numa_add_cpu(int cpu);
 extern void numa_remove_cpu(int cpu);
+extern void init_gi_nodes(void);
 #else	/* CONFIG_NUMA */
 static inline void numa_set_node(int cpu, int node)	{ }
 static inline void numa_clear_node(int cpu)		{ }
 static inline void init_cpu_to_node(void)		{ }
 static inline void numa_add_cpu(int cpu)		{ }
 static inline void numa_remove_cpu(int cpu)		{ }
+static inline void init_gi_nodes(void)			{ }
 #endif	/* CONFIG_NUMA */
 
 #ifdef CONFIG_DEBUG_PER_CPU_MAPS
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index bbe35bf879f5..8c368279624d 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1265,6 +1265,7 @@ void __init setup_arch(char **cmdline_p)
 	prefill_possible_map();
 
 	init_cpu_to_node();
+	init_gi_nodes();
 
 	io_apic_init_mappings();
 
diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index e6dad600614c..2f561344d590 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -733,6 +733,20 @@ static void __init init_memory_less_node(int nid)
 	 */
 }
 
+/*
+ * Generic Initiator Nodes may have neither CPU nor Memory.
+ * At this stage if either of the others were present we would
+ * already be online.
+ */
+void __init init_gi_nodes(void)
+{
+	int nid;
+
+	for_each_node_state(nid, N_GENERIC_INITIATOR)
+		if (!node_online(nid))
+			init_memory_less_node(nid);
+}
+
 /*
  * Setup early cpu_to_node.
  *
-- 
2.20.1

