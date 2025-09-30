Return-Path: <linux-acpi+bounces-17457-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3602EBAE215
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Sep 2025 19:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2D271C0FCD
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Sep 2025 17:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80CC530AD1B;
	Tue, 30 Sep 2025 17:06:30 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA6A30AD05;
	Tue, 30 Sep 2025 17:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759251990; cv=none; b=Jq+JpF2lctrYB+V4pJXOJ8L8Z8UfmbZm3djL0TETL97oWzUMA243aZndjZWNThYNpaa+JB8a1YKvaX5/tnT13qpO7zdUzoOlF6PmnFOaCS95UTr2b+QMSdpkgzuUs//yBaGZ1dSdFFvP4wu5sWyoP9XJljiAElgYcLA+fTaJImQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759251990; c=relaxed/simple;
	bh=dxCbi5pelgO5PBkZQgjKIlz4PLLOs+UV27mWOnubvY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lj4RcAa+bud10drkWetLHFRPbu2N9QgUPuHkUtgdlyPe/HIqSzvZxJ25XIXwAV66RQ8Sm4scuKIBNVgae3Vcy4gckxR1nEsaSvDbdyAtCHRtkCQYlmO3RGpWHZn7icEYYt03tSTcqixYQPeIAMB68NVcgSUziik9JZyzGWAP4sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD4F812FC;
	Tue, 30 Sep 2025 10:06:19 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 08F273F59E;
	Tue, 30 Sep 2025 10:06:21 -0700 (PDT)
Message-ID: <eea8e8c5-d9da-43cc-914b-bba6e59b6e8f@arm.com>
Date: Tue, 30 Sep 2025 18:06:20 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/29] arm_mpam: Extend reset logic to allow devices to
 be reset any time
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
 <20250910204309.20751-18-james.morse@arm.com>
 <20250912130216.00006d92@huawei.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <20250912130216.00006d92@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jonathan,

On 12/09/2025 13:02, Jonathan Cameron wrote:
> On Wed, 10 Sep 2025 20:42:57 +0000
> James Morse <james.morse@arm.com> wrote:
> 
>> cpuhp callbacks aren't the only time the MSC configuration may need to
>> be reset. Resctrl has an API call to reset a class.
>> If an MPAM error interrupt arrives it indicates the driver has
>> misprogrammed an MSC. The safest thing to do is reset all the MSCs
>> and disable MPAM.
>>
>> Add a helper to reset RIS via their class. Call this from mpam_disable(),
>> which can be scheduled from the error interrupt handler.

>> Changes since v1:
>>  * Use guard macro for srcu.
> 
> I'm not seeing a strong reason for doing this for the case here and not
> for cases in earlier patches like in mpam_cpu_online() 

I just missed them...


> I'm a fan of using
> these broadly in a given code base, so would guard(srcu) in those earlier patches
> as well.

I've done the online/offline - I'll take another pass through them.


> Anyhow, one other trivial thing inline that you can ignore or not as you wish.
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

Thanks!

>> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
>> index e7faf453b5d7..a9d3c4b09976 100644
>> --- a/drivers/resctrl/mpam_devices.c
>> +++ b/drivers/resctrl/mpam_devices.c

>> @@ -1340,8 +1338,56 @@ static void mpam_enable_once(void)
>> +static void mpam_reset_component_locked(struct mpam_component *comp)
>> +{
>> +	struct mpam_msc *msc;
>> +	struct mpam_vmsc *vmsc;
>> +	struct mpam_msc_ris *ris;
>> +
>> +	lockdep_assert_cpus_held();
>> +
>> +	guard(srcu)(&mpam_srcu);
>> +	list_for_each_entry_srcu(vmsc, &comp->vmsc, comp_list,
>> +				 srcu_read_lock_held(&mpam_srcu)) {
>> +		msc = vmsc->msc;
> 
> Might be worth reducing scope of msc and ris

Sure,


Thanks,

James

