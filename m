Return-Path: <linux-acpi+bounces-21470-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLmNEhI6qmnUNQEAu9opvQ
	(envelope-from <linux-acpi+bounces-21470-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 03:21:06 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A685421A905
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 03:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D45E305BABD
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Mar 2026 02:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0D533A6F9;
	Fri,  6 Mar 2026 02:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="5QG1NEmJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700D1317715;
	Fri,  6 Mar 2026 02:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772763574; cv=none; b=JWfETtjJMeHkwWPuE3yNEV0lKBvKoGICiLV6r1T6YqZiHfNT8oBtFyN0ACgal/6oOcjGwsj738up5skUjoVRMBnzXgcVPBstO73TAkiN901p0Dn8MYxRRUEaB0Wj9yRsdtmQ8Gdcc6Qe8zb3/fQMQlNaYw8Mas+z9YOlWGLeJVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772763574; c=relaxed/simple;
	bh=yKN4j+c/JW8JyphjBUkaK0kHgcCkYU698CToNMvKlBo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pteooc88R3PzIYuVS/9FeBIAW1EoSBwHkOsfzoDKyWnXCPi5q5aSdHQLkx3r9JxUyJUkslvO0ly3V+r9+Tluc7GnGpaHq/DWS4UbQaxXwtKRQixEmEgAeWmmg4juth8bGZR+jjR656u5VvBcdKDfTCjv5EvrcLt0YTjY1KErTBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=5QG1NEmJ; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=yfMx8zNgzaqPrBfREx6+iwivzUdYyzT0Hs0ec61O+Nk=;
	b=5QG1NEmJIhkm3YFDFldXOR3evDsXu6CrEywGvqQ5CLkThfE42kdLfXxIYXM8J7azYR/0U8h2D
	ZvY4q+7KiX7ZiB9D+F6aueg6bE9UJExt0mbJzbvtb8xIz5JYwJHmn9ebeI+UQi6M6eGNqY6Rv3m
	X29t/dQFsxKILZQASDRYGZE=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4fRqjQ5rjlzmVcw;
	Fri,  6 Mar 2026 10:14:34 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id D70354048B;
	Fri,  6 Mar 2026 10:19:27 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 6 Mar 2026 10:19:26 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>, Jonathan Corbet
	<corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Huacai Chen
	<chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Paul Walmsley
	<pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Sunil V L <sunilvl@ventanamicro.com>, Mark
 Rutland <mark.rutland@arm.com>, Eric Van Tassell <Eric.VanTassell@amd.com>,
	Wei Huang <wei.huang2@amd.com>, Ajit Khaparde <ajit.khaparde@broadcom.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>
CC: <linux-acpi@vger.kernel.org>, <jonathan.cameron@huawei.com>,
	<wangzhou1@hisilicon.com>, <wanghuiqiang@huawei.com>,
	<liuyonglong@huawei.com>, <stable@vger.kernel.org>, <jeremy.linton@arm.com>,
	<sunilvl@oss.qualcomm.com>, <chenhuacai@loongson.cn>,
	<wangliupu@loongson.cn>, Chengwen Feng <fengchengwen@huawei.com>, Somnath
 Kotur <somnath.kotur@broadcom.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<loongarch@lists.linux.dev>, <linux-riscv@lists.infradead.org>,
	<linux-perf-users@vger.kernel.org>
Subject: [PATCH v3] PCI/TPH: Fix get cpu steer-tag fail on ARM64 platform
Date: Fri, 6 Mar 2026 10:19:17 +0800
Message-ID: <20260306021920.23233-1-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260303003625.39035-1-fengchengwen@huawei.com>
References: <20260303003625.39035-1-fengchengwen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk500009.china.huawei.com (7.202.194.94)
X-Rspamd-Queue-Id: A685421A905
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[44];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21470-lists,linux-acpi=lfdr.de];
	DKIM_TRACE(0.00)[huawei.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fengchengwen@huawei.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:dkim,huawei.com:email,huawei.com:mid,pcisig.com:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Currently the pcie_tph_get_cpu_st() has an issue on ARM64 platform:
1. The pcie_tph_get_cpu_st() function directly uses cpu_uid as the input
   parameter to call the PCI ACPI DSM method. According to the DSM
   definition, the input value should be the ACPI Processor UID (see [1]
   for details).
2. In the Broadcom driver implementation [2] (which invokes
   pcie_tph_get_cpu_st()), cpu_uid is obtained via
   cpumask_first(irq->cpu_mask) - this is the logical CPU ID of a CPU
   core, generated and managed by kernel (e.g., [0,255] for a system
   with 256 logical CPU cores).
3. On ARM64 platforms, ACPI assigns Processor UID to cores listed in the
   MADT table, and this UID may not match the kernel's logical CPU ID.
   As a result, the current implementation fails to retrieve the correct
   CPU steer-tag in such cases.
4. The function works on AMD x86 platforms only because the logical CPU
   ID is identical to the ACPI Processor UID on those systems.

This commit fixes it by:
1. For ACPI-enabled platforms, unify the CPU ACPI ID retrieval
   interface:
   - On arm64/riscv/loongarch: Rename existing get_acpi_id_for_cpu() to
     acpi_get_cpu_acpi_id().
   - On x86: Add new acpi_get_cpu_acpi_id() implementation that wraps
     cpu_acpi_id().
2. Update pcie_tph_get_cpu_st() to use acpi_get_cpu_acpi_id(cpu) to get
   valid ACPI Processor UID for DSM calls.
3. Renaming pcie_tph_get_cpu_st()'s input parameter cpu_uid to cpu for
   clarity, as the parameter now represents a logical CPU ID (not a
   UID).

[1] According to ECN_TPH-ST_Revision_20200924
    (https://members.pcisig.com/wg/PCI-SIG/document/15470), the input
    is defined as: "If the target is a processor, then this field
    represents the ACPI Processor UID of the processor as specified in
    the MADT. If the target is a processor container, then this field
    represents the ACPI Processor UID of the processor container as
    specified in the PPTT."
[2] commit c214410c47d6e ("bnxt_en: Add TPH support in BNXT driver")

Fixes: d2e8a34876ce ("PCI/TPH: Add Steering Tag support")
Cc: stable@vger.kernel.org
Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>

---
Changes in v3:
- Rename existing get_acpi_id_for_cpu() to acpi_get_cpu_acpi_id() other
  than add one new API.

Changes in v2:
- Add ECN _DSM reference doc name and its URL.
- Separate implement acpi_get_cpu_acpi_id() in each arch which supports
  ACPI.
- Refine commit-log.

---
 Documentation/PCI/tph.rst          |  4 ++--
 arch/arm64/include/asm/acpi.h      |  4 ++--
 arch/loongarch/include/asm/acpi.h  |  2 +-
 arch/riscv/include/asm/acpi.h      |  2 +-
 arch/riscv/kernel/acpi_numa.c      |  2 +-
 arch/x86/include/asm/acpi.h        |  2 ++
 arch/x86/kernel/cpu/common.c       |  8 ++++++++
 drivers/acpi/pptt.c                | 16 ++++++++--------
 drivers/acpi/riscv/rhct.c          |  2 +-
 drivers/pci/tph.c                  | 11 ++++++-----
 drivers/perf/arm_cspmu/arm_cspmu.c |  2 +-
 include/linux/pci-tph.h            |  4 ++--
 12 files changed, 35 insertions(+), 24 deletions(-)

diff --git a/Documentation/PCI/tph.rst b/Documentation/PCI/tph.rst
index e8993be64fd6..b6cf22b9bd90 100644
--- a/Documentation/PCI/tph.rst
+++ b/Documentation/PCI/tph.rst
@@ -79,10 +79,10 @@ To retrieve a Steering Tag for a target memory associated with a specific
 CPU, use the following function::
 
   int pcie_tph_get_cpu_st(struct pci_dev *pdev, enum tph_mem_type type,
-                          unsigned int cpu_uid, u16 *tag);
+                          unsigned int cpu, u16 *tag);
 
 The `type` argument is used to specify the memory type, either volatile
-or persistent, of the target memory. The `cpu_uid` argument specifies the
+or persistent, of the target memory. The `cpu` argument specifies the
 CPU where the memory is associated to.
 
 After the ST value is retrieved, the device driver can use the following
diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
index c07a58b96329..202107aeb05b 100644
--- a/arch/arm64/include/asm/acpi.h
+++ b/arch/arm64/include/asm/acpi.h
@@ -114,7 +114,7 @@ static inline bool acpi_has_cpu_in_madt(void)
 }
 
 struct acpi_madt_generic_interrupt *acpi_cpu_get_madt_gicc(int cpu);
