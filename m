Return-Path: <linux-acpi+bounces-21521-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGUhENpJrmlWBwIAu9opvQ
	(envelope-from <linux-acpi+bounces-21521-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Mar 2026 05:17:30 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5953233A19
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Mar 2026 05:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 346B4301A156
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Mar 2026 04:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6048282F11;
	Mon,  9 Mar 2026 04:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="V84GHQ/U"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23656281376;
	Mon,  9 Mar 2026 04:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773029842; cv=none; b=b8Ugfvj2c8TAJMijGY5S228/HNXv5suPtOrSx18vZYASzp4o3yjVfL+9TLfc8fIdGoW+bOXY3+3BOOsOXTn9+bFQJZ6Zn5Rh2c5l3eCro3S1z/TN6tC7ILGmBvc05DpU7+KLzJJNaXnFCteVq8phbd6F89qax62mKCXBrgXqQRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773029842; c=relaxed/simple;
	bh=nUzGMVTeElKnKiIR7ZLx2aKonvkNffqv+GxMirJZzbA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BWQ8PktgduzqNRYekMLNy01khiVPI5NiRLKTya0Tk/bTMh6X63Fc9mhyttTy7koSfXPSXr1YkKYdpGhUCCgO4tid2XHWcm9jva0/W0HYX6pS7y5Fdwu4xpONWoi5iDatB+X7Ll/k68VtKUz21BWuwkTXt1cZ9uCbDX7Ew8GpT30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=V84GHQ/U; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Jy7s+i13Z9Yho5Eo++yt7ZT6jecKhfqtdltzMmvprxQ=;
	b=V84GHQ/UFqIyqvjBCvUFlRDnp72NsVKdkmC8sMao55Gd7RpF0tBk/xpTSm60/oRc1SFLMP0L6
	6XzEOGAVGM4shoD0MFrTio477zDj5GJ1fgL/e4fw+Cvb8L6fWkGy2GZmZxuZffRlw7TQgPhlXzX
	DRVxeL/o637kij3iItMcLMk=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4fTk9b5JHXzpSvj;
	Mon,  9 Mar 2026 12:12:03 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 7123040569;
	Mon,  9 Mar 2026 12:17:11 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 9 Mar 2026 12:17:10 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>, Jonathan Corbet
	<corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Gospodarek
	<andrew.gospodarek@broadcom.com>, Somnath Kotur <somnath.kotur@broadcom.com>,
	Wei Huang <wei.huang2@amd.com>, Eric Van Tassell <Eric.VanTassell@amd.com>
CC: <linux-acpi@vger.kernel.org>, <rafael@kernel.org>, <lenb@kernel.org>,
	<jonathan.cameron@huawei.com>, <wangzhou1@hisilicon.com>,
	<wanghuiqiang@huawei.com>, <liuyonglong@huawei.com>,
	<stable@vger.kernel.org>, <jeremy.linton@arm.com>,
	<sunilvl@ventanamicro.com>, <sunilvl@oss.qualcomm.com>,
	<chenhuacai@loongson.cn>, <wangliupu@loongson.cn>, Chengwen Feng
	<fengchengwen@huawei.com>, Ajit Khaparde <ajit.khaparde@broadcom.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 2/2] PCI/TPH: Fix get cpu steer-tag fail on ARM64 platform
Date: Mon, 9 Mar 2026 12:16:58 +0800
Message-ID: <20260309041659.18815-3-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260309041659.18815-1-fengchengwen@huawei.com>
References: <20260303003625.39035-1-fengchengwen@huawei.com>
 <20260309041659.18815-1-fengchengwen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemk500009.china.huawei.com (7.202.194.94)
X-Rspamd-Queue-Id: B5953233A19
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[31];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21521-lists,linux-acpi=lfdr.de];
	DKIM_TRACE(0.00)[huawei.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fengchengwen@huawei.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.984];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:dkim,huawei.com:email,huawei.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
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
1. Add new acpi_get_cpu_acpi_id() implementation on x86 that wraps
   cpu_acpi_id(), completing the unified ACPI CPU ID retrieval interface
   across ACPI-enabled platforms.
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
 Documentation/PCI/tph.rst    |  4 ++--
 arch/x86/include/asm/acpi.h  |  2 ++
 arch/x86/kernel/cpu/common.c |  8 ++++++++
 drivers/pci/tph.c            | 11 ++++++-----
 include/linux/pci-tph.h      |  4 ++--
 5 files changed, 20 insertions(+), 9 deletions(-)

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


