Return-Path: <linux-acpi+bounces-16607-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B92B520FB
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 21:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCB20583932
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 19:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C69255F31;
	Wed, 10 Sep 2025 19:30:20 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24EE266B41;
	Wed, 10 Sep 2025 19:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757532620; cv=none; b=UPXMgdsnZdaOy06Nnq7UblNbOnvHgwKmpa9REXtIqhJ3ll12yNpuAGIidSia+HwiJyBkA3cVp6Xgb0lKeRy68Bn2/Nn67w30HziBS9XFrUca4401GGtHIir502sAD0ylni1SgeN3m71qcdF1Ax2xFbMk+QR4rgMpp4bOZPtMJ4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757532620; c=relaxed/simple;
	bh=Uqi1go0GTbFQXSvP3sPTw/841KpccjtRPjidoyTbWjI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sam/tTi1RUlc8Qc2WDQjLQbn0+MaL0ydCvP6GpMGnSN+Zjmr8FzpPFsZK6zkIUt9Tpl6l2bDwPP7mHid1E8x6tzt0Euqoq3Ble2j+YV705pewWiIkc698yE7o362DgHgMxuoNFaj/bOdLBKd/ZdrjAmUs2ihhIxZpizNYLltRt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 38D2C328D;
	Wed, 10 Sep 2025 12:30:10 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 554513F694;
	Wed, 10 Sep 2025 12:30:07 -0700 (PDT)
Message-ID: <1ac89055-12ab-4aa0-a34f-1523ac579b8e@arm.com>
Date: Wed, 10 Sep 2025 20:30:05 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 25/33] arm_mpam: Probe and reset the rest of the features
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
 Danilo Krummrich <dakr@kernel.org>, Zeng Heng <zengheng4@huawei.com>
References: <20250822153048.2287-1-james.morse@arm.com>
 <20250822153048.2287-26-james.morse@arm.com>
 <13767875-3744-47f3-98ec-a808c0c22f21@arm.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <13767875-3744-47f3-98ec-a808c0c22f21@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ben,

On 28/08/2025 11:11, Ben Horgan wrote:
> On 8/22/25 16:30, James Morse wrote:
>> MPAM supports more features than are going to be exposed to resctrl.
>> For partid other than 0, the reset values of these controls isn't
>> known.
>>
>> Discover the rest of the features so they can be reset to avoid any
>> side effects when resctrl is in use.
>>
>> PARTID narrowing allows MSC/RIS to support less configuration space than
>> is usable. If this feature is found on a class of device we are likely
>> to use, then reduce the partid_max to make it usable. This allows us
>> to map a PARTID to itself.

>> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
>> index 8f6df2406c22..aedd743d6827 100644
>> --- a/drivers/resctrl/mpam_devices.c
>> +++ b/drivers/resctrl/mpam_devices.c

>> @@ -964,6 +1054,29 @@ static void mpam_reprogram_ris_partid(struct mpam_msc_ris *ris, u16 partid,
>>  
>>  	if (mpam_has_feature(mpam_feat_mbw_prop, rprops))
>>  		mpam_write_partsel_reg(msc, MBW_PROP, bwa_fract);
>> +
>> +	if (mpam_has_feature(mpam_feat_cmax_cmax, rprops))
>> +		mpam_write_partsel_reg(msc, CMAX, cmax);
>> +
>> +	if (mpam_has_feature(mpam_feat_cmax_cmin, rprops))
>> +		mpam_write_partsel_reg(msc, CMIN, 0);

> Missing reset for cmax_cassoc. I wonder if it makes sense to have
> separate enums for partitioning features, which require reset, and the rest.

Fixed. They all need resetting because the architecture doesn't guarantee the state of
controls out of reset for PARTID other than zero. (or - when the MSC are reset).

I think those two lists would just be those that are reset to zero, as opposed to some
other value. Given the register names have to be listed here, I don't think its any worse
to have the hand-picked reset value.


Thanks,

James

