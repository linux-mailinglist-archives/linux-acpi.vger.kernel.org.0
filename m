Return-Path: <linux-acpi+bounces-16543-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B93BCB50385
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Sep 2025 18:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B02BD1632CE
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Sep 2025 16:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C99536CC83;
	Tue,  9 Sep 2025 16:57:04 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DEC535CECD;
	Tue,  9 Sep 2025 16:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757437024; cv=none; b=j9YikYjYG4NVKPk9+M6TWSnV6FRwxyu3YGXRaipdff773GMLRHvbqSlBUYFCSmmrcZRk9q7oKtmAdi3U6Sr13EwCnqbEWH3QPmeImSXp+ivBs7wxTqBmJ2thXeplUntL7kBsrjYNmuSZkb3uLm9zgLGPf3oeDWA3bj4DfcBaRqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757437024; c=relaxed/simple;
	bh=nSQPNZ4WUUm7de/wm1BZUW50VLYHe6WrJNLGHffxzpw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G6bSSk11CBgKqqS+FubLDUKhZJFqaG/8sS4yX0Q3umSnZNSiZEGoTpbHNpOARJFmY+i5fXHCa69opkqt/NRyDKrqqpmj+/OGau6zOhYl0Ib4WbR8VZLi9ww/fW9KToPHeVcARPfzVgcafm67qWwt8t/jW13LfsgGmBwWo6p/6Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 98DF41FCD;
	Tue,  9 Sep 2025 09:56:53 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 718753F694;
	Tue,  9 Sep 2025 09:56:55 -0700 (PDT)
Message-ID: <cbc2a9e2-4919-4ade-9d1b-afd0464f43bf@arm.com>
Date: Tue, 9 Sep 2025 17:56:52 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/33] arm_mpam: Probe MSCs to find the supported
 partid/pmg values
To: Ben Horgan <ben.horgan@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
 devicetree@vger.kernel.org
Cc: shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, fenghuay@nvidia.com,
 baisheng.gao@unisoc.com, Jonathan Cameron <jonathan.cameron@huawei.com>,
 Rob Herring <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
 Rafael Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>
References: <20250822153048.2287-1-james.morse@arm.com>
 <20250822153048.2287-16-james.morse@arm.com>
 <507919cd-a6d0-42b7-8721-d35f232edfa5@arm.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <507919cd-a6d0-42b7-8721-d35f232edfa5@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ben,

On 28/08/2025 14:12, Ben Horgan wrote:
> On 8/22/25 16:29, James Morse wrote:
>> CPUs can generate traffic with a range of PARTID and PMG values,
>> but each MSC may have its own maximum size for these fields.
>> Before MPAM can be used, the driver needs to probe each RIS on
>> each MSC, to find the system-wide smallest value that can be used.
>>
>> While doing this, RIS entries that firmware didn't describe are create
>> under MPAM_CLASS_UNKNOWN.
>>
>> While we're here, implement the mpam_register_requestor() call
>> for the arch code to register the CPU limits. Future callers of this
>> will tell us about the SMMU and ITS.

>> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
>> index 9d6516f98acf..012e09e80300 100644
>> --- a/drivers/resctrl/mpam_devices.c
>> +++ b/drivers/resctrl/mpam_devices.c
>> @@ -106,6 +116,74 @@ static inline u32 _mpam_read_partsel_reg(struct mpam_msc *msc, u16 reg)

>> +int mpam_register_requestor(u16 partid_max, u8 pmg_max)
>> +{
>> +	int err = 0;
>> +
>> +	lockdep_assert_irqs_enabled();
>> +
>> +	spin_lock(&partid_max_lock);
>> +	if (!partid_max_init) {
>> +		mpam_partid_max = partid_max;
>> +		mpam_pmg_max = pmg_max;
>> +		partid_max_init = true;
>> +	} else if (!partid_max_published) {
>> +		mpam_partid_max = min(mpam_partid_max, partid_max);
>> +		mpam_pmg_max = min(mpam_pmg_max, pmg_max);

> Do we really need to reduce these maximum here? If, say, we add an SMMU
> requester which supports fewer partids than the cpus don't we want to be
> able to carry on using those partids from the cpus. In this case the
> SMMU requestor can, without risk of error interrupts, just use all the
> partids it supports.

How would it do that?

We're probably going to expose that SMMU, or the devices behind it, via resctrl. You can
create 10 control groups in resctrl - but can't assign the SMMU/devices to the last two
because it doesn't actually support that many...


Thanks,

James

