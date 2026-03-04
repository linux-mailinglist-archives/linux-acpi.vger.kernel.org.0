Return-Path: <linux-acpi+bounces-21325-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIyZHFP7p2mtmwAAu9opvQ
	(envelope-from <linux-acpi+bounces-21325-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 04 Mar 2026 10:28:51 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E031FD8FB
	for <lists+linux-acpi@lfdr.de>; Wed, 04 Mar 2026 10:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A1C8B300C837
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Mar 2026 09:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CAF386C09;
	Wed,  4 Mar 2026 09:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="LXDzUsjd"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF21D1A6821;
	Wed,  4 Mar 2026 09:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772616528; cv=none; b=R8150wni4Hll2GQR9da5YQYczPBaOBdhdB9QbEd3u9+HXTElxkdWaS7rRkMBQT3OZIP7MSFiEMyGLfMk8DawQD5U6yQSVcZNqON3/vnbEkZlwAOglMZCwLvykHWF/qofgkpx3iljGnf4S7Z3wR8z4ayHtDENB/ionIYqwal4FkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772616528; c=relaxed/simple;
	bh=F/onQkFGeEpM4gZ3U1SklklytcVxg+sXuT/SBBcPR6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dR9FvDu+e2vAVl+jNACot9bUQl0MS2ZuyE0jaiDmunlDMKspYB+ftypSPYoe6OdIclddiH0z3LAbgQLRsiRL/X9ZdOojeEQIHr9MO9LwpeLFGUCafT9MKczDS1e930P+FxBsNYM5HmllJVV6tl94TjZSWX+qgNYfqJifORWxNIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=LXDzUsjd; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=uviTWF7SUXu3C2x10PLtsSEtUgqLdpqtBhNC0gamoCk=;
	b=LXDzUsjd971No7GQT5dKB1dj7h+CoUMpOgUKgZt4KdBom/3H8kA3Ch29SVd8AcVKrz2pNPkuH
	cGLFugEc88VSYam8OMN/91CBYcs0L+yvjRTnAzw8c3R7enTKrDTwcGANsoC7Uttf8ZiwKX0jW0v
	2C83GXL2QzhwVDva6rNdpck=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4fQnKs3TlVz12LdV;
	Wed,  4 Mar 2026 17:24:01 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id EF8BF404AD;
	Wed,  4 Mar 2026 17:28:37 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 4 Mar 2026 17:28:37 +0800
Message-ID: <ddf4b6db-b0c7-43ca-baad-a9df6acdca2e@huawei.com>
Date: Wed, 4 Mar 2026 17:28:36 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/TPH: Fix get cpu steer-tag fail on ARM64 platform
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
	<linux-acpi@vger.kernel.org>, <rafael@kernel.org>, <lenb@kernel.org>,
	<wei.huang2@amd.com>, <Eric.VanTassell@amd.com>,
	<jonathan.cameron@huawei.com>, <wangzhou1@hisilicon.com>,
	<wanghuiqiang@huawei.com>, <liuyonglong@huawei.com>,
	<stable@vger.kernel.org>, Jeremy Linton <jeremy.linton@arm.com>, Sunil V L
	<sunilvl@ventanamicro.com>, Sunil V L <sunilvl@oss.qualcomm.com>, Huacai Chen
	<chenhuacai@loongson.cn>, Liupu Wang <wangliupu@loongson.cn>
References: <20260303190211.GA4059782@bhelgaas>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260303190211.GA4059782@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk500009.china.huawei.com (7.202.194.94)
X-Rspamd-Queue-Id: C9E031FD8FB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-21325-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fengchengwen@huawei.com,linux-acpi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,huawei.com:dkim,huawei.com:email,huawei.com:mid]
X-Rspamd-Action: no action

Thanks for your feedback and suggestions. Replies inline.