-static inline u32 get_acpi_id_for_cpu(unsigned int cpu)
+static inline u32 acpi_get_cpu_acpi_id(unsigned int cpu)
 {
 	return	acpi_cpu_get_madt_gicc(cpu)->uid;
 }
@@ -125,7 +125,7 @@ static inline int get_cpu_for_acpi_id(u32 uid)
 
 	for (cpu = 0; cpu < nr_cpu_ids; cpu++)
 		if (acpi_cpu_get_madt_gicc(cpu) &&
-		    uid == get_acpi_id_for_cpu(cpu))
+		    uid == acpi_get_cpu_acpi_id(cpu))
 			return cpu;
 
 	return -EINVAL;
diff --git a/arch/loongarch/include/asm/acpi.h b/arch/loongarch/include/asm/acpi.h
index 7376840fa9f7..89c6c8f52cc3 100644
--- a/arch/loongarch/include/asm/acpi.h
+++ b/arch/loongarch/include/asm/acpi.h
@@ -40,7 +40,7 @@ extern struct acpi_madt_core_pic acpi_core_pic[MAX_CORE_PIC];
 
 extern int __init parse_acpi_topology(void);
 
-static inline u32 get_acpi_id_for_cpu(unsigned int cpu)
+static inline u32 acpi_get_cpu_acpi_id(unsigned int cpu)
 {
 	return acpi_core_pic[cpu_logical_map(cpu)].processor_id;
 }
diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
index 6e13695120bc..1d23681b61b5 100644
--- a/arch/riscv/include/asm/acpi.h
+++ b/arch/riscv/include/asm/acpi.h
@@ -61,7 +61,7 @@ static inline void arch_fix_phys_package_id(int num, u32 slot) { }
 
 void acpi_init_rintc_map(void);
 struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu);
-static inline u32 get_acpi_id_for_cpu(int cpu)
+static inline u32 acpi_get_cpu_acpi_id(int cpu)
 {
 	return acpi_cpu_get_madt_rintc(cpu)->uid;
 }
diff --git a/arch/riscv/kernel/acpi_numa.c b/arch/riscv/kernel/acpi_numa.c
index 130769e3a99c..c2eb4824d0f7 100644
--- a/arch/riscv/kernel/acpi_numa.c
+++ b/arch/riscv/kernel/acpi_numa.c
@@ -40,7 +40,7 @@ static inline int get_cpu_for_acpi_id(u32 uid)
 	int cpu;
 
 	for (cpu = 0; cpu < nr_cpu_ids; cpu++)
-		if (uid == get_acpi_id_for_cpu(cpu))
+		if (uid == acpi_get_cpu_acpi_id(cpu))
 			return cpu;
 
 	return -EINVAL;
diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
index a03aa6f999d1..b968369715c1 100644
--- a/arch/x86/include/asm/acpi.h
+++ b/arch/x86/include/asm/acpi.h
@@ -157,6 +157,8 @@ static inline bool acpi_has_cpu_in_madt(void)
 	return !!acpi_lapic;
 }
 
+u32 acpi_get_cpu_acpi_id(unsigned int cpu);
+
 #define ACPI_HAVE_ARCH_SET_ROOT_POINTER
 static __always_inline void acpi_arch_set_root_pointer(u64 addr)
 {
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 1c3261cae40c..1c7aa7a4faa0 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -29,6 +29,7 @@
 #include <linux/utsname.h>
 #include <linux/efi.h>
 
+#include <asm/acpi.h>
 #include <asm/alternative.h>
 #include <asm/cmdline.h>
 #include <asm/cpuid/api.h>
@@ -57,6 +58,7 @@
 #include <asm/asm.h>
 #include <asm/bugs.h>
 #include <asm/cpu.h>
+#include <asm/smp.h>
 #include <asm/mce.h>
 #include <asm/msr.h>
 #include <asm/cacheinfo.h>
@@ -2643,3 +2645,9 @@ void __init arch_cpu_finalize_init(void)
 	 */
 	mem_encrypt_init();
 }
