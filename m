Return-Path: <linux-acpi+bounces-11946-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4525A57412
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Mar 2025 22:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86BB73B0E6D
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Mar 2025 21:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C4720C008;
	Fri,  7 Mar 2025 21:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="SnZFHeoT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9DF2080FD;
	Fri,  7 Mar 2025 21:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741384526; cv=none; b=gDB7UthQqr1VbomEuN4Z6LQJg+tcH2LL6m6jLljkJfjaqRjK2XJYbbJp17qLBxctu7BzKfC8Dy6I1rZ2kxHimdSEMDxGRF/9yZut2mJsqdlRCoj67JygIJwTQcyFSkv1iAOvByVHlGeaLUz+/h6XZ5znK011OcNs3ZI8+kVS73o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741384526; c=relaxed/simple;
	bh=lClzBMRdUULwzoMLwEqwrMgSFr14uRCRgTFs1G4m8e0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QIjcB8sA7a6wiIFMUlIZiWGhJsfKA3SayTqSaWqbPZhXSP7gCbReIr4I1hS0IRm4x5CuqlGVBe3q/gaB4NW3kPRL9s7WOdZBk7lFb4o2Zl0537uUCJ2KoG+H1kT3XIUVqosSrnQ7YlWNAkNwk/YY7Z43HdhExGcVg4/yLxYISVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=SnZFHeoT; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.35.166] (c-24-22-154-137.hsd1.wa.comcast.net [24.22.154.137])
	by linux.microsoft.com (Postfix) with ESMTPSA id E30EB2038F3B;
	Fri,  7 Mar 2025 13:55:23 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E30EB2038F3B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741384524;
	bh=BYiqT5jddIJjKfv2s/zeQhMm81+sjONX7rRhWau6sX8=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=SnZFHeoT4mDZsn5Rlyo65kO8j7OrCyFjXp+yUsoaUMwBj04Pv8Hr4YbS0zY1M5JBI
	 KzbKWXQF8/IhMnTVs9LQmBaZigJf+/bNz8HHHuNKFlreUORpgb5AXo51iKtcbOmmA6
	 dV2IMIxGY2uY01fbJKBPdec4cij7cYKcHmJG8rSE=
Message-ID: <9cd97b0e-dfd3-4923-961e-00ba09eb6cef@linux.microsoft.com>
Date: Fri, 7 Mar 2025 13:55:22 -0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Michael Kelley <mhklinux@outlook.com>, eahariha@linux.microsoft.com,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "kys@microsoft.com" <kys@microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "decui@microsoft.com" <decui@microsoft.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will@kernel.org" <will@kernel.org>, "tglx@linutronix.de"
 <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>,
 "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "hpa@zytor.com" <hpa@zytor.com>,
 "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
 "joro@8bytes.org" <joro@8bytes.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>, "arnd@arndb.de"
 <arnd@arndb.de>,
 "jinankjain@linux.microsoft.com" <jinankjain@linux.microsoft.com>,
 "muminulrussell@gmail.com" <muminulrussell@gmail.com>,
 "skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>,
 "mrathor@linux.microsoft.com" <mrathor@linux.microsoft.com>,
 "ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
 "apais@linux.microsoft.com" <apais@linux.microsoft.com>,
 "Tianyu.Lan@microsoft.com" <Tianyu.Lan@microsoft.com>,
 "stanislav.kinsburskiy@gmail.com" <stanislav.kinsburskiy@gmail.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "vkuznets@redhat.com" <vkuznets@redhat.com>,
 "prapal@linux.microsoft.com" <prapal@linux.microsoft.com>,
 "muislam@microsoft.com" <muislam@microsoft.com>,
 "anrayabh@linux.microsoft.com" <anrayabh@linux.microsoft.com>,
 "rafael@kernel.org" <rafael@kernel.org>, "lenb@kernel.org"
 <lenb@kernel.org>, "corbet@lwn.net" <corbet@lwn.net>
