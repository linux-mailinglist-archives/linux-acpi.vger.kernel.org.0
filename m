Return-Path: <linux-acpi+bounces-18573-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BC1C3921B
	for <lists+linux-acpi@lfdr.de>; Thu, 06 Nov 2025 06:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D230E189D5E6
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Nov 2025 05:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51371DF99A;
	Thu,  6 Nov 2025 05:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="VzQM6QJL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B4934D38E;
	Thu,  6 Nov 2025 05:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762405459; cv=none; b=I8V/hXVU/04uVnVTp6JCQIbXI7IWHBbOPOPjKT6FaEddixFW8K4FEgGPyHZ9MX7YtCLEdNIPG4+uE7Wu1DR/9ZaoDns3/WcsHH1ZLweFf9+NRN0XwucsEi8x/RQRmzycIgQLbV8NSBEw47kZReg9FoA2h3RZUgCCyPGLvg5f56M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762405459; c=relaxed/simple;
	bh=9MFTHhTyAuIXmNt1lnMnlfUeqBBv+PebUZL4ozVF4tg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LPpIwXHm1pO4sbQZ4qppIxYMfFp6hlOfwShsmtyWuM9fCCturmEG1yvlUtYBIQNuNTIENZBE9Dt9r0n8P7IqPlixbR+W+xL11PHSgoh+kc2OWCAcqKB0rN+s2W5vFk7FL2waong37MSfCtLgma9qi0aiuElD0IuG4fKGKTfnVGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=VzQM6QJL; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1762405447; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ayrBHiC5YJYK4R+BfF6m9SthRISNQab5BiTJkkGwV8Q=;
	b=VzQM6QJLTpKYPkMWL1mWwbq3Jucf5d9Mp6cbimom7J9GUZSGJZwNyg1mycwEZtNqu1lpua8DOzT1mi2jF6Ww4n/xlLP4JM12GVAxJkwbtaB7/ejcHZ2i29l2s8i4MdQxP/Rd28pzjtolnkC9nk1ZluJjJLzSJuSLu4a0a4b7BK8=
