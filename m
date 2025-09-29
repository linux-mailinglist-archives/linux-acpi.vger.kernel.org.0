Return-Path: <linux-acpi+bounces-17424-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59ACFBAA359
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Sep 2025 19:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4B167A1F01
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Sep 2025 17:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9666220F34;
	Mon, 29 Sep 2025 17:44:44 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FFB220687;
	Mon, 29 Sep 2025 17:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759167884; cv=none; b=SNOn3ns6fVXP7Khh3PrQbpE2aQFTzwUDUcwOkTehoFlJ9B2JbXkbj3aJHXuTAjZPQfr2hV6AnJJdBP2PvB0OVLGMUnapbiA3Qa+u4bWvj7cdwQfeN0KJUeJ7tlEUR1o+8mLzHLavOTuwX/vS/n2vHjC14qvY7LEXfHSaON+sszE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759167884; c=relaxed/simple;
	bh=rtc9wYYiql/zxa6Fl+MwsGqtAZBHcTXLvHbZteu4+jE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HylyiBv67YMCS0Iu4nOAwYxzt2ieZxs3Gwc8pY9cER6ZSaM8/joX7n6HmG4WF5lBxhhy698eWgHoLLZMSCuYnW3Yb6IRkUACThV3a2cqOIiL/WqKjGoQJIsS8ERPGM2Y+pv5sN4+cw5wdWGJ5KE+bhUtL8HQr/jKlQn93JQtFQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F47C150C;
	Mon, 29 Sep 2025 10:44:34 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B1C543F59E;
	Mon, 29 Sep 2025 10:44:36 -0700 (PDT)
Message-ID: <628b42e2-6605-4f19-8ee8-e1c8707a6f96@arm.com>
Date: Mon, 29 Sep 2025 18:44:35 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/29] arm_mpam: Probe hardware to find the supported
 partid/pmg values
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-acpi@vger.kernel.org,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Dave Martin <dave.martin@arm.com>,
 Koba Ko <kobak@nvidia.com>, Shanker Donthineni <sdonthineni@nvidia.com>,
 fenghuay@nvidia.com, baisheng.gao@unisoc.com, Rob Herring <robh@kernel.org>,
 Rohit Mathew <rohit.mathew@arm.com>, Rafael Wysocki <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>
References: <20250910204309.20751-1-james.morse@arm.com>
 <20250910204309.20751-12-james.morse@arm.com>
 <20250911161850.00005667@huawei.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <20250911161850.00005667@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/09/2025 16:18, Jonathan Cameron wrote:
> On Wed, 10 Sep 2025 20:42:51 +0000
> James Morse <james.morse@arm.com> wrote:
> 
>> CPUs can generate traffic with a range of PARTID and PMG values,
>> but each MSC may also have its own maximum size for these fields.
>> Before MPAM can be used, the driver needs to probe each RIS on
>> each MSC, to find the system-wide smallest value that can be used.
>> The limits from requestors (e.g. CPUs) also need taking into account.
>>
>> While doing this, RIS entries that firmware didn't describe are created
>> under MPAM_CLASS_UNKNOWN.
>>
>> While we're here, implement the mpam_register_requestor() call
>> for the arch code to register the CPU limits. Future callers of this
>> will tell us about the SMMU and ITS.
>>
>> Signed-off-by: James Morse <james.morse@arm.com>

> Trivial stuff inline.
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

Thanks!


>>  drivers/resctrl/mpam_devices.c  | 150 +++++++++++++++++++++++++++++++-
>>  drivers/resctrl/mpam_internal.h |   6 ++
>>  include/linux/arm_mpam.h        |  14 +++
>>  3 files changed, 169 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
>> index c265376d936b..24dc81c15ec8 100644
>> --- a/drivers/resctrl/mpam_devices.c
>> +++ b/drivers/resctrl/mpam_devices.c
> 
> 
>> +int mpam_register_requestor(u16 partid_max, u8 pmg_max)
>> +{
>> +	int err = 0;
>> +
>> +	spin_lock(&partid_max_lock);

> guard() perhaps so you can return early in the error pat and avoid
> need for local variable err.

Negh ... okay. I dislike the guard thing as its never clear when the lock is unlocked.
I'm not a fan of spooky action at a distance!


>> +	if (!partid_max_init) {
>> +		mpam_partid_max = partid_max;
>> +		mpam_pmg_max = pmg_max;
>> +		partid_max_init = true;
>> +	} else if (!partid_max_published) {
>> +		mpam_partid_max = min(mpam_partid_max, partid_max);
>> +		mpam_pmg_max = min(mpam_pmg_max, pmg_max);
>> +	} else {
>> +		/* New requestors can't lower the values */
>> +		if (partid_max < mpam_partid_max || pmg_max < mpam_pmg_max)
>> +			err = -EBUSY;
>> +	}
>> +	spin_unlock(&partid_max_lock);
>> +
>> +	return err;
>> +}
>> +EXPORT_SYMBOL(mpam_register_requestor);
> 
>> @@ -470,9 +547,37 @@ int mpam_ris_create(struct mpam_msc *msc, u8 ris_idx,
>> +static struct mpam_msc_ris *mpam_get_or_create_ris(struct mpam_msc *msc,
>> +						   u8 ris_idx)
>> +{
>> +	int err;
>> +	struct mpam_msc_ris *ris, *found = ERR_PTR(-ENOENT);
>> +
>> +	lockdep_assert_held(&mpam_list_lock);
>> +
>> +	if (!test_bit(ris_idx, &msc->ris_idxs)) {
>> +		err = mpam_ris_create_locked(msc, ris_idx, MPAM_CLASS_UNKNOWN,
>> +					     0, 0);
>> +		if (err)
>> +			return ERR_PTR(err);
>> +	}
>> +
>> +	list_for_each_entry(ris, &msc->ris, msc_list) {
>> +		if (ris->ris_idx == ris_idx) {
>> +			found = ris;
> I'd return ris;
> 
> Then can do return ERR_PTR(-ENOENT) below and not bother with found.
> 
> Ignore if this gets more complex later.

Thank - this is another relic of more complex locking...
Fixed as you suggested.


>> +			break;
>> +		}
>> +	}
>> +
>> +	return found;
>> +}
> 
>> @@ -675,9 +813,18 @@ static struct platform_driver mpam_msc_driver = {
>>  
>>  static void mpam_enable_once(void)
>>  {
>> +	/*
>> +	 * Once the cpuhp callbacks have been changed, mpam_partid_max can no
>> +	 * longer change.
>> +	 */
>> +	spin_lock(&partid_max_lock);
>> +	partid_max_published = true;
>> +	spin_unlock(&partid_max_lock);
>> +
>>  	mpam_register_cpuhp_callbacks(mpam_cpu_online, mpam_cpu_offline);
>>  
>> -	pr_info("MPAM enabled\n");
>> +	printk(KERN_INFO "MPAM enabled with %u PARTIDs and %u PMGs\n",
>> +	       mpam_partid_max + 1, mpam_pmg_max + 1);

> Not sure why pr_info before and printk now.  

That looks like a conflict gone wrong!
Fixed.


Thanks,

James


