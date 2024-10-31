Return-Path: <linux-acpi+bounces-9159-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE929B7205
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 02:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 316DA1F26476
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 01:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0765049638;
	Thu, 31 Oct 2024 01:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="kOAMTMWR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0145D2FB;
	Thu, 31 Oct 2024 01:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730338631; cv=none; b=aLwdno6xPZ9RN5F/VdI2c6K9ppH7BfAlx8NHAwYj0oQTAlkc3qXbZZsJ3mjyuF5lC/rGWRQCwZmwts/fhMksGtgJP458YJYGsAfcjs/s14j7x2DpHJhLssYJQJfODYF3eula7HcJMVnjHEJIiJyMiJ0BokT9Qc99Pi5193u60dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730338631; c=relaxed/simple;
	bh=lfjgKJ5opjQCVR3WWil6/01M2fEvUAOzIvEdpGyNQbY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QiGCRVbMEWrzTmWUV1v3ikfmtzQRZ98Qet+zwCvFmSsdVperBVppQkFtUX44b1cEkSz726VeU8N0NHg+GMnfT1VPl1Ihj8jWq/uPGnkV93mIiV5lQ+i0BgH3rwf2KUWobtXa4XzMwYwasjm/UIAefE7DIHhYD62drXM39Rr99rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=kOAMTMWR; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730338624; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ZwUq071psuIhKucSfF2WgOJ4JR/ocIDnq9dWFuR/ybI=;
	b=kOAMTMWRCU1vpoeHvxLJW8MujHzxBgBVg2M/BupAYkMSqv2rEP2/zl/mp2bVpzX0be+q20VTO0ZlMig5GPcFGrPuV9+uADhiz7CWp2ktlEvifXLGGKlCFG8kPzFKQXPI//gUk6Za6K7FRzGJ2vC6MrFYsk/7nGB0/x3eWmgr7Vs=
Received: from 30.246.162.170(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WIGN02O_1730338618 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 31 Oct 2024 09:37:02 +0800
Message-ID: <6979b369-7aeb-4157-a89e-3fc4b7f39333@linux.alibaba.com>
Date: Thu, 31 Oct 2024 09:36:58 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 1/3] ACPI: APEI: send SIGBUS to current task if
 synchronous memory error not recovered
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: mark.rutland@arm.com, catalin.marinas@arm.com, mingo@redhat.com,
 robin.murphy@arm.com, Jonathan.Cameron@huawei.com, bp@alien8.de,
 rafael@kernel.org, wangkefeng.wang@huawei.com, tanxiaofei@huawei.com,
 mawupeng1@huawei.com, tony.luck@intel.com, linmiaohe@huawei.com,
 naoya.horiguchi@nec.com, james.morse@arm.com, tongtiangen@huawei.com,
 gregkh@linuxfoundation.org, will@kernel.org, jarkko@kernel.org,
 linux-acpi@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 linux-edac@vger.kernel.org, x86@kernel.org, justin.he@arm.com,
 ardb@kernel.org, ying.huang@intel.com, ashish.kalra@amd.com,
 baolin.wang@linux.alibaba.com, tglx@linutronix.de,
 dave.hansen@linux.intel.com, lenb@kernel.org, hpa@zytor.com,
 robert.moore@intel.com, lvying6@huawei.com, xiexiuqi@huawei.com,
 zhuo.song@linux.alibaba.com
References: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
 <20241028081142.66028-2-xueshuai@linux.alibaba.com>
 <20241029204848.GA1229628@yaz-khff2.amd.com>
 <d62d775e-08e3-4a2d-88a8-437a4c04ebd3@linux.alibaba.com>
 <20241030140800.GA1288714@yaz-khff2.amd.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20241030140800.GA1288714@yaz-khff2.amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/10/30 22:08, Yazen Ghannam 写道:
