Return-Path: <linux-acpi+bounces-18811-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CB8C532F9
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Nov 2025 16:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E724E34F807
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Nov 2025 15:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6B32D130B;
	Wed, 12 Nov 2025 15:38:00 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6101D269811;
	Wed, 12 Nov 2025 15:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762961880; cv=none; b=ShWHSTybVGZoHCZgCC7nmiwtfu+I1Skb3fldtIlV56UzYK1vKsSwbX5NUKI7c2gzSuSKdooMHKzAzdKF6nem7DBBd+M1DgjibDj0KG2qTdLopNBqJKfBXUR28GxkZcjuRqFp7liO7p28EVlW/WyUojdaxJ32mr44rtw75khBq20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762961880; c=relaxed/simple;
	bh=ehcjdwzwHqCLwN5zy3PgTPFC6JJphL3yRBrEu05kED8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mshUWqZ2r5qbc6RDtpjKNtkwncaz98rRxXQLXjewYWOQeKV2cf6hvpBqDGWux+uqN4cjILBTIVYs60aJZ3NThACo3n7sT7M0loITb681iXAqSiXHOQTc7i8EfZC3Zr1lSiJR3AsYY8BAKcUx9V2og0W+9cIF0Pm8+WyMLXfNfJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 17ED01515;
	Wed, 12 Nov 2025 07:37:50 -0800 (PST)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2670E3F66E;
	Wed, 12 Nov 2025 07:37:53 -0800 (PST)
Message-ID: <83ba6e8f-30be-4e82-ae1f-2443a0f16d3c@arm.com>
Date: Wed, 12 Nov 2025 15:37:51 +0000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/33] arm_mpam: Add probe/remove for mpam msc driver and
 kbuild boiler plate
To: "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>,
 "james.morse@arm.com" <james.morse@arm.com>
Cc: "amitsinght@marvell.com" <amitsinght@marvell.com>,
 "baisheng.gao@unisoc.com" <baisheng.gao@unisoc.com>,
 "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
 "bobo.shaobowang@huawei.com" <bobo.shaobowang@huawei.com>,
 "carl@os.amperecomputing.com" <carl@os.amperecomputing.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "dakr@kernel.org" <dakr@kernel.org>,
 "dave.martin@arm.com" <dave.martin@arm.com>,
 "david@redhat.com" <david@redhat.com>,
 "dfustini@baylibre.com" <dfustini@baylibre.com>,
 "fenghuay@nvidia.com" <fenghuay@nvidia.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "gshan@redhat.com" <gshan@redhat.com>,
 "guohanjun@huawei.com" <guohanjun@huawei.com>,
 "jeremy.linton@arm.com" <jeremy.linton@arm.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "kobak@nvidia.com" <kobak@nvidia.com>,
 "lcherian@marvell.com" <lcherian@marvell.com>,
 "lenb@kernel.org" <lenb@kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 "peternewman@google.com" <peternewman@google.com>,
 "quic_jiles@quicinc.com" <quic_jiles@quicinc.com>,
 "rafael@kernel.org" <rafael@kernel.org>, "robh@kernel.org"
 <robh@kernel.org>, "rohit.mathew@arm.com" <rohit.mathew@arm.com>,
 "scott@os.amperecomputing.com" <scott@os.amperecomputing.com>,
 "sdonthineni@nvidia.com" <sdonthineni@nvidia.com>,
 "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
 "will@kernel.org" <will@kernel.org>,
 "xhao@linux.alibaba.com" <xhao@linux.alibaba.com>
References: <20251107123450.664001-1-ben.horgan@arm.com>
 <20251107123450.664001-11-ben.horgan@arm.com>
 <OSZPR01MB879857F2126672D1EADA04668BCCA@OSZPR01MB8798.jpnprd01.prod.outlook.com>
From: Ben Horgan <ben.horgan@arm.com>
Content-Language: en-US
In-Reply-To: <OSZPR01MB879857F2126672D1EADA04668BCCA@OSZPR01MB8798.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Shaopeng,

On 11/12/25 07:22, Shaopeng Tan (Fujitsu) wrote:
> Hello Ben,
> 
>> From: James Morse <james.morse@arm.com>
>>
>> Probing MPAM is convoluted. MSCs that are integrated with a CPU may only be
>> accessible from those CPUs, and they may not be online.
>> Touching the hardware early is pointless as MPAM can't be used until the
>> system-wide common values for num_partid and num_pmg have been
>> discovered.
>>
>> Start with driver probe/remove and mapping the MSC.
>>
>> CC: Carl Worth <carl@os.amperecomputing.com>
>> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
>> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
>> Tested-by: Peter Newman <peternewman@google.com>
>> Signed-off-by: James Morse <james.morse@arm.com>
>> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
>> ---
[...]
>> +static struct mpam_msc *do_mpam_msc_drv_probe(struct platform_device
>> +*pdev) {
>> +	int err;
>> +	u32 tmp;
>> +	struct mpam_msc *msc;
>> +	struct resource *msc_res;
>> +	struct device *dev = &pdev->dev;
>> +
>> +	lockdep_assert_held(&mpam_list_lock);
>> +
>> +	msc = devm_kzalloc(&pdev->dev, sizeof(*msc), GFP_KERNEL);
>> +	if (!msc)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	err = devm_mutex_init(dev, &msc->probe_lock);
>> +	if (err)
>> +		return ERR_PTR(err);
>> +	err = devm_mutex_init(dev, &msc->part_sel_lock);
>> +	if (err)
>> +		return ERR_PTR(err);
>> +	msc->id = pdev->id;
>> +	msc->pdev = pdev;
>> +	INIT_LIST_HEAD_RCU(&msc->all_msc_list);
>> +	INIT_LIST_HEAD_RCU(&msc->ris);
>> +
>> +	err = update_msc_accessibility(msc);
>> +	if (err)
>> +		return ERR_PTR(err);
> 
> Since the return value of update_msc_accessibility(msc) is always 0,
> this check is unnecessary.

Yes, I've changed update_msc_accessibility() to return void.
> 
> Best regards,
> Shaopeng TAN
> 
Thanks,

Ben


