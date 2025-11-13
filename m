Return-Path: <linux-acpi+bounces-18854-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F41C5640C
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Nov 2025 09:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3D1BB3522AA
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Nov 2025 08:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867D0331A68;
	Thu, 13 Nov 2025 08:18:48 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E8A3314D1;
	Thu, 13 Nov 2025 08:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763021928; cv=none; b=le98TbwzoPjafRN2eSVkHbx/EAYwr0H88jI/FgU9P/7qgF67rNY85ApxvF0DMzMmZs2v8vCj423GSwYhJ7NhLVc1+ShlGr33y1KnX1HyknrHVMhY82uGTrbnah5BlzElM16UjFUY6IvNDYASK3tmo35DBKxKqHo8I7v+N6Tmpfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763021928; c=relaxed/simple;
	bh=kklI8L8EsTq1Q3PmRCPpKmquh67Xwwv+nLpxhUlRcD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Kv0TL1RIoFA0oOOlABZK0XV/DRHcvfTtqrCc/ReckYchtFiNdE1RAvF2fwf5JEKIyj6pfeYRYQv7X4r9ChZGno8+7MGeetn5qtjePU97siXrnAxqWOocID6vvRpr8jh93iVuY9/SauY4txfRWHUKDP2uRlMRXWrC8u2omhwRyPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4d6Y5s6RTgz12LDD;
	Thu, 13 Nov 2025 16:17:05 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id D8C1A180494;
	Thu, 13 Nov 2025 16:18:36 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemf200017.china.huawei.com
 (7.202.181.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 13 Nov
 2025 16:18:36 +0800
Message-ID: <05ba04d8-4c96-4497-9c81-ae72de139b1b@hisilicon.com>
Date: Thu, 13 Nov 2025 16:18:35 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] cpufreq: CPPC: Update FIE arch_freq_scale in ticks for
 non-PCC regs
To: Beata Michalska <beata.michalska@arm.com>
CC: <viresh.kumar@linaro.org>, <rafael@kernel.org>, <ionela.voinescu@arm.com>,
	<linux-pm@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>,
	<zhenglifeng1@huawei.com>, <prime.zeng@hisilicon.com>,
	<jonathan.cameron@huawei.com>
References: <20251104065039.1675549-1-zhanjie9@hisilicon.com>
 <aRIXlSOPzAy1nXUQ@arm.com>
 <e439d370-48a3-40c3-ae54-67d2f844bae5@hisilicon.com>
 <aRWRGvQg1u9bPg5V@arm.com>
Content-Language: en-US
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <aRWRGvQg1u9bPg5V@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemf200017.china.huawei.com (7.202.181.10)



On 11/13/2025 4:04 PM, Beata Michalska wrote:
> On Tue, Nov 11, 2025 at 07:30:09PM +0800, Jie Zhan wrote:
>>
>>
>> On 11/11/2025 12:49 AM, Beata Michalska wrote:
>>> Hi Jie,
>>> On Tue, Nov 04, 2025 at 02:50:39PM +0800, Jie Zhan wrote:
>>>> Currently, the CPPC Frequency Invariance Engine (FIE) is invoked from the
>>>> scheduler tick but defers the update of arch_freq_scale to a separate
>>>> thread because cppc_get_perf_ctrs() would sleep if the CPC regs are in PCC.
>>>>
>>>> However, this deferred update mechanism is unnecessary and introduces extra
>>>> overhead for non-PCC register spaces (e.g. System Memory or FFH), where
>>>> accessing the regs won't sleep and can be safely performed from the tick
>>>> context.
>>>>
>>>> Furthermore, with the CPPC FIE registered, it throws repeated warnings of
>>>> "cppc_scale_freq_workfn: failed to read perf counters" on our platform with
>>>> the CPC regs in System Memory and a power-down idle state enabled.  That's
>>>> because the remote CPU can be in a power-down idle state, and reading its
>>>> perf counters returns 0.  Moving the FIE handling back to the scheduler
>>>> tick process makes the CPU handle its own perf counters, so it won't be
>>>> idle and the issue would be inherently solved.
>>>>
>>>> To address the above issues, update arch_freq_scale directly in ticks for
>>>> non-PCC regs and keep the deferred update mechanism for PCC regs.
>>> Something about it just didn’t sit right with me, and apparently, it needed some
>>> time to settle down - thus the delay.
>>>
>>> It all looks sensible though it might be worth to considered applying
>>> the change on a per-CPU basis, as, in theory at least, different address
>>> spaces are allowed for different registers (at least according to the ACPI
>>> spec, if I read it right).
>>> So I was thinking about smth along the lines of:
>> Beata,
>>
>> Right, I see what you want to do.
>> Some comments inline.
>>
>> Would you like to make it a full patch so I can include it in the next
>> version? or some other way?
> What I have shared was just to ilustrate the idea, so if that's ok with you,
> you might carry on with that as well ?
> 
> ---
> BR
> Beata
Sure, I will try to incorporate this and update.

...

