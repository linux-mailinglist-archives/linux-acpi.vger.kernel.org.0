Return-Path: <linux-acpi+bounces-18571-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3862EC38BBD
	for <lists+linux-acpi@lfdr.de>; Thu, 06 Nov 2025 02:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E239C3B47AD
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Nov 2025 01:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E950158857;
	Thu,  6 Nov 2025 01:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="r7mwuw9B"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481AE18C031;
	Thu,  6 Nov 2025 01:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762393607; cv=none; b=gyW8ymW0VVI13NsJteLmocod+5icm9by9Fnt1+01zG1cbUIFEfpOoMwv76ubs0UqbmVTnK6PofNEyXzSVow1jsb4n3FMhpJwRoR2oj63FSAiZWutAOICi7GtCQk5OLlgzGIwWpNE8kUZyCo/QSJRvchUUDo0qxocWvffHsr8sBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762393607; c=relaxed/simple;
	bh=r8bX+yJXsU0v2Pmnrd8Ky6DxWtmt9NZxiobsxGY6T9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iOGVSwo33H/AP26qXVVd50T3Z9l4JzPkC1f3EVm7nRpztk18njMu1nCMeSWbNAa7vfBbUYQ8MC49+sztrAa++ADFpTnbeODPwSMDXVzxAi14tBeL0oc45DYC1E0t1qP6frtVUc4yh4MgRyd8+PtgfIH9o+dhpH7PRUXXJw2rC04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=r7mwuw9B; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1762393595; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=SIoe8Yy+lzQHHxDyVTXXxWwFYxdZgxjpGLMjyIO/Btw=;
	b=r7mwuw9Bn/Rwn0K4wOF7FQYMEMnd/YW70b0XJaTgy+gc0WCtOFM5cAkCgxBICdUEqgHa+4em1dOUQd3gacChd37aayNiZxMAeswoih2GU0tgZGwRrkf5gD4SnRnsiKDIKk1+uLwjHropmFfNkdPFQEoDjHvb1PReP3WTiCcll84=
Received: from 30.246.177.186(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WrnXrJr_1762393594 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 06 Nov 2025 09:46:34 +0800
Message-ID: <4ecbe3d3-71f0-47e9-8fad-35b16689d1fa@linux.alibaba.com>
Date: Thu, 6 Nov 2025 09:46:33 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: APEI: GHES: Improve ghes_notify_nmi() status check
To: Tony Luck <tony.luck@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Hanjun Guo <guohanjun@huawei.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, patches@lists.linux.dev,
 Andi Kleen <andi.kleen@intel.com>
References: <20251103230547.8715-1-tony.luck@intel.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20251103230547.8715-1-tony.luck@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/11/4 07:05, Tony Luck 写道:
> ghes_notify_nmi() is called for every NMI and must check whether the NMI was
> generated because an error was signalled by platform firmware.
> 
> This check is very expensive as for each registered GHES NMI source it reads
> from the acpi generic address attached to this error source to get the physical
> address of the acpi_hest_generic_status block.  It then checks the "block_status"
> to see if an error was logged.
> 
> The ACPI/APEI code must create virtual mappings for each of those physical
> addresses, and tear them down afterwards. On an Icelake system this takes around
> 15,000 TSC cycles. Enough to disturb efforts to profile system performance.

Hi, Tony

Interesting.

If I understand correctly, you mean ghes_peek_estatus() and
ghes_clear_estatus().

I conducted performance testing on our system (ARM v8) and found the
following average costs:

- ghes_peek_estatus(): 8,138.3 ns (21,160 cycles)
- ghes_clear_estatus(): 2,038.3 ns (5,300 cycles)

> 
> If that were not bad enough, there are some atomic accesses in the code path
> that will cause cache line bounces between CPUs. A problem that gets worse as
> the core count increases.

Could you elaborate on which specific atomic accesses you're referring to?

> 
> But BIOS changes neither the acpi generic address nor the physical address of
> the acpi_hest_generic_status block. So this walk can be done once when the NMI is
> registered to save the virtual address (unmapping if the NMI is ever unregistered).
> The "block_status" can be checked directly in the NMI handler. This can be done
> without any atomic accesses.
> 
> Resulting time to check that there is not an error record is around 900 cycles.
> 
> Reported-by: Andi Kleen <andi.kleen@intel.com>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> 
> ---
> N.B. I only talked to an Intel BIOS expert about this. GHES code is shared by
> other architectures, so it would be wise to get confirmation on whether this
> assumption applies to all, or is Intel (or X86) specific.

The assumption is "BIOS changes neither the acpi generic address nor the
physical address of the acpi_hest_generic_status block."?

I've consulted with our BIOS experts from both ARM and RISC-V platform
teams, and they confirmed that error status blocks are reserved at boot
time and remain unchanged during runtime.

> ---
>   include/acpi/ghes.h      |  1 +
>   drivers/acpi/apei/ghes.c | 39 ++++++++++++++++++++++++++++++++++++---
>   2 files changed, 37 insertions(+), 3 deletions(-)
> 
> diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
> index ebd21b05fe6e..58655d313a1f 100644
> --- a/include/acpi/ghes.h
> +++ b/include/acpi/ghes.h
> @@ -29,6 +29,7 @@ struct ghes {
>   	};
>   	struct device *dev;
>   	struct list_head elist;
> +	void __iomem *error_status_vaddr;
>   };
>   
>   struct ghes_estatus_node {
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 97ee19f2cae0..62713b612865 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -1425,7 +1425,21 @@ static LIST_HEAD(ghes_nmi);
>   static int ghes_notify_nmi(unsigned int cmd, struct pt_regs *regs)
>   {
>   	static DEFINE_RAW_SPINLOCK(ghes_notify_lock_nmi);
> +	bool active_error = false;
>   	int ret = NMI_DONE;
> +	struct ghes *ghes;
> +
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(ghes, &ghes_nmi, list) {
> +		if (ghes->error_status_vaddr && readl(ghes->error_status_vaddr)) {
> +			active_error = true;
> +			break;
> +		}
> +	}
> +	rcu_read_unlock();
> +
> +	if (!active_error)
> +		return ret;

Shoud we put active_error into struct ghes? If we know it is active, we
do not need to call __ghes_peek_estatus() to estatus->block_status().

Thanks.
Shuai

