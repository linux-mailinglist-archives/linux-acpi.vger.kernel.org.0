Return-Path: <linux-acpi+bounces-16612-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C85FFB5210A
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 21:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C0597BA2C1
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 19:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC932D8788;
	Wed, 10 Sep 2025 19:31:14 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43702C11D8;
	Wed, 10 Sep 2025 19:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757532674; cv=none; b=PXaDjaYPOXH1RZxj6kbKvF2LK5NYUmCS3O/4Nd+MOK5E1LX2XMh1+c5RhwkyxCwOrzir+RYWBlhNkose1Lb5bzLKrxpc1aDfKMWj/ZG0dqD3CCvfw4JS6b9pgYD88BhhnmeT7U9/h/Eenqjl59BLdqzzjVF4bsclmhK68Sz8+TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757532674; c=relaxed/simple;
	bh=/Uh9Xp7+XEhYQ2/f4u2JkNH4LdJB1BW8hgsgMYfh00s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fk3IT8wQf+ALBJ5CFX33bt7/poaLBMVM08UfFZFN+Qk7VoLnmEFZZ2hiPePl7UWutb9gqB6SbxLnqGEnKYhzKKk2u/setDOEO7WXNYWe2eR89rHo1JnNJE3oLHhCNlTwz/SJQrhL5JSIPoYLXQt8XJ4/0oHqnw9o2FSDJZZtjq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E824016F2;
	Wed, 10 Sep 2025 12:31:02 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC36D3F694;
	Wed, 10 Sep 2025 12:31:04 -0700 (PDT)
Message-ID: <4d7a9b82-9d96-4796-949d-d32c02b6af28@arm.com>
Date: Wed, 10 Sep 2025 20:31:02 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 33/33] arm_mpam: Add kunit tests for props_mismatch()
To: Ben Horgan <ben.horgan@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
 devicetree@vger.kernel.org
Cc: shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, fenghuay@nvidia.com,
 baisheng.gao@unisoc.com, Jonathan Cameron <jonathan.cameron@huawei.com>,
 Rob Herring <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
 Rafael Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>
References: <20250822153048.2287-1-james.morse@arm.com>
 <20250822153048.2287-34-james.morse@arm.com>
 <ceb64a9b-0ffe-4193-942e-5ddf71478e5d@arm.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <ceb64a9b-0ffe-4193-942e-5ddf71478e5d@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ben,

On 29/08/2025 18:11, Ben Horgan wrote:
> The tests seem reasonable. Just some comments on the comments.
> 
> On 8/22/25 16:30, James Morse wrote:
>> When features are mismatched between MSC the way features are combined
>> to the class determines whether resctrl can support this SoC.
>>
>> Add some tests to illustrate the sort of thing that is expected to
>> work, and those that must be removed.

