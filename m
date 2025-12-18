Return-Path: <linux-acpi+bounces-19642-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB48FCCA658
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Dec 2025 07:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B04E300FF8F
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Dec 2025 06:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A9C330B04;
	Thu, 18 Dec 2025 06:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="uoONYxoT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42A5330677;
	Thu, 18 Dec 2025 06:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766037814; cv=none; b=pDi69EzxfKhmsEZ+Jlc9D25wDytFdPRYWpGlx49wRvV45toC2Gwj5Tc+R5V39PovJr3cKA8C+o22Wd3x9PbgpD4kvmblca5bIADn9eXuuAjXApOzIwlidjZjD2D0S6xGg3LHlV9lGf5RTHd+6pg9SZ3DpNe01qXWIpj70vv5kXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766037814; c=relaxed/simple;
	bh=GktUOPCi3myfBRraLPgy35wotWOUL1/d6sjnzoA7/g4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e3WY5LPZtW5hNWJvAVrviyv01IphPNlNZTiEd375lhkzidB0i/CCErQshV8ZSxDg2eHR+M87pyB3O+N92TEcknbpbYfIpMxjuIGgMVRAR6DqovRpPPaKCU6Er0oHyVEKMryYxltqUl4drvNRufeeYfSfO/lUE1nk6TdGikutUtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=uoONYxoT; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1766037802; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=2yPSg/9AoedAg56bUdUbMIz1gz9sxiVQ4H99lA0b2nc=;
	b=uoONYxoTNz7sE1sAphg+DG6mnzWK7wNpMxqpilAKDUjjzopkwgbVMk7sLXiF0llR1G7ybP0ounYhipwyM+jffZJ+62+8F3kvbTcv/QZ3pYhmMaArDaUdiLjR0Ac38SOCy+oxiGFO5UZ4737GjTOQry9SipgSgujW/oHF+vGPX+I=
Received: from 30.246.178.18(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Wv7LiwE_1766037800 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 18 Dec 2025 14:03:21 +0800
Message-ID: <fbe8ace9-83b5-4dbe-bea1-d910de1a9b70@linux.alibaba.com>
Date: Thu, 18 Dec 2025 14:03:20 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] ACPI: APEI: GHES: Extract helper functions for error
 status handling
To: Hanjun Guo <guohanjun@huawei.com>, tony.luck@intel.com,
 mchehab@kernel.org, yazen.ghannam@amd.com
Cc: dave.jiang@intel.com, Smita.KoralahalliChannabasappa@amd.com,
 leitao@debian.org, pengdonglin@xiaomi.com, baolin.wang@linux.alibaba.com,
 benjamin.cheatham@amd.com, bp@alien8.de, dan.j.williams@intel.com,
 james.morse@arm.com, lenb@kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, rafael@kernel.org, zhuo.song@linux.alibaba.com
References: <20251203130253.73888-1-xueshuai@linux.alibaba.com>
 <20251203130253.73888-3-xueshuai@linux.alibaba.com>
 <4af676a8-26f1-0e1b-5e7f-1ca4824d56fb@huawei.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <4af676a8-26f1-0e1b-5e7f-1ca4824d56fb@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/17/25 9:25 AM, Hanjun Guo wrote:
