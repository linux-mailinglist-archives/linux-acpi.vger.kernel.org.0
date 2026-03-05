Return-Path: <linux-acpi+bounces-21398-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKEcNoNBqWkZ3gAAu9opvQ
	(envelope-from <linux-acpi+bounces-21398-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 09:40:35 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CAC020D96C
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 09:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D5F263012BCE
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Mar 2026 08:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6859372ED1;
	Thu,  5 Mar 2026 08:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="26xxDlsA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E141930EF92;
	Thu,  5 Mar 2026 08:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772700033; cv=none; b=MhO5M6cxWP5DzNBGXke1dHnWYvKjKs7Oq8s/FnT6C6v0ClLH60JFBSYHSGs9JJBC8Vzvys9/zOCUGEIRAELqrAnCxwlQ+Xuu9RDUmhGYUy/tww3iKCgigGdDRuHI5IHyGClBbMlT1vKwTbunbdTvWvJ72bqQs0fojHqNHFJUgwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772700033; c=relaxed/simple;
	bh=rYdj61l11m/Wdad5KqChC73PDjCHTsOIYre68lpjfeE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Czpcl9jk7z5ElLZuAll6l9FtDN2cyEZpKNqdmLewAl/GmW0F01eiNf0jOK9ugnueR4LQUOW8uymZ4pYoczwbY/hs44MEp+74wQZC2iSt15YpBkX4ezCCjkvrrFN4eeBWdcG7xwfBeOiiroglSK5Z1sQZJ8GnavhGUAOerAppBkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=26xxDlsA; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=vsl3SAJBzjZoiRidCvb/tfklZVUpZMGiX0MCG5/qPzI=;
	b=26xxDlsAY8fgLKY79vUxhY3tqvcYDzHLRa8KSTgNUiIzwRX0z06TYvelrzlgHbW8QN8a63Qvm
	S4oUbwG/TF23kDtcM7iYFLqHnA5TW1hMvRRe96IHnwowce/pRI4x0HJUf38+kOMQuluTaAuSnA2
	VYzM6YXobkd+qUC/jdpQ0q4=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fRNCs4kt2znTby;
	Thu,  5 Mar 2026 16:35:53 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id BC2D240363;
	Thu,  5 Mar 2026 16:40:29 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 5 Mar 2026 16:40:28 +0800
Message-ID: <f03eab1f-1fcd-4279-bef9-ce69796be2e2@huawei.com>
Date: Thu, 5 Mar 2026 16:40:28 +0800
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
References: <20260304153847.GA23109@bhelgaas>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260304153847.GA23109@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk500009.china.huawei.com (7.202.194.94)
X-Rspamd-Queue-Id: 7CAC020D96C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-21398-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fengchengwen@huawei.com,linux-acpi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,huawei.com:dkim,huawei.com:mid]
X-Rspamd-Action: no action

