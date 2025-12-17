Return-Path: <linux-acpi+bounces-19609-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36974CC5B25
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Dec 2025 02:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0293030194FB
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Dec 2025 01:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00F2242D95;
	Wed, 17 Dec 2025 01:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="uIGi01pn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3540823EAA4;
	Wed, 17 Dec 2025 01:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765934760; cv=none; b=nrS4KBzwHTTW++RGEyD9eI+p5Gcxd25TsfnUO3KXAAMm7XSmrPpEJ29IhA7qjgAyC7XFQ7Vx8lDt5ewlcS9WLxxq6+OPWEVvdkerqfFv+Duh8IzxzG9aRhHrwjyopFvjO+XkxCIUB/ByJ2WQXwdWCYe5LMZPjZyAed3544wEZXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765934760; c=relaxed/simple;
	bh=U7zYNPNUy6V7alXydWr/TPrMRyLTd6dj2rrCe6WM83k=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ePobrpnEJ8FzgHgEV2P7knxIAWTb4SVHu4cFqdydaD3mKlBosqLo4Xz4vHK9Op2SxK87EWYVjgs4hKhIyBzEwu7LMcS9nPPslsVMgw6sMpkH6Yp6hUPJsaTZ7tLD8U8WTWhYlt77rHd5KJ9bNHMsnTcA7FQZqJ/7Ddo7XLuAg78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=uIGi01pn; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=JWk4LPlis1GjX4QIR+qbNhsp7qhcdG77N7UBNjo5nhg=;
	b=uIGi01pnF+Nhf5yTCtNXtibKVjPZWb649AQoMQfHE1Nd9PsbtZO39yE17gbqJSHhbN6GuBV7F
	eY1xlgDDsDJR5pVgDJ6VbrwuAkkrSBKk0UvHKbqayVVI59MDJBOogXdjK9IxAuT3RB8l5YLqk6h
	KUI8WJAVAxmyOazKCGX034g=
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4dWGK46Bv4z1T4JP;
	Wed, 17 Dec 2025 09:23:36 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 88D57180475;
	Wed, 17 Dec 2025 09:25:48 +0800 (CST)
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 17 Dec 2025 09:25:47 +0800
Subject: Re: [PATCH 2/3] ACPI: APEI: GHES: Extract helper functions for error
 status handling
To: Shuai Xue <xueshuai@linux.alibaba.com>, <tony.luck@intel.com>,
	<mchehab@kernel.org>, <yazen.ghannam@amd.com>
CC: <dave.jiang@intel.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<leitao@debian.org>, <pengdonglin@xiaomi.com>,
	<baolin.wang@linux.alibaba.com>, <benjamin.cheatham@amd.com>, <bp@alien8.de>,
	<dan.j.williams@intel.com>, <james.morse@arm.com>, <lenb@kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<rafael@kernel.org>, <zhuo.song@linux.alibaba.com>
References: <20251203130253.73888-1-xueshuai@linux.alibaba.com>
 <20251203130253.73888-3-xueshuai@linux.alibaba.com>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <4af676a8-26f1-0e1b-5e7f-1ca4824d56fb@huawei.com>
Date: Wed, 17 Dec 2025 09:25:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20251203130253.73888-3-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500002.china.huawei.com (7.185.36.57)

