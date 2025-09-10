Return-Path: <linux-acpi+bounces-16617-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0D8B5211A
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 21:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C88A1C87853
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 19:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DF92C11D8;
	Wed, 10 Sep 2025 19:32:52 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65DC329F19;
	Wed, 10 Sep 2025 19:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757532772; cv=none; b=vAWu/x1TTgeZGlxi/jIUi0MOi8aLhaEvcF0TafwhIIrrCfByKPuMjEMVJCCPeBMzsifez5/EEbJqvRfn+4RjRVUey20hBJbX7dP4rIyY6VmtCRr/VENYwaOJWGzur0tGu1ss+EmNW/noq+E9XkiKmtJE2qpnRz7wD+/XuXNaGRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757532772; c=relaxed/simple;
	bh=js4ayK6vpaghgxoZZUdzjCrrU3+EnDX4w5xEbDslrgs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TsLX/O2DLKPHCccj2tBAmZ4jgP2U+imP7v4kwHzyo/e9kKQAi4znvUsDot+ZwLtzMop3Qc+xE+oYd327UhTNrHKz2La74oCPpF1/qE3X9bMrnE4u9V5UXk9nROtOabcs3fRjsSMiL8T3fgq0E4K97cYFnDSsuuwUCu7ooA4sqh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D6B1316F2;
	Wed, 10 Sep 2025 12:32:41 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CE9E33F694;
	Wed, 10 Sep 2025 12:32:43 -0700 (PDT)
Message-ID: <cdd07b6e-5cc5-407f-b55b-75f230a2e786@arm.com>
Date: Wed, 10 Sep 2025 20:32:42 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/33] arm_mpam: Add the class and component structures
 for ris firmware described
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
 <20250822153048.2287-47-james.morse@arm.com>
 <a23294ed-e5af-4ed3-89d5-aee9f5844bf2@arm.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <a23294ed-e5af-4ed3-89d5-aee9f5844bf2@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ben,

On 29/08/2025 13:41, Ben Horgan wrote:
> On 8/22/25 16:30, James Morse wrote:
>> An MSC is a container of resources, each identified by their RIS index.
>> Some RIS are described by firmware to provide their position in the system.
>> Others are discovered when the driver probes the hardware.
>>
>> To configure a resource it needs to be found by its class, e.g. 'L2'.
>> There are two kinds of grouping, a class is a set of components, which
>> are visible to user-space as there are likely to be multiple instances
>> of the L2 cache. (e.g. one per cluster or package)
>>
>> struct mpam_components are a set of struct mpam_vmsc. A vMSC groups the
>> RIS in an MSC that control the same logical piece of hardware. (e.g. L2).
>> This is to allow hardware implementations where two controls are presented
>> as different RIS. Re-combining these RIS allows their feature bits to
>> be or-ed. This structure is not visible outside mpam_devices.c
>>
>> struct mpam_vmsc are then a set of struct mpam_msc_ris, which are not
>> visible as each L2 cache may be composed of individual slices which need
>> to be configured the same as the hardware is not able to distribute the
>> configuration.
>>
>> Add support for creating and destroying these structures.
>>
>> A gfp is passed as the structures may need creating when a new RIS entry
>> is discovered when probing the MSC.

>> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
>> index 71a1fb1a9c75..5baf2a8786fb 100644
>> --- a/drivers/resctrl/mpam_devices.c
>> +++ b/drivers/resctrl/mpam_devices.c
>> @@ -179,7 +650,10 @@ static int update_msc_accessibility(struct mpam_msc *msc)
>>  		cpumask_copy(&msc->accessibility, cpu_possible_mask);
>>  		err = 0;
>>  	} else {
>> -		if (of_device_is_compatible(parent, "memory")) {
>> +		if (of_device_is_compatible(parent, "cache")) {
>> +			err = get_cpumask_from_cache(parent,
>> +						     &msc->accessibility);
>> +		} else if (of_device_is_compatible(parent, "memory")) {

> The determination of the accessibility for the h/w msc doesn't fit with
> the subject of this patch. Could this hunk and the supporting functions
> be split into a precursor patch?

I've moved this bit into the previous patches.


Thanks,

James

