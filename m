Return-Path: <linux-acpi+bounces-18818-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CCEABC53CFD
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Nov 2025 18:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0DFD354310D
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Nov 2025 17:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BDA3451C7;
	Wed, 12 Nov 2025 17:21:16 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440F53446AA;
	Wed, 12 Nov 2025 17:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762968076; cv=none; b=I0d3at1HzwOCLAexyNAGqRPNfy554tukXgkY+dRJRhw8PYLdIcB8g73Ip6CNxShpKROETRpeMcVvWeKW/1XUW6t+ynC4RVBQRcXlUvClz4d8n+1Rjcwbo3VTBKZQ67TanPOcG3r+CB0t3GgIwaCjlM1Pt1N/JkXnRHs/ui0GzyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762968076; c=relaxed/simple;
	bh=8KTlR3+G/KRddrmRdJEIaKZw3jPDeR/xXj2CzrP5esA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ULb8gyem3JPUNoV/r5ttUXRxvv+YkNHzblhcgK268NmkVNDdb0jVKbO9k65lfQG4U2ZnO+s8NBiXv/ftibNnljovo28kcufIYKIb3zO2pEOioDRHHLm4cXd1GWt/cXBb+o6whMk6n5bMKQFKTlgWR93/6VyO1vM2yer6BIDDBgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 715731515;
	Wed, 12 Nov 2025 09:21:05 -0800 (PST)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D85D3F66E;
	Wed, 12 Nov 2025 09:21:08 -0800 (PST)
Message-ID: <4d68d1b7-e3c9-4692-aba8-4361156e8b80@arm.com>
Date: Wed, 12 Nov 2025 17:21:07 +0000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/33] arm_mpam: Add the class and component structures
 for firmware described ris
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: james.morse@arm.com, amitsinght@marvell.com, baisheng.gao@unisoc.com,
 baolin.wang@linux.alibaba.com, bobo.shaobowang@huawei.com,
 carl@os.amperecomputing.com, catalin.marinas@arm.com, dakr@kernel.org,
 dave.martin@arm.com, david@redhat.com, dfustini@baylibre.com,
 fenghuay@nvidia.com, gregkh@linuxfoundation.org, gshan@redhat.com,
 guohanjun@huawei.com, jeremy.linton@arm.com, kobak@nvidia.com,
 lcherian@marvell.com, lenb@kernel.org, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 lpieralisi@kernel.org, peternewman@google.com, quic_jiles@quicinc.com,
 rafael@kernel.org, robh@kernel.org, rohit.mathew@arm.com,
 scott@os.amperecomputing.com, sdonthineni@nvidia.com, sudeep.holla@arm.com,
 tan.shaopeng@fujitsu.com, will@kernel.org, xhao@linux.alibaba.com,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
References: <20251107123450.664001-1-ben.horgan@arm.com>
 <20251107123450.664001-12-ben.horgan@arm.com>
 <20251110171041.00000a0d@huawei.com>
From: Ben Horgan <ben.horgan@arm.com>
Content-Language: en-US
In-Reply-To: <20251110171041.00000a0d@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jonathan,

On 11/10/25 17:10, Jonathan Cameron wrote:
> On Fri,  7 Nov 2025 12:34:28 +0000
> Ben Horgan <ben.horgan@arm.com> wrote:
> 
>> From: James Morse <james.morse@arm.com>
>>
>> An MSC is a container of resources, each identified by their RIS index.
>> Some RIS are described by firmware to provide their position in the system.
>> Others are discovered when the driver probes the hardware.
>>
>> To configure a resource it needs to be found by its class, e.g. 'L2'.
>> There are two kinds of grouping, a class is a set of components, which
>> are visible to user-space as there are likely to be multiple instances
>> of the L2 cache. (e.g. one per cluster or package)
>>
>> Add support for creating and destroying structures to allow a hierarchy
>> of resources to be created.
>>
>> CC: Ben Horgan <ben.horgan@arm.com>
> Hi Ben,
> 
> Remember to clear out CC'ing yourself.
> 
>> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
>> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
>> Tested-by: Peter Newman <peternewman@google.com>
>> Signed-off-by: James Morse <james.morse@arm.com>
>> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
>> ---
>> Changes since v3:
>> Jonathan:
>> Code reordering.
> 
> I'm guessing I may have sent things in a slightly less than ideal directly.
> 
> Why can't we have ordering as follows (with no forwards declarations)
> 
> mpam_class_alloc()
> mpam_class_destroy()
> //maybe other mpam_class stuff here
> mpam_component_alloc()
> mpam_component_destroy() - needs mpam_class_destroy()
> //maybe other mpam_component stuff here
> mpam_vmsc_alloc()
> mpam_vmsc_destroy() - needs mpam_component_destroy()
> //other mpam_vmsc here

This works and then I need to add mpam_ris_get_affinity() as
mpam_ris_create_locked() depends on it.

I also add the helper functions it depends on
mpam_get_cpumask_from_cache_id() and get_cpumask_from_node_id().

> mpam_ris_create_locked() - needs all the destroys.
> mpam_ris_destroy() - needs mpam vmsc_destroy()

> 
> I may well have missed a more complex dependency chain.
> 
> Other than that, LGTM. Given any change in ordering can be trivially verified
> by building it and Gavin's comments seem simple to resolve.
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

Thanks,

Ben