On 2025/12/3 21:02, Shuai Xue wrote:
> Refactors the GHES driver by extracting common functionality into
> reusable helper functions:
> 
> 1. ghes_has_active_errors() - Checks if any error sources in a given list
>     have active errors
> 2. ghes_map_error_status() - Maps error status address to virtual address
> 3. ghes_unmap_error_status() - Unmaps error status virtual address
> 
> These helpers eliminate code duplication in the NMI path and prepare for
> similar usage in the SEA path in a subsequent patch.
> 
> No functional change intended.
> 
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> ---
>   drivers/acpi/apei/ghes.c | 92 +++++++++++++++++++++++++++++++---------
>   1 file changed, 72 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 62713b612865..2c7f3ca6ce50 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -1375,6 +1375,74 @@ static int ghes_in_nmi_spool_from_list(struct list_head *rcu_list,
>   	return ret;
>   }
>   
> +/**
> + * ghes_has_active_errors - Check if there are active errors in error sources
> + * @ghes_list: List of GHES entries to check for active errors
> + *
> + * This function iterates through all GHES entries in the given list and
> + * checks if any of them has active error status by reading the error
> + * status register.
> + *
> + * Return: true if at least one source has active error, false otherwise.
> + */
> +static bool __maybe_unused ghes_has_active_errors(struct list_head *ghes_list)
> +{
> +	bool active_error = false;
> +	struct ghes *ghes;
> +
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(ghes, ghes_list, list) {
> +		if (ghes->error_status_vaddr &&
> +		    readl(ghes->error_status_vaddr)) {
> +			active_error = true;
> +			break;
> +		}
> +	}
> +	rcu_read_unlock();
> +
> +	return active_error;
> +}
> +
> +/**
> + * ghes_map_error_status - Map error status address to virtual address
> + * @ghes: pointer to GHES structure
> + *
> + * Reads the error status address from ACPI HEST table and maps it to a virtual
> + * address that can be accessed by the kernel.
> + *
> + * Return: 0 on success, error code on failure.
> + */
> +static int __maybe_unused ghes_map_error_status(struct ghes *ghes)
> +{
> +	struct acpi_hest_generic *g = ghes->generic;
> +	u64 paddr;
> +	int rc;
> +
> +	rc = apei_read(&paddr, &g->error_status_address);
> +	if (rc)
> +		return rc;
> +	ghes->error_status_vaddr =
> +		acpi_os_ioremap(paddr, sizeof(ghes->estatus->block_status));
> +	if (!ghes->error_status_vaddr)
> +		return AE_BAD_ADDRESS;

Same update here.

> +
> +	return 0;
> +}
> +
> +/**
> + * ghes_unmap_error_status - Unmap error status virtual address
> + * @ghes: pointer to GHES structure
> + *
> + * Unmaps the error status address if it was previously mapped.
> + */
> +static void __maybe_unused ghes_unmap_error_status(struct ghes *ghes)
> +{
> +	if (ghes->error_status_vaddr) {
> +		iounmap(ghes->error_status_vaddr);
> +		ghes->error_status_vaddr = NULL;
> +	}
> +}
> +
>   #ifdef CONFIG_ACPI_APEI_SEA
>   static LIST_HEAD(ghes_sea);
>   
> @@ -1425,20 +1493,9 @@ static LIST_HEAD(ghes_nmi);
>   static int ghes_notify_nmi(unsigned int cmd, struct pt_regs *regs)
>   {
>   	static DEFINE_RAW_SPINLOCK(ghes_notify_lock_nmi);
> -	bool active_error = false;
>   	int ret = NMI_DONE;
> -	struct ghes *ghes;
>   
> -	rcu_read_lock();
> -	list_for_each_entry_rcu(ghes, &ghes_nmi, list) {
> -		if (ghes->error_status_vaddr && readl(ghes->error_status_vaddr)) {
> -			active_error = true;
> -			break;
> -		}
> -	}
> -	rcu_read_unlock();
> -
> -	if (!active_error)
> +	if (!ghes_has_active_errors(&ghes_nmi))
>   		return ret;
>   
>   	if (!atomic_add_unless(&ghes_in_nmi, 1, 1))
> @@ -1455,16 +1512,11 @@ static int ghes_notify_nmi(unsigned int cmd, struct pt_regs *regs)
>   
>   static int ghes_nmi_add(struct ghes *ghes)
>   {
> -	struct acpi_hest_generic *g = ghes->generic;
> -	u64 paddr;
>   	int rc;
>   
> -	rc = apei_read(&paddr, &g->error_status_address);
> +	rc = ghes_map_error_status(ghes);
>   	if (rc)
>   		return rc;
> -	ghes->error_status_vaddr = acpi_os_ioremap(paddr, sizeof(ghes->estatus->block_status));
> -	if (!ghes->error_status_vaddr)
> -		return AE_BAD_ADDRESS;
>   
>   	mutex_lock(&ghes_list_mutex);
>   	if (list_empty(&ghes_nmi))
> @@ -1483,8 +1535,7 @@ static void ghes_nmi_remove(struct ghes *ghes)
>   		unregister_nmi_handler(NMI_LOCAL, "ghes");
>   	mutex_unlock(&ghes_list_mutex);
>   
> -	if (ghes->error_status_vaddr)
> -		iounmap(ghes->error_status_vaddr);
> +	ghes_unmap_error_status(ghes);
>   
>   	/*
>   	 * To synchronize with NMI handler, ghes can only be
> @@ -1492,6 +1543,7 @@ static void ghes_nmi_remove(struct ghes *ghes)
>   	 */
>   	synchronize_rcu();
>   }
> +

I think it's not belong to this patch.

Thanks
Hanjun

>   #else /* CONFIG_HAVE_ACPI_APEI_NMI */
>   static inline int ghes_nmi_add(struct ghes *ghes) { return -EINVAL; }
>   static inline void ghes_nmi_remove(struct ghes *ghes) { }
> 

