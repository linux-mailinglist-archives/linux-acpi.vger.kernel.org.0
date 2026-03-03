Return-Path: <linux-acpi+bounces-21300-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iI1DKSoupmkrLwAAu9opvQ
	(envelope-from <linux-acpi+bounces-21300-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 03 Mar 2026 01:41:14 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A69BE1E7424
	for <lists+linux-acpi@lfdr.de>; Tue, 03 Mar 2026 01:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DC73D3034B25
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Mar 2026 00:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767BD225417;
	Tue,  3 Mar 2026 00:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="xxGS+VIR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AE9224B04;
	Tue,  3 Mar 2026 00:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772498199; cv=none; b=JCnbR4bjGvdieDHI5KRQTbW2CK9OKraIR0dzwfsmoECCnaqnsVf/z+sZpWYspzFNfR2Sw7Qs2T9frWpIAeX9OYSG8xG59LfqgUK9E+WKAb8p+xrJ7I6ezgzv1EejRp/3NGwj6AAPq+vOsttaduP5xytQjuhAkJdrmPp87tN472g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772498199; c=relaxed/simple;
	bh=0CEHPr6DEYGE59x3t5sJ9elpuDzrwhkOozxEbUISUFU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tox0y1egIWEdlm3SR0BDIInGACu5o1Cdy9mePkDTmIIDULi3FGil1/Dn9flLl4aiG0XfLwuzLbIf97yqgvhNPr98lswps9hlzrAIh8uh375nh4tXVLvwlA0NiTTkd/jIJydYxTVpcwjBKTxiAWKYXPMv+c/yvPcZ6fb+IMfaO3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=xxGS+VIR; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=sD5AimCjlJV0VqtFhbfiB9tyaA7e5aehyOcJEzn24TM=;
	b=xxGS+VIRZ6/pTrBpzBKTsKWZpINKEE8FdTUBvDbsDx/rU4AYhOtyiwQveVX/ea5SOaV7WlkWi
	LeHUMwuqQyCSZbUjp58awf45c64AK1yj6ADXBQZ56eSVqA15Iz8KyKJDEvzflmARVT1yeC8GyuO
	5+gG63nWDoHeS8d6TTHOtMM=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fPxZM6rGZznTVR;
	Tue,  3 Mar 2026 08:31:55 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 62FD640363;
	Tue,  3 Mar 2026 08:36:33 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 3 Mar 2026 08:36:32 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>
CC: <linux-acpi@vger.kernel.org>, <rafael@kernel.org>, <lenb@kernel.org>,
	<wei.huang2@amd.com>, <Eric.VanTassell@amd.com>,
	<jonathan.cameron@huawei.com>, <wangzhou1@hisilicon.com>,
	<wanghuiqiang@huawei.com>, <liuyonglong@huawei.com>, Chengwen Feng
	<fengchengwen@huawei.com>, <stable@vger.kernel.org>
Subject: [PATCH] PCI/TPH: Fix get cpu steer-tag fail on ARM64 platform
Date: Tue, 3 Mar 2026 08:36:25 +0800
Message-ID: <20260303003625.39035-1-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemk500009.china.huawei.com (7.202.194.94)
X-Rspamd-Queue-Id: A69BE1E7424
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21300-lists,linux-acpi=lfdr.de];
	DKIM_TRACE(0.00)[huawei.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fengchengwen@huawei.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,huawei.com:dkim,huawei.com:email,huawei.com:mid]
X-Rspamd-Action: no action

Currently the pcie_tph_get_cpu_st() has a problem on ARM64 platform:
1. The pcie_tph_get_cpu_st() function directly uses cpu_uid as the input
   parameter to call the PCI ACPI DSM method. According to the DSM
   definition, the input value should be the ACPI Processor UID. For
   details, please see [1].
2. In the Broadcom driver implementation [2] (which invoke
   pcie_tph_get_cpu_st()), cpu_uid is obtained based on
   cpumask_first(irq->cpu_mask), that is the logical ID of a CPU core,
   which is generated and managed by the kernel. For example, [0,255]
   if the system has 256 logical CPU cores.
3. Unfortunately, on ARM64 platform, ACPI assigns Processor UID to the
   core which listed in the MADT table, the Processor UID may not equal
   the logical ID of a CPU core in the kernel. So the current
   implementation cannot obtain the cpu's real steer-tag in such case.
