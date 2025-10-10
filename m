Return-Path: <linux-acpi+bounces-17720-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 412E8BCDFE6
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Oct 2025 18:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E5E9547B32
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Oct 2025 16:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FECB2FC037;
	Fri, 10 Oct 2025 16:53:54 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD232F999F;
	Fri, 10 Oct 2025 16:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760115234; cv=none; b=f7p/ZO1TbjH+O9UzbMthJ9JKj/ijnMzaiu9/ZTxeKDLzjQ8rvojbhF1p1WjbuYkTufec+og8IOiOzXkkQL0tPXcJf6kkNkH9lfkSW6NsB2uZBlisuI23Ho9pxMLq5Qokn4DK1NTgsC/1VPWpMlvCruCFSiweF73/Gu10AC3oQXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760115234; c=relaxed/simple;
	bh=CqGj61voJwsaj0+36GL0rHI7OvKvqxVooI1mEQbwj/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bb6n0twO6Nv38qcJY0ZPjPQOI7JHqvMrapyF/7sJFG+bPH6FlLTgPHVzizwfWRFkrUtN/Z8QiwGH06Tx73RYd4+s/skcWCUyAOXRH7C+SZZa0dYEC9b68ysvIYQdSvilrvBuo/OBbArEs+gMYyJgVKRr7DqqNS+r96KM/xrbZIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 86652153B;
	Fri, 10 Oct 2025 09:53:44 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D82983F66E;
	Fri, 10 Oct 2025 09:53:46 -0700 (PDT)
Message-ID: <73967f49-f276-404e-afd2-259f3319dfdb@arm.com>
Date: Fri, 10 Oct 2025 17:53:45 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 28/29] arm_mpam: Add kunit test for bitmap reset
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
 <20250910204309.20751-29-james.morse@arm.com>
 <20250912143704.00001ae8@huawei.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <20250912143704.00001ae8@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jonathan,

On 12/09/2025 14:37, Jonathan Cameron wrote:
> On Wed, 10 Sep 2025 20:43:08 +0000
> James Morse <james.morse@arm.com> wrote:
> 
>> The bitmap reset code has been a source of bugs. Add a unit test.
>>
>> This currently has to be built in, as the rest of the driver is
>> builtin.
>>
>> Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Signed-off-by: James Morse <james.morse@arm.com>


> Few trivial comments inline.
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

Thanks!


>> diff --git a/drivers/resctrl/Kconfig b/drivers/resctrl/Kconfig
>> index c30532a3a3a4..ef59b3057d5d 100644
>> --- a/drivers/resctrl/Kconfig
>> +++ b/drivers/resctrl/Kconfig
>> @@ -5,10 +5,20 @@ menuconfig ARM64_MPAM_DRIVER
>>  	  MPAM driver for System IP, e,g. caches and memory controllers.
>>  
>>  if ARM64_MPAM_DRIVER
>> +
>>  config ARM64_MPAM_DRIVER_DEBUG
>>  	bool "Enable debug messages from the MPAM driver"
>>  	depends on ARM64_MPAM_DRIVER
> 
> Doing this under an if for the same isn't useful. So if you want to do this
> style I'd do it before adding this earlier config option.

Yup, you pointed at the this same shape of bug earlier in the series.


>>  	help
>>  	  Say yes here to enable debug messages from the MPAM driver.
>>  
>> +config MPAM_KUNIT_TEST
>> +	bool "KUnit tests for MPAM driver " if !KUNIT_ALL_TESTS
>> +	depends on KUNIT=y
>> +	default KUNIT_ALL_TESTS
>> +	help
>> +	  Enable this option to run tests in the MPAM driver.
>> +
>> +	  If unsure, say N.
>> +
>>  endif
> 
>> diff --git a/drivers/resctrl/test_mpam_devices.c b/drivers/resctrl/test_mpam_devices.c
>> new file mode 100644
>> index 000000000000..3e7058f7601c
>> --- /dev/null
>> +++ b/drivers/resctrl/test_mpam_devices.c
>> @@ -0,0 +1,68 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +// Copyright (C) 2024 Arm Ltd.
>> +/* This file is intended to be included into mpam_devices.c */
>> +
>> +#include <kunit/test.h>
>> +
>> +static void test_mpam_reset_msc_bitmap(struct kunit *test)
>> +{
>> +	char __iomem *buf = kunit_kzalloc(test, SZ_16K, GFP_KERNEL);
>> +	struct mpam_msc fake_msc = {0};
> 
> = { }; is sufficient and what newer c specs have adopted to mean
> fill everything including holes in structures with 0.  There are some
> tests that ensure that behavior applies with older compilers + the options
> we use for building the kernel.

Muscle memory is difficult to overcome ... I've fixed this one, and will keep an eye out
for more.


>> +	u32 *test_result;
>> +
>> +	if (!buf)
>> +		return;
>> +
>> +	fake_msc.mapped_hwpage = buf;
>> +	fake_msc.mapped_hwpage_sz = SZ_16K;
>> +	cpumask_copy(&fake_msc.accessibility, cpu_possible_mask);
>> +
>> +	mutex_init(&fake_msc.part_sel_lock);
>> +	mutex_lock(&fake_msc.part_sel_lock);

> Perhaps add a comment to say this is to satisfy lock markings?
> Otherwise someone might wonder why mutex_init() immediately followed
> by taking the lock maskes sense.

Makes sense, Done.

>> +
>> +	test_result = (u32 *)(buf + MPAMCFG_CPBM);


Thanks,

James