Received: from 30.246.177.186(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WroMjBT_1762405446 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 06 Nov 2025 13:04:07 +0800
Message-ID: <d49c1287-6a55-4eff-a908-b8a878bdd08a@linux.alibaba.com>
Date: Thu, 6 Nov 2025 13:04:05 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: APEI: GHES: Improve ghes_notify_nmi() status check
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Hanjun Guo <guohanjun@huawei.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, patches@lists.linux.dev,
 Andi Kleen <andi.kleen@intel.com>
References: <20251103230547.8715-1-tony.luck@intel.com>
 <4ecbe3d3-71f0-47e9-8fad-35b16689d1fa@linux.alibaba.com>
 <aQwDd-Nhgxpkdrcb@agluck-desk3>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <aQwDd-Nhgxpkdrcb@agluck-desk3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/11/6 10:09, Luck, Tony 写道:
> On Thu, Nov 06, 2025 at 09:46:33AM +0800, Shuai Xue wrote:
>>
>>
>> 在 2025/11/4 07:05, Tony Luck 写道:
>>> ghes_notify_nmi() is called for every NMI and must check whether the NMI was
>>> generated because an error was signalled by platform firmware.
>>>
>>> This check is very expensive as for each registered GHES NMI source it reads
>>> from the acpi generic address attached to this error source to get the physical
>>> address of the acpi_hest_generic_status block.  It then checks the "block_status"
>>> to see if an error was logged.
>>>
>>> The ACPI/APEI code must create virtual mappings for each of those physical
>>> addresses, and tear them down afterwards. On an Icelake system this takes around
>>> 15,000 TSC cycles. Enough to disturb efforts to profile system performance.
>>
>> Hi, Tony
>>
>> Interesting.
>>
>> If I understand correctly, you mean ghes_peek_estatus() and
>> ghes_clear_estatus().
>>
>> I conducted performance testing on our system (ARM v8) and found the
>> following average costs:
>>
>> - ghes_peek_estatus(): 8,138.3 ns (21,160 cycles)
>> - ghes_clear_estatus(): 2,038.3 ns (5,300 cycles)
> 
> ARM doesn't use the NMI path (HAVE_ACPI_APEI_NMI is only set on X86).
> But maybe you are looking at ghes_notify_sea() which seems similar?

Yes. It is measured in ghes_notify_sea().

>>
>>>
>>> If that were not bad enough, there are some atomic accesses in the code path
>>> that will cause cache line bounces between CPUs. A problem that gets worse as
>>> the core count increases.
>>
>> Could you elaborate on which specific atomic accesses you're referring to?
> 
> ghes_notify_nmi() starts with code to ensure only one CPU executes the
> GHES NMI path.
> 
> 	if (!atomic_add_unless(&ghes_in_nmi, 1, 1))
> 		return ret;
> 
> Looks like an optimization to avoid having a bunch of CPUs queue up
> waiting for this spinllock:
> 
> 	raw_spin_lock(&ghes_notify_lock_nmi);
> 
> when the first one to get it will find and handle the logged error.

If an NMI issued, at last one status block is active. I don't see how
the code path is different.

>>
>>>
>>> But BIOS changes neither the acpi generic address nor the physical address of
>>> the acpi_hest_generic_status block. So this walk can be done once when the NMI is
>>> registered to save the virtual address (unmapping if the NMI is ever unregistered).
>>> The "block_status" can be checked directly in the NMI handler. This can be done
>>> without any atomic accesses.
>>>
>>> Resulting time to check that there is not an error record is around 900 cycles.
>>>
>>> Reported-by: Andi Kleen <andi.kleen@intel.com>
>>> Signed-off-by: Tony Luck <tony.luck@intel.com>
>>>
>>> ---
>>> N.B. I only talked to an Intel BIOS expert about this. GHES code is shared by
>>> other architectures, so it would be wise to get confirmation on whether this
>>> assumption applies to all, or is Intel (or X86) specific.
>>
>> The assumption is "BIOS changes neither the acpi generic address nor the
>> physical address of the acpi_hest_generic_status block."?
>>
>> I've consulted with our BIOS experts from both ARM and RISC-V platform
>> teams, and they confirmed that error status blocks are reserved at boot
>> time and remain unchanged during runtime.
> 
> Thanks. Good to have this confirmation.
> 
>>> ---
>>>    include/acpi/ghes.h      |  1 +
>>>    drivers/acpi/apei/ghes.c | 39 ++++++++++++++++++++++++++++++++++++---
>>>    2 files changed, 37 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
>>> index ebd21b05fe6e..58655d313a1f 100644
>>> --- a/include/acpi/ghes.h
>>> +++ b/include/acpi/ghes.h
>>> @@ -29,6 +29,7 @@ struct ghes {
>>>    	};
>>>    	struct device *dev;
>>>    	struct list_head elist;
>>> +	void __iomem *error_status_vaddr;
>>>    };
>>>    struct ghes_estatus_node {
>>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>>> index 97ee19f2cae0..62713b612865 100644
>>> --- a/drivers/acpi/apei/ghes.c
>>> +++ b/drivers/acpi/apei/ghes.c
>>> @@ -1425,7 +1425,21 @@ static LIST_HEAD(ghes_nmi);
>>>    static int ghes_notify_nmi(unsigned int cmd, struct pt_regs *regs)
>>>    {
>>>    	static DEFINE_RAW_SPINLOCK(ghes_notify_lock_nmi);
>>> +	bool active_error = false;
>>>    	int ret = NMI_DONE;
>>> +	struct ghes *ghes;
>>> +
>>> +	rcu_read_lock();
>>> +	list_for_each_entry_rcu(ghes, &ghes_nmi, list) {
>>> +		if (ghes->error_status_vaddr && readl(ghes->error_status_vaddr)) {
>>> +			active_error = true;
>>> +			break;
>>> +		}
>>> +	}
>>> +	rcu_read_unlock();
>>> +
>>> +	if (!active_error)
>>> +		return ret;
>>
>> Shoud we put active_error into struct ghes? If we know it is active, we
>> do not need to call __ghes_peek_estatus() to estatus->block_status().
> 
> That might be a useful addition. I was primarily concerned in fixing the
> "no erroor" case that happens at a very high rate while profiling the
> system with "perf". 

Do you mean you see "NMI received for unknown reason" when profiling with
"perf"? And the unknown error is handled by ghes_notify_nmi().

I see some unknown NMI in production in Intel platform, but I did not
figure out how it happend. Can you help to explain it?

> But skipping (or just removing?
> __ghes_peek_estatus()) if you have already confirmed that there is
> a logged error would be good.
> 
> If you can use the same technique for ghes_notify_sea() then it would be
> sensible to move the code I added to ghes_nmi_add() to ghes_new() to
> save the virtual address for every type of GHES notification.

Sure, I'd like to add it for ghes_notify_sea().

Thanks.
Shuai