4. The reason why it can run on the AMD platform is that the mapping
   between the logical ID and ACPI Processor UID is similar.

This commit fixes it by:
1. Introduce config ARCH_HAS_GET_CPU_ACPI_ID_API and its corresponding
   API acpi_get_cpu_acpi_id() to obtain the ACPI Processor UID of a CPU
   core. This API invokes get_acpi_id_for_cpu() to obtain the UID on
   ARM64 platform.
2. Because using the logical ID as the ACPI Processor UID directly on
   X86 platform is not standard. This commit uses cpu_acpi_id() to
   obtain the UID.
3. At the same time, the input parameter cpu_uid of
   pcie_tph_get_cpu_st() is renamed to cpu for clarity.

[1] According to the _DSM ECN, the input is defined as: "If the target
    is a processor, then this field represents the ACPI Processor
    UID of the processor as specified in the MADT. If the target is
    a processor container, then this field represents the ACPI
    Processor UID of the processor container as specified in the
    PPTT."
[2] commit c214410c47d6e ("bnxt_en: Add TPH support in BNXT driver")

Fixes: d2e8a34876ce ("PCI/TPH: Add Steering Tag support")
Cc: stable@vger.kernel.org
Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 Documentation/PCI/tph.rst     |  4 ++--
 drivers/acpi/Kconfig          |  8 ++++++++
 drivers/acpi/processor_core.c | 13 +++++++++++++
 drivers/pci/tph.c             | 13 +++++++------
 include/linux/acpi.h          |  4 ++++
 include/linux/pci-tph.h       |  4 ++--
 6 files changed, 36 insertions(+), 10 deletions(-)

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
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index df0ff0764d0d..9d851a017cd1 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -606,6 +606,14 @@ config ACPI_PRMT
 	  substantially increase computational overhead related to the
 	  initialization of some server systems.
 
+config ARCH_HAS_GET_CPU_ACPI_ID_API
+	bool "Architecture supports get cpu's ACPI Processor UID"
+	depends on (X86 || ARM64)
+	default y
+	help
+	  This config indicates whether the architecture provides a standard
+	  API to get ACPI Processor UID of a cpu from MADT table.
+
 endif	# ACPI
 
 config X86_PM_TIMER
diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index a4498357bd16..6150f5bdb62e 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -335,6 +335,19 @@ int acpi_get_cpuid(acpi_handle handle, int type, u32 acpi_id)
 }
 EXPORT_SYMBOL_GPL(acpi_get_cpuid);
 
+#ifdef CONFIG_ARCH_HAS_GET_CPU_ACPI_ID_API
+unsigned int acpi_get_cpu_acpi_id(unsigned int cpu)
+{
+	if (cpu >= nr_cpu_ids)
+		return 0;
+#ifdef CONFIG_X86
+	return cpu_acpi_id(cpu);
+#elif CONFIG_ARM64
+	return get_acpi_id_for_cpu(cpu);
+#endif
+}
+#endif /* CONFIG_ARCH_HAS_GET_CPU_ACPI_ID_API */
+
 #ifdef CONFIG_ACPI_HOTPLUG_IOAPIC
 static int get_ioapic_id(struct acpi_subtable_header *entry, u32 gsi_base,
 			 u64 *phys_addr, int *ioapic_id)
diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
index ca4f97be7538..a47c2fbb6148 100644
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
-#ifdef CONFIG_ACPI
+#ifdef CONFIG_ARCH_HAS_GET_CPU_ACPI_ID_API
+	unsigned int cpu_uid = acpi_get_cpu_acpi_id(cpu);
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
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 4d2f0bed7a06..789bfcb8e0f3 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -324,6 +324,10 @@ int acpi_unmap_cpu(int cpu);
 
 acpi_handle acpi_get_processor_handle(int cpu);
 
+#ifdef CONFIG_ARCH_HAS_GET_CPU_ACPI_ID_API
+unsigned int acpi_get_cpu_acpi_id(unsigned int cpu);
+#endif
+
 #ifdef CONFIG_ACPI_HOTPLUG_IOAPIC
 int acpi_get_ioapic_id(acpi_handle handle, u32 gsi_base, u64 *phys_addr);
 #endif
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


