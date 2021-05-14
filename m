Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92F2538068A
	for <lists+linux-acpi@lfdr.de>; Fri, 14 May 2021 11:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbhENJzj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 14 May 2021 05:55:39 -0400
Received: from foss.arm.com ([217.140.110.172]:46144 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232470AbhENJzj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 14 May 2021 05:55:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 126C8175D;
        Fri, 14 May 2021 02:54:28 -0700 (PDT)
Received: from e108754-lin.cambridge.arm.com (unknown [10.1.195.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9B2483F719;
        Fri, 14 May 2021 02:54:26 -0700 (PDT)
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/3] arch_topology: obtain cpu capacity using information from CPPC
Date:   Fri, 14 May 2021 10:53:38 +0100
Message-Id: <20210514095339.12979-3-ionela.voinescu@arm.com>
X-Mailer: git-send-email 2.29.2.dirty
In-Reply-To: <20210514095339.12979-1-ionela.voinescu@arm.com>
References: <20210514095339.12979-1-ionela.voinescu@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Define init_cpu_capacity_cppc() to use highest performance values
from _CPC objects to obtain and set maximum capacity information for
each CPU. acpi_cppc_processor_probe() is a good point at which to
trigger the initialization of CPU (u-arch) capacity values, as at this
point the highest performance values can be obtained from each CPU's
_CPC objects. Architectures can therefore use this functionality
through arch_init_invariance_cppc().

The performance scale used by CPPC is a unified scale for all CPUs in
the system. Therefore, by obtaining the raw highest performance values
from the _CPC objects, and normalizing them on the [0, 1024] capacity
scale, used by the task scheduler, we obtain the CPU capacity of each
CPU.

While an ACPI Notify(0x85) could alert about a change in the highest
performance value, which should in turn retrigger the CPU capacity
computations, this notification is not currently handled by the ACPI
processor driver. When supported, a call to arch_init_invariance_cppc()
would perform the update.

Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/base/arch_topology.c  | 39 +++++++++++++++++++++++++++++++++++
 include/linux/arch_topology.h |  4 ++++
 2 files changed, 43 insertions(+)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index c1179edc0f3b..f710d64f125b 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -291,6 +291,45 @@ bool __init topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu)
 	return !ret;
 }
 
+#ifdef CONFIG_ACPI_CPPC_LIB
+#include <acpi/cppc_acpi.h>
+
+void init_cpu_capacity_cppc(void)
+{
+	struct cppc_perf_caps perf_caps;
+	int cpu;
+
+	if (likely(acpi_disabled || !acpi_cpc_valid()))
+		return;
+
+	raw_capacity = kcalloc(num_possible_cpus(), sizeof(*raw_capacity),
+			       GFP_KERNEL);
+	if (!raw_capacity)
+		return;
+
+	for_each_possible_cpu(cpu) {
+		if (!cppc_get_perf_caps(cpu, &perf_caps)) {
+			raw_capacity[cpu] = perf_caps.highest_perf;
+			pr_debug("%s: CPU%d cpu_capacity=%u (raw).\n",
+				 __func__, cpu, raw_capacity[cpu]);
+		} else {
+			pr_err("%s: CPU%d missing highest performance.\n",
+				 __func__, cpu);
+			pr_err("%s: fallback to 1024 for all CPUs\n",
+				 __func__);
+			goto exit;
+		}
+	}
+
+	topology_normalize_cpu_scale();
+	schedule_work(&update_topology_flags_work);
+	pr_debug("%s: cpu_capacity initialization done\n", __func__);
+
+exit:
+	free_raw_capacity();
+}
+#endif
+
 #ifdef CONFIG_CPU_FREQ
 static cpumask_var_t cpus_to_visit;
 static void parsing_done_workfn(struct work_struct *work);
diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
index f180240dc95f..fbd829c3b7f7 100644
--- a/include/linux/arch_topology.h
+++ b/include/linux/arch_topology.h
@@ -11,6 +11,10 @@
 void topology_normalize_cpu_scale(void);
 int topology_update_cpu_topology(void);
 
+#ifdef CONFIG_ACPI_CPPC_LIB
+void init_cpu_capacity_cppc(void);
+#endif
+
 struct device_node;
 bool topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu);
 
-- 
2.29.2.dirty

