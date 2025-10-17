Return-Path: <linux-acpi+bounces-17892-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5827CBEB454
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Oct 2025 20:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 884271AE036F
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Oct 2025 18:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492C4332900;
	Fri, 17 Oct 2025 18:51:38 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C936132E15B;
	Fri, 17 Oct 2025 18:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760727098; cv=none; b=c6RMdqGb7MVE5YTjSCvlz7JF7tWEBqGnlideQ/Gn9Rp3iWob/XJCcIiqKzwXC7bdeP/bgEYX/mTIpqNNhEos1sAeWowddVQqTTK/17KhIo1G/rAAXDFc1DzRyk/H94rUoX39MAwCOvHt2RYprVQHc36/cn6W+7/mYdKIPXk2TGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760727098; c=relaxed/simple;
	bh=AD3KLuF4zTUXhyvnuNWglSjw55akjAxcp2FObMQflPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bGUIC1j+zaLSJRjKiRT0LV7ZPHB0t2zr3ycNhyipwlO/r6A+JjEeM4zNwfBbIAP5fFMPbWHDoyKu1KhTSHjMBo3eA6F+p8JMlYPFd1Bfq7UlCGhQjAHXKr2vinipRqN0A/ZUoNfCEhHtiN2NoHhaC3NMJuBH9UFZB5xR1IzYeIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 56D8A1596;
	Fri, 17 Oct 2025 11:51:28 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 159A33F6A8;
	Fri, 17 Oct 2025 11:51:27 -0700 (PDT)
Message-ID: <a1c4517e-8110-47f6-a053-291955b17c48@arm.com>
Date: Fri, 17 Oct 2025 19:51:11 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/29] arm_mpam: Add probe/remove for mpam msc driver
 and kbuild boiler plate
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
 <20250910204309.20751-8-james.morse@arm.com>
 <20250911143544.000026aa@huawei.com>
 <9982847d-2878-4748-8c65-2d98a2e47396@arm.com>
 <20250926155543.00005de0@huawei.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <20250926155543.00005de0@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jonathan,

On 26/09/2025 15:55, Jonathan Cameron wrote:
>>>> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
>>>> new file mode 100644
>>>> index 000000000000..7c63d590fc98
>>>> --- /dev/null
>>>> +++ b/drivers/resctrl/mpam_internal.h
>>>> @@ -0,0 +1,65 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>>> +// Copyright (C) 2025 Arm Ltd.
>>>> +
>>>> +#ifndef MPAM_INTERNAL_H
>>>> +#define MPAM_INTERNAL_H
>>>> +
>>>> +#include <linux/arm_mpam.h>
>>>> +#include <linux/cpumask.h>
>>>> +#include <linux/io.h>
>>>> +#include <linux/mailbox_client.h>
>>>> +#include <linux/mutex.h>  
>>>
>>> spinlock.h  
>>
>> Fixed,
>>
>>
>>>> +#include <linux/resctrl.h>  
>>>
>>> Not spotting anything rsctl yet.  So maybe this belongs later.  
>>
>> There shouldn't be anything that depends on resctrl in this series - looks like
>> this is a 2018 era bug in the way I carved this up!
>>
>>
>>>> +#include <linux/sizes.h>
>>>> +
>>>> +struct mpam_msc {
>>>> +	/* member of mpam_all_msc */
>>>> +	struct list_head        all_msc_list;
>>>> +
>>>> +	int			id;  
>>>
>>> I'd follow (approx) include what you use principles to make later header
>>> shuffling easier. So a forward def for this.  
>>
>> -ENOPARSE
>>
>> I'm sure I'll work this out from your later comments.
> 
> I missed on the comment (I think). Would have made more sense a line later.
> Add a forwards def
> 
> struct platform_device;
> 
> as no reason to include the appropriate header
> (and you didn't anwyay).
> 

Right - gotcha.


Thanks,

James

