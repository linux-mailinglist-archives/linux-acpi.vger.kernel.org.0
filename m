Return-Path: <linux-acpi+bounces-14703-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16596AEA42E
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 19:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0F5F1C447F1
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 17:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B8F2E6116;
	Thu, 26 Jun 2025 17:12:03 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F3E214236
	for <linux-acpi@vger.kernel.org>; Thu, 26 Jun 2025 17:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750957923; cv=none; b=PCHluOA2AEPRAAWKQ3qO/VsD88IeXb0sUcN3XZaZITZsqGXWBcPr4afac1AtRn29uILX2Sm4a7vMKytV33c8YQHVmcuHv7v/+VsxqQfadIoFUqL8SP48Es9OwxtymB170WtFf4Mzyp3UPK50DxqgzNTairGTbD5PEftKt0dPbCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750957923; c=relaxed/simple;
	bh=SeByJPMxd2PObe6DIaVG02+MuR7EuZuaFbriaqxXuzc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CNWQl9uaNj1Rf6nVMCYhBY/Q85++o3GaUirDQZhqjGT4KpY6yq6KcNcOSzxU8wGnZfeeLVpFBdVYsAVdz1YlWqWNsov/qfRn6mJl8b+WeBjRnY/wvV0wkan+rW6dvhHsiQet7vnXGyIbD8gFMXEO94vQUVOStLGCyTcbI6btFpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C73EF1758;
	Thu, 26 Jun 2025 10:11:43 -0700 (PDT)
Received: from [10.1.197.43] (eglon.cambridge.arm.com [10.1.197.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9592B3F762;
	Thu, 26 Jun 2025 10:12:00 -0700 (PDT)
Message-ID: <0a659a48-fb39-4966-afb3-01db796919a8@arm.com>
Date: Thu, 26 Jun 2025 18:11:58 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] ACPI / PPTT: Add a helper to fill a cpumask from a
 processor container
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-acpi@vger.kernel.org, Rafael Wysocki <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, jeremy.linton@arm.com
References: <20250612171336.4858-1-james.morse@arm.com>
 <20250612171336.4858-2-james.morse@arm.com>
 <20250623-optimistic-chicken-of-merriment-fbefe3@sudeepholla>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <20250623-optimistic-chicken-of-merriment-fbefe3@sudeepholla>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Sudeep,

On 23/06/2025 14:21, Sudeep Holla wrote:
> On Thu, Jun 12, 2025 at 05:13:33PM +0000, James Morse wrote:
>> The PPTT describes CPUs and caches, as well as processor containers.
>> The ACPI table for MPAM describes the set of CPUs that can access an MSC
>> with the UID of a processor container.
>>
>> Add a helper to find the processor container by its id, then walk
>> the possible CPUs to fill a cpumask with the CPUs that have this
>> processor container as a parent.

>> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
>> index 54676e3d82dd..aaf9b5a26d07 100644
>> --- a/drivers/acpi/pptt.c
>> +++ b/drivers/acpi/pptt.c
>> +
>> +/**
>> + * acpi_pptt_get_cpus_from_container() - Populate a cpumask with all CPUs in a
>> + *                                       processor containers
>> + * @acpi_cpu_id:	The UID of the processor container.
>> + * @cpus		The resulting CPU mask.
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
>> + */
>> +int acpi_pptt_get_cpus_from_container(u32 acpi_cpu_id, cpumask_t *cpus)
>> +{

> Just noticed now that it is not used anywhere in the series. Can this be added
> along with the user later instead ?

T'was mentioned in the cover letter - I'll roll these into the series with the driver -
which will unfortunately give you more email. There is another pre-requisite series, which
made posting it like this was going to be easier for reviewers.

Do you have an opinion on how this should get merged?
The MPAM driver may need to go via tip if it has dependencies on resctrl, but also arm64
because it touches the arch code's __cpu_switch_to() path. Adding acpi and potentially
Greg's tree for cacheinfo makes this more complicated. I will probably defer the restrl
parts of the MPAM driver to remove one of these.


Thanks,

James

