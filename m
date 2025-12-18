Return-Path: <linux-acpi+bounces-19641-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D15ACCA697
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Dec 2025 07:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57D3A304C287
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Dec 2025 06:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35B6330320;
	Thu, 18 Dec 2025 06:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="cGJB9mPn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E1932FA36;
	Thu, 18 Dec 2025 06:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766037720; cv=none; b=Z5WKvppzoOiDWImM+jo1m8fRm+CaVTIkTsCqVqa0dwIp51jf9dYh2HuZKOO8bRDGBP3L0i2TVWEc7PMigEVJc6/kCrUC6mB1ibT8cix7LhOSG5x6E9xQGZ/0Io7AjKvgtbzzonfFnwCcLkhp+ZlZsDWriWgFc/ILjCJMJGGmsNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766037720; c=relaxed/simple;
	bh=NbXxcpEA2Pj03nTaueUILN7jZNO7BE5witQTMbnv1mY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DjRVKFsjeozah7zwbdjgHRFSnUnzirFwqYPhPM6s+8xQPb9HPa9p3QHuMIG+0x8UYZPGX1tZ8kpnviQPijuAoyyVMmobG6m3ElD2/2OZhyMOyRu1Eg1U366V6gEcQhlrJV174oTUefnoSOIge+zyNqZ5ZMPi8Sb4Bcc8H0Xwhyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=cGJB9mPn; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1766037711; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=tUSXsbBST/K/r80Y0FxI8W0AL34NCaR5mGeMFDDANpc=;
	b=cGJB9mPn5bwTHaQDHjx6zF51UcCaFws8t6MdEPSXv8f08yci1z8czBGMDvYran+JKt4uR5/A30qTkAEGOPb3Ge1UXkZIoroUrjFrSkNeCNAixpB+9I6V23uuTah5+bniViVdZb2yonY4RGv+co+bq13DYZGDjSU74xiuKHek6Hw=
Received: from 30.246.178.18(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Wv7D6FQ_1766037708 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 18 Dec 2025 14:01:49 +0800
Message-ID: <9838f123-2628-440c-afe5-6e50b8dc85e8@linux.alibaba.com>
Date: Thu, 18 Dec 2025 14:01:47 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] ACPI: APEI: GHES: Improve ghes_notify_nmi() status
 check
To: Hanjun Guo <guohanjun@huawei.com>, tony.luck@intel.com,
 mchehab@kernel.org, yazen.ghannam@amd.com
Cc: dave.jiang@intel.com, Smita.KoralahalliChannabasappa@amd.com,
 leitao@debian.org, pengdonglin@xiaomi.com, baolin.wang@linux.alibaba.com,
 benjamin.cheatham@amd.com, bp@alien8.de, dan.j.williams@intel.com,
 james.morse@arm.com, lenb@kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, rafael@kernel.org, zhuo.song@linux.alibaba.com
References: <20251203130253.73888-1-xueshuai@linux.alibaba.com>
 <20251203130253.73888-2-xueshuai@linux.alibaba.com>
 <f40cff8b-56b5-58e5-5652-457e681c0964@huawei.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <f40cff8b-56b5-58e5-5652-457e681c0964@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi, Hanjun

On 12/17/25 9:13 AM, Hanjun Guo wrote:
> Hi Shuai,
> 
> Some minor comments inline.
> 
> On 2025/12/3 21:02, Shuai Xue wrote:
>> From: Tony Luck <tony.luck@intel.com>
>>
>> ghes_notify_nmi() is called for every NMI and must check whether the NMI was
>> generated because an error was signalled by platform firmware.
>>
>> This check is very expensive as for each registered GHES NMI source it reads
>> from the acpi generic address attached to this error source to get the physical
>> address of the acpi_hest_generic_status block.  It then checks the "block_status"
>> to see if an error was logged.
>>
>> The ACPI/APEI code must create virtual mappings for each of those physical
>> addresses, and tear them down afterwards. On an Icelake system this takes around
>> 15,000 TSC cycles. Enough to disturb efforts to profile system performance.
>>
>> If that were not bad enough, there are some atomic accesses in the code path
>> that will cause cache line bounces between CPUs. A problem that gets worse as
>> the core count increases.
>>
>> But BIOS changes neither the acpi generic address nor the physical address of
>> the acpi_hest_generic_status block. So this walk can be done once when the NMI is
>> registered to save the virtual address (unmapping if the NMI is ever unregistered).
>> The "block_status" can be checked directly in the NMI handler. This can be done
>> without any atomic accesses.
>>
>> Resulting time to check that there is not an error record is around 900 cycles.
>>
>> Reported-by: Andi Kleen <andi.kleen@intel.com>
>> Signed-off-by: Tony Luck <tony.luck@intel.com>
>> ---
>>   drivers/acpi/apei/ghes.c | 39 ++++++++++++++++++++++++++++++++++++---
>>   include/acpi/ghes.h      |  1 +
>>   2 files changed, 37 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>> index 97ee19f2cae0..62713b612865 100644
>> --- a/drivers/acpi/apei/ghes.c
>> +++ b/drivers/acpi/apei/ghes.c
>> @@ -1425,7 +1425,21 @@ static LIST_HEAD(ghes_nmi);
>>   static int ghes_notify_nmi(unsigned int cmd, struct pt_regs *regs)
>>   {
>>       static DEFINE_RAW_SPINLOCK(ghes_notify_lock_nmi);
>> +    bool active_error = false;
>>       int ret = NMI_DONE;
>> +    struct ghes *ghes;
>> +
>> +    rcu_read_lock();
>> +    list_for_each_entry_rcu(ghes, &ghes_nmi, list) {
>> +        if (ghes->error_status_vaddr && readl(ghes->error_status_vaddr)) {
>> +            active_error = true;
>> +            break;
>> +        }
>> +    }
>> +    rcu_read_unlock();
>> +
>> +    if (!active_error)
>> +        return ret;
>>       if (!atomic_add_unless(&ghes_in_nmi, 1, 1))
>>           return ret;
>> @@ -1439,13 +1453,26 @@ static int ghes_notify_nmi(unsigned int cmd, struct pt_regs *regs)
>>       return ret;
>>   }
>> -static void ghes_nmi_add(struct ghes *ghes)
>> +static int ghes_nmi_add(struct ghes *ghes)
>>   {
>> +    struct acpi_hest_generic *g = ghes->generic;
>> +    u64 paddr;
>> +    int rc;
>> +
>> +    rc = apei_read(&paddr, &g->error_status_address);
>> +    if (rc)
>> +        return rc;
> 
> It will be good to add a empty line here.

Sure, will fix it.

> 
>> +    ghes->error_status_vaddr = acpi_os_ioremap(paddr, sizeof(ghes->estatus->block_status));
>> +    if (!ghes->error_status_vaddr)
>> +        return AE_BAD_ADDRESS;
> 
> It's static int for ghes_nmi_add(), and AE_BAD_ADDRESS is the type of
> acpi_status, it's better to return -EINVAL here.

Thanks for pointing it out, will fix it.

> 
> Thanks
> Hanjun

Thanks.
Shuai