> On 2025/12/3 21:02, Shuai Xue wrote:
>> Refactors the GHES driver by extracting common functionality into
>> reusable helper functions:
>>
>> 1. ghes_has_active_errors() - Checks if any error sources in a given list
>>     have active errors
>> 2. ghes_map_error_status() - Maps error status address to virtual address
>> 3. ghes_unmap_error_status() - Unmaps error status virtual address
>>
>> These helpers eliminate code duplication in the NMI path and prepare for
>> similar usage in the SEA path in a subsequent patch.
>>
>> No functional change intended.
>>
>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>> ---
>>   drivers/acpi/apei/ghes.c | 92 +++++++++++++++++++++++++++++++---------
>>   1 file changed, 72 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>> index 62713b612865..2c7f3ca6ce50 100644
>> --- a/drivers/acpi/apei/ghes.c
>> +++ b/drivers/acpi/apei/ghes.c
>> @@ -1375,6 +1375,74 @@ static int ghes_in_nmi_spool_from_list(struct list_head *rcu_list,
>>       return ret;
>>   }
>> +/**
>> + * ghes_has_active_errors - Check if there are active errors in error sources
>> + * @ghes_list: List of GHES entries to check for active errors
>> + *
>> + * This function iterates through all GHES entries in the given list and
>> + * checks if any of them has active error status by reading the error
>> + * status register.
>> + *
>> + * Return: true if at least one source has active error, false otherwise.
>> + */
>> +static bool __maybe_unused ghes_has_active_errors(struct list_head *ghes_list)
>> +{
>> +    bool active_error = false;
>> +    struct ghes *ghes;
>> +
>> +    rcu_read_lock();
>> +    list_for_each_entry_rcu(ghes, ghes_list, list) {
>> +        if (ghes->error_status_vaddr &&
>> +            readl(ghes->error_status_vaddr)) {
>> +            active_error = true;
>> +            break;
>> +        }
>> +    }
>> +    rcu_read_unlock();
>> +
>> +    return active_error;
>> +}
>> +
>> +/**
>> + * ghes_map_error_status - Map error status address to virtual address
>> + * @ghes: pointer to GHES structure
>> + *
>> + * Reads the error status address from ACPI HEST table and maps it to a virtual
>> + * address that can be accessed by the kernel.
>> + *
>> + * Return: 0 on success, error code on failure.
>> + */
>> +static int __maybe_unused ghes_map_error_status(struct ghes *ghes)
>> +{
>> +    struct acpi_hest_generic *g = ghes->generic;
>> +    u64 paddr;
>> +    int rc;
>> +
>> +    rc = apei_read(&paddr, &g->error_status_address);
>> +    if (rc)
>> +        return rc;
>> +    ghes->error_status_vaddr =
>> +        acpi_os_ioremap(paddr, sizeof(ghes->estatus->block_status));
>> +    if (!ghes->error_status_vaddr)
>> +        return AE_BAD_ADDRESS;
> 
> Same update here.

Got it. Will fix it.

> 
>> +
>> +    return 0;
>> +}
>> +
>> +/**
>> + * ghes_unmap_error_status - Unmap error status virtual address
>> + * @ghes: pointer to GHES structure
>> + *
>> + * Unmaps the error status address if it was previously mapped.
>> + */
>> +static void __maybe_unused ghes_unmap_error_status(struct ghes *ghes)
>> +{
>> +    if (ghes->error_status_vaddr) {
>> +        iounmap(ghes->error_status_vaddr);
>> +        ghes->error_status_vaddr = NULL;
>> +    }
>> +}
>> +
>>   #ifdef CONFIG_ACPI_APEI_SEA
>>   static LIST_HEAD(ghes_sea);
>> @@ -1425,20 +1493,9 @@ static LIST_HEAD(ghes_nmi);
>>   static int ghes_notify_nmi(unsigned int cmd, struct pt_regs *regs)
>>   {
>>       static DEFINE_RAW_SPINLOCK(ghes_notify_lock_nmi);
>> -    bool active_error = false;
>>       int ret = NMI_DONE;
>> -    struct ghes *ghes;
>> -    rcu_read_lock();
>> -    list_for_each_entry_rcu(ghes, &ghes_nmi, list) {
>> -        if (ghes->error_status_vaddr && readl(ghes->error_status_vaddr)) {
>> -            active_error = true;
>> -            break;
>> -        }
>> -    }
>> -    rcu_read_unlock();
>> -
>> -    if (!active_error)
>> +    if (!ghes_has_active_errors(&ghes_nmi))
>>           return ret;
>>       if (!atomic_add_unless(&ghes_in_nmi, 1, 1))
>> @@ -1455,16 +1512,11 @@ static int ghes_notify_nmi(unsigned int cmd, struct pt_regs *regs)
>>   static int ghes_nmi_add(struct ghes *ghes)
>>   {
>> -    struct acpi_hest_generic *g = ghes->generic;
>> -    u64 paddr;
>>       int rc;
>> -    rc = apei_read(&paddr, &g->error_status_address);
>> +    rc = ghes_map_error_status(ghes);
>>       if (rc)
>>           return rc;
>> -    ghes->error_status_vaddr = acpi_os_ioremap(paddr, sizeof(ghes->estatus->block_status));
>> -    if (!ghes->error_status_vaddr)
>> -        return AE_BAD_ADDRESS;
>>       mutex_lock(&ghes_list_mutex);
>>       if (list_empty(&ghes_nmi))
>> @@ -1483,8 +1535,7 @@ static void ghes_nmi_remove(struct ghes *ghes)
>>           unregister_nmi_handler(NMI_LOCAL, "ghes");
>>       mutex_unlock(&ghes_list_mutex);
>> -    if (ghes->error_status_vaddr)
>> -        iounmap(ghes->error_status_vaddr);
>> +    ghes_unmap_error_status(ghes);
>>       /*
>>        * To synchronize with NMI handler, ghes can only be
>> @@ -1492,6 +1543,7 @@ static void ghes_nmi_remove(struct ghes *ghes)
>>        */
>>       synchronize_rcu();
>>   }
>> +
> 
> I think it's not belong to this patch.

Will drop it.

> 
> Thanks
> Hanjun
>
Thanks.
Shuai

