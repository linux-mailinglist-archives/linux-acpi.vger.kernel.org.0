Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7159CB966
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Oct 2019 13:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730423AbfJDLo1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Oct 2019 07:44:27 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:36536 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726024AbfJDLo0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 4 Oct 2019 07:44:26 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 4A0CD4D78D6F1D03B630;
        Fri,  4 Oct 2019 19:44:25 +0800 (CST)
Received: from lhrphicprd00229.huawei.com (10.123.41.22) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Fri, 4 Oct 2019 19:44:17 +0800
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-mm@kvack.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <x86@kernel.org>
CC:     Keith Busch <keith.busch@intel.com>, <jglisse@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, <linuxarm@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH V5 3/4] x86: Support Generic Initiator only proximity domains
Date:   Fri, 4 Oct 2019 19:43:29 +0800
Message-ID: <20191004114330.104746-4-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191004114330.104746-1-Jonathan.Cameron@huawei.com>
References: <20191004114330.104746-1-Jonathan.Cameron@huawei.com>
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
index cfb533d42371..b6c977907ea5 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1264,6 +1264,7 @@ void __init setup_arch(char **cmdline_p)
 	prefill_possible_map();
 
 	init_cpu_to_node();
+	init_gi_nodes();
 
 	io_apic_init_mappings();
 
diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 4123100e0eaf..50bf724a425e 100644
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

