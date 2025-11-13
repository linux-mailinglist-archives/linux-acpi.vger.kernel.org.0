Return-Path: <linux-acpi+bounces-18866-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DF9C57F2B
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Nov 2025 15:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B717C4E208F
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Nov 2025 14:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910062874E1;
	Thu, 13 Nov 2025 14:24:10 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7620A1DF75C;
	Thu, 13 Nov 2025 14:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763043850; cv=none; b=Xs+0os+g9+kKt8s8j66VzmthWq/ILNBlwAWUCLid22MqguHtXgvZYYHs6E7wvJiZ5A2D9+QYcMYYjd1XQyImx1jEmmrFny8fhF7NMHIsL3GpOaYXhICZeaGZU3dRyTQgDaCQia9ysNpZxfn7FBj5npLVMC7BiNym3PeMzSKqJSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763043850; c=relaxed/simple;
	bh=CEP4KEPnF72NVqsMUE4duO12tNjdNoTH0ZLkj1zJOf8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P0rPQ2pjjAAeuDszKwGzbrWggUvEIIFigxGme1YYa0OskIVc/+UNJoqRr+vCSFzDiN725hkd5nt4BABnwmllcWIS7i5Z3epPo+VqyjK7yTzEA5vg1kE19+sexR7MRbQmTjosqTuQfKL5d6/AiyuKQNkfI9+SBhkG8n4YdUia2HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A9C0912FC;
	Thu, 13 Nov 2025 06:23:59 -0800 (PST)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A8CD3F5A1;
	Thu, 13 Nov 2025 06:24:02 -0800 (PST)
Message-ID: <633d5c15-ffe1-4b52-a6aa-9a2c54e5fb98@arm.com>
Date: Thu, 13 Nov 2025 14:24:01 +0000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/33] ACPI / MPAM: Parse the MPAM table
To: Fenghua Yu <fenghuay@nvidia.com>, james.morse@arm.com
Cc: amitsinght@marvell.com, baisheng.gao@unisoc.com,
 baolin.wang@linux.alibaba.com, bobo.shaobowang@huawei.com,
 carl@os.amperecomputing.com, catalin.marinas@arm.com, dakr@kernel.org,
 dave.martin@arm.com, david@redhat.com, dfustini@baylibre.com,
 gregkh@linuxfoundation.org, gshan@redhat.com, guohanjun@huawei.com,
 jeremy.linton@arm.com, jonathan.cameron@huawei.com, kobak@nvidia.com,
 lcherian@marvell.com, lenb@kernel.org, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 lpieralisi@kernel.org, peternewman@google.com, quic_jiles@quicinc.com,
 rafael@kernel.org, robh@kernel.org, rohit.mathew@arm.com,
 scott@os.amperecomputing.com, sdonthineni@nvidia.com, sudeep.holla@arm.com,
 tan.shaopeng@fujitsu.com, will@kernel.org, xhao@linux.alibaba.com,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
References: <20251107123450.664001-1-ben.horgan@arm.com>
 <20251107123450.664001-10-ben.horgan@arm.com>
 <498b5814-28fb-4b5d-91a8-1aab02f3f5d6@nvidia.com>
From: Ben Horgan <ben.horgan@arm.com>
Content-Language: en-US
In-Reply-To: <498b5814-28fb-4b5d-91a8-1aab02f3f5d6@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Fenghua,

On 11/13/25 02:33, Fenghua Yu wrote:
> Hi, Ben and James,
> 
> On 11/7/25 04:34, Ben Horgan wrote:
>> From: James Morse <james.morse@arm.com>
> 
> [SNIP]
> 
>> +static int acpi_mpam_parse_resource(struct mpam_msc *msc,
>> +                    struct acpi_mpam_resource_node *res)
>> +{
>> +    int level, nid;
>> +    u32 cache_id;
>> +
>> +    switch (res->locator_type) {
>> +    case ACPI_MPAM_LOCATION_TYPE_PROCESSOR_CACHE:
>> +        cache_id = res->locator.cache_locator.cache_reference;
>> +        level = find_acpi_cache_level_from_id(cache_id);
>> +        if (level <= 0) {
>> +            pr_err_once("Bad level (%d) for cache with id %u\n",
>> level, cache_id);
>> +            return -EINVAL;
>> +        }
>> +        return mpam_ris_create(msc, res->ris_index, MPAM_CLASS_CACHE,
>> +                       level, cache_id);
>> +    case ACPI_MPAM_LOCATION_TYPE_MEMORY:
>> +        nid = pxm_to_node(res->locator.memory_locator.proximity_domain);
>> +        if (nid == NUMA_NO_NODE) {
>> +            pr_debug("Bad proxmity domain %lld, using node 0 instead\n",
>> +                 res->locator.memory_locator.proximity_domain);
>> +            nid = 0;
>> +        }
>> +        return mpam_ris_create(msc, res->ris_index, MPAM_CLASS_MEMORY,
>> +                       255, nid);
> 
> nit.
> 
> Seems "255" is an ad-hoc value which won't be used for memory type?
> The "class_id" in mpam_ris_create() is confused: it may be level for
> cache or it may be 255 for memory.
> 
> To be clearer, maybe it's better to define and enum for class_id?
> Something like:
> enum mpam_class_id {
>     CLASS_ID_LEVEL_1 = 1,
>     CLASS_ID_LEVEL_2,
>     CLASS_ID_LEVEL_3,
>     CLASS_ID_NOT_USED = 255  <--- for memory type
> };

I've added a new define, MPAM_CLASS_ID_DEFAULT, which can be used for
memory and anything else that only needs one class_id.

> 
> Thanks.
> 
> -Fenghua

-- 
Thanks,

Ben


