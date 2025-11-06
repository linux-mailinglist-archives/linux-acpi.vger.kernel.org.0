Return-Path: <linux-acpi+bounces-18597-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 98830C3C6FE
	for <lists+linux-acpi@lfdr.de>; Thu, 06 Nov 2025 17:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 085CE5055A7
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Nov 2025 16:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69BD83557FE;
	Thu,  6 Nov 2025 16:18:25 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF793557F4;
	Thu,  6 Nov 2025 16:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762445905; cv=none; b=EZ7dpcbmLvUQtqiNXoNwrOfaf2i+IWXWf7WWtilN8o3V1KlzTJ8ljYrycL/PXjssxMKe91fghFtr8x5oeBFQsgs+FFPTdmZVbFC1SnWKYvK+JpeUMSQ6X4C2NhAkP1eW+dmHP51yJX6Zf3bloP0HHVe4fIP3wHFOdWyefgy9mFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762445905; c=relaxed/simple;
	bh=RmalfJvaE1QbTu2NHfKlbVpyEIq5qGANdoiyXzbE0KY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IO7hyl6kdXC4ocUSCI3S7b95o6U//GlR99Kkje80wxQDZSUzOzDEuytL0Xr/LExAbnjzHRqhDY2/qzHQNfcMkcwdGbx5REzX3UMjcCXbcbjy5/INP/11r8Q32uTjh+/feSk4FDgAOJ8CMSS19Qh+VDzW18i5StHxoMmx6JK5/tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1EC8F12FC;
	Thu,  6 Nov 2025 08:18:15 -0800 (PST)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4DC073F66E;
	Thu,  6 Nov 2025 08:18:18 -0800 (PST)
Message-ID: <cc81b3f4-5736-4c11-894a-b37cf1c7c0a8@arm.com>
Date: Thu, 6 Nov 2025 16:18:16 +0000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/29] ACPI / PPTT: Add a helper to fill a cpumask from
 a cache_id
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
 Jeremy Linton <jeremy.linton@arm.com>
Cc: James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
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
 Danilo Krummrich <dakr@kernel.org>, Gavin Shan <gshan@redhat.com>
References: <20251017185645.26604-1-james.morse@arm.com>
 <20251017185645.26604-5-james.morse@arm.com>
 <50a8cc38-810b-4bea-9a73-2463a6160b9f@arm.com>
 <20251024152256.00003f8e@huawei.com>
From: Ben Horgan <ben.horgan@arm.com>
Content-Language: en-US
In-Reply-To: <20251024152256.00003f8e@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jonathan, Jeremy,

(Replying for James as I'll post the next version of this series.)

On 10/24/25 15:22, Jonathan Cameron wrote:
> On Wed, 22 Oct 2025 07:58:36 -0500
> Jeremy Linton <jeremy.linton@arm.com> wrote:
> 
>> Hi,
>>
>> This is largely looking pretty solid, but..
>>
>>
>> On 10/17/25 1:56 PM, James Morse wrote:
>>> MPAM identifies CPUs by the cache_id in the PPTT cache structure.
>>>
>>> The driver needs to know which CPUs are associated with the cache.
>>> The CPUs may not all be online, so cacheinfo does not have the
>>> information.
>>>
>>> Add a helper to pull this information out of the PPTT.
>>>
>>> CC: Rohit Mathew <Rohit.Mathew@arm.com>
>>> Signed-off-by: James Morse <james.morse@arm.com>
>>> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
>>> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
>>> ---
[...]
>>
>> Is the core acpi definition in actbl2.h correct? Shouldn't it be 
>> something along the lines of:
>>
>> struct acpi_pptt_cache_v1 {
>>   struct acpi_subtable_header header;
>>   u16 reservedd;
>>   u32 flags;
>>   u32 next_level_of_cache;
>>   u32 size;
>>   u32 number_of_sets;
>>   u8 associativity;
>>   u8 attributes;
>>   u16 lines_size;
>>   u32 cache_id;
>> }
>>
>>
>> Then that solves the detection of the additional field problem correctly 
>> because the length (24 vs 28) of the subtable then tells you which 
>> version your dealing with. (and goes back to why much of this is coded 
>> to use ACPI_ADD_PTR rather than structure+ logic.)
>>
> 
> Do we want to deal with arguing the change in ACPICA? 
> I fully agree that it would be much nicer if that didn't use this weird
> bits of structures approach :(  

For the moment I've added:

struct acpi_pptt_cache_v1_full {
	struct acpi_pptt_cache		f;
	struct acpi_pptt_cache_v1	extra;
} __packed;

in drivers/acpi/pptt.c
A stop gap but the length can be used to check for field presence and
you can avoid some ACPI_ADD_PTR usages.

> 
> https://github.com/acpica/acpica/blob/master/source/include/actbl2.h#L3497
> is where this is coming from.
> 
> Maybe can do it in parallel. Rafael, what do you think is best way forwards
> with this?
> 
> Jonathan
Thanks,

Ben


