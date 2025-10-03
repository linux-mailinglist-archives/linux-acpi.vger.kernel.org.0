Return-Path: <linux-acpi+bounces-17576-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3110FBB7D47
	for <lists+linux-acpi@lfdr.de>; Fri, 03 Oct 2025 20:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68CFD48374F
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Oct 2025 18:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33002D0619;
	Fri,  3 Oct 2025 18:03:21 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC256381BA;
	Fri,  3 Oct 2025 18:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759514601; cv=none; b=Mea+WDKVC/fCYvQ0oNi4fL/Me1qhmcdsCPpq2MROaWTawtCAU3xuQ5VlazvowkmgmrZQ2Zjji4juCJGu2amJPttH3BBsQ93iXXw2yY+3EDCo7Vl8eFJcDDHOE4BvyPxWicQ+nOsEvAwD3XnNfnhpEGouOIBp6/QRy1RIs4BSroE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759514601; c=relaxed/simple;
	bh=gfgh+rMDTBoily0sJrLGPj3ihI4LmKMhJ3/h56zR/zE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WHii7qP8SbT89gp2IObcB+8x+G+LkRftXkwI40HXXWH93GLKIEvA2D0pSkoXyviptAhVWhCclg3t7v5p1MU5ApNwRxcMwm0kjgzCHwsklosjYWBeWaj+wijFZKK2Ugshif80gMaIZq56rCYEOdUVQmYUFyQoj9/Iei+lsBtnjbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 057321596;
	Fri,  3 Oct 2025 11:03:11 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 15F0B3F5A1;
	Fri,  3 Oct 2025 11:03:13 -0700 (PDT)
Message-ID: <b1e1c98b-d6ca-4d47-b33a-e3af8457c4fd@arm.com>
Date: Fri, 3 Oct 2025 19:03:12 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 18/29] arm_mpam: Register and enable IRQs
To: Fenghua Yu <fenghuay@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
Cc: D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Xin Hao <xhao@linux.alibaba.com>,
 peternewman@google.com, dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Dave Martin <dave.martin@arm.com>,
 Koba Ko <kobak@nvidia.com>, Shanker Donthineni <sdonthineni@nvidia.com>,
 baisheng.gao@unisoc.com, Jonathan Cameron <jonathan.cameron@huawei.com>,
 Rob Herring <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
 Rafael Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>
References: <20250910204309.20751-1-james.morse@arm.com>
 <20250910204309.20751-19-james.morse@arm.com>
 <83ec74cb-02c3-4be4-a182-c2c69619abaf@nvidia.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <83ec74cb-02c3-4be4-a182-c2c69619abaf@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Fenghua,

On 25/09/2025 07:33, Fenghua Yu wrote:
> On 9/10/25 13:42, James Morse wrote:
>> Register and enable error IRQs. All the MPAM error interrupts indicate a
>> software bug, e.g. out of range partid. If the error interrupt is ever
>> signalled, attempt to disable MPAM.
>>
>> Only the irq handler accesses the ESR register, so no locking is needed.
>> The work to disable MPAM after an error needs to happen at process
>> context as it takes mutex. It also unregisters the interrupts, meaning
>> it can't be done from the threaded part of a threaded interrupt.
>> Instead, mpam_disable() gets scheduled.
>>
>> Enabling the IRQs in the MSC may involve cross calling to a CPU that
>> can access the MSC.
>>
>> Once the IRQ is requested, the mpam_disable() path can be called
>> asynchronously, which will walk structures sized by max_partid. Ensure
>> this size is fixed before the interrupt is requested.

>> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
>> index a9d3c4b09976..e7e4afc1ea95 100644
>> --- a/drivers/resctrl/mpam_devices.c
>> +++ b/drivers/resctrl/mpam_devices.c
>> @@ -1318,11 +1405,172 @@ static void mpam_enable_merge_features(struct list_head

>> +static void mpam_unregister_irqs(void)
>> +{
>> +    int irq, idx;
>> +    struct mpam_msc *msc;
>> +
>> +    cpus_read_lock();
>> +    /* take the lock as free_irq() can sleep */
>> +    idx = srcu_read_lock(&mpam_srcu);

> guard(srcu)(&mpam_srcu);

Yes - Jonathan already suggested this.


>> +    list_for_each_entry_srcu(msc, &mpam_all_msc, all_msc_list,
>> +                 srcu_read_lock_held(&mpam_srcu)) {
>> +        irq = platform_get_irq_byname_optional(msc->pdev, "error");
>> +        if (irq <= 0)
>> +            continue;
>> +
>> +        if (test_and_clear_bit(MPAM_ERROR_IRQ_HW_ENABLED, &msc->error_irq_flags))
>> +            mpam_touch_msc(msc, mpam_disable_msc_ecr, msc);
>> +
>> +        if (test_and_clear_bit(MPAM_ERROR_IRQ_REQUESTED, &msc->error_irq_flags)) {
>> +            if (irq_is_percpu(irq)) {
>> +                msc->reenable_error_ppi = 0;
>> +                free_percpu_irq(irq, msc->error_dev_id);
>> +            } else {
>> +                devm_free_irq(&msc->pdev->dev, irq, msc);
>> +            }
>> +        }
>> +    }
>> +    srcu_read_unlock(&mpam_srcu, idx);
>> +    cpus_read_unlock();
>> +}


James

