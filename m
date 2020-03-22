Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E945B18EA59
	for <lists+linux-acpi@lfdr.de>; Sun, 22 Mar 2020 17:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgCVQ2h (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 22 Mar 2020 12:28:37 -0400
Received: from mga17.intel.com ([192.55.52.151]:10907 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725785AbgCVQ2h (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 22 Mar 2020 12:28:37 -0400
IronPort-SDR: 0aRH+LrrdcHKlJWYrQUP1u1PCxifuaHB1vH9bdQNsXswcO/IruMS/2gK+slquputPu63FblYNX
 wjoX38BV9uPg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2020 09:28:36 -0700
IronPort-SDR: NmuGacDqSIJJK4jSYgPl0Wf7OddL+EhRlwVHtQAURJ7bPWjS+ZUxGVB4D2WwNQatsrXZ+ZhjtF
 2TVOyp7aWVUg==
X-IronPort-AV: E=Sophos;i="5.72,293,1580803200"; 
   d="scan'208";a="392671243"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2020 09:28:36 -0700
Subject: [PATCH v2 1/6] x86/numa: Cleanup configuration dependent
 command-line options
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        peterz@infradead.org, dave.hansen@linux.intel.com,
        ard.biesheuvel@linaro.org, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        joao.m.martins@oracle.com
Date:   Sun, 22 Mar 2020 09:12:29 -0700
Message-ID: <158489354992.1457606.6286687362997273812.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <158489354353.1457606.8327903161927980740.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <158489354353.1457606.8327903161927980740.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

In preparation for adding a new numa= option clean up the existing ones
to avoid ifdefs in numa_setup(), and provide feedback when the option is
numa=fake= option is invalid due to kernel config. The same does not
need to be done for numa=noacpi, since the capability is already hard
disabled at compile-time.

Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/x86/include/asm/numa.h  |    8 +++++++-
 arch/x86/mm/numa.c           |    8 ++------
 arch/x86/mm/numa_emulation.c |    3 ++-
 arch/x86/xen/enlighten_pv.c  |    2 +-
 drivers/acpi/numa/srat.c     |    9 +++++++--
 include/acpi/acpi_numa.h     |    6 +++++-
 6 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/numa.h b/arch/x86/include/asm/numa.h
index bbfde3d2662f..0aecc0b629e0 100644
--- a/arch/x86/include/asm/numa.h
+++ b/arch/x86/include/asm/numa.h
@@ -3,6 +3,7 @@
 #define _ASM_X86_NUMA_H
 
 #include <linux/nodemask.h>
+#include <linux/errno.h>
 
 #include <asm/topology.h>
 #include <asm/apicdef.h>
@@ -77,7 +78,12 @@ void debug_cpumask_set_cpu(int cpu, int node, bool enable);
 #ifdef CONFIG_NUMA_EMU
 #define FAKE_NODE_MIN_SIZE	((u64)32 << 20)
 #define FAKE_NODE_MIN_HASH_MASK	(~(FAKE_NODE_MIN_SIZE - 1UL))
-void numa_emu_cmdline(char *);
+int numa_emu_cmdline(char *str);
+#else /* CONFIG_NUMA_EMU */
+static inline int numa_emu_cmdline(char *str)
+{
+	return -EINVAL;
+}
 #endif /* CONFIG_NUMA_EMU */
 
 #endif	/* _ASM_X86_NUMA_H */
diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 59ba008504dc..9c1266b2628c 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -37,14 +37,10 @@ static __init int numa_setup(char *opt)
 		return -EINVAL;
 	if (!strncmp(opt, "off", 3))
 		numa_off = 1;
-#ifdef CONFIG_NUMA_EMU
 	if (!strncmp(opt, "fake=", 5))
-		numa_emu_cmdline(opt + 5);
-#endif
-#ifdef CONFIG_ACPI_NUMA
+		return numa_emu_cmdline(opt + 5);
 	if (!strncmp(opt, "noacpi", 6))
-		acpi_numa = -1;
-#endif
+		disable_srat();
 	return 0;
 }
 early_param("numa", numa_setup);
diff --git a/arch/x86/mm/numa_emulation.c b/arch/x86/mm/numa_emulation.c
index 7f1d2034df1e..0bd27231e038 100644
--- a/arch/x86/mm/numa_emulation.c
+++ b/arch/x86/mm/numa_emulation.c
@@ -13,9 +13,10 @@
 static int emu_nid_to_phys[MAX_NUMNODES];
 static char *emu_cmdline __initdata;
 
-void __init numa_emu_cmdline(char *str)
+int __init numa_emu_cmdline(char *str)
 {
 	emu_cmdline = str;
+	return 0;
 }
 
 static int __init emu_find_memblk_by_nid(int nid, const struct numa_meminfo *mi)
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 1f756ffffe8b..7ca8f257b47b 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -1283,7 +1283,7 @@ asmlinkage __visible void __init xen_start_kernel(void)
 	 * any NUMA information the kernel tries to get from ACPI will
 	 * be meaningless.  Prevent it from trying.
 	 */
-	acpi_numa = -1;
+	disable_srat();
 #endif
 	WARN_ON(xen_cpuhp_setup(xen_cpu_up_prepare_pv, xen_cpu_dead_pv));
 
diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index 47b4969d9b93..aa8e5d53f646 100644
--- a/drivers/acpi/numa/srat.c
+++ b/drivers/acpi/numa/srat.c
@@ -27,7 +27,12 @@ static int node_to_pxm_map[MAX_NUMNODES]
 			= { [0 ... MAX_NUMNODES - 1] = PXM_INVAL };
 
 unsigned char acpi_srat_revision __initdata;
-int acpi_numa __initdata;
+static int acpi_numa __initdata;
+
+void __init disable_srat(void)
+{
+	acpi_numa = -1;
+}
 
 int pxm_to_node(int pxm)
 {
@@ -162,7 +167,7 @@ static int __init slit_valid(struct acpi_table_slit *slit)
 void __init bad_srat(void)
 {
 	pr_err("SRAT: SRAT not used.\n");
-	acpi_numa = -1;
+	disable_srat();
 }
 
 int __init srat_disabled(void)
diff --git a/include/acpi/acpi_numa.h b/include/acpi/acpi_numa.h
index fdebcfc6c8df..8784183b2204 100644
--- a/include/acpi/acpi_numa.h
+++ b/include/acpi/acpi_numa.h
@@ -17,10 +17,14 @@ extern int pxm_to_node(int);
 extern int node_to_pxm(int);
 extern int acpi_map_pxm_to_node(int);
 extern unsigned char acpi_srat_revision;
-extern int acpi_numa __initdata;
+extern void disable_srat(void);
 
 extern void bad_srat(void);
 extern int srat_disabled(void);
 
+#else				/* CONFIG_ACPI_NUMA */
+static inline void disable_srat(void)
+{
+}
 #endif				/* CONFIG_ACPI_NUMA */
 #endif				/* __ACP_NUMA_H */

