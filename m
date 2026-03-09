Return-Path: <linux-acpi+bounces-21530-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJxIEByhrmkLHAIAu9opvQ
	(envelope-from <linux-acpi+bounces-21530-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Mar 2026 11:29:48 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9726E23714F
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Mar 2026 11:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1856303D70E
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Mar 2026 10:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502CB38F926;
	Mon,  9 Mar 2026 10:28:49 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A3C34DB44;
	Mon,  9 Mar 2026 10:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773052129; cv=none; b=PiWbl6k1DPUEuoxuxCOuQyZ7PF6pPJ/XUD++YqMT6esrKRiuhCu3PMQU/stLsv9YyZTtGIrj+kzrzNaoaBsv7RFutpw7xmC0x7W+Hl09qG3aHkJa8tK5GEM5klaZ8TM/NTFMXoFrIYVFbzIyP98OGMabYkCgqIFjnQxzgN74QRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773052129; c=relaxed/simple;
	bh=oeGbNvYNeLEMdzYsVNQfSow8qwSs7c8u3UPk74uZnmc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ac9e9EZTNreLxnEefPpyjTKS/Kg9257rUvxpAoOdJ7YLbtkvAjJJcqcUezgmBU36babONqqzJItCjEBwmrUH/Fq7DM7ayUkSMVLSM7vGM2nt/mm2f7+50fS909VdS6BsyWlbmmnQXbKKO4sDaILIXMRJNdhvDZouFvlbH36R/H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fTtWG6PDFzJ46vK;
	Mon,  9 Mar 2026 18:27:54 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id A6E264056E;
	Mon,  9 Mar 2026 18:28:37 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 9 Mar
 2026 10:28:36 +0000
Date: Mon, 9 Mar 2026 10:28:35 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Chengwen Feng <fengchengwen@huawei.com>
CC: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>, Paul Walmsley
	<pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	<linux-acpi@vger.kernel.org>, <rafael@kernel.org>, <lenb@kernel.org>,
	<wei.huang2@amd.com>, <Eric.VanTassell@amd.com>, <wangzhou1@hisilicon.com>,
	<wanghuiqiang@huawei.com>, <liuyonglong@huawei.com>,
	<stable@vger.kernel.org>, <jeremy.linton@arm.com>,
	<sunilvl@ventanamicro.com>, <sunilvl@oss.qualcomm.com>,
	<chenhuacai@loongson.cn>, <wangliupu@loongson.cn>,
	<linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v4 0/2] Fix get cpu steer-tag fail on ARM64 platform
Message-ID: <20260309102835.000037ad@huawei.com>
In-Reply-To: <20260309041659.18815-1-fengchengwen@huawei.com>
References: <20260303003625.39035-1-fengchengwen@huawei.com>
	<20260309041659.18815-1-fengchengwen@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml500005.china.huawei.com (7.214.145.207)
X-Rspamd-Queue-Id: 9726E23714F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[huawei.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-21530-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonathan.cameron@huawei.com,linux-acpi@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.590];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:mid,huawei.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, 9 Mar 2026 12:16:56 +0800
Chengwen Feng <fengchengwen@huawei.com> wrote:

> This patchset addresses the issue where retrieving the CPU steer-tag
> fails on ARM64 platforms. The first commit is a pure renaming of the
> ACPI CPU ID retrieval interface (no functional changes), which serves
> as preparation for the second commit that implements the core fix for
> the steer-tag retrieval logic.

Hi,

For future reference, please keep same lists +CC on every patch
(for a small series, send everything to everyone who gets any patch).
For me at least, that led to my filter putting patch 1 in a totally different
place from the rest and some confusion.

Also, don't send in reply to a previous version. Just start a new email
thread.  That both avoids deep nesting in email clients and generally
ensures your series ends up in the right place if people are sorting
by time of sending.

No need to resend this time unless others ask for it. 

Thanks,

Jonathan

> 
> ---
> Changes in v4:
> - Split the rename into a separate commit.
> 
> Changes in v3:
> - Rename existing get_acpi_id_for_cpu() to acpi_get_cpu_acpi_id() other
>   than add one new API.
> 
> Changes in v2:
> - Add ECN _DSM reference doc name and its URL.
> - Separate implement acpi_get_cpu_acpi_id() in each arch which supports
>   ACPI.
> - Refine commit-log.
> 
> Chengwen Feng (2):
>   ACPI: Rename get_acpi_id_for_cpu() to acpi_get_cpu_acpi_id() on
>     non-x86
>   PCI/TPH: Fix get cpu steer-tag fail on ARM64 platform
> 
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
> 


