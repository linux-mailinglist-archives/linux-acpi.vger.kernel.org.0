Return-Path: <linux-acpi+bounces-19417-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 78FCACA1922
	for <lists+linux-acpi@lfdr.de>; Wed, 03 Dec 2025 21:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09E83300CB82
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Dec 2025 20:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F1D2A1BB;
	Wed,  3 Dec 2025 17:34:51 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E26255F2D;
	Wed,  3 Dec 2025 17:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764783291; cv=none; b=EJFnVQwfXK4R6zwQ3LiXxE2QIxiNjEbjjaHlAtgTQK14eDglMENIN7wLhzMFBp25Fm68lWbBBH+Pjp2OCIeOHCPgH7fPqCQKos3HhyEU+oz9rqPQdMCW8KtH/Z4oyBMFpBU3GTEw6RKoGjsdEjobt19LbUmVgRhurnLN+aWO91Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764783291; c=relaxed/simple;
	bh=SoLD9RLzqEkv+8/4SJv+u92YbIkhjmNLT9LNM3ju0YE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P2F0lpxOIDKhpbrxhg6K/iGmGWTm2AaNKYcQ4a8Xl6uMpnTzNn1OU8L41IykCVlT4gcRFdiMnfKzCZhBUEjs/1HkIgAvd3sm3GZNv5m1F1VpU+TOVxRnKw9QdAS0VHgcSAMQMeQsRCgziIZS0biG49ShHHZYgsvNJyN0TFLsKBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D3EC339;
	Wed,  3 Dec 2025 09:34:41 -0800 (PST)
Received: from [10.1.197.58] (eglon.cambridge.arm.com [10.1.197.58])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 45E733F59E;
	Wed,  3 Dec 2025 09:34:40 -0800 (PST)
Message-ID: <642767c9-f926-490a-83a1-160978c37553@arm.com>
Date: Wed, 3 Dec 2025 17:34:37 +0000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/34] arm_mpam: Add basic mpam driver
To: Punit Agrawal <punit.agrawal@oss.qualcomm.com>,
 Ben Horgan <ben.horgan@arm.com>
Cc: amitsinght@marvell.com, baisheng.gao@unisoc.com,
 baolin.wang@linux.alibaba.com, bobo.shaobowang@huawei.com,
 carl@os.amperecomputing.com, catalin.marinas@arm.com, dakr@kernel.org,
 dave.martin@arm.com, david@redhat.com, dfustini@baylibre.com,
 fenghuay@nvidia.com, gregkh@linuxfoundation.org, gshan@redhat.com,
 guohanjun@huawei.com, jeremy.linton@arm.com, jonathan.cameron@huawei.com,
 kobak@nvidia.com, lcherian@marvell.com, lenb@kernel.org,
 linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, lpieralisi@kernel.org, peternewman@google.com,
 quic_jiles@quicinc.com, rafael@kernel.org, robh@kernel.org,
 rohit.mathew@arm.com, scott@os.amperecomputing.com, sdonthineni@nvidia.com,
 sudeep.holla@arm.com, tan.shaopeng@fujitsu.com, will@kernel.org,
 xhao@linux.alibaba.com, reinette.chatre@intel.com
References: <20251119122305.302149-1-ben.horgan@arm.com>
 <877bvfa23i.fsf@stealth> <a04aa337-a3eb-42a0-855b-500ba549e2d8@arm.com>
 <87sedrlsjk.fsf@stealth>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <87sedrlsjk.fsf@stealth>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Punit,

On 03/12/2025 11:21, Punit Agrawal wrote:
> Ben Horgan <ben.horgan@arm.com> writes:
>> On 11/24/25 15:21, Punit Agrawal wrote:
>>> Although a little late to the party,

There was a party?!


>>> I've managed to throw together
>>> enough firmware to describe the MPAM hardware and take this set (more
>>> specifically mpam/snapshot/v6.18-rc4-v5 branch from James' repository)
>>> for a spin. Using the branch, the kernel is able to probe the hardware
>>> and discover the advertised features. Yay! We are in business.
>>
>> Thanks for giving it a go. :)
>>
>>>
>>> Having said that, there are a few quirks of the platform that run into
>>> issues with later patches in the branch.

So something in the resctrl support code is causing this.
Any idea which patch causes this to happen?

There are a load of pr_debug() in the picking logic, if you enable DYNDEBUG and add:
| dyndbg="file mpam_resctrl.c +pl"

to the commandline, you should get some snotty messages about what non-Xeon-like property
your platform has.



>>> The platform has MSCs attached
>>> to shared L2 caches which are being skipped during later stages of
>>> initialisation. IIUC, the L2 MSCs' limitations stems from the
>>> assumptions in the resctrl interface.
>>
>> What in particualar is being skipped?

> The registration of the discovered MSCs with resctrl and subsequent
> exposing it to the user.

resctrl's 'L2' support is limited to the CPOR bitmap.
If you have controls, there is no resctrl 'event' that can exposed them.
(the problem being they all have 'L3' in the name!)


>>> I was wondering if there are any patches available to relax these
>>> limitations?

Knowing which property it is will help - but some of these things are checked
to match resctrl's ABI. They can't necessarily be relaxed without breaking
user-space.

Others are sanity checks, e.g. all CPUs are represented. This is to avoid tasks
that run on cpu-9 escaping the resctrl controls. Platforms that did this may as
well not bother with resctrl at all.


>>> I can give them a try. Or do these need to be put together
>>> from the ground up? Any pointers greatly appreciated.
>>
>> There are some extra things added in the extras branch [1] e.g. cache
>> maximum usage controls (cmax). However, lots of possible things are
>> still missing e.g. any monitors on L2. If it doesn't fit with the
>> topology expected by resctrl then it is unlikely to have been considered
>> yet.
> 
> Thanks for the pointer. I'll give the snapshot+extras branch[1] a try.
> 
> The platform does have both controls and monitors attached to L2. If
> this isn't being looked at, I can try and put something together. Thanks
> for confirming that the limitation is likely due to resctrl.

My view on 'extra' counters is to try and expose them via perf, as this would also
allow platform specific counters. I worry that if we start adding 'easy' ones like
l2_mbm_total to resctrl, someone will want left_hand_side_of_soc_mbm_total.


Thanks,

James

