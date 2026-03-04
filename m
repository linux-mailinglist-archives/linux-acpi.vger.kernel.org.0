Return-Path: <linux-acpi+bounces-21331-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +E7OMH5VqGlutQAAu9opvQ
	(envelope-from <linux-acpi+bounces-21331-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 04 Mar 2026 16:53:34 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3C82035D8
	for <lists+linux-acpi@lfdr.de>; Wed, 04 Mar 2026 16:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C61F31FC607
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Mar 2026 15:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C1F34B1AD;
	Wed,  4 Mar 2026 15:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZ/M2/nA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E5C3491CD;
	Wed,  4 Mar 2026 15:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772638730; cv=none; b=uoly9NbJLyOqYSIQvzcM32XOYUYSozELRtSo8zQ/boUOfDutbAqUhJKz9sh6u7FbtyoOqhp9JPWpp2tra6dD9CLh5abkzA5ePDy0u3aqv/BJC2o7JGQxm4Qqe+K/UqrYqOr73TfNUJhPGNtNPeaNZd4DukF+IVdfEDcMhMlO/0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772638730; c=relaxed/simple;
	bh=+2y0TVWK+1mxtFkQGBZ5c+xyYFKAYuSiURAJvKFtcJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=pyG4u4jkBPsmc8xIB5GWDjMmyLMKjs6Katni+Jfy+ICTs8x0YSXbaVfdVl64tU6ce4psmQ6mmKjjy7p/LFH1waFZZdeWd6xAJf15GoGijlS/rH0yR7OwPF4cdWyL2lvgKHp8D5MLqkAmNmy6H517wxXPhrnZhYVlNyRAi37Bfy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZ/M2/nA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42BAFC4CEF7;
	Wed,  4 Mar 2026 15:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772638729;
	bh=+2y0TVWK+1mxtFkQGBZ5c+xyYFKAYuSiURAJvKFtcJ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=AZ/M2/nA/TTlnyPlxoPPO7EVvRaa1LGPJygEkPPlAUFMqNcscOCJQSUTJYlG3BmAy
	 VJo9Y/U/t4ky/NZ6jkYnBGtmWhCGcUh6NQnnSNmRJYD7+rAdu2wfL+RlyKZQAao1zR
	 Jj4kUbHgSVFRk0pG9TQrHmIaump8gzcND8PfOO3wwnwrws1OIw9jpCOsc3LHWBHfzF
	 OJtdm2qWzDZPJRKQ0hsZ5sTbnc3oUlfjuWTazLj1RdCGLP7guzUhZE5PufzyYiNfof
	 +QK2IlC33id33RDxw7fcuokmmMnQu5uY9L3Ez2fVlgkbgmHPk3UgqnKrJzJhow1Zvg
	 tqrNGAMRFJIDA==
Date: Wed, 4 Mar 2026 09:38:47 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: fengchengwen <fengchengwen@huawei.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
	linux-acpi@vger.kernel.org, rafael@kernel.org, lenb@kernel.org,
	wei.huang2@amd.com, Eric.VanTassell@amd.com,
	jonathan.cameron@huawei.com, wangzhou1@hisilicon.com,
	wanghuiqiang@huawei.com, liuyonglong@huawei.com,
	stable@vger.kernel.org, Jeremy Linton <jeremy.linton@arm.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Sunil V L <sunilvl@oss.qualcomm.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Liupu Wang <wangliupu@loongson.cn>
Subject: Re: [PATCH] PCI/TPH: Fix get cpu steer-tag fail on ARM64 platform
Message-ID: <20260304153847.GA23109@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ddf4b6db-b0c7-43ca-baad-a9df6acdca2e@huawei.com>
X-Rspamd-Queue-Id: 2B3C82035D8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21331-lists,linux-acpi=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[helgaas@kernel.org,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 05:28:36PM +0800, fengchengwen wrote:
> On 3/4/2026 3:02 AM, Bjorn Helgaas wrote:
> > [+cc Jeremy, Sunil, Huacai, Liupu, authors of get_acpi_id_for_cpu()
> > for arm64, riscv, loongson]
> > 
> > On Tue, Mar 03, 2026 at 08:36:25AM +0800, Chengwen Feng wrote:
> >> Currently the pcie_tph_get_cpu_st() has a problem on ARM64 platform:
> >> 1. The pcie_tph_get_cpu_st() function directly uses cpu_uid as the input
> >>    parameter to call the PCI ACPI DSM method. According to the DSM
> >>    definition, the input value should be the ACPI Processor UID. For
> >>    details, please see [1].
> >>
> >> 2. In the Broadcom driver implementation [2] (which invoke
> >>    pcie_tph_get_cpu_st()), cpu_uid is obtained based on
> >>    cpumask_first(irq->cpu_mask), that is the logical ID of a CPU core,
> >>    which is generated and managed by the kernel. For example, [0,255]
> >>    if the system has 256 logical CPU cores.
> >> 3. Unfortunately, on ARM64 platform, ACPI assigns Processor UID to the
> >>    core which listed in the MADT table, the Processor UID may not equal
> >>    the logical ID of a CPU core in the kernel. So the current
> >>    implementation cannot obtain the cpu's real steer-tag in such case.
> >> 4. The reason why it can run on the AMD platform is that the mapping
> >>    between the logical ID and ACPI Processor UID is similar.
> >>
> >> This commit fixes it by:
> >> 1. Introduce config ARCH_HAS_GET_CPU_ACPI_ID_API and its corresponding
> >>    API acpi_get_cpu_acpi_id() to obtain the ACPI Processor UID of a CPU
> >>    core. This API invokes get_acpi_id_for_cpu() to obtain the UID on
> >>    ARM64 platform.
> >> 2. Because using the logical ID as the ACPI Processor UID directly on
> >>    X86 platform is not standard. This commit uses cpu_acpi_id() to
> >>    obtain the UID.
> >> 3. At the same time, the input parameter cpu_uid of
> >>    pcie_tph_get_cpu_st() is renamed to cpu for clarity.
> > 
> > Thanks for raising this issue!
> > 
> > TLP Processing Hints (TPH) and Steering Tags are generic PCIe features
> > that we should support for both ACPI and non-ACPI systems.
> > 
> > The current implementation of pcie_tph_get_cpu_st() only supports
> > ACPI, and it assumes the cpu_uid parameter is an ACPI CPU UID that can
> > be passed directly to the _DSM.  But since we want this to be a
> > generic interface, I think the "cpu" parameter should be the Linux
> > logical CPU ID, not an ACPI UID, as you point out.
> ...

> >>  int pcie_tph_get_cpu_st(struct pci_dev *pdev, enum tph_mem_type mem_type,
> >> -			unsigned int cpu_uid, u16 *tag)
> >> +			unsigned int cpu, u16 *tag)
> >>  {
> >> -#ifdef CONFIG_ACPI
> >> +#ifdef CONFIG_ARCH_HAS_GET_CPU_ACPI_ID_API
> >> +	unsigned int cpu_uid = acpi_get_cpu_acpi_id(cpu);
> > 
> > Any required conversion between Linux logical CPU and ACPI CPU UID
> > should be internal to pcie_tph_get_cpu_st(), as you're doing here.
> > 
> > But rather than adding CONFIG_ARCH_HAS_GET_CPU_ACPI_ID_API and the
> > ifdefs in acpi_get_cpu_acpi_id(), I think there should be a generic
> > ACPI interface that converts logical CPU ID to ACPI UID, and every
> > arch supporting ACPI should have to implement it.
> > 
> > We already have get_acpi_id_for_cpu(), implemented for arm64, riscv,
> > and loongarch:
> > 
> >   30d87bfacbee ("arm64/acpi: Create arch specific cpu to acpi id helper")
> >   f99561199470 ("RISC-V: ACPI: Cache and retrieve the RINTC structure")
> >   f6f0c9a74a48 ("LoongArch: Add SMT (Simultaneous Multi-Threading) support")
> > 
> > What if we just implemented it for x86 as well and moved it to
> > include/linux/acpi.h or similar?
> 
> Your idea to unify the ACPI CPU ID function across architectures is
> great. I noticed that all exported ACPI functions use the `acpi_`
> prefix, so I think we shouldn’t simply modify x86’s implementation
> directly – we should also align the naming convention for other
> platforms.
> 
> Since only x86, arm64, risc-v, and loongarch currently support ACPI,
> how about we remove the new config and instead use this approach:
> 
> unsigned int acpi_get_cpu_acpi_id(unsigned int cpu)
> {
>         if (cpu >= nr_cpu_ids)
>                 return 0;
> #ifdef CONFIG_X86
>         return cpu_acpi_id(cpu);
> #elif defined(CONFIG_ARM64) || defined(CONFIG_RISCV) || defined(CONFIG_LOONGARCH)
>         return get_acpi_id_for_cpu(cpu);
> #endif
> }
> 
> For any new platform that plans to support ACPI in the future, this
> will trigger a compile error – which is intentional. It will prompt
> the maintainers of that platform to add their own implementation of
> either `get_acpi_id_for_cpu` or `cpu_acpi_id` as needed.

I agree that an "acpi_" prefix would be appropriate.  I'd suggest
separate implementations in arch/*/kernel/acpi.c instead of #ifdefs in
a common version.

Maybe users of cpu_acpi_id() and get_acpi_id_for_cpu() could be
converted to use the generic interface.

