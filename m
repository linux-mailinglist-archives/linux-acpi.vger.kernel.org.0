Return-Path: <linux-acpi+bounces-17896-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D073BEB48D
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Oct 2025 20:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B88F11AE1BBE
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Oct 2025 18:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF5230F53E;
	Fri, 17 Oct 2025 18:53:56 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D562332EA4;
	Fri, 17 Oct 2025 18:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760727236; cv=none; b=XoQqBvTbV5BXW1upJw1V1edBkNyPDuIq/NER8eHQYHsvy+LYaMYelgeR4YA69W0fFTLZgr5K3XLXNiFoMWm07LzfJfIcOQKP0Y+tieirOfq/LxJCXYeb6ZGdtDM/b7WenMdhxkEhqJdY5L/dw6ycf5g/+xLO0AVtRrU/Q4laQqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760727236; c=relaxed/simple;
	bh=QOlmNvUsKhd6u6e0k5iyOXyqQT4bhwZhGl4uKNdAABg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dw97VBTJyeBXTzBIlhTRZ5gnd4h86RBLGOCAIoOqVFRXFvBbfsxWDfWfqhfsMUzkYkb8bfo7tFSKy32lfiuXsvjUcJMiqDZAYRvads3Ngh12Tp/iQVYaUbLl7WNMuHESYNtdr2NtnUi/QiUSY1l+B3Gvt2V5Wmjb+Hkd+e4KLZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A93AF1515;
	Fri, 17 Oct 2025 11:53:46 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB1733F66E;
	Fri, 17 Oct 2025 11:53:48 -0700 (PDT)
Message-ID: <e1874826-2f18-4fae-b83d-cf099c0cf1e6@arm.com>
Date: Fri, 17 Oct 2025 19:51:32 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/29] arm_mpam: Add the class and component structures
 for firmware described ris
To: Gavin Shan <gshan@redhat.com>, linux-kernel@vger.kernel.org,
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
 Danilo Krummrich <dakr@kernel.org>, Ben Horgan <ben.horgan@arm.com>
References: <20250910204309.20751-1-james.morse@arm.com>
 <20250910204309.20751-9-james.morse@arm.com>
 <a66c6df0-f5e7-4704-a341-d34d07b8c6e1@redhat.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <a66c6df0-f5e7-4704-a341-d34d07b8c6e1@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Gavin,

On 07/10/2025 00:13, Gavin Shan wrote:
> On 9/11/25 6:42 AM, James Morse wrote:
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

>> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
>> index efc4738e3b4d..c7f4981b3545 100644
>> --- a/drivers/resctrl/mpam_devices.c
>> +++ b/drivers/resctrl/mpam_devices.c

>> +static struct mpam_class *
>> +mpam_class_get(u8 level_idx, enum mpam_class_types type)
>> +{
>> +    bool found = false;
>> +    struct mpam_class *class;
>> +
>> +    lockdep_assert_held(&mpam_list_lock);
>> +
>> +    list_for_each_entry(class, &mpam_classes, classes_list) {
>> +        if (class->type == type && class->level == level_idx) {
>> +            found = true;
>> +            break;
>> +        }
>> +    }
>> +
>> +    if (found)
>> +        return class;
>> +
>> +    return mpam_class_alloc(level_idx, type);
>> +}
>> +
> 
> The variable @found can be avoided if the found class can be returned immediately.
> 
>     list_for_each_entry(class, &mpam_classes, classes_list) {
>         if (class->type == type && class->level == level_idx)
>             return class;
>     }
> 
>     return mpam_class_alloc(level_idx, type);

Yes, feedback like this already came from Jonathan.


>> +static int mpam_ris_get_affinity(struct mpam_msc *msc, cpumask_t *affinity,
>> +                 enum mpam_class_types type,
>> +                 struct mpam_class *class,
>> +                 struct mpam_component *comp)
>> +{
>> +    int err;
>> +
>> +    switch (type) {
>> +    case MPAM_CLASS_CACHE:
>> +        err = mpam_get_cpumask_from_cache_id(comp->comp_id, class->level,
>> +                             affinity);
>> +        if (err)
>> +            return err;
>> +
>> +        if (cpumask_empty(affinity))
>> +            pr_warn_once("%s no CPUs associated with cache node",
>> +                     dev_name(&msc->pdev->dev));
>> +
>> +        break;
> 
> "\n" missed in the error message and dev_warn_once() can be used:
> 
>         if (cpumask_empty(affinity))
>             dev_warn_once(&msc->pdev->dev, "No CPUs associated with cache node\n");

Yup, I'd mopped up most of these but missed this one.


>> +    case MPAM_CLASS_MEMORY:
>> +        get_cpumask_from_node_id(comp->comp_id, affinity);
>> +        /* affinity may be empty for CPU-less memory nodes */
>> +        break;
>> +    case MPAM_CLASS_UNKNOWN:
>> +        return 0;
>> +    }
>> +
>> +    cpumask_and(affinity, affinity, &msc->accessibility);
>> +
>> +    return 0;
>> +}


Thanks,

James