On 3/4/2026 11:38 PM, Bjorn Helgaas wrote:
> On Wed, Mar 04, 2026 at 05:28:36PM +0800, fengchengwen wrote:
>> On 3/4/2026 3:02 AM, Bjorn Helgaas wrote:
>>> [+cc Jeremy, Sunil, Huacai, Liupu, authors of get_acpi_id_for_cpu()
>>> for arm64, riscv, loongson]
>>>
>>> On Tue, Mar 03, 2026 at 08:36:25AM +0800, Chengwen Feng wrote:
>>>> Currently the pcie_tph_get_cpu_st() has a problem on ARM64 platform:
>>>> 1. The pcie_tph_get_cpu_st() function directly uses cpu_uid as the input
>>>>    parameter to call the PCI ACPI DSM method. According to the DSM
>>>>    definition, the input value should be the ACPI Processor UID. For
>>>>    details, please see [1].
>>>>
>>>> 2. In the Broadcom driver implementation [2] (which invoke
>>>>    pcie_tph_get_cpu_st()), cpu_uid is obtained based on
>>>>    cpumask_first(irq->cpu_mask), that is the logical ID of a CPU core,
>>>>    which is generated and managed by the kernel. For example, [0,255]
>>>>    if the system has 256 logical CPU cores.
>>>> 3. Unfortunately, on ARM64 platform, ACPI assigns Processor UID to the
>>>>    core which listed in the MADT table, the Processor UID may not equal
>>>>    the logical ID of a CPU core in the kernel. So the current
>>>>    implementation cannot obtain the cpu's real steer-tag in such case.
>>>> 4. The reason why it can run on the AMD platform is that the mapping
>>>>    between the logical ID and ACPI Processor UID is similar.
>>>>
>>>> This commit fixes it by:
>>>> 1. Introduce config ARCH_HAS_GET_CPU_ACPI_ID_API and its corresponding
>>>>    API acpi_get_cpu_acpi_id() to obtain the ACPI Processor UID of a CPU
>>>>    core. This API invokes get_acpi_id_for_cpu() to obtain the UID on
>>>>    ARM64 platform.
>>>> 2. Because using the logical ID as the ACPI Processor UID directly on
>>>>    X86 platform is not standard. This commit uses cpu_acpi_id() to
>>>>    obtain the UID.
>>>> 3. At the same time, the input parameter cpu_uid of
>>>>    pcie_tph_get_cpu_st() is renamed to cpu for clarity.
>>>
>>> Thanks for raising this issue!
>>>
>>> TLP Processing Hints (TPH) and Steering Tags are generic PCIe features
>>> that we should support for both ACPI and non-ACPI systems.
>>>
>>> The current implementation of pcie_tph_get_cpu_st() only supports
>>> ACPI, and it assumes the cpu_uid parameter is an ACPI CPU UID that can
>>> be passed directly to the _DSM.  But since we want this to be a
>>> generic interface, I think the "cpu" parameter should be the Linux
>>> logical CPU ID, not an ACPI UID, as you point out.
>> ...
> 
>>>>  int pcie_tph_get_cpu_st(struct pci_dev *pdev, enum tph_mem_type mem_type,
>>>> -			unsigned int cpu_uid, u16 *tag)
>>>> +			unsigned int cpu, u16 *tag)
>>>>  {
>>>> -#ifdef CONFIG_ACPI
>>>> +#ifdef CONFIG_ARCH_HAS_GET_CPU_ACPI_ID_API
>>>> +	unsigned int cpu_uid = acpi_get_cpu_acpi_id(cpu);
>>>
>>> Any required conversion between Linux logical CPU and ACPI CPU UID
>>> should be internal to pcie_tph_get_cpu_st(), as you're doing here.
>>>
>>> But rather than adding CONFIG_ARCH_HAS_GET_CPU_ACPI_ID_API and the
>>> ifdefs in acpi_get_cpu_acpi_id(), I think there should be a generic
>>> ACPI interface that converts logical CPU ID to ACPI UID, and every
>>> arch supporting ACPI should have to implement it.
>>>
>>> We already have get_acpi_id_for_cpu(), implemented for arm64, riscv,
>>> and loongarch:
>>>
>>>   30d87bfacbee ("arm64/acpi: Create arch specific cpu to acpi id helper")
>>>   f99561199470 ("RISC-V: ACPI: Cache and retrieve the RINTC structure")
>>>   f6f0c9a74a48 ("LoongArch: Add SMT (Simultaneous Multi-Threading) support")
>>>
>>> What if we just implemented it for x86 as well and moved it to
>>> include/linux/acpi.h or similar?
>>
>> Your idea to unify the ACPI CPU ID function across architectures is
>> great. I noticed that all exported ACPI functions use the `acpi_`
>> prefix, so I think we shouldn’t simply modify x86’s implementation
>> directly – we should also align the naming convention for other
>> platforms.
>>
>> Since only x86, arm64, risc-v, and loongarch currently support ACPI,
>> how about we remove the new config and instead use this approach:
>>
>> unsigned int acpi_get_cpu_acpi_id(unsigned int cpu)
>> {
>>         if (cpu >= nr_cpu_ids)
>>                 return 0;
>> #ifdef CONFIG_X86
>>         return cpu_acpi_id(cpu);
>> #elif defined(CONFIG_ARM64) || defined(CONFIG_RISCV) || defined(CONFIG_LOONGARCH)
>>         return get_acpi_id_for_cpu(cpu);
>> #endif
>> }
>>
>> For any new platform that plans to support ACPI in the future, this
>> will trigger a compile error – which is intentional. It will prompt
>> the maintainers of that platform to add their own implementation of
>> either `get_acpi_id_for_cpu` or `cpu_acpi_id` as needed.
> 
> I agree that an "acpi_" prefix would be appropriate.  I'd suggest
> separate implementations in arch/*/kernel/acpi.c instead of #ifdefs in
> a common version.

Hi, I have sent out v2 as requested. Please review, thanks.

> 
> Maybe users of cpu_acpi_id() and get_acpi_id_for_cpu() could be
> converted to use the generic interface.
> 


