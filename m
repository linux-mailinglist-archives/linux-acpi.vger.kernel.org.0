Return-Path: <linux-acpi+bounces-21479-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KP4qJ2uqqmnjVAEAu9opvQ
	(envelope-from <linux-acpi+bounces-21479-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 11:20:27 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 993DB21E96F
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 11:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 869E4300B444
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Mar 2026 10:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6DBF378D96;
	Fri,  6 Mar 2026 10:20:22 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCAA33B6D1;
	Fri,  6 Mar 2026 10:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772792422; cv=none; b=okjfVwGOaqdS6cHxDsbYLwwNuLe0oH6CkE7BiGZBBMD8VZXHnKkkmLiw9/yc1AtWlpndLUGGwhIKIVd8cbFb53jr4h1ToKD7j8aSG9pYWU63zQZCSLNh+Zl4WoO3Aioc0Y13vCPOsQsvrauJ7il+KEFIsvwNSPLAMa7/ZKlPUgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772792422; c=relaxed/simple;
	bh=B4Iz5OWHrL/GsYmEXkDnVo27GZHa07EKtd/KCQQ/MF8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FDPqvaS+od49ei8gfVKKaTXEHqAi9rGh8zt4qLctClhoHK8N5CD/nuckdfbZbv+2jVNZvyfEK63T0yBVIpETM2qKXlKrc6aYk0loQQNlDhnDFF9RYzmMXCyJ8l4Ja+zU363axMz/zOcVLnUF5RSYRxu+srcqiy8kmi0/GiE7SP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fS2454tK9zHnH5p;
	Fri,  6 Mar 2026 18:01:25 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 214B440086;
	Fri,  6 Mar 2026 18:02:25 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 6 Mar
 2026 10:02:23 +0000
Date: Fri, 6 Mar 2026 10:01:50 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Chengwen Feng <fengchengwen@huawei.com>
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
 Rutland <mark.rutland@arm.com>, "Eric Van Tassell" <Eric.VanTassell@amd.com>,
	Wei Huang <wei.huang2@amd.com>, "Ajit Khaparde" <ajit.khaparde@broadcom.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	<linux-acpi@vger.kernel.org>, <wangzhou1@hisilicon.com>,
	<wanghuiqiang@huawei.com>, <liuyonglong@huawei.com>,
	<stable@vger.kernel.org>, <jeremy.linton@arm.com>,
	<sunilvl@oss.qualcomm.com>, <chenhuacai@loongson.cn>,
	<wangliupu@loongson.cn>, Somnath Kotur <somnath.kotur@broadcom.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <loongarch@lists.linux.dev>,
	<linux-riscv@lists.infradead.org>, <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH v3] PCI/TPH: Fix get cpu steer-tag fail on ARM64
 platform
Message-ID: <20260306100150.00003f38@huawei.com>
In-Reply-To: <20260306021920.23233-1-fengchengwen@huawei.com>
References: <20260303003625.39035-1-fengchengwen@huawei.com>
	<20260306021920.23233-1-fengchengwen@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 dubpeml500005.china.huawei.com (7.214.145.207)
X-Rspamd-Queue-Id: 993DB21E96F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[huawei.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	NEURAL_HAM(-0.00)[-0.999];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[43];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-acpi];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonathan.cameron@huawei.com,linux-acpi@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21479-lists,linux-acpi=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Action: no action

On Fri, 6 Mar 2026 10:19:17 +0800
Chengwen Feng <fengchengwen@huawei.com> wrote:

> Currently the pcie_tph_get_cpu_st() has an issue on ARM64 platform:
> 1. The pcie_tph_get_cpu_st() function directly uses cpu_uid as the input
>    parameter to call the PCI ACPI DSM method. According to the DSM
>    definition, the input value should be the ACPI Processor UID (see [1]
>    for details).
> 2. In the Broadcom driver implementation [2] (which invokes
>    pcie_tph_get_cpu_st()), cpu_uid is obtained via
>    cpumask_first(irq->cpu_mask) - this is the logical CPU ID of a CPU
>    core, generated and managed by kernel (e.g., [0,255] for a system
>    with 256 logical CPU cores).
> 3. On ARM64 platforms, ACPI assigns Processor UID to cores listed in the
>    MADT table, and this UID may not match the kernel's logical CPU ID.
>    As a result, the current implementation fails to retrieve the correct
>    CPU steer-tag in such cases.
> 4. The function works on AMD x86 platforms only because the logical CPU
>    ID is identical to the ACPI Processor UID on those systems.
> 
> This commit fixes it by:
> 1. For ACPI-enabled platforms, unify the CPU ACPI ID retrieval
>    interface:
>    - On arm64/riscv/loongarch: Rename existing get_acpi_id_for_cpu() to
>      acpi_get_cpu_acpi_id().
>    - On x86: Add new acpi_get_cpu_acpi_id() implementation that wraps
>      cpu_acpi_id().
> 2. Update pcie_tph_get_cpu_st() to use acpi_get_cpu_acpi_id(cpu) to get
>    valid ACPI Processor UID for DSM calls.
> 3. Renaming pcie_tph_get_cpu_st()'s input parameter cpu_uid to cpu for
>    clarity, as the parameter now represents a logical CPU ID (not a
>    UID).
> 
> [1] According to ECN_TPH-ST_Revision_20200924
>     (https://members.pcisig.com/wg/PCI-SIG/document/15470), the input
>     is defined as: "If the target is a processor, then this field
>     represents the ACPI Processor UID of the processor as specified in
>     the MADT. If the target is a processor container, then this field
>     represents the ACPI Processor UID of the processor container as
>     specified in the PPTT."
> [2] commit c214410c47d6e ("bnxt_en: Add TPH support in BNXT driver")
> 
> Fixes: d2e8a34876ce ("PCI/TPH: Add Steering Tag support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
> 
> ---
> Changes in v3:
> - Rename existing get_acpi_id_for_cpu() to acpi_get_cpu_acpi_id() other
>   than add one new API.
Ah. I wasn't clear around that rename suggestion.  Split this into two patches.
1) Rename
2) The new stuff plus x86 implementation.

> 
> Changes in v2:
> - Add ECN _DSM reference doc name and its URL.
> - Separate implement acpi_get_cpu_acpi_id() in each arch which supports
>   ACPI.
> - Refine commit-log.
> 
> ---
>  Documentation/PCI/tph.rst          |  4 ++--
>  arch/arm64/include/asm/acpi.h      |  4 ++--
>  arch/loongarch/include/asm/acpi.h  |  2 +-
>  arch/riscv/include/asm/acpi.h      |  2 +-
>  arch/riscv/kernel/acpi_numa.c      |  2 +-
>  arch/x86/include/asm/acpi.h        |  2 ++
>  arch/x86/kernel/cpu/common.c       |  8 ++++++++
>  drivers/acpi/pptt.c                | 16 ++++++++--------
>  drivers/acpi/riscv/rhct.c          |  2 +-
>  drivers/pci/tph.c                  | 11 ++++++-----
>  drivers/perf/arm_cspmu/arm_cspmu.c |  2 +-
>  include/linux/pci-tph.h            |  4 ++--
>  12 files changed, 35 insertions(+), 24 deletions(-)




