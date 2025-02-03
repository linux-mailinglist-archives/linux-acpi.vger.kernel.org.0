Return-Path: <linux-acpi+bounces-10880-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF34BA25A3E
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Feb 2025 13:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1CFD1624A2
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Feb 2025 12:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AEC7204C03;
	Mon,  3 Feb 2025 12:59:46 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7C6204C11;
	Mon,  3 Feb 2025 12:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738587586; cv=none; b=OLCcaAYRBoj1FV1sm0H31huNmawph9ygjZjDZ7kKfQY7prvEOmdPpanQyhCmly+loEQo7o89SnV0nHiYuqY5NVuy/f5Ys/pI447hY2GB6KxZYVXzGH8RHBff5BXUa7A67Dg15Rq3jVw3ACblAUGa96DWcpfcwtayKOPYtcUmp6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738587586; c=relaxed/simple;
	bh=/y/y+yMPC+kxSkrXxO3Guy9FZRh/OM4w1hP6Ch7QS1Y=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OUyX8aAf/02//BMdJmiiLrlM0xG2dggGhRRBT+Mtd1tNHJpwYvDjUNLF0rYx7dWlfUmsJNy8wk+l/TPXaeDrwYpSDhZKRP+Lxz/T7Uu1/fHSHVBLQBl9Q09q1Ir+p7rEFEu9nQ8dpZ/R8TOhti3Jj3RHLIS3RG5wWqJZ6lu09Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3c9ff7000001d7ae-5c-67a0ba2e234c
Message-ID: <a2b428ed-212a-4e39-bcf7-5ab67249132d@sk.com>
Date: Mon, 3 Feb 2025 21:44:29 +0900
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: kernel_team@skhynix.com, Gregory Price <gourry@gourry.net>,
 ying.huang@linux.alibaba.com, rafael@kernel.org, lenb@kernel.org,
 gregkh@linuxfoundation.org, akpm@linux-foundation.org, rakie.kim@sk.com,
 dan.j.williams@intel.com, Jonathan.Cameron@huawei.com, dave.jiang@intel.com,
 horen.chuang@linux.dev, hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-mm@kvack.org, kernel-team@meta.com,
 42.hyeyoo@gmail.com, Honggyu Kim <honggyu.km@gmail.com>
Subject: Re: [PATCH v4] Weighted Interleave Auto-tuning
To: Joshua Hahn <joshua.hahnjy@gmail.com>
References: <20250202141247.2219681-1-joshua.hahnjy@gmail.com>
Content-Language: ko
From: Honggyu Kim <honggyu.kim@sk.com>
In-Reply-To: <20250202141247.2219681-1-joshua.hahnjy@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFIsWRmVeSWpSXmKPExsXC9ZZnka7ergXpBmtWKVpM7DGwmLN+DZvF
	9KkXGC1O3Gxks/h59zi7RfPi9WwWqzf5WszZeYfZ4nb/OVaLVQuvsVkc3zqP3WLfRaCGnQ/f
	slks39fPaHF51xw2i3tr/rNazP0yldli9ZoMByGPw2/eM3vsnHWX3aO77TK7R8uRt6wei/e8
	ZPLYtKqTzWPTp0nsHidm/Gbx2PnQ0mNhw1Rmj/1z17B7nLtY4fF5k1wAbxSXTUpqTmZZapG+
	XQJXxue9uxgL/olUzL01gbGB8bZAFyMnh4SAiUTv4ndMMPabuTvYQGxeAUuJSysfsoPYLAIq
	Er/ndLFDxAUlTs58wgJiiwrIS9y/NQMozsXBLPCaWeLV1HVADgeHsIC5xNflKiA1IgKaEida
	JzGD2EICdhKHLjWD2cwCIhKzO9vAbDYBNYkrLyeB3cApYC/R3X+fHaLGTKJraxcjhC0vsf3t
	HGaQXRIC59gl2tfsZYU4WlLi4IobLBMYBWchuW8Wkh2zkMyahWTWAkaWVYxCmXlluYmZOSZ6
	GZV5mRV6yfm5mxiBMbys9k/0DsZPF4IPMQpwMCrx8J7YtiBdiDWxrLgy9xCjBAezkgjv6e1A
	Id6UxMqq1KL8+KLSnNTiQ4zSHCxK4rxG38pThATSE0tSs1NTC1KLYLJMHJxSDYxh62/ofC3x
	OhKu4eGjWhntvqL0Z+La+fsCPQ6++C8UsFrJMHdWhJfVqi83DNiLg6IrP1RpKa5Ys/KuNIuv
	XvEzDWFuOW8fZ29LzveHNt5ynN1zSq5v6YL9mscljvKdvXLTb713zmyTaJ2NaxzyvNzKHp8+
	9OLwn3hhyYqzsat2sL4MnyRn2qfEUpyRaKjFXFScCAAp8lm43QIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFIsWRmVeSWpSXmKPExsXCNUNLT1dv14J0g/YVQhYTewws5qxfw2Yx
	feoFRosTNxvZLH7ePc5u0bx4PZvF6k2+FnN23mG2uN1/jtVi1cJrbBbHt85jt9h3Eajh8NyT
	rBY7H75ls1i+r5/R4vKuOWwW99b8Z7WY+2Uqs8Wha89ZLVavyXAQ8Tj85j2zx85Zd9k9utsu
	s3u0HHnL6rF4z0smj02rOtk8Nn2axO5xYsZvFo+dDy09FjZMZfbYP3cNu8e5ixUe3257eCx+
	8YHJ4/MmuQD+KC6blNSczLLUIn27BK6Mz3t3MRb8E6mYe2sCYwPjbYEuRk4OCQETiTdzd7CB
	2LwClhKXVj5kB7FZBFQkfs/pYoeIC0qcnPmEBcQWFZCXuH9rBlCci4NZ4DWzxKup64AcDg5h
	AXOJr8tVQGpEBDQlTrROYgaxhQTsJA5dagazmQVEJGZ3toHZbAJqEldeTmICsTkF7CW6+++z
	Q9SYSXRt7WKEsOUltr+dwzyBkW8WkjNmIRk1C0nLLCQtCxhZVjGKZOaV5SZm5pjqFWdnVOZl
	Vugl5+duYgTG6LLaPxN3MH657H6IUYCDUYmH98S2BelCrIllxZW5hxglOJiVRHhPbwcK8aYk
	VlalFuXHF5XmpBYfYpTmYFES5/UKT00QEkhPLEnNTk0tSC2CyTJxcEo1MK59pb/yn+q0J7H/
	r2Rc6/uXkuC4a/nsnpxJRVyH/26SVo4sFeP8qrVotmCH7q8oz+uad+6o3154bKFSdmnNQjcL
	zbLOgq/Bdz/xmKy3mj2Bj2OZYVznvVkLHkzy3Xz8V+aJ57nqR5bfrrjc5rq9LrdISPC/UZjT
	b47pjC9PmvsZlh75rb/sxiQlluKMREMt5qLiRACl6TpzzQIAAA==
