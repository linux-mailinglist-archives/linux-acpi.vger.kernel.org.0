Return-Path: <linux-acpi+bounces-17723-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF19BCDFFE
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Oct 2025 18:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0D64547F17
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Oct 2025 16:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909372FC03E;
	Fri, 10 Oct 2025 16:54:14 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F052D2FBE16;
	Fri, 10 Oct 2025 16:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760115254; cv=none; b=MCqvCiFHyBauxv4+KP1CRn7OLbE6DqjcGo2PgZxID6DxpEiG+BAT95t0X/u+Q8OW4iPKqbpJ48srJY/3O6Hi7DvdHHHJ8a5fqvANaDYwAKjgzD6CtL3S1FeyuhacOz/iWFKLTcoVGAJ2t3HdO0+xKHrG+ODn9Oe63p6sHrpkC+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760115254; c=relaxed/simple;
	bh=JbQRDD8cUBIkZxrk1eL9YZhlOGuS5zVv1GB2lV0cr20=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S/eVss2dR0YK4InJLVJ6eMyV16wb8w8VhzJaa7BP7eZjKM1hr0Bv1VPtJ0wrxmFCID9gBw6XA0FVMpkaWuM6Te9ptYj+BMutgyqKn7qXG/c3huksXjCYrHkfuAjbYNjBgJrzcXfullJVDdND45rtke5Gqxt3tkYmzs3IlEZNhq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 578AF1713;
	Fri, 10 Oct 2025 09:54:03 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC2583F66E;
	Fri, 10 Oct 2025 09:54:04 -0700 (PDT)
Message-ID: <2d9a9291-610b-4af0-b61e-bdc03a3b39c4@arm.com>
Date: Fri, 10 Oct 2025 17:54:01 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 29/29] arm_mpam: Add kunit tests for props_mismatch()
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
 <20250910204309.20751-30-james.morse@arm.com>
 <20250912144148.00003204@huawei.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <20250912144148.00003204@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jonathan,

On 12/09/2025 14:41, Jonathan Cameron wrote:
> On Wed, 10 Sep 2025 20:43:09 +0000
> James Morse <james.morse@arm.com> wrote:
> 
>> When features are mismatched between MSC the way features are combined
>> to the class determines whether resctrl can support this SoC.
>>
>> Add some tests to illustrate the sort of thing that is expected to
>> work, and those that must be removed.
>>
>> Signed-off-by: James Morse <james.morse@arm.com>

> Nice in general though I didn't go through the test expected results etc.

> A few comments inline.
> 
> Thanks and looking forward to seeing this go in.


>> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
>> index 7cbcafe8294a..6119e4573187 100644
>> --- a/drivers/resctrl/mpam_internal.h
>> +++ b/drivers/resctrl/mpam_internal.h
>> @@ -189,7 +195,7 @@ struct mpam_props {
>>  	u16			dspri_wd;
>>  	u16			num_csu_mon;
>>  	u16			num_mbwu_mon;
>> -};
>> +} PACKED_FOR_KUNIT;
> 
> Add a comment on 'why'.

| * Kunit tests use memset() to set up feature combinations that should be
| * removed, and will false-positive if the compiler introduces padding that
| * isn't cleared during sanitisation.


>> diff --git a/drivers/resctrl/test_mpam_devices.c b/drivers/resctrl/test_mpam_devices.c
>> index 3e7058f7601c..4eca8590c691 100644
>> --- a/drivers/resctrl/test_mpam_devices.c
>> +++ b/drivers/resctrl/test_mpam_devices.c
>> @@ -4,6 +4,325 @@
>>  
>>  #include <kunit/test.h>
>>  
>> +/*
>> + * This test catches fields that aren't being sanitised - but can't tell you
>> + * which one...
>> + */
>> +static void test__props_mismatch(struct kunit *test)
>> +{
>> +	struct mpam_props parent = { 0 };
>> +	struct mpam_props child;
>> +
>> +	memset(&child, 0xff, sizeof(child));
>> +	__props_mismatch(&parent, &child, false);
>> +
>> +	memset(&child, 0, sizeof(child));
>> +	KUNIT_EXPECT_EQ(test, memcmp(&parent, &child, sizeof(child)), 0);
>> +
>> +	memset(&child, 0xff, sizeof(child));
>> +	__props_mismatch(&parent, &child, true);
>> +
>> +	KUNIT_EXPECT_EQ(test, memcmp(&parent, &child, sizeof(child)), 0);
>> +}
>> +
>> +static struct list_head fake_classes_list;
>> +static struct mpam_class fake_class = { 0 };
>> +static struct mpam_component fake_comp1 = { 0 };
>> +static struct mpam_component fake_comp2 = { 0 };
>> +static struct mpam_vmsc fake_vmsc1 = { 0 };
>> +static struct mpam_vmsc fake_vmsc2 = { 0 };
>> +static struct mpam_msc fake_msc1 = { 0 };
>> +static struct mpam_msc fake_msc2 = { 0 };
>> +static struct mpam_msc_ris fake_ris1 = { 0 };
>> +static struct mpam_msc_ris fake_ris2 = { 0 };
>> +static struct platform_device fake_pdev = { 0 };
>> +
>> +static void test_mpam_enable_merge_features(struct kunit *test)
>> +{
>> +#define RESET_FAKE_HIEARCHY()	do {				\
>> +	INIT_LIST_HEAD(&fake_classes_list);			\
>> +								\
>> +	memset(&fake_class, 0, sizeof(fake_class));		\

> Maybe just use a function?  Seems to be changing stuff that is
> global mostly anyway so seems like it won't need large numbers
> of parameters or anything like that.

Sure - it only became global in v3.


Thanks,

James