On 3/4/2026 3:02 AM, Bjorn Helgaas wrote:
> [+cc Jeremy, Sunil, Huacai, Liupu, authors of get_acpi_id_for_cpu()
> for arm64, riscv, loongson]
> 
> On Tue, Mar 03, 2026 at 08:36:25AM +0800, Chengwen Feng wrote:
>> Currently the pcie_tph_get_cpu_st() has a problem on ARM64 platform:
>> 1. The pcie_tph_get_cpu_st() function directly uses cpu_uid as the input
>>    parameter to call the PCI ACPI DSM method. According to the DSM
>>    definition, the input value should be the ACPI Processor UID. For
>>    details, please see [1].
>>
>> 2. In the Broadcom driver implementation [2] (which invoke
>>    pcie_tph_get_cpu_st()), cpu_uid is obtained based on
>>    cpumask_first(irq->cpu_mask), that is the logical ID of a CPU core,
>>    which is generated and managed by the kernel. For example, [0,255]
>>    if the system has 256 logical CPU cores.
>> 3. Unfortunately, on ARM64 platform, ACPI assigns Processor UID to the
>>    core which listed in the MADT table, the Processor UID may not equal
>>    the logical ID of a CPU core in the kernel. So the current
>>    implementation cannot obtain the cpu's real steer-tag in such case.
>> 4. The reason why it can run on the AMD platform is that the mapping
>>    between the logical ID and ACPI Processor UID is similar.
>>
>> This commit fixes it by:
>> 1. Introduce config ARCH_HAS_GET_CPU_ACPI_ID_API and its corresponding
>>    API acpi_get_cpu_acpi_id() to obtain the ACPI Processor UID of a CPU
>>    core. This API invokes get_acpi_id_for_cpu() to obtain the UID on
>>    ARM64 platform.
>> 2. Because using the logical ID as the ACPI Processor UID directly on
>>    X86 platform is not standard. This commit uses cpu_acpi_id() to
>>    obtain the UID.
>> 3. At the same time, the input parameter cpu_uid of
>>    pcie_tph_get_cpu_st() is renamed to cpu for clarity.
> 
> Thanks for raising this issue!
> 
> TLP Processing Hints (TPH) and Steering Tags are generic PCIe features
> that we should support for both ACPI and non-ACPI systems.
> 
> The current implementation of pcie_tph_get_cpu_st() only supports
> ACPI, and it assumes the cpu_uid parameter is an ACPI CPU UID that can
> be passed directly to the _DSM.  But since we want this to be a
> generic interface, I think the "cpu" parameter should be the Linux
> logical CPU ID, not an ACPI UID, as you point out.
> 
>> [1] According to the _DSM ECN, the input is defined as: "If the target
>>     is a processor, then this field represents the ACPI Processor
>>     UID of the processor as specified in the MADT. If the target is
>>     a processor container, then this field represents the ACPI
>>     Processor UID of the processor container as specified in the
>>     PPTT."
> 
> This needs a specific spec citation for the _DSM function.  Ideally it
> would be "PCI Firmware spec r3.3, sec xx", but I don't think there's a
> revision of the spec that includes this ECN.  But we can at least
> include the actual name and URL for the approved ECN.

OK, will do in v2

