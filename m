Return-Path: <linux-acpi+bounces-17427-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 320F3BAA36B
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Sep 2025 19:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA791175335
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Sep 2025 17:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D90D2288E3;
	Mon, 29 Sep 2025 17:45:02 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71429221546;
	Mon, 29 Sep 2025 17:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759167901; cv=none; b=PAM8YRgsxcp3ubyin9wswekn8hPkuJmS20KLXj7BO4vunNR4mlSPN7eyLIcss7fOm2WG7danO3YEbUidlE2vFS4uBCBds2fqyCHXnAA8xZefnIwPo8C3+tv5wYC5UYZmJUcUnJp9lhk/n+uKKYln4Q1p5oeQeA79q5/hGD5rK/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759167901; c=relaxed/simple;
	bh=DbJyopLs9gb7tcDqwcyS8ltGYv6IGcFf1Qf6xx98aBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uGSZrj3xhVyeGoNpxCkMJraMa70ydJ8u6FOwd6zmsFkG8EbcmrzzToZ59nP8cK0pdYP3S7ngpAqZjgF04oPRMQzsp6QHj8FaGqI73m5FV78cilBpR2/bGlV4TGXUJ3zZ6ZR1AfLtQtI1ZHDPcXQxE2ILf5lUOeIVL7aqwsdn4lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A4F021CC4;
	Mon, 29 Sep 2025 10:44:51 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8E5C33F59E;
	Mon, 29 Sep 2025 10:44:54 -0700 (PDT)
Message-ID: <2672f409-7923-4b9b-9009-bb5815205e57@arm.com>
Date: Mon, 29 Sep 2025 18:44:54 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/29] arm_mpam: Add helpers for managing the locking
 around the mon_sel registers
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
 <20250910204309.20751-13-james.morse@arm.com>
 <aaefa134-b520-42d2-a700-4f7382b0318f@arm.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <aaefa134-b520-42d2-a700-4f7382b0318f@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ben,

On 11/09/2025 16:31, Ben Horgan wrote:
> On 9/10/25 21:42, James Morse wrote:
>> The MSC MON_SEL register needs to be accessed from hardirq for the overflow
>> interrupt, and when taking an IPI to access these registers on platforms
>> where MSC are not accesible from every CPU. This makes an irqsave
>> spinlock the obvious lock to protect these registers. On systems with SCMI
>> mailboxes it must be able to sleep, meaning a mutex must be used. The
>> SCMI platforms can't support an overflow interrupt.
>>
>> Clearly these two can't exist for one MSC at the same time.
>>
>> Add helpers for the MON_SEL locking. The outer lock must be taken in a
>> pre-emptible context before the inner lock can be taken. On systems with
>> SCMI mailboxes where the MON_SEL accesses must sleep - the inner lock
>> will fail to be 'taken' if the caller is unable to sleep. This will allow
>> callers to fail without having to explicitly check the interface type of
>> each MSC.

>> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
>> index 828ce93c95d5..4cc44d4e21c4 100644
>> --- a/drivers/resctrl/mpam_internal.h
>> +++ b/drivers/resctrl/mpam_internal.h
>> @@ -70,12 +70,17 @@ struct mpam_msc {
>>  
>>  	/*
>>  	 * mon_sel_lock protects access to the MSC hardware registers that are
>> -	 * affected by MPAMCFG_MON_SEL.
>> +	 * affected by MPAMCFG_MON_SEL, and the mbwu_state.
>> +	 * Access to mon_sel is needed from both process and interrupt contexts,
>> +	 * but is complicated by firmware-backed platforms that can't make any
>> +	 * access unless they can sleep.
>> +	 * Always use the mpam_mon_sel_lock() helpers.
>> +	 * Accessed to mon_sel need to be able to fail if they occur in the wrong
>> +	 * context.
>>  	 * If needed, take msc->probe_lock first.
>>  	 */
>> -	struct mutex		outer_mon_sel_lock;
>> -	raw_spinlock_t		inner_mon_sel_lock;
>> -	unsigned long		inner_mon_sel_flags;
>> +	raw_spinlock_t		_mon_sel_lock;
>> +	unsigned long		_mon_sel_flags;
>>  
> 
> These stale variables can be removed in the patch that introduced them,
> outer_mon_sel_lock, inner_mon_sel_lock, inner_mon_sel_flags. Jonathan
> has already pointed out the stale comment and paragraph in the commit
> message.

Yeah - I forgot to rewrite the commit message when I split this patch.
I'll pull those earlier bits into the now:later patch that splits the locking up.


Thanks,

James

