Return-Path: <linux-acpi+bounces-21522-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBpjBS9KrmloBwIAu9opvQ
	(envelope-from <linux-acpi+bounces-21522-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Mar 2026 05:18:55 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 63AE3233A57
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Mar 2026 05:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96A16301651C
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Mar 2026 04:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D32427F01E;
	Mon,  9 Mar 2026 04:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ol8QqwPN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D445C257821;
	Mon,  9 Mar 2026 04:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773029932; cv=none; b=Iu1ooL0ZhPgWeQWbU/cFCObRePF9fon3U+PusU2CwsEQFbcmDLrA2s7wUSi11lam70bISMm7Z5ZlIrKFwmhE4T27up7xf1UiOjg2MiPbPwB6f0zceHIzFb7kECg8WuARKiCEWK8cBIPjMvI7hW+UKuswammGbaGfiefg4AHcuv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773029932; c=relaxed/simple;
	bh=9U4uXKxGql6tmmX9FvIUwXrYinnE1PnRuSYUT66fISg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SPKJ9dQ7EPtgzHCk55Md8ko+0zzazUgYU/ro+OnFAQvsnSIUf8nLTCUK/o6UvW2nVrHXkAC/HYum5I47gADBrhywWyZgIRXZ2xmYnzuQW2h9TTbz1Vw3bqHmpTaFDagX7xZv9s9Jbtqpp1zacNuxtQ8r1dqY6cDECMJF3Tn3vjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ol8QqwPN; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=VcFeIjx/kFPapeVcWBRCbJKEh34txyf1s44oxCrJMLM=;
	b=ol8QqwPNIUmxbtyWrgNcNqbEdLIpeRj6Pz/TpU3TDi14gpa7wLJpmDHXFdha5RdCid7NTLtTf
	voC6PheOGh96yK0L9QAS865k3rYsGeK1D/sKryROy0/4JqM66H1zLhU7FxxLd8941ZOL+vMRs0S
	d7tvBLpfx7y6tsXoh01LOjw=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4fTkCQ6yyKzpTXt;
	Mon,  9 Mar 2026 12:13:38 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id ACFA420168;
	Mon,  9 Mar 2026 12:18:46 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 9 Mar 2026 12:18:45 +0800
Message-ID: <004f0d24-4413-40b2-8e31-392cb7f69523@huawei.com>
Date: Mon, 9 Mar 2026 12:18:44 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] PCI/TPH: Fix get cpu steer-tag fail on ARM64 platform
To: Jonathan Cameron <jonathan.cameron@huawei.com>
CC: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>, Jonathan Corbet
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
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	<linux-acpi@vger.kernel.org>, <wangzhou1@hisilicon.com>,
	<wanghuiqiang@huawei.com>, <liuyonglong@huawei.com>,
	<stable@vger.kernel.org>, <jeremy.linton@arm.com>,
	<sunilvl@oss.qualcomm.com>, <chenhuacai@loongson.cn>,
	<wangliupu@loongson.cn>, Somnath Kotur <somnath.kotur@broadcom.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <loongarch@lists.linux.dev>,
	<linux-riscv@lists.infradead.org>, <linux-perf-users@vger.kernel.org>
References: <20260303003625.39035-1-fengchengwen@huawei.com>
 <20260306021920.23233-1-fengchengwen@huawei.com>
 <20260306100150.00003f38@huawei.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260306100150.00003f38@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk500009.china.huawei.com (7.202.194.94)
X-Rspamd-Queue-Id: 63AE3233A57
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[43];
	TAGGED_FROM(0.00)[bounces-21522-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fengchengwen@huawei.com,linux-acpi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.946];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,huawei.com:dkim,huawei.com:email,huawei.com:mid]
X-Rspamd-Action: no action

On 3/6/2026 6:01 PM, Jonathan Cameron wrote:
> On Fri, 6 Mar 2026 10:19:17 +0800
> Chengwen Feng <fengchengwen@huawei.com> wrote:
> 
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
>> 1. For ACPI-enabled platforms, unify the CPU ACPI ID retrieval
>>    interface:
>>    - On arm64/riscv/loongarch: Rename existing get_acpi_id_for_cpu() to
>>      acpi_get_cpu_acpi_id().
>>    - On x86: Add new acpi_get_cpu_acpi_id() implementation that wraps
>>      cpu_acpi_id().
>> 2. Update pcie_tph_get_cpu_st() to use acpi_get_cpu_acpi_id(cpu) to get
>>    valid ACPI Processor UID for DSM calls.
>> 3. Renaming pcie_tph_get_cpu_st()'s input parameter cpu_uid to cpu for
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
>> Changes in v3:
>> - Rename existing get_acpi_id_for_cpu() to acpi_get_cpu_acpi_id() other
>>   than add one new API.
> Ah. I wasn't clear around that rename suggestion.  Split this into two patches.
> 1) Rename
> 2) The new stuff plus x86 implementation.

Hi Jonathan,

All fixes are applied in v4. Please review.

Thanks.

> 
>>
>> Changes in v2:
>> - Add ECN _DSM reference doc name and its URL.
>> - Separate implement acpi_get_cpu_acpi_id() in each arch which supports
>>   ACPI.
>> - Refine commit-log.
>>
>> ---
>>  Documentation/PCI/tph.rst          |  4 ++--
>>  arch/arm64/include/asm/acpi.h      |  4 ++--
>>  arch/loongarch/include/asm/acpi.h  |  2 +-
>>  arch/riscv/include/asm/acpi.h      |  2 +-
>>  arch/riscv/kernel/acpi_numa.c      |  2 +-
>>  arch/x86/include/asm/acpi.h        |  2 ++
>>  arch/x86/kernel/cpu/common.c       |  8 ++++++++
>>  drivers/acpi/pptt.c                | 16 ++++++++--------
>>  drivers/acpi/riscv/rhct.c          |  2 +-
>>  drivers/pci/tph.c                  | 11 ++++++-----
>>  drivers/perf/arm_cspmu/arm_cspmu.c |  2 +-
>>  include/linux/pci-tph.h            |  4 ++--
>>  12 files changed, 35 insertions(+), 24 deletions(-)
> 
> 
> 