+
+u32 acpi_get_cpu_acpi_id(unsigned int cpu)
+{
+	return cpu_acpi_id(cpu);
+}
+EXPORT_SYMBOL_GPL(acpi_get_cpu_acpi_id);
diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
index de5f8c018333..c1a8fba4c2b2 100644
--- a/drivers/acpi/pptt.c
+++ b/drivers/acpi/pptt.c
@@ -459,7 +459,7 @@ static void cache_setup_acpi_cpu(struct acpi_table_header *table,
 {
 	struct acpi_pptt_cache *found_cache;
 	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
-	u32 acpi_cpu_id = get_acpi_id_for_cpu(cpu);
+	u32 acpi_cpu_id = acpi_get_cpu_acpi_id(cpu);
 	struct cacheinfo *this_leaf;
 	unsigned int index = 0;
 	struct acpi_pptt_processor *cpu_node = NULL;
@@ -546,7 +546,7 @@ static int topology_get_acpi_cpu_tag(struct acpi_table_header *table,
 				     unsigned int cpu, int level, int flag)
 {
 	struct acpi_pptt_processor *cpu_node;
-	u32 acpi_cpu_id = get_acpi_id_for_cpu(cpu);
+	u32 acpi_cpu_id = acpi_get_cpu_acpi_id(cpu);
 
 	cpu_node = acpi_find_processor_node(table, acpi_cpu_id);
 	if (cpu_node) {
@@ -622,7 +622,7 @@ static int find_acpi_cpu_topology_tag(unsigned int cpu, int level, int flag)
 static int check_acpi_cpu_flag(unsigned int cpu, int rev, u32 flag)
 {
 	struct acpi_table_header *table;
-	u32 acpi_cpu_id = get_acpi_id_for_cpu(cpu);
+	u32 acpi_cpu_id = acpi_get_cpu_acpi_id(cpu);
 	struct acpi_pptt_processor *cpu_node = NULL;
 	int ret = -ENOENT;
 
@@ -671,7 +671,7 @@ int acpi_get_cache_info(unsigned int cpu, unsigned int *levels,
 
 	pr_debug("Cache Setup: find cache levels for CPU=%d\n", cpu);
 
-	acpi_cpu_id = get_acpi_id_for_cpu(cpu);
+	acpi_cpu_id = acpi_get_cpu_acpi_id(cpu);
 	cpu_node = acpi_find_processor_node(table, acpi_cpu_id);
 	if (!cpu_node)
 		return -ENOENT;
@@ -797,7 +797,7 @@ int find_acpi_cpu_topology_cluster(unsigned int cpu)
 	if (!table)
 		return -ENOENT;
 
-	acpi_cpu_id = get_acpi_id_for_cpu(cpu);
+	acpi_cpu_id = acpi_get_cpu_acpi_id(cpu);
 	cpu_node = acpi_find_processor_node(table, acpi_cpu_id);
 	if (!cpu_node || !cpu_node->parent)
 		return -ENOENT;
@@ -872,7 +872,7 @@ static void acpi_pptt_get_child_cpus(struct acpi_table_header *table_hdr,
 	cpumask_clear(cpus);
 
 	for_each_possible_cpu(cpu) {
-		acpi_id = get_acpi_id_for_cpu(cpu);
+		acpi_id = acpi_get_cpu_acpi_id(cpu);
 		cpu_node = acpi_find_processor_node(table_hdr, acpi_id);
 
 		while (cpu_node) {
@@ -966,7 +966,7 @@ int find_acpi_cache_level_from_id(u32 cache_id)
 	for_each_possible_cpu(cpu) {
 		bool empty;
 		int level = 1;
-		u32 acpi_cpu_id = get_acpi_id_for_cpu(cpu);
+		u32 acpi_cpu_id = acpi_get_cpu_acpi_id(cpu);
 		struct acpi_pptt_cache *cache;
 		struct acpi_pptt_processor *cpu_node;
 
@@ -1030,7 +1030,7 @@ int acpi_pptt_get_cpumask_from_cache_id(u32 cache_id, cpumask_t *cpus)
 	for_each_possible_cpu(cpu) {
 		bool empty;
 		int level = 1;
-		u32 acpi_cpu_id = get_acpi_id_for_cpu(cpu);
+		u32 acpi_cpu_id = acpi_get_cpu_acpi_id(cpu);
 		struct acpi_pptt_cache *cache;
 		struct acpi_pptt_processor *cpu_node;
 
diff --git a/drivers/acpi/riscv/rhct.c b/drivers/acpi/riscv/rhct.c
index caa2c16e1697..c15ce8c13136 100644
--- a/drivers/acpi/riscv/rhct.c
+++ b/drivers/acpi/riscv/rhct.c
@@ -44,7 +44,7 @@ int acpi_get_riscv_isa(struct acpi_table_header *table, unsigned int cpu, const
 	struct acpi_rhct_isa_string *isa_node;
 	struct acpi_table_rhct *rhct;
 	u32 *hart_info_node_offset;
-	u32 acpi_cpu_id = get_acpi_id_for_cpu(cpu);
+	u32 acpi_cpu_id = acpi_get_cpu_acpi_id(cpu);
 
 	BUG_ON(acpi_disabled);
 
diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
index ca4f97be7538..c1bd60637b5a 100644
--- a/drivers/pci/tph.c
+++ b/drivers/pci/tph.c
@@ -236,18 +236,19 @@ static int write_tag_to_st_table(struct pci_dev *pdev, int index, u16 tag)
  * with a specific CPU
  * @pdev: PCI device
  * @mem_type: target memory type (volatile or persistent RAM)
- * @cpu_uid: associated CPU id
+ * @cpu: associated CPU id
  * @tag: Steering Tag to be returned
  *
  * Return the Steering Tag for a target memory that is associated with a
- * specific CPU as indicated by cpu_uid.
+ * specific CPU as indicated by cpu.
  *
  * Return: 0 if success, otherwise negative value (-errno)
  */
 int pcie_tph_get_cpu_st(struct pci_dev *pdev, enum tph_mem_type mem_type,
-			unsigned int cpu_uid, u16 *tag)
+			unsigned int cpu, u16 *tag)
 {
 #ifdef CONFIG_ACPI
+	u32 cpu_uid = acpi_get_cpu_acpi_id(cpu);
 	struct pci_dev *rp;
 	acpi_handle rp_acpi_handle;
 	union st_info info;
@@ -265,9 +266,9 @@ int pcie_tph_get_cpu_st(struct pci_dev *pdev, enum tph_mem_type mem_type,
 
 	*tag = tph_extract_tag(mem_type, pdev->tph_req_type, &info);
 
-	pci_dbg(pdev, "get steering tag: mem_type=%s, cpu_uid=%d, tag=%#04x\n",
+	pci_dbg(pdev, "get steering tag: mem_type=%s, cpu=%d, tag=%#04x\n",
 		(mem_type == TPH_MEM_TYPE_VM) ? "volatile" : "persistent",
-		cpu_uid, *tag);
+		cpu, *tag);
 
 	return 0;
 #else
diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
index 34430b68f602..506b661c60fd 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.c
+++ b/drivers/perf/arm_cspmu/arm_cspmu.c
@@ -1115,7 +1115,7 @@ static int arm_cspmu_acpi_get_cpus(struct arm_cspmu *cspmu)
 	if (affinity_flag == ACPI_APMT_FLAGS_AFFINITY_PROC) {
 		for_each_possible_cpu(cpu) {
 			if (apmt_node->proc_affinity ==
-			    get_acpi_id_for_cpu(cpu)) {
+			    acpi_get_cpu_acpi_id(cpu)) {
 				cpumask_set_cpu(cpu, &cspmu->associated_cpus);
 				break;
 			}
diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
index ba28140ce670..be68cd17f2f8 100644
--- a/include/linux/pci-tph.h
+++ b/include/linux/pci-tph.h
@@ -25,7 +25,7 @@ int pcie_tph_set_st_entry(struct pci_dev *pdev,
 			  unsigned int index, u16 tag);
 int pcie_tph_get_cpu_st(struct pci_dev *dev,
 			enum tph_mem_type mem_type,
-			unsigned int cpu_uid, u16 *tag);
+			unsigned int cpu, u16 *tag);
 void pcie_disable_tph(struct pci_dev *pdev);
 int pcie_enable_tph(struct pci_dev *pdev, int mode);
 u16 pcie_tph_get_st_table_size(struct pci_dev *pdev);
@@ -36,7 +36,7 @@ static inline int pcie_tph_set_st_entry(struct pci_dev *pdev,
 { return -EINVAL; }
 static inline int pcie_tph_get_cpu_st(struct pci_dev *dev,
 				      enum tph_mem_type mem_type,
-				      unsigned int cpu_uid, u16 *tag)
+				      unsigned int cpu, u16 *tag)
 { return -EINVAL; }
 static inline void pcie_disable_tph(struct pci_dev *pdev) { }
 static inline int pcie_enable_tph(struct pci_dev *pdev, int mode)
-- 
2.17.1


