Return-Path: <linux-acpi+bounces-17724-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE01BCDFE8
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Oct 2025 18:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 215601A6471D
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Oct 2025 16:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CA72FC024;
	Fri, 10 Oct 2025 16:54:37 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC592FB99D;
	Fri, 10 Oct 2025 16:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760115276; cv=none; b=CwMKjD1SBON/FZSnQ3+QBM1WltWJ/8/hiCaYgHTjiGr89zURM3bnjmJfDD+lvsWs2wMvoZJBX7mhk3D789iwHS99Kfy6dpsvcifUgJ2SIaNbUzZFSDfapsx8lIfcoxLXZUzGpdWchYNr/464nxilL70EZglDldSOwVVTe5pEv9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760115276; c=relaxed/simple;
	bh=6yF72+wuOjRJokJK1hGKbPF/1SHbTsmzEdv0rbRr2V4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aeBIdgiPRVacPrJpT/AuMrXmNIxdirPH5cxkQ/8Oaw1lnD7hRlslc1eRxzULF2REp1oHiyHSHn9ifjruvj6TqjfApNuYN2pi5GdjGkPCQWRyJ8iaKKxi7udqVhVjUCn8d8JxaR6/RsnQ8fGd2qs4/yPOu3uehqrTW2Y7S2jjfwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3AEDA153B;
	Fri, 10 Oct 2025 09:54:27 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2D77B3F66E;
	Fri, 10 Oct 2025 09:54:22 -0700 (PDT)
Message-ID: <219dff63-11ad-4eb4-8499-2c5085181339@arm.com>
Date: Fri, 10 Oct 2025 17:54:19 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/29] ACPI / PPTT: Add a helper to fill a cpumask from
 a processor container
To: Stanimir Varbanov <svarbanov@suse.de>, linux-kernel@vger.kernel.org,
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
 <20250910204309.20751-2-james.morse@arm.com>
 <3d2252ef-92a2-4717-a472-3e5b275419ce@suse.de>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <3d2252ef-92a2-4717-a472-3e5b275419ce@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Stan,

On 25/09/2025 10:32, Stanimir Varbanov wrote:
> On 9/10/25 11:42 PM, James Morse wrote:
>> The ACPI MPAM table uses the UID of a processor container specified in
>> the PPTT to indicate the subset of CPUs and cache topology that can
>> access each MPAM System Component (MSC).
>>
>> This information is not directly useful to the kernel. The equivalent
>> cpumask is needed instead.
>>
>> Add a helper to find the processor container by its id, then walk
>> the possible CPUs to fill a cpumask with the CPUs that have this
>> processor container as a parent.

>> +
>> +/**
>> + * acpi_pptt_get_cpus_from_container() - Populate a cpumask with all CPUs in a
>> + *                                       processor container
>> + * @acpi_cpu_id:	The UID of the processor container.
>> + * @cpus:		The resulting CPU mask.
>> + *
>> + * Find the specified Processor Container, and fill @cpus with all the cpus
>> + * below it.
>> + *
>> + * Not all 'Processor' entries in the PPTT are either a CPU or a Processor
>> + * Container, they may exist purely to describe a Private resource. CPUs
>> + * have to be leaves, so a Processor Container is a non-leaf that has the
>> + * 'ACPI Processor ID valid' flag set.
>> + *
>> + * Return: 0 for a complete walk, or an error if the mask is incomplete.
> 
> Leftover, drop this.

Good spot - thanks,


James