X-CFilter-Loop: Reflected

Hi Joshua,

On 2/2/2025 11:12 PM, Joshua Hahn wrote:
> Hi Honggyu,
> 
> On Sun, 2 Feb 2025 22:51:34 +0900 Honggyu Kim <honggyu.km@gmail.com> wrote:
> 
>> On 2/2/25 01:53, Gregory Price wrote:
>>> On Sat, Feb 01, 2025 at 11:49:31AM -0500, Gregory Price wrote:
>>>>>     1. the auto mode set the weights as 10:5:1 for node{0-2}.
>>>>>     2. node2 is offlined, then recalculation makes it as 2:1 for node{0,1}.
>>>
>>> Point of clarification here:  a hot-unplug event won't cause
>>> recalculation.
>>>
>>> What actually causes re-weight is hot-plug reporting new capacity.
>>
>> So do you mean re-weight is done only when a new node is onlined while
>> offline doesn't trigger re-weight?
>>
>> I see node_set_perf_attrs() does recalculation by calling
>> mempolicy_set_node_perf(), then reduce_interleave_weights().
>>
>> But I'm not sure if the re-weight is done via node_set_perf_attrs() only
>> when a new node is onlined.
>>
>> Could you please explain where I can find it?
> 
> Just chiming in to add some clarification:
> Your analysis above is correct; reduce_interleave_weights() is only
> called in 2 spots: once when the mode is switched from manual --> auto,
> and the other when new bandwidth data is available, which calls
> node_set_perf_attrs() and so on. In all other scenarios, iw_table is
> preserved, and all values inside remain the same without manual changes.

Yeah, this part is clear.

> A node offlining (or even onlining with no new bandwidth information)
> will just mean that the node inherits whatever value is stored in
> iw_table at that moment, whether that contains the default values
> created on init or the last values that it had taken.

It looks the call sequence is as follows.

   cxl_region_perf_attrs_callback()
   -> cxl_region_update_coordinates()
   -> node_set_perf_attrs()
   -> mempolicy_set_node_perf()
   -> reduce_interleave_weights()

I haven't searched all the paths of cxl_region_perf_attrs_callback() via
cxlr->memory_notifier.notifier_call callback pointer, but maybe this
function is not called when a node is offlined, then I get node
offlining doesn't trigger re-weight calculation.

By the way, do you test it using CXL hardware or using qemu?

> 
>>> So in this scenario, the weight will remain the same for node2.
>>
>> If it's true, my scenario is wrong.
>>
>> Thanks,
>> Honggyu
>>
>>>
>>>>>     3. the auto sysfs interface is set to 0 to make it manual mode.
> 
> Please let me know if this makes sense. Thank you for your review
> as always, and have a great day!
> Joshua

Thanks for your response.  Have a great day you too!

Regards,
Honggyu

