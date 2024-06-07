Return-Path: <linux-acpi+bounces-6262-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B028FFEF1
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Jun 2024 11:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4D611C21ECC
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Jun 2024 09:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC69B15B57B;
	Fri,  7 Jun 2024 09:10:22 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE8715B546;
	Fri,  7 Jun 2024 09:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717751422; cv=none; b=n7pwIVBrIfmEqI4vtrvGGSONW9r37fvjgs42lmcX6uKWtU7IzxWiqSm9fbP0UlI4Nx0nvAUcW/z/q0e1YrtgBsZyfUgecvGViJ1iopUH+Ynd4VmPojBP7pSiSvUaCq2OYSCnDXc+dywfeQmN/itHaizkHURjM7diXdAcUBsnhu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717751422; c=relaxed/simple;
	bh=DYpx4jfQ2pJ69pholDvW6SWXEkPz4I4Vl9+n460bUJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pi2NaIOTGSOVM18jnKstL2mrCZStHCmphlLNyWe/tbjQ8Oyo/tjgiS1s2I8vB35LnacB6lcPBQtxEbCyV//AkdwWNuyy8XlLOMZIZmJRbabQlS9ck4X6R8PYrwD2gkJmY0HNjKjtSq+V+3+iHGYk6KY/bre8GGai3xx4vlakWU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E08E82F4;
	Fri,  7 Jun 2024 02:10:44 -0700 (PDT)
Received: from [10.57.70.104] (unknown [10.57.70.104])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E3EE93F762;
	Fri,  7 Jun 2024 02:10:18 -0700 (PDT)
Message-ID: <d1ce4b09-c0ac-447e-8779-633bfb2bd8c3@arm.com>
Date: Fri, 7 Jun 2024 10:10:17 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/1] irqchip/gic-v3: Enable non-coherent
 redistributors/ITSes ACPI probing
To: Amit Singh Tomar <amitsinght@marvell.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Mark Rutland <mark.rutland@arm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
 acpica-devel@lists.linux.dev
References: <20240123110332.112797-1-lpieralisi@kernel.org>
 <20240606094238.757649-1-lpieralisi@kernel.org>
 <20240606094238.757649-2-lpieralisi@kernel.org>
 <f901fd06-3b6b-4444-a3da-2b75c59059d3@marvell.com>
 <ZmK5Ilk37GyJ4QEa@lpieralisi>
 <02dba55e-39a3-4853-ac52-834cb1c0fc7f@marvell.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <02dba55e-39a3-4853-ac52-834cb1c0fc7f@marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-06-07 8:53 am, Amit Singh Tomar wrote:
>> On Fri, Jun 07, 2024 at 12:21:54AM +0530, Amit Singh Tomar wrote:
>>
>> [...]
>>
>>>> diff --git a/drivers/acpi/processor_core.c 
>>>> b/drivers/acpi/processor_core.c
>>>> index b203cfe28550..915713c0e9b7 100644
>>>> --- a/drivers/acpi/processor_core.c
>>>> +++ b/drivers/acpi/processor_core.c
>>>> @@ -215,6 +215,21 @@ phys_cpuid_t __init acpi_map_madt_entry(u32 
>>>> acpi_id)
>>>>        return rv;
>>>>    }
>>>> +int __init acpi_get_madt_revision(void)
>>>
>>> Wondering, if we can have a generic function (acpi_get_tbl_revision) to
>>> obtain the revision number for any ACPI table, not just specific to 
>>> MADT?
>>
>> We could - I don't think there would be users other than code in this
>> patch though so I thought it would not be necessary.
>>
> 
> Right, it might not be essential now but I see that MPAM will be another 
> user of it once the MPAM patches are out.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/tree/drivers/acpi/arm64/mpam.c?h=mpam/snapshot/v6.7-rc2#n299

Not really; there's already plenty of ACPI code which checks the 
revision of a table *while* also parsing other information from it, and 
that MPAM code is doing the same. Using a standalone function to look up 
the table, check one thing and throw it away, and then immediately have 
to look it up again to do the rest would be needlessly overcomplicated.

The thing in the GIC case is that doing this semi-redundant lookup to 
re-retrieve the top-level MADT header while we're already deep into 
parsing its subtables is still the least-worst option, because the 
alternative would be invasively churning the whole common MADT 
abstraction to pass that information all the way down just for this one 
slightly niche thing.

Thanks,
Robin.

