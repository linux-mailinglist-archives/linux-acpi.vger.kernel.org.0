Return-Path: <linux-acpi+bounces-17511-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0593EBB4CF8
	for <lists+linux-acpi@lfdr.de>; Thu, 02 Oct 2025 20:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A168619E50F7
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Oct 2025 18:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824DD2773D9;
	Thu,  2 Oct 2025 18:03:18 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C83274FD0;
	Thu,  2 Oct 2025 18:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759428198; cv=none; b=MzM71wpf0iy5TVCqRcg6Vsj6y2qAQmO0PhR2MADguiWipDRSHGLXcwBY529Fpgy+9L5sVwXfos9V7OsSQf5ftwpTtYSpxSEL1B496faSuu97DX76fjxqCGiC8v3lB3M5BL6lS4DcX3YHZUDCACEHOQXbVmSFbgcV7MoRsSUrdQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759428198; c=relaxed/simple;
	bh=B5Nxhkm8uFnPxdRcvBCO85/sayA1a1izuFHO5azh7qY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P74t/vacxFG6bb/UuW9zOAJWV5SXloxbiCSZ2s8Y6mpg6omB+sLMDXnxwcFhOjRL65JSnKSFYvOAuiQDjqWnTf1OOlD3cRxx5q5FAy5Bnr7JwyPna3imVO1hDnvNlhR1ZErmthIBzFD9tgCJiBt8NnnQAbjf3ub44np68v/8oVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 23F661CE0;
	Thu,  2 Oct 2025 11:03:08 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 24C923F66E;
	Thu,  2 Oct 2025 11:03:11 -0700 (PDT)
Message-ID: <3f0894fc-adf8-4465-b1f8-55bb5eab7c5c@arm.com>
Date: Thu, 2 Oct 2025 19:03:10 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 18/29] arm_mpam: Register and enable IRQs
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
 <20250910204309.20751-19-james.morse@arm.com>
 <487a736c-27c8-427c-97d5-31fd2d97e919@arm.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <487a736c-27c8-427c-97d5-31fd2d97e919@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ben,

On 12/09/2025 15:40, Ben Horgan wrote:
> On 9/10/25 21:42, James Morse wrote:
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


>> +static int __setup_ppi(struct mpam_msc *msc)
>> +{
>> +	int cpu;
>> +	struct device *dev = &msc->pdev->dev;
>> +
>> +	msc->error_dev_id = alloc_percpu(struct mpam_msc *);
>> +	if (!msc->error_dev_id)
>> +		return -ENOMEM;
>> +
>> +	for_each_cpu(cpu, &msc->accessibility) {
>> +		struct mpam_msc *empty = *per_cpu_ptr(msc->error_dev_id, cpu);
>> +
>> +		if (empty) {
> 
> I'm confused about how this if conditioned can be satisfied. Isn't the
> alloc clearing msc->error_dev_id for each cpu and then it's only getting
> set for each cpu later in the iteration.

Yes, you're right.

I think this was part of the support for PPI partitions, where multiple partitions would
get set up here. This was a sanity check that they didn't overlap...


I've ripped that out.


>> +			dev_err_once(dev, "MSC shares PPI with %s!\n",
>> +				     dev_name(&empty->pdev->dev));
>> +			return -EBUSY;
>> +		}
>> +		*per_cpu_ptr(msc->error_dev_id, cpu) = msc;
>> +	}
>> +
>> +	return 0;
>> +}

Thanks,

James

