Return-Path: <linux-acpi+bounces-16739-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8AFB55259
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 16:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1E923B8237
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 14:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7E5305042;
	Fri, 12 Sep 2025 14:52:10 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FDF1ADC7E;
	Fri, 12 Sep 2025 14:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757688730; cv=none; b=LpLq6kXWjAaZ2Ps6sVeXZ0ti6sQlhwHgk67d04ayDtaLVzUDdLXViaEsx8RHxFJJdPIUfVYBpjIeEa+splaHe02sXV6JI4CdCH0IGScMrwWiH84C1Y+2BxS5KeHFYXbE3XPiJ8l3hEVCmaf7upP+s9xUIkQNgGVGAASSwDcIwQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757688730; c=relaxed/simple;
	bh=tx7gKECzBGglDYScYxykBugQKeJo9p/J+c6tXl7A3RQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ui5cLRWNUm8tCJNjPtdMcjsULgwjjSWnpverBCTJG3fn6CRbgHveCR1JQOGBcDtqGtI1isSKdFTXeDpUUkMlpf0vs2yQyhxlmTK4IhDjPkVvQE00KvzLjahO+eEGF10tIzBJ3uvuyvRQPtKg7ezrfU5ideBAs05acfWk9OoTDpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 93B2616A3;
	Fri, 12 Sep 2025 07:52:00 -0700 (PDT)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4F0013F694;
	Fri, 12 Sep 2025 07:52:04 -0700 (PDT)
Message-ID: <52b6bd30-55af-4916-89c0-f87446689fbe@arm.com>
Date: Fri, 12 Sep 2025 15:52:03 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/29] arm_mpam: Reset MSC controls from cpu hp
 callbacks
From: Ben Horgan <ben.horgan@arm.com>
To: James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org,
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
 <20250910204309.20751-16-james.morse@arm.com>
 <abb9b4bb-18d8-4de7-a216-3c18769f61cb@arm.com>
Content-Language: en-US
In-Reply-To: <abb9b4bb-18d8-4de7-a216-3c18769f61cb@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/12/25 12:25, Ben Horgan wrote:
> Hi James,
> 
> On 9/10/25 21:42, James Morse wrote:
>> When a CPU comes online, it may bring a newly accessible MSC with
>> it. Only the default partid has its value reset by hardware, and
>> even then the MSC might not have been reset since its config was
>> previously dirtyied. e.g. Kexec.
>>
>> Any in-use partid must have its configuration restored, or reset.
>> In-use partids may be held in caches and evicted later.
>>
>> MSC are also reset when CPUs are taken offline to cover cases where
>> firmware doesn't reset the MSC over reboot using UEFI, or kexec
>> where there is no firmware involvement.
>>
>> If the configuration for a RIS has not been touched since it was
>> brought online, it does not need resetting again.
>>
>> To reset, write the maximum values for all discovered controls.
>>
>> CC: Rohit Mathew <Rohit.Mathew@arm.com>
>> Signed-off-by: James Morse <james.morse@arm.com>
>> ---
>> Changes since RFC:
>>  * Last bitmap write will always be non-zero.
>>  * Dropped READ_ONCE() - teh value can no longer change.
>>  * Write 0 to proporitional stride, remove the bwa_fract variable.
>>  * Removed nested srcu lock, the assert should cover it.
>> ---
>>  drivers/resctrl/mpam_devices.c  | 117 ++++++++++++++++++++++++++++++++
>>  drivers/resctrl/mpam_internal.h |   8 +++
>>  2 files changed, 125 insertions(+)
>>
>> +
>> +static void mpam_reset_msc(struct mpam_msc *msc, bool online)
>> +{
>> +	struct mpam_msc_ris *ris;
>> +
>> +	mpam_assert_srcu_read_lock_held();
> 
> Unneeded? Checked in list_for_each_entry_srcu().> +

If you do get rid of this then that leaves one use of the helper,
mpam_assert_srcu_read_lock_held(), and so the helper could go.

> Thanks,
> 
> Ben
> 
> 

Thanks,

Ben


