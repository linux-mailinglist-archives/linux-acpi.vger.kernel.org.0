Return-Path: <linux-acpi+bounces-21400-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UOvNN9NHqWm33gAAu9opvQ
	(envelope-from <linux-acpi+bounces-21400-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 10:07:31 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AA87220DFFA
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 10:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B0B54300B457
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Mar 2026 09:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7736D375F9A;
	Thu,  5 Mar 2026 09:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="IZCt+0BH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D03030FC26;
	Thu,  5 Mar 2026 09:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772701646; cv=none; b=Vn/rZ2903tYyyGQ2GyQwrnJNgJBKVxu7fof3GX+XCc4uJCdiCulVzST9tUUVEmyiO5fXtGO5VlC9nl9Zb3FMCVTGtUi2YBmUqaianzte/uprzqC08oZ8M7Bk51PGu3u+RLxbEdObaM4r8TIeGYdFmS7JJKNbglif9JoKehqFGJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772701646; c=relaxed/simple;
	bh=1uK9eHcasbO96xtPiCVeDgqdyb42/NY06mlnCjfFOws=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fkccuRf/Wt/vTMwfR+udKW0foI+c74H3rTzzhC8n8miPEn3U1CDV3B7rYwqu/qCqpSyJA+rPLpJ9/41Ej4yH5TMf6Jhn3k2co+NRyEsUTn7rvYElWJpx8kSxlE3GoFgoAbc3H6EAbFWO7OttZ8SBzZfbtncPz0K2joWJ/jqtzT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=IZCt+0BH; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Q9kNWZNHFfk8yxY8WedVJ7a4Vwhty1A6nAbbKnWpPcI=;
	b=IZCt+0BH+/vIH1JKtxu11xsNTz+i7YWwJBs6bV0sMOaBqk5ZiYKlP7pjJGw3pSIgZPh25bNCn
	kdtp/RJpP3PggEH0WKZwkN4IkKq2z8MpdKAZ1ARuPs7D8ILjJZvNUYbiGIltTWIHJcl8LZFdxzm
	L01E4I4vl8Pkjeu9EojjAPU=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4fRNpZ6tj8zRhsm;
	Thu,  5 Mar 2026 17:02:30 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id E7CD34056F;
	Thu,  5 Mar 2026 17:07:21 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 5 Mar 2026 17:07:19 +0800
Message-ID: <795a9167-6c49-4c7c-9a36-385bf543cacf@huawei.com>
Date: Thu, 5 Mar 2026 17:07:18 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI/TPH: Fix get cpu steer-tag fail on ARM64 platform
To: Huacai Chen <chenhuacai@kernel.org>
CC: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>, Jonathan Corbet
	<corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, WANG Xuerui
	<kernel@xen0n.name>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt
	<palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti
	<alex@ghiti.fr>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown
	<lenb@kernel.org>, Andy Gospodarek <andrew.gospodarek@broadcom.com>, Eric Van
 Tassell <Eric.VanTassell@amd.com>, Ajit Khaparde
	<ajit.khaparde@broadcom.com>, Somnath Kotur <somnath.kotur@broadcom.com>,
	<linux-acpi@vger.kernel.org>, <wei.huang2@amd.com>,
	<jonathan.cameron@huawei.com>, <wangzhou1@hisilicon.com>,
	<wanghuiqiang@huawei.com>, <liuyonglong@huawei.com>,
	<stable@vger.kernel.org>, <jeremy.linton@arm.com>,
	<sunilvl@ventanamicro.com>, <sunilvl@oss.qualcomm.com>,
	<chenhuacai@loongson.cn>, <wangliupu@loongson.cn>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <loongarch@lists.linux.dev>,
	<linux-riscv@lists.infradead.org>
References: <20260303003625.39035-1-fengchengwen@huawei.com>
 <20260305083650.54611-1-fengchengwen@huawei.com>
 <CAAhV-H4xZsyLdzswPxPGHoQNd4LKXrTOL-oPGZHyVt8dj0xu6A@mail.gmail.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <CAAhV-H4xZsyLdzswPxPGHoQNd4LKXrTOL-oPGZHyVt8dj0xu6A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk500009.china.huawei.com (7.202.194.94)
X-Rspamd-Queue-Id: AA87220DFFA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[41];
	TAGGED_FROM(0.00)[bounces-21400-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fengchengwen@huawei.com,linux-acpi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:dkim,huawei.com:email,huawei.com:mid,pcisig.com:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hi Huacai,

On 3/5/2026 4:53 PM, Huacai Chen wrote:
> Hi, Chengwen,
> 
> On Thu, Mar 5, 2026 at 4:37 PM Chengwen Feng <fengchengwen@huawei.com> wrote:
>>
>> Currently the pcie_tph_get_cpu_st() has an issue on ARM64 platform:
>> 1. The pcie_tph_get_cpu_st() function directly uses cpu_uid as the input
>>    parameter to call the PCI ACPI DSM method. According to the DSM
>>    definition, the input value should be the ACPI Processor UID (see [1]
>>    for details).
>> 2. In the Broadcom driver implementation [2] (which invokes
>>    pcie_tph_get_cpu_st()), cpu_uid is obtained via
>>    cpumask_first(irq->cpu_mask) - this is the logical CPU ID of a CPU
>>    core, generated and managed by kernel (e.g., [0,255] for a system
>>    with 256 logical CPU cores).
>> 3. On ARM64 platforms, ACPI assigns Processor UID to cores listed in the
>>    MADT table, and this UID may not match the kernel's logical CPU ID.
>>    As a result, the current implementation fails to retrieve the correct
>>    CPU steer-tag in such cases.
>> 4. The function works on AMD x86 platforms only because the logical CPU
>>    ID is identical to the ACPI Processor UID on those systems.
>>
>> This commit fixes it by:
>> 1. Introducing acpi_get_cpu_acpi_id() in all ACPI-enabled platforms.
>>    This new API calls get_acpi_id_for_cpu() to retrieve the ACPI
>>    Processor UID on arm64/riscv/loongarch arch, and it calls
>>    cpu_acpi_id() on x86 arch.
>> 2. Renaming pcie_tph_get_cpu_st()'s input parameter cpu_uid to cpu for
>>    clarity, as the parameter now represents a logical CPU ID (not a
>>    UID).
>>
>> [1] According to ECN_TPH-ST_Revision_20200924
>>     (https://members.pcisig.com/wg/PCI-SIG/document/15470), the input
>>     is defined as: "If the target is a processor, then this field
>>     represents the ACPI Processor UID of the processor as specified in
>>     the MADT. If the target is a processor container, then this field
>>     represents the ACPI Processor UID of the processor container as
>>     specified in the PPTT."
>> [2] commit c214410c47d6e ("bnxt_en: Add TPH support in BNXT driver")
>>
>> Fixes: d2e8a34876ce ("PCI/TPH: Add Steering Tag support")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
>>
>> ---
>> Changes in v2:
>> - Add ECN _DSM reference doc name and its URL.
>> - Separate implement acpi_get_cpu_acpi_id() in each arch which supports
>>   ACPI.
>> - Refine commit-log.
>>
>> ---
>>  Documentation/PCI/tph.rst    |  4 ++--
>>  arch/arm64/kernel/acpi.c     |  9 +++++++++
>>  arch/loongarch/kernel/acpi.c |  9 +++++++++
>>  arch/riscv/kernel/acpi.c     | 10 ++++++++++
>>  arch/x86/kernel/cpu/common.c | 17 +++++++++++++++++
>>  drivers/pci/tph.c            | 17 ++++++++++++-----
>>  include/linux/acpi.h         | 10 ++++++++++
>>  include/linux/pci-tph.h      |  4 ++--
>>  8 files changed, 71 insertions(+), 9 deletions(-)
>>
>> diff --git a/Documentation/PCI/tph.rst b/Documentation/PCI/tph.rst
>> index e8993be64fd6..b6cf22b9bd90 100644
>> --- a/Documentation/PCI/tph.rst
>> +++ b/Documentation/PCI/tph.rst
>> @@ -79,10 +79,10 @@ To retrieve a Steering Tag for a target memory associated with a specific
>>  CPU, use the following function::
>>
>>    int pcie_tph_get_cpu_st(struct pci_dev *pdev, enum tph_mem_type type,
>> -                          unsigned int cpu_uid, u16 *tag);
>> +                          unsigned int cpu, u16 *tag);
>>
>>  The `type` argument is used to specify the memory type, either volatile
>> -or persistent, of the target memory. The `cpu_uid` argument specifies the
>> +or persistent, of the target memory. The `cpu` argument specifies the
>>  CPU where the memory is associated to.
>>
>>  After the ST value is retrieved, the device driver can use the following
>> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
>> index af90128cfed5..e7d4d9bd3036 100644
>> --- a/arch/arm64/kernel/acpi.c
>> +++ b/arch/arm64/kernel/acpi.c
>> @@ -29,6 +29,7 @@
>>  #include <linux/suspend.h>
>>  #include <linux/pgtable.h>
>>
>> +#include <acpi/acpi.h>
>>  #include <acpi/ghes.h>
>>  #include <acpi/processor.h>
>>  #include <asm/cputype.h>
>> @@ -458,3 +459,11 @@ int acpi_unmap_cpu(int cpu)
>>  }
>>  EXPORT_SYMBOL(acpi_unmap_cpu);
>>  #endif /* CONFIG_ACPI_HOTPLUG_CPU */
>> +
>> +int acpi_get_cpu_acpi_id(unsigned int cpu)
>> +{
>> +       if (cpu >= nr_cpu_ids || !cpu_possible(cpu))
>> +               return -EINVAL;
>> +       return get_acpi_id_for_cpu(cpu);
>> +}
>> +EXPORT_SYMBOL_GPL(acpi_get_cpu_acpi_id);
>> diff --git a/arch/loongarch/kernel/acpi.c b/arch/loongarch/kernel/acpi.c
>> index 1367ca759468..db28747a18e8 100644
>> --- a/arch/loongarch/kernel/acpi.c
>> +++ b/arch/loongarch/kernel/acpi.c
>> @@ -16,6 +16,7 @@
>>  #include <linux/memblock.h>
>>  #include <linux/of_fdt.h>
>>  #include <linux/serial_core.h>
>> +#include <asm/acpi.h>
>>  #include <asm/io.h>
>>  #include <asm/numa.h>
>>  #include <asm/loongson.h>
>> @@ -385,3 +386,11 @@ int acpi_unmap_cpu(int cpu)
>>  EXPORT_SYMBOL(acpi_unmap_cpu);
>>
>>  #endif /* CONFIG_ACPI_HOTPLUG_CPU */
>> +
>> +int acpi_get_cpu_acpi_id(unsigned int cpu)
>> +{
>> +       if (cpu >= nr_cpu_ids || !cpu_possible(cpu))
>> +               return -EINVAL;
>> +       return get_acpi_id_for_cpu(cpu);
>> +}
>> +EXPORT_SYMBOL_GPL(acpi_get_cpu_acpi_id);
>> diff --git a/arch/riscv/kernel/acpi.c b/arch/riscv/kernel/acpi.c
>> index 71698ee11621..287c25e79347 100644
>> --- a/arch/riscv/kernel/acpi.c
>> +++ b/arch/riscv/kernel/acpi.c
>> @@ -22,6 +22,8 @@
>>  #include <linux/pci.h>
>>  #include <linux/serial_core.h>
>>
>> +#include <asm/acpi.h>
>> +
>>  int acpi_noirq = 1;            /* skip ACPI IRQ initialization */
>>  int acpi_disabled = 1;
>>  EXPORT_SYMBOL(acpi_disabled);
>> @@ -337,3 +339,11 @@ int raw_pci_write(unsigned int domain, unsigned int bus,
>>  }
>>
>>  #endif /* CONFIG_PCI */
>> +
>> +int acpi_get_cpu_acpi_id(unsigned int cpu)
>> +{
>> +       if (cpu >= nr_cpu_ids || !cpu_possible(cpu))
>> +               return -EINVAL;
>> +       return get_acpi_id_for_cpu(cpu);
>> +}
>> +EXPORT_SYMBOL_GPL(acpi_get_cpu_acpi_id);
>> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
>> index 1c3261cae40c..9b06c76d5c0c 100644
>> --- a/arch/x86/kernel/cpu/common.c
>> +++ b/arch/x86/kernel/cpu/common.c
>> @@ -28,6 +28,7 @@
>>  #include <linux/stackprotector.h>
>>  #include <linux/utsname.h>
>>  #include <linux/efi.h>
>> +#include <linux/acpi.h>
>>
>>  #include <asm/alternative.h>
>>  #include <asm/cmdline.h>
>> @@ -57,6 +58,7 @@
>>  #include <asm/asm.h>
>>  #include <asm/bugs.h>
>>  #include <asm/cpu.h>
>> +#include <asm/smp.h>
>>  #include <asm/mce.h>
>>  #include <asm/msr.h>
>>  #include <asm/cacheinfo.h>
>> @@ -2643,3 +2645,18 @@ void __init arch_cpu_finalize_init(void)
>>          */
>>         mem_encrypt_init();
>>  }
>> +
>> +int acpi_get_cpu_acpi_id(unsigned int cpu)
>> +{
>> +       u32 acpi_id;
>> +
>> +       if (cpu >= nr_cpu_ids || !cpu_possible(cpu))
>> +               return -EINVAL;
>> +
>> +       acpi_id = cpu_acpi_id(cpu);
>> +       if (acpi_id == CPU_ACPIID_INVALID)
>> +               return -ENODEV;
>> +
>> +       return (int)acpi_id;
>> +}
>> +EXPORT_SYMBOL_GPL(acpi_get_cpu_acpi_id);
>> diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
>> index ca4f97be7538..3cd38972fcb1 100644
>> --- a/drivers/pci/tph.c
>> +++ b/drivers/pci/tph.c
>> @@ -236,21 +236,28 @@ static int write_tag_to_st_table(struct pci_dev *pdev, int index, u16 tag)
>>   * with a specific CPU
>>   * @pdev: PCI device
>>   * @mem_type: target memory type (volatile or persistent RAM)
>> - * @cpu_uid: associated CPU id
>> + * @cpu: associated CPU id
>>   * @tag: Steering Tag to be returned
>>   *
>>   * Return the Steering Tag for a target memory that is associated with a
>> - * specific CPU as indicated by cpu_uid.
>> + * specific CPU as indicated by cpu.
>>   *
>>   * Return: 0 if success, otherwise negative value (-errno)
>>   */
>>  int pcie_tph_get_cpu_st(struct pci_dev *pdev, enum tph_mem_type mem_type,
>> -                       unsigned int cpu_uid, u16 *tag)
>> +                       unsigned int cpu, u16 *tag)
>>  {
>>  #ifdef CONFIG_ACPI
>> +       unsigned int cpu_uid;
>>         struct pci_dev *rp;
>>         acpi_handle rp_acpi_handle;
>>         union st_info info;
>> +       int ret;
>> +
>> +       ret = acpi_get_cpu_acpi_id(cpu);
> Can we use get_acpi_id_for_cpu() directly? Then just x86 needs a wrapper.

Yes, it indeed simple.

But I prefer to have the acpi_ prefix for such API names because it's a cross-subsystem API reference.

Thanks

> 
> Huacai
> 
>> +       if (ret < 0)
>> +               return ret;
>> +       cpu_uid = (unsigned int)ret;
>>
>>         rp = pcie_find_root_port(pdev);
>>         if (!rp || !rp->bus || !rp->bus->bridge)
>> @@ -265,9 +272,9 @@ int pcie_tph_get_cpu_st(struct pci_dev *pdev, enum tph_mem_type mem_type,
>>
>>         *tag = tph_extract_tag(mem_type, pdev->tph_req_type, &info);
>>
>> -       pci_dbg(pdev, "get steering tag: mem_type=%s, cpu_uid=%d, tag=%#04x\n",
>> +       pci_dbg(pdev, "get steering tag: mem_type=%s, cpu=%d, tag=%#04x\n",
>>                 (mem_type == TPH_MEM_TYPE_VM) ? "volatile" : "persistent",
>> -               cpu_uid, *tag);
>> +               cpu, *tag);
>>
>>         return 0;
>>  #else
>> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
>> index 4d2f0bed7a06..426fb4dca333 100644
>> --- a/include/linux/acpi.h
>> +++ b/include/linux/acpi.h
>> @@ -324,6 +324,16 @@ int acpi_unmap_cpu(int cpu);
>>
>>  acpi_handle acpi_get_processor_handle(int cpu);
>>
>> +/*
>> + * acpi_get_cpu_acpi_id() - Get ACPI Processor UID of a specified CPU from MADT table
>> + * @cpu: Logical CPU number (0-based)
>> + *
>> + * Return: ACPI Processor ID of the CPU on success (non-negative);
>> + *         -EINVAL if the CPU number is invalid or not possible;
>> + *         -ENODEV if the ACPI ID of the CPU is invalid.
>> + */
>> +int acpi_get_cpu_acpi_id(unsigned int cpu);
>> +
>>  #ifdef CONFIG_ACPI_HOTPLUG_IOAPIC
>>  int acpi_get_ioapic_id(acpi_handle handle, u32 gsi_base, u64 *phys_addr);
>>  #endif
>> diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
>> index ba28140ce670..be68cd17f2f8 100644
>> --- a/include/linux/pci-tph.h
>> +++ b/include/linux/pci-tph.h
>> @@ -25,7 +25,7 @@ int pcie_tph_set_st_entry(struct pci_dev *pdev,
>>                           unsigned int index, u16 tag);
>>  int pcie_tph_get_cpu_st(struct pci_dev *dev,
>>                         enum tph_mem_type mem_type,
>> -                       unsigned int cpu_uid, u16 *tag);
>> +                       unsigned int cpu, u16 *tag);
>>  void pcie_disable_tph(struct pci_dev *pdev);
>>  int pcie_enable_tph(struct pci_dev *pdev, int mode);
>>  u16 pcie_tph_get_st_table_size(struct pci_dev *pdev);
>> @@ -36,7 +36,7 @@ static inline int pcie_tph_set_st_entry(struct pci_dev *pdev,
>>  { return -EINVAL; }
>>  static inline int pcie_tph_get_cpu_st(struct pci_dev *dev,
>>                                       enum tph_mem_type mem_type,
>> -                                     unsigned int cpu_uid, u16 *tag)
>> +                                     unsigned int cpu, u16 *tag)
>>  { return -EINVAL; }
>>  static inline void pcie_disable_tph(struct pci_dev *pdev) { }
>>  static inline int pcie_enable_tph(struct pci_dev *pdev, int mode)
>> --
>> 2.17.1
>>
> 


