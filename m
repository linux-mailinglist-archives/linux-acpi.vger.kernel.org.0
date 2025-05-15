Return-Path: <linux-acpi+bounces-13736-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3B3AB8E99
	for <lists+linux-acpi@lfdr.de>; Thu, 15 May 2025 20:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2C3E9E3F06
	for <lists+linux-acpi@lfdr.de>; Thu, 15 May 2025 18:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13BDF25B1F7;
	Thu, 15 May 2025 18:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="DG3BzwQ2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F31C120;
	Thu, 15 May 2025 18:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747332706; cv=none; b=o5qDqHFyOFk0KbNiFY0IeTC2U7YQOahuxLa4SOyL3NMyxlMvMHMlxQQmXLEkfF4PioiSBsucV+qaRjCsuvI6mEJsyfUsFArxijMPF/NrqK4D0Tc38gGcrmR65nH9HhNBu60A+r2Qy8F9KkOVl/VnmL+tH9Zm+6VTTNHug/rhQe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747332706; c=relaxed/simple;
	bh=of79dNqunf4yRsxRAGw+9Azkn+i5XcrrCVCeH8uM+zs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lnq+CxOdWkB7pQQxmcA+DRS1iB5RN7SCS0MgTv2suQIJK6D4yD42TLvtd+FJ+CC/SfGRr6g2ADtuOuSD9sfLQXirlTbmeswbIpfKbP0f2aLU9oZH/s9fK88wwbDKw7OnGDPpbaDWd/H72P18mVzk+gb+KXlf7+/EWyUv2RVXb24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=DG3BzwQ2; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [192.168.7.202] ([71.202.166.45])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 54FIBA613610523
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 15 May 2025 11:11:10 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 54FIBA613610523
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025042001; t=1747332671;
	bh=9c1R4oy3soG5VO6mIRJI3CqW6DmwJ6Mep1AU0zB8N4A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DG3BzwQ2BWylwPDcl7KrfGhx2mIF7dLUmwl61g76BeleGjxlXwR4RDqh1sN4AbaLj
	 LCiKCPNKKZn+A3q/x0AZAtwJwqjQspJXZq6Gj4MU6eeg51aUBJC8fVM+e53znk7u7i
	 OQoSxfM434A9LxtAKAO1Jlmfa/R0vptHUyiea5Xf3GDQSRfEJR1UQIXvaqBBKtOpcy
	 AVto//EUOxjmaJK2YYQKuOz5qz8i2tTQuKWYati/DUVFmup3bEHu0inyoANKIPOidS
	 StXvbk7nGpNOH4+MoZQIgOsZzrfgFScQn6oJjgAvI1D78ZdQ87LB/YAc3eQv2WkUMF
	 EniWYTJqe8v3A==
Message-ID: <30affad5-4f26-4e22-9d64-b8ece1199773@zytor.com>
Date: Thu, 15 May 2025 11:11:09 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] x86/xen/msr: Fix uninitialized symbol 'err'
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-acpi@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        peterz@infradead.org, jgross@suse.com, boris.ostrovsky@oracle.com,
        rafael@kernel.org, lenb@kernel.org
References: <20250512084552.1586883-1-xin@zytor.com>
 <20250512084552.1586883-3-xin@zytor.com> <aCYIblffvBGUuxWf@gmail.com>
Content-Language: en-US
From: Xin Li <xin@zytor.com>
Autocrypt: addr=xin@zytor.com; keydata=
 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
 l75w1xInsg==
In-Reply-To: <aCYIblffvBGUuxWf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/15/2025 8:29 AM, Ingo Molnar wrote:
> 
> * Xin Li (Intel) <xin@zytor.com> wrote:
> 
>> xen_read_msr_safe() currently passes an uninitialized argument err to
>> xen_do_read_msr().  But as xen_do_read_msr() may not set the argument,
>> xen_read_msr_safe() could return err with an unpredictable value.
>>
>> To ensure correctness, initialize err to 0 (representing success)
>> in xen_read_msr_safe().
>>
>> Because xen_read_msr_safe() is essentially a wrapper of xen_do_read_msr(),
>> the latter should be responsible for initializing the value of *err to 0.
>> Thus initialize *err to 0 in xen_do_read_msr().
>>
>> Fixes: 502ad6e5a619 ("x86/msr: Change the function type of native_read_msr_safe()")
>> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
>> Closes: https://lore.kernel.org/xen-devel/aBxNI_Q0-MhtBSZG@stanley.mountain/
>> Signed-off-by: Xin Li (Intel) <xin@zytor.com>
>> ---
>>   arch/x86/xen/enlighten_pv.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
>> index 3be38350f044..01f1d441347e 100644
>> --- a/arch/x86/xen/enlighten_pv.c
>> +++ b/arch/x86/xen/enlighten_pv.c
>> @@ -1091,6 +1091,9 @@ static u64 xen_do_read_msr(u32 msr, int *err)
>>   {
>>   	u64 val = 0;	/* Avoid uninitialized value for safe variant. */
>>   
>> +	if (err)
>> +		*err = 0;
>> +
>>   	if (pmu_msr_chk_emulated(msr, &val, true))
>>   		return val;
>>   
>> @@ -1162,7 +1165,7 @@ static void xen_do_write_msr(u32 msr, u64 val, int *err)
>>   
>>   static int xen_read_msr_safe(u32 msr, u64 *val)
>>   {
>> -	int err;
>> +	int err = 0;
>>   
>>   	*val = xen_do_read_msr(msr, &err);
>>   	return err;
> 
> So why not initialize 'err' with 0 in both callers, xen_read_msr_safe()
> and xen_read_msr(), and avoid all the initialization trouble in
> xen_do_read_msr()?

Yeah, I should make the change in xen_read_msr() too.

However xen_do_read_msr() should be implemented in a defensive way to
set *err properly as it's part of its return value.  Actually it was so,
but one of my previous cleanup patch removed it because err is no longer
passed to pmu_msr_chk_emulated().

Thanks!
     Xin