> 
>> [2] commit c214410c47d6e ("bnxt_en: Add TPH support in BNXT driver")
>>
>> Fixes: d2e8a34876ce ("PCI/TPH: Add Steering Tag support")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
>> ---
>>  Documentation/PCI/tph.rst     |  4 ++--
>>  drivers/acpi/Kconfig          |  8 ++++++++
>>  drivers/acpi/processor_core.c | 13 +++++++++++++
>>  drivers/pci/tph.c             | 13 +++++++------
>>  include/linux/acpi.h          |  4 ++++
>>  include/linux/pci-tph.h       |  4 ++--
>>  6 files changed, 36 insertions(+), 10 deletions(-)
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
>> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
>> index df0ff0764d0d..9d851a017cd1 100644
>> --- a/drivers/acpi/Kconfig
>> +++ b/drivers/acpi/Kconfig
>> @@ -606,6 +606,14 @@ config ACPI_PRMT
>>  	  substantially increase computational overhead related to the
>>  	  initialization of some server systems.
>>  
>> +config ARCH_HAS_GET_CPU_ACPI_ID_API
>> +	bool "Architecture supports get cpu's ACPI Processor UID"
>> +	depends on (X86 || ARM64)
>> +	default y
>> +	help
>> +	  This config indicates whether the architecture provides a standard
>> +	  API to get ACPI Processor UID of a cpu from MADT table.
>> +
>>  endif	# ACPI
>>  
>>  config X86_PM_TIMER
>> diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
>> index a4498357bd16..6150f5bdb62e 100644
>> --- a/drivers/acpi/processor_core.c
>> +++ b/drivers/acpi/processor_core.c
>> @@ -335,6 +335,19 @@ int acpi_get_cpuid(acpi_handle handle, int type, u32 acpi_id)
>>  }
>>  EXPORT_SYMBOL_GPL(acpi_get_cpuid);
>>  
>> +#ifdef CONFIG_ARCH_HAS_GET_CPU_ACPI_ID_API
>> +unsigned int acpi_get_cpu_acpi_id(unsigned int cpu)
>> +{
>> +	if (cpu >= nr_cpu_ids)
>> +		return 0;
>> +#ifdef CONFIG_X86
>> +	return cpu_acpi_id(cpu);
>> +#elif CONFIG_ARM64
>> +	return get_acpi_id_for_cpu(cpu);
>> +#endif
>> +}
>> +#endif /* CONFIG_ARCH_HAS_GET_CPU_ACPI_ID_API */
>> +
>>  #ifdef CONFIG_ACPI_HOTPLUG_IOAPIC
>>  static int get_ioapic_id(struct acpi_subtable_header *entry, u32 gsi_base,
>>  			 u64 *phys_addr, int *ioapic_id)
>> diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
>> index ca4f97be7538..a47c2fbb6148 100644
>> --- a/drivers/pci/tph.c
>> +++ b/drivers/pci/tph.c
>> @@ -236,18 +236,19 @@ static int write_tag_to_st_table(struct pci_dev *pdev, int index, u16 tag)
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
>> -			unsigned int cpu_uid, u16 *tag)
>> +			unsigned int cpu, u16 *tag)
>>  {
>> -#ifdef CONFIG_ACPI
>> +#ifdef CONFIG_ARCH_HAS_GET_CPU_ACPI_ID_API
>> +	unsigned int cpu_uid = acpi_get_cpu_acpi_id(cpu);
> 
> Any required conversion between Linux logical CPU and ACPI CPU UID
> should be internal to pcie_tph_get_cpu_st(), as you're doing here.
> 
> But rather than adding CONFIG_ARCH_HAS_GET_CPU_ACPI_ID_API and the
> ifdefs in acpi_get_cpu_acpi_id(), I think there should be a generic
> ACPI interface that converts logical CPU ID to ACPI UID, and every
> arch supporting ACPI should have to implement it.
> 
> We already have get_acpi_id_for_cpu(), implemented for arm64, riscv,
> and loongarch:
> 
>   30d87bfacbee ("arm64/acpi: Create arch specific cpu to acpi id helper")
>   f99561199470 ("RISC-V: ACPI: Cache and retrieve the RINTC structure")
>   f6f0c9a74a48 ("LoongArch: Add SMT (Simultaneous Multi-Threading) support")
> 
> What if we just implemented it for x86 as well and moved it to
> include/linux/acpi.h or similar?

Your idea to unify the ACPI CPU ID function across architectures is great. I noticed
that all exported ACPI functions use the `acpi_` prefix, so I think we shouldn’t
simply modify x86’s implementation directly – we should also align the naming
convention for other platforms.

Since only x86, arm64, risc-v, and loongarch currently support ACPI, how about we
remove the new config and instead use this approach:

unsigned int acpi_get_cpu_acpi_id(unsigned int cpu)
{
        if (cpu >= nr_cpu_ids)
                return 0;
#ifdef CONFIG_X86
        return cpu_acpi_id(cpu);
#elif defined(CONFIG_ARM64) || defined(CONFIG_RISCV) || defined(CONFIG_LOONGARCH)
        return get_acpi_id_for_cpu(cpu);
#endif
}

For any new platform that plans to support ACPI in the future, this will trigger a
compile error – which is intentional. It will prompt the maintainers of that platform
to add their own implementation of either `get_acpi_id_for_cpu` or `cpu_acpi_id` as
needed.

> 
>>  	struct pci_dev *rp;
>>  	acpi_handle rp_acpi_handle;
>>  	union st_info info;
>> @@ -265,9 +266,9 @@ int pcie_tph_get_cpu_st(struct pci_dev *pdev, enum tph_mem_type mem_type,
>>  
>>  	*tag = tph_extract_tag(mem_type, pdev->tph_req_type, &info);
>>  
>> -	pci_dbg(pdev, "get steering tag: mem_type=%s, cpu_uid=%d, tag=%#04x\n",
>> +	pci_dbg(pdev, "get steering tag: mem_type=%s, cpu=%d, tag=%#04x\n",
>>  		(mem_type == TPH_MEM_TYPE_VM) ? "volatile" : "persistent",
>> -		cpu_uid, *tag);
>> +		cpu, *tag);
>>  
>>  	return 0;
>>  #else
>> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
>> index 4d2f0bed7a06..789bfcb8e0f3 100644
>> --- a/include/linux/acpi.h
>> +++ b/include/linux/acpi.h
>> @@ -324,6 +324,10 @@ int acpi_unmap_cpu(int cpu);
>>  
>>  acpi_handle acpi_get_processor_handle(int cpu);
>>  
>> +#ifdef CONFIG_ARCH_HAS_GET_CPU_ACPI_ID_API
>> +unsigned int acpi_get_cpu_acpi_id(unsigned int cpu);
>> +#endif
>> +
>>  #ifdef CONFIG_ACPI_HOTPLUG_IOAPIC
>>  int acpi_get_ioapic_id(acpi_handle handle, u32 gsi_base, u64 *phys_addr);
>>  #endif
>> diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
>> index ba28140ce670..be68cd17f2f8 100644
>> --- a/include/linux/pci-tph.h
>> +++ b/include/linux/pci-tph.h
>> @@ -25,7 +25,7 @@ int pcie_tph_set_st_entry(struct pci_dev *pdev,
>>  			  unsigned int index, u16 tag);
>>  int pcie_tph_get_cpu_st(struct pci_dev *dev,
>>  			enum tph_mem_type mem_type,
>> -			unsigned int cpu_uid, u16 *tag);
>> +			unsigned int cpu, u16 *tag);
>>  void pcie_disable_tph(struct pci_dev *pdev);
>>  int pcie_enable_tph(struct pci_dev *pdev, int mode);
>>  u16 pcie_tph_get_st_table_size(struct pci_dev *pdev);
>> @@ -36,7 +36,7 @@ static inline int pcie_tph_set_st_entry(struct pci_dev *pdev,
>>  { return -EINVAL; }
>>  static inline int pcie_tph_get_cpu_st(struct pci_dev *dev,
>>  				      enum tph_mem_type mem_type,
>> -				      unsigned int cpu_uid, u16 *tag)
>> +				      unsigned int cpu, u16 *tag)
>>  { return -EINVAL; }
>>  static inline void pcie_disable_tph(struct pci_dev *pdev) { }
>>  static inline int pcie_enable_tph(struct pci_dev *pdev, int mode)
>> -- 
>> 2.17.1
>>
> 