> On Wed, Oct 30, 2024 at 09:54:00AM +0800, Shuai Xue wrote:
>>
>>
>> 在 2024/10/30 04:48, Yazen Ghannam 写道:
>>> On Mon, Oct 28, 2024 at 04:11:40PM +0800, Shuai Xue wrote:
>>>> Synchronous error was detected as a result of user-space process accessing
>>>> a 2-bit uncorrected error. The CPU will take a synchronous error exception
>>>> such as Synchronous External Abort (SEA) on Arm64. The kernel will queue a
>>>> memory_failure() work which poisons the related page, unmaps the page, and
>>>> then sends a SIGBUS to the process, so that a system wide panic can be
>>>> avoided.
>>>>
>>>> However, no memory_failure() work will be queued when abnormal synchronous
>>>> errors occur. These errors can include situations such as invalid PA,
>>>> unexpected severity, no memory failure config support, invalid GUID
>>>> section, etc. In such case, the user-space process will trigger SEA again.
>>>> This loop can potentially exceed the platform firmware threshold or even
>>>> trigger a kernel hard lockup, leading to a system reboot.
>>>>
>>>> Fix it by performing a force kill if no memory_failure() work is queued
>>>> for synchronous errors.
>>>>
>>>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>>>> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
>>>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>> ---
>>>>    drivers/acpi/apei/ghes.c | 10 ++++++++++
>>>>    1 file changed, 10 insertions(+)
>>>>
>>>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>>>> index ada93cfde9ba..f2ee28c44d7a 100644
>>>> --- a/drivers/acpi/apei/ghes.c
>>>> +++ b/drivers/acpi/apei/ghes.c
>>>> @@ -801,6 +801,16 @@ static bool ghes_do_proc(struct ghes *ghes,
>>>>    		}
>>>>    	}
>>>> +	/*
>>>> +	 * If no memory failure work is queued for abnormal synchronous
>>>> +	 * errors, do a force kill.
>>>> +	 */
>>>> +	if (sync && !queued) {
>>>> +		pr_err("%s:%d: hardware memory corruption (SIGBUS)\n",
>>>> +			current->comm, task_pid_nr(current));
>>>
>>> I think it would help to include the GHES_PFX to indicate where this
>>> message is coming from. The pr_fmt() macro could also be introduced
>>> instead.
>>
>> Yes, GHES_PFX is a effective prefix and will be consistent to other message
>> in GHES driver. Will add it in next version.
>>
>> What do you mean about pr_fmt()?
> 
> This can be used to set a prefix for an entire section of code. The
> pr_*() macros will pick it up without needing to include a prefix for
> each call.
> 
> This is described in "Documentation/core-api/printk-basics.rst".

Got you point, a pr_fmt is much more convenient, but it is beyond this 
patch. I would like to send a patch to add pr_fmt and then replace each 
call after this patch merged.

> 
>>
>>>
>>> Also, you may want to include the HW_ERR prefix. Not all kernel messages
>>> related to hardware errors have this prefix today. But maybe that should
>>> be changed so there is more consistent messaging.
>>>
>>
>> Do we really need a HW_ERR prefix? The other case which use HW_ERR prefix
>> are for hardware registers. The messages which send SIGBUS does
>> not include HW_ERR, e.g. in kill_proc(), kill_procs().
>>
>>      pr_err("%#lx: Sending SIGBUS to %s:%d due to hardware memory
>> corruption\n",...
>>      pr_err("%#lx: forcibly killing %s:%d because of failure to unmap
>> corrupted page\n",...
>>
>>
> 
> Correct, HW_ERR isn't used there. My interpretation is that it can be
> used whenever an event is due to a hardware error (real or simulated).
> This is a very clear message to a user.
> 
> It may be redundant in some cases (like here where the message already
> says "hardware memory corruption"). But I think it would be go to use it
> anyway for consistency.
> 
> I think other relevant places in the kernel should also be updated. But
> that is beyond this patch, and I don't expect it to be done here and
> now.

Ok, I will add the HW_ERR in next version, if no one else objects.
> 
> Thanks,
> Yazen

Thank you.
Best Regards,
Shuai