Subject: Re: [PATCH v5 03/10] arm64/hyperv: Add some missing functions to
 arm64
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
References: <1740611284-27506-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1740611284-27506-4-git-send-email-nunodasneves@linux.microsoft.com>
 <5f3d660d-fe2e-4ac1-94a7-66d6c8ffe579@linux.microsoft.com>
 <2fee888a-4f81-40aa-9545-617a49a7fb30@linux.microsoft.com>
 <SN6PR02MB41579F4147561B96A2C1C057D4CA2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <7f689725-f676-4465-974d-ca2477d445f7@linux.microsoft.com>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <7f689725-f676-4465-974d-ca2477d445f7@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/7/2025 1:36 PM, Nuno Das Neves wrote:
> On 3/6/2025 11:05 AM, Michael Kelley wrote:
>> From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Thursday, February 27, 2025 4:21 PM
>>>
>>> On 2/26/2025 9:56 PM, Easwar Hariharan wrote:
>>>> On 2/26/2025 3:07 PM, Nuno Das Neves wrote:
>>>>> These non-nested msr and fast hypercall functions are present in x86,
>>>>> but they must be available in both architetures for the root partition
>>>>
>>>> nit: *architectures*
>>>>
>>>>
>>> Thanks!
>>>
>>>>> driver code.
>>>>>
>>>>> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
>>>>> ---
>>>>>  arch/arm64/hyperv/hv_core.c       | 17 +++++++++++++++++
>>>>>  arch/arm64/include/asm/mshyperv.h | 12 ++++++++++++
>>>>>  include/asm-generic/mshyperv.h    |  2 ++
>>>>>  3 files changed, 31 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm64/hyperv/hv_core.c b/arch/arm64/hyperv/hv_core.c
>>>>> index 69004f619c57..e33a9e3c366a 100644
>>>>> --- a/arch/arm64/hyperv/hv_core.c
>>>>> +++ b/arch/arm64/hyperv/hv_core.c
>>>>> @@ -53,6 +53,23 @@ u64 hv_do_fast_hypercall8(u16 code, u64 input)
>>>>>  }
>>>>>  EXPORT_SYMBOL_GPL(hv_do_fast_hypercall8);
>>>>>
>>>>> +/*
>>>>> + * hv_do_fast_hypercall16 -- Invoke the specified hypercall
>>>>> + * with arguments in registers instead of physical memory.
>>>>> + * Avoids the overhead of virt_to_phys for simple hypercalls.
>>>>> + */
>>>>> +u64 hv_do_fast_hypercall16(u16 code, u64 input1, u64 input2)
>>>>> +{
>>>>> +	struct arm_smccc_res	res;
>>>>> +	u64			control;
>>>>> +
>>>>> +	control = (u64)code | HV_HYPERCALL_FAST_BIT;
>>>>> +
>>>>> +	arm_smccc_1_1_hvc(HV_FUNC_ID, control, input1, input2, &res);
>>>>> +	return res.a0;
>>>>> +}
>>>>> +EXPORT_SYMBOL_GPL(hv_do_fast_hypercall16);
>>>>> +
>>>>
>>>> I'd like this to have been in arch/arm64/include/asm/mshyperv.h like its x86
>>>> counterpart, but that's just my personal liking of symmetry. I see why it's here
>>>> with its slow and 8-byte brethren.
>>>>
>>> Good point, I don't see a good reason this can't be in the header.
>>
>> I was trying to remember if there was some reason I originally put
>> hv_do_hypercall() and hv_do_fast_hypercall8() in the .c file instead of
>> the header like on x86. But I don't remember a reason. During
>> development, the code changed several times, and there might have
>> been a reason that didn't persistent in the version that was finally
>> accepted upstream.
>>
>> My only comment is that hv_do_hypercall() and the 8 and 16 "fast"
>> versions should probably stay together one place on the arm64 side,
>> even if it doesn't match x86.
>>
> 
> I think I'll just keep them together here for now then. They
> could be moved to the header in future if it seems worth doing.
> 

I was really hoping the answer here would be to move all of them together to the header,
but oh well.

<snip>

