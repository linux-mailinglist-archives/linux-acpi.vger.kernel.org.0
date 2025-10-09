Return-Path: <linux-acpi+bounces-17693-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85CF5BCA6C0
	for <lists+linux-acpi@lfdr.de>; Thu, 09 Oct 2025 19:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A9124816D0
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Oct 2025 17:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D62424678D;
	Thu,  9 Oct 2025 17:49:09 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2DB1E2614;
	Thu,  9 Oct 2025 17:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760032149; cv=none; b=DtGgHWlwDHVC15IoWgv5/+h9S7tSDMfMNfD7WalJoop8GQXBnhF6eNFq8oWnBMFCz6RmF1jmKYiblT0ZPTzB8J59zOwEIEBOvALRBvOs4Iz0VoUbrUFfCBuiILXONRnE7f9YopPNBjQwnt/GGTk1K0hrZ4yYCo17auesiP5th8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760032149; c=relaxed/simple;
	bh=YvB8bQMXk5P5GRPATdHPIj8bOM795l0LYG++eYyqFig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XpO0S3hj5f+lR4lZGDJQTPVPILCVKEyOMm5lR6umPqyM4KcOTG4u8DllfXTr/GObMkvua7044o+7i7Hcbv/o8gray3pHEZaI6y+3v/PIxJHUUPFuKqWOhBWao1M3T4887z3D/l55/RJQYfGjgUSGMMY5JciO39tIAKfif2M9pEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E0DA51762;
	Thu,  9 Oct 2025 10:48:56 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D06373F66E;
	Thu,  9 Oct 2025 10:48:59 -0700 (PDT)
Message-ID: <2e9ba7d2-1ecb-4573-87ec-812c7bac89e4@arm.com>
Date: Thu, 9 Oct 2025 18:48:49 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 23/29] arm_mpam: Add mpam_msmon_read() to read monitor
 value
To: Fenghua Yu <fenghuay@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
Cc: D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
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
 <20250910204309.20751-24-james.morse@arm.com>
 <74afb5d1-850c-4e30-a9bb-9903a5193280@nvidia.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <74afb5d1-850c-4e30-a9bb-9903a5193280@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Fenghua,

On 25/09/2025 03:30, Fenghua Yu wrote:
> On 9/10/25 13:43, James Morse wrote:
>> Reading a monitor involves configuring what you want to monitor, and
>> reading the value. Components made up of multiple MSC may need values
>> from each MSC. MSCs may take time to configure, returning 'not ready'.
>> The maximum 'not ready' time should have been provided by firmware.
>>
>> Add mpam_msmon_read() to hide all this. If (one of) the MSC returns
>> not ready, then wait the full timeout value before trying again.

>> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
>> index cf190f896de1..1543c33c5d6a 100644
>> --- a/drivers/resctrl/mpam_devices.c
>> +++ b/drivers/resctrl/mpam_devices.c
>> @@ -898,6 +898,232 @@ static int mpam_msc_hw_probe(struct mpam_msc *msc)

>> +static int _msmon_read(struct mpam_component *comp, struct mon_read *arg)
>> +{
>> +    int err, idx;

> Can err be initialized to some error code e.g. -ENODEV?

Feedback from Jonathan has led to numerous changes here.


>> +    struct mpam_msc *msc;
>> +    struct mpam_vmsc *vmsc;
>> +    struct mpam_msc_ris *ris;
>> +
>> +    idx = srcu_read_lock(&mpam_srcu);
>> +    list_for_each_entry_rcu(vmsc, &comp->vmsc, comp_list) {
>> +        msc = vmsc->msc;
>> +
>> +        list_for_each_entry_rcu(ris, &vmsc->ris, vmsc_list) {
>> +            arg->ris = ris;
>> +
>> +            err = smp_call_function_any(&msc->accessibility,
>> +                            __ris_msmon_read, arg,
>> +                            true);
>> +            if (!err && arg->err)
>> +                err = arg->err;
>> +            if (err)
>> +                break;
>> +        }
>> +        if (err)
>> +            break;
>> +    }
> 
> comp->vmsc or vmsc->ris usually are not empty. But in some condition, they can be empty.

Really? There is no call to create a VMSC - only to create a RIS with a set of ids. If you
provide an ID for a VMSC that doesn't exist yet - it gets created for the RIS to be added to.

There was some defensive programming earlier, (and a comment that said it wasn't
possible). That was some left over debug.


> In that case, uninitialized err value may cause unexpected behavior for the callers.
> 
> So it's better to initialize err to avoid any complexity.

Not complexity - the risk is returning an uninitialised value.

After Jonathan's feedback, and my guess at to what Zheng is seeing, it looks like this:
----------%<----------
static int _msmon_read(struct mpam_component *comp, struct mon_read *arg)
{
	int err,  any_err = 0;
	struct mpam_vmsc *vmsc;

	guard(srcu)(&mpam_srcu);
	list_for_each_entry_srcu(vmsc, &comp->vmsc, comp_list,
				 srcu_read_lock_held(&mpam_srcu)) {
		struct mpam_msc *msc = vmsc->msc;
		struct mpam_msc_ris *ris;

		list_for_each_entry_srcu(ris, &vmsc->ris, vmsc_list,
					 srcu_read_lock_held(&mpam_srcu)) {
			arg->ris = ris;

			err = smp_call_function_any(&msc->accessibility,
						    __ris_msmon_read, arg,
						    true);
			if (!err && arg->err)
				err = arg->err;

			/*
			 * Save one error to be returned to the caller, but
			 * keep reading counters so that get reprogrammed. On
			 * platforms with NRDY this lets us wait once.
			 */
			if (err)
				any_err = err;
		}
	}

	return any_err;
}
----------%<----------


>> +    srcu_read_unlock(&mpam_srcu, idx);
>> +
>> +    return err;
>> +}


Thanks,

James