>> diff --git a/drivers/resctrl/test_mpam_devices.c b/drivers/resctrl/test_mpam_devices.c
>> index 8e9d6c88171c..ef39696e7ff8 100644
>> --- a/drivers/resctrl/test_mpam_devices.c
>> +++ b/drivers/resctrl/test_mpam_devices.c
>> @@ -4,6 +4,326 @@
>> +static void test_mpam_enable_merge_features(struct kunit *test)
>> +{

[...]

>> +	/* One Class+Comp, two MSC with non-overlapping features */
>> +	fake_comp1.class = &fake_class;
>> +	list_add(&fake_comp1.class_list, &fake_class.components);
>> +	fake_comp2.class = NULL;
>> +	fake_vmsc1.comp = &fake_comp1;
>> +	list_add(&fake_vmsc1.comp_list, &fake_comp1.vmsc);
>> +	fake_vmsc2.comp = &fake_comp1;
>> +	list_add(&fake_vmsc2.comp_list, &fake_comp1.vmsc);
>> +	fake_ris1.vmsc = &fake_vmsc1;
>> +	list_add(&fake_ris1.vmsc_list, &fake_vmsc1.ris);
>> +	fake_ris2.vmsc = &fake_vmsc2;
>> +	list_add(&fake_ris2.vmsc_list, &fake_vmsc2.ris);
>> +
>> +	mpam_set_feature(mpam_feat_cpor_part, &fake_ris1.props);
>> +	mpam_set_feature(mpam_feat_cmax_cmin, &fake_ris2.props);
>> +	fake_ris1.props.cpbm_wd = 4;
>> +	fake_ris2.props.cmax_wd = 4;
>> +
>> +	mpam_enable_merge_features(&fake_classes_list);
>> +
>> +	/*
>> +	 * Multiple RIS in different MSC can't the same resource, mismatched

> s/can't the same/can't control the same/

Thanks,


>> +	 * features can not be supported.
>> +	 */
>> +	KUNIT_EXPECT_FALSE(test, mpam_has_feature(mpam_feat_cpor_part, &fake_class.props));
>> +	KUNIT_EXPECT_FALSE(test, mpam_has_feature(mpam_feat_cmax_cmin, &fake_class.props));
>> +	KUNIT_EXPECT_EQ(test, fake_class.props.cpbm_wd, 0);
>> +	KUNIT_EXPECT_EQ(test, fake_class.props.cmax_wd, 0);
>> +
>> +	RESET_FAKE_HIEARCHY();
>> +
>> +	/* One Class+Comp, two MSC with incompatible overlapping features */
>> +	fake_comp1.class = &fake_class;
>> +	list_add(&fake_comp1.class_list, &fake_class.components);
>> +	fake_comp2.class = NULL;
>> +	fake_vmsc1.comp = &fake_comp1;
>> +	list_add(&fake_vmsc1.comp_list, &fake_comp1.vmsc);
>> +	fake_vmsc2.comp = &fake_comp1;
>> +	list_add(&fake_vmsc2.comp_list, &fake_comp1.vmsc);
>> +	fake_ris1.vmsc = &fake_vmsc1;
>> +	list_add(&fake_ris1.vmsc_list, &fake_vmsc1.ris);
>> +	fake_ris2.vmsc = &fake_vmsc2;
>> +	list_add(&fake_ris2.vmsc_list, &fake_vmsc2.ris);
>> +
>> +	mpam_set_feature(mpam_feat_cpor_part, &fake_ris1.props);
>> +	mpam_set_feature(mpam_feat_cpor_part, &fake_ris2.props);
>> +	mpam_set_feature(mpam_feat_mbw_part, &fake_ris1.props);
>> +	mpam_set_feature(mpam_feat_mbw_part, &fake_ris2.props);
>> +	fake_ris1.props.cpbm_wd = 5;
>> +	fake_ris2.props.cpbm_wd = 3;
>> +	fake_ris1.props.mbw_pbm_bits = 5;
>> +	fake_ris2.props.mbw_pbm_bits = 3;
>> +
>> +	mpam_enable_merge_features(&fake_classes_list);
>> +
>> +	/*
>> +	 * Multiple RIS in different MSC can't the same resource, mismatched
>> +	 * features can not be supported.
>> +	 */

> Missing the word "control" again.

Copy and paste!


>> +	KUNIT_EXPECT_FALSE(test, mpam_has_feature(mpam_feat_cpor_part, &fake_class.props));
>> +	KUNIT_EXPECT_FALSE(test, mpam_has_feature(mpam_feat_mbw_part, &fake_class.props));
>> +	KUNIT_EXPECT_EQ(test, fake_class.props.cpbm_wd, 0);
>> +	KUNIT_EXPECT_EQ(test, fake_class.props.mbw_pbm_bits, 0);
>> +
>> +	RESET_FAKE_HIEARCHY();
>> +
>> +	/* One Class+Comp, two MSC with overlapping features that need tweaking */
>> +	fake_comp1.class = &fake_class;
>> +	list_add(&fake_comp1.class_list, &fake_class.components);
>> +	fake_comp2.class = NULL;
>> +	fake_vmsc1.comp = &fake_comp1;
>> +	list_add(&fake_vmsc1.comp_list, &fake_comp1.vmsc);
>> +	fake_vmsc2.comp = &fake_comp1;
>> +	list_add(&fake_vmsc2.comp_list, &fake_comp1.vmsc);
>> +	fake_ris1.vmsc = &fake_vmsc1;
>> +	list_add(&fake_ris1.vmsc_list, &fake_vmsc1.ris);
>> +	fake_ris2.vmsc = &fake_vmsc2;
>> +	list_add(&fake_ris2.vmsc_list, &fake_vmsc2.ris);
>> +
>> +	mpam_set_feature(mpam_feat_mbw_min, &fake_ris1.props);
>> +	mpam_set_feature(mpam_feat_mbw_min, &fake_ris2.props);
>> +	mpam_set_feature(mpam_feat_cmax_cmax, &fake_ris1.props);
>> +	mpam_set_feature(mpam_feat_cmax_cmax, &fake_ris2.props);
>> +	fake_ris1.props.bwa_wd = 5;
>> +	fake_ris2.props.bwa_wd = 3;
>> +	fake_ris1.props.cmax_wd = 5;
>> +	fake_ris2.props.cmax_wd = 3;
>> +
>> +	mpam_enable_merge_features(&fake_classes_list);
>> +
>> +	/*
>> +	 * Multiple RIS in different MSC can't the same resource, mismatched
>> +	 * features can not be supported.
>> +	 */

> Comment is for a different case.

Fixed as:
	/*
	 * RIS with different control properties need to be sanitised so the
	 * class has the common set of properties.
	 */


>> +	KUNIT_EXPECT_TRUE(test, mpam_has_feature(mpam_feat_mbw_min, &fake_class.props));
>> +	KUNIT_EXPECT_TRUE(test, mpam_has_feature(mpam_feat_cmax_cmax, &fake_class.props));
>> +	KUNIT_EXPECT_EQ(test, fake_class.props.bwa_wd, 3);
>> +	KUNIT_EXPECT_EQ(test, fake_class.props.cmax_wd, 3);


Thanks,

James

