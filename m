Return-Path: <linux-acpi+bounces-17508-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D58BB4C9E
	for <lists+linux-acpi@lfdr.de>; Thu, 02 Oct 2025 20:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33BBC323C43
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Oct 2025 18:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81A9277029;
	Thu,  2 Oct 2025 18:02:26 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B19F275AE4;
	Thu,  2 Oct 2025 18:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759428146; cv=none; b=q4h0ynemZMT9hc076y7Drky4zGoydi3AemVwsBq8CzDmFnJD+1eruj+RiL1NlmKlenbNtkgt4/UZvenFJiN4o/OgOG4HyB9WjDQUVZ3mbR7qXfe6BQWWpxAoYXwEohxggxnIk9exz+b6l5VODKQVU2KgeyFilwN6QEv01OqYY+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759428146; c=relaxed/simple;
	bh=d9JMwz3pZXPH7YSUzmEm3uXPoHX5XC/PPW4BNzQqJCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f92e+9Anw8T03m9xynA3Py5vyVGEl3ucyl2jnKlmXNMnOuUgzOvwO/eSJiYVkj9Py0A18ZvjXW17F+/TJ8wHuk0SIygr3cOyNeecH23crse4KK4dgKEvw6Nx7tlSO6YOXDVQL4/3jaeIf1WyN0moN7efO5YzFCJtmJYLWZHAuT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 006BE1FCD;
	Thu,  2 Oct 2025 11:02:16 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF10D3F66E;
	Thu,  2 Oct 2025 11:02:18 -0700 (PDT)
Message-ID: <2c5c6e2a-e0ea-4786-ba6e-2c536a53a68b@arm.com>
Date: Thu, 2 Oct 2025 19:02:05 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/29] arm_mpam: Extend reset logic to allow devices to
 be reset any time
To: Ben Horgan <ben.horgan@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
Cc: D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Dave Martin <dave.martin@arm.com>,
 Koba Ko <kobak@nvidia.com>, Shanker Donthineni <sdonthineni@nvidia.com>,
 fenghuay@nvidia.com, baisheng.gao@unisoc.com,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Rob Herring
 <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
 Rafael Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>
References: <20250910204309.20751-1-james.morse@arm.com>
 <20250910204309.20751-18-james.morse@arm.com>
 <9fa1b584-130b-45b0-9dba-8e046e643bf0@arm.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <9fa1b584-130b-45b0-9dba-8e046e643bf0@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ben,

On 12/09/2025 12:42, Ben Horgan wrote:
> On 9/10/25 21:42, James Morse wrote:
>> cpuhp callbacks aren't the only time the MSC configuration may need to
>> be reset. Resctrl has an API call to reset a class.
>> If an MPAM error interrupt arrives it indicates the driver has
>> misprogrammed an MSC. The safest thing to do is reset all the MSCs
>> and disable MPAM.
>>
>> Add a helper to reset RIS via their class. Call this from mpam_disable(),
>> which can be scheduled from the error interrupt handler.
>> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
>> index e7faf453b5d7..a9d3c4b09976 100644
>> --- a/drivers/resctrl/mpam_devices.c
>> +++ b/drivers/resctrl/mpam_devices.c
>> @@ -842,8 +842,6 @@ static int mpam_reset_ris(void *arg)
>>  	u16 partid, partid_max;
>>  	struct mpam_msc_ris *ris = arg;
>>
>> -	mpam_assert_srcu_read_lock_held();
>> -
>
> Remove where it is introduced. There is already one in
> mpam_reset_ris_partid() at that time.

Mmmm, this should really have been replaced with a comment.

I prefer each function to have an assert like this as documentation. In this case, a new
caller may miss the lock, but always hit the 'in_reset_state' case during testing, and be
caught out when a call to mpam_reset_ris_partid() occurs. Having documentation comments
that can also bark at you when you ignore them is really handy!

It's removed in this  patch  because calling it via mpam_touch_msc() puts it behind an
call to schedule, and lockdep expects 'current' to be the one holding the lock.

I'll add the comment. Looks like it just got dropped when mpam_touch_msc() stopped using
an IPI...


>>  	if (ris->in_reset_state)
>>  		return 0;
>
> Reviewed-by: Ben Horgan <ben.horgan@arm.com>

Thanks!


James

