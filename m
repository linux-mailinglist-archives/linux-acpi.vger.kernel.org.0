Return-Path: <linux-acpi+bounces-19608-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF93CC5ADC
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Dec 2025 02:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 29E773001C35
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Dec 2025 01:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D29238C0B;
	Wed, 17 Dec 2025 01:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="L4WlNqgw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38AB4502F;
	Wed, 17 Dec 2025 01:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765934051; cv=none; b=Drl6xwTi6Olpn6eSfILRX14H0imJdJija58+S5ulrVHzWrVAYN91HRTnZDeP5jrr5JC4PlahQUONG9nMEEhh5Nddie4VsdRBsOYLrzhaSI3vuRFfeK43lQ1soO4VgJv1TXj4sidLaAU04k+3hQQXXqZZiKUgubWMexOn4Kfikc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765934051; c=relaxed/simple;
	bh=BHfi/pGwEDHoldCwd1Np4ZZbN90dSLMknF3Lmdnuchk=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=LUZs1ns2iU4HArRI0CMVAPU86qHwCUDQGHriOXKSlkuSRV2esMdh3ldq1looEvkt2PcNuZc9TT4d3F0HrUCFmYaCYf9ZGHeOks9Kd+QyU2kalKjqgcPcmD68Q9Ge/IxAHj015M/spf7HmCrQcpwQcU8QXJXsYqL35b5lxFwN1Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=L4WlNqgw; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=rY2mv/0SfF4EwRAOhSupmicm0UGHTYBqMJi1g8QjB7Q=;
	b=L4WlNqgwgDP5L7Usa8lUCJnfRidiR1x6FQNsCOJbI8gWLFOhHTgcBUtMGEu+eAdms/BOOkpLG
	+lVrGPJrsNe+H9KSKmbnuFHlsAwgeOq2fBkqVCbDWKNow7s8sgG9PeKfyz/dVTzOS0mosVySUh6
	oo177zNnfajvFa9QQm03pJo=
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dWG3Z4Z9TzKm4G;
	Wed, 17 Dec 2025 09:11:54 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id B13F01A016C;
	Wed, 17 Dec 2025 09:13:55 +0800 (CST)
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 17 Dec 2025 09:13:54 +0800
Subject: Re: [PATCH 1/3] ACPI: APEI: GHES: Improve ghes_notify_nmi() status
 check
To: Shuai Xue <xueshuai@linux.alibaba.com>, <tony.luck@intel.com>,
	<mchehab@kernel.org>, <yazen.ghannam@amd.com>
CC: <dave.jiang@intel.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<leitao@debian.org>, <pengdonglin@xiaomi.com>,
	<baolin.wang@linux.alibaba.com>, <benjamin.cheatham@amd.com>, <bp@alien8.de>,
	<dan.j.williams@intel.com>, <james.morse@arm.com>, <lenb@kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<rafael@kernel.org>, <zhuo.song@linux.alibaba.com>
References: <20251203130253.73888-1-xueshuai@linux.alibaba.com>
 <20251203130253.73888-2-xueshuai@linux.alibaba.com>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <f40cff8b-56b5-58e5-5652-457e681c0964@huawei.com>
Date: Wed, 17 Dec 2025 09:13:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20251203130253.73888-2-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf500002.china.huawei.com (7.185.36.57)

Hi Shuai,

Some minor comments inline.

On 2025/12/3 21:02, Shuai Xue wrote:
> From: Tony Luck <tony.luck@intel.com>
> 
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
> 
> If that were not bad enough, there are some atomic accesses in the code path
> that will cause cache line bounces between CPUs. A problem that gets worse as
> the core count increases.
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
> ---
>   drivers/acpi/apei/ghes.c | 39 ++++++++++++++++++++++++++++++++++++---
>   include/acpi/ghes.h      |  1 +
>   2 files changed, 37 insertions(+), 3 deletions(-)
> 
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
>   
>   	if (!atomic_add_unless(&ghes_in_nmi, 1, 1))
>   		return ret;
> @@ -1439,13 +1453,26 @@ static int ghes_notify_nmi(unsigned int cmd, struct pt_regs *regs)
>   	return ret;
>   }
>   
> -static void ghes_nmi_add(struct ghes *ghes)
> +static int ghes_nmi_add(struct ghes *ghes)
>   {
> +	struct acpi_hest_generic *g = ghes->generic;
> +	u64 paddr;
> +	int rc;
> +
> +	rc = apei_read(&paddr, &g->error_status_address);
> +	if (rc)
> +		return rc;

It will be good to add a empty line here.

> +	ghes->error_status_vaddr = acpi_os_ioremap(paddr, sizeof(ghes->estatus->block_status));
> +	if (!ghes->error_status_vaddr)
> +		return AE_BAD_ADDRESS;

It's static int for ghes_nmi_add(), and AE_BAD_ADDRESS is the type of
acpi_status, it's better to return -EINVAL here.

Thanks
Hanjun

