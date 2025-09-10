Return-Path: <linux-acpi+bounces-16618-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED33EB52120
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 21:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9CAC585579
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 19:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D518A2D5940;
	Wed, 10 Sep 2025 19:32:58 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC2B329F19;
	Wed, 10 Sep 2025 19:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757532778; cv=none; b=NZx0Jqr4Arp4PabU1Uj1KIhV1e4zUEQ7xGL3HcKszeVgzXnyuQeB+Miist+lSkr+5gyXD5iIqtJNVqih0D+4LW4ePJMYypcnljxXeTU+gBXyX3zFgE+Wk9CdSHJSirXn5aaoyEkhs4+4d5uTlhEffQ03P7Oc96iZFHs+Wm4qWow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757532778; c=relaxed/simple;
	bh=7oIoIA6bBHSZX2g7UU2DW6jdrNpIqgMfBRZHw8gABFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AJcVBjYUH5nykUPSnhrof0xcYEc15XyxvmLJotITaX9JapocJ7xX+l5kuP0y7lPiWx36fswiN119+OVWpi3bbFusTjHAgoFrN7qQPrPy1XmBVXzBKmVrAuJEEIyDOB6H7E91GySDokg0o7n4Y30JmjkK93yRiDhsNQfK3eo3Z18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B8943165;
	Wed, 10 Sep 2025 12:32:48 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 939F13F694;
	Wed, 10 Sep 2025 12:32:50 -0700 (PDT)
Message-ID: <8d6e9ff2-2279-475a-8135-304dac6c0920@arm.com>
Date: Wed, 10 Sep 2025 20:32:49 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/33] arm_mpam: Add the class and component structures
 for ris firmware described
To: "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Cc: "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 "carl@os.amperecomputing.com" <carl@os.amperecomputing.com>,
 "lcherian@marvell.com" <lcherian@marvell.com>,
 "bobo.shaobowang@huawei.com" <bobo.shaobowang@huawei.com>,
 "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
 Jamie Iles <quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
 "peternewman@google.com" <peternewman@google.com>,
 "dfustini@baylibre.com" <dfustini@baylibre.com>,
 "amitsinght@marvell.com" <amitsinght@marvell.com>,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>,
 "fenghuay@nvidia.com" <fenghuay@nvidia.com>,
 "baisheng.gao@unisoc.com" <baisheng.gao@unisoc.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Rob Herring
 <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
 Rafael Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>, Ben Horgan <ben.horgan@arm.com>
References: <20250822153048.2287-1-james.morse@arm.com>
 <20250822153048.2287-47-james.morse@arm.com>
 <OSZPR01MB87983DB7BF0AF0672A027D4E8B0FA@OSZPR01MB8798.jpnprd01.prod.outlook.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <OSZPR01MB87983DB7BF0AF0672A027D4E8B0FA@OSZPR01MB8798.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Shaopeng,

On 09/09/2025 08:30, Shaopeng Tan (Fujitsu) wrote:
>> An MSC is a container of resources, each identified by their RIS index.
>> Some RIS are described by firmware to provide their position in the system.
>> Others are discovered when the driver probes the hardware.
>>
>> To configure a resource it needs to be found by its class, e.g. 'L2'.
>> There are two kinds of grouping, a class is a set of components, which are
>> visible to user-space as there are likely to be multiple instances of the L2 cache.
>> (e.g. one per cluster or package)
>>
>> struct mpam_components are a set of struct mpam_vmsc. A vMSC groups the
>> RIS in an MSC that control the same logical piece of hardware. (e.g. L2).
>> This is to allow hardware implementations where two controls are presented as
>> different RIS. Re-combining these RIS allows their feature bits to be or-ed. This
>> structure is not visible outside mpam_devices.c
>>
>> struct mpam_vmsc are then a set of struct mpam_msc_ris, which are not
>> visible as each L2 cache may be composed of individual slices which need to
>> be configured the same as the hardware is not able to distribute the
>> configuration.
>>
>> Add support for creating and destroying these structures.
>>
>> A gfp is passed as the structures may need creating when a new RIS entry is
>> discovered when probing the MSC.

>> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
>> index 71a1fb1a9c75..5baf2a8786fb 100644
>> --- a/drivers/resctrl/mpam_devices.c
>> +++ b/drivers/resctrl/mpam_devices.c
>> @@ -35,11 +34,483 @@

>> +static struct mpam_vmsc *mpam_vmsc_get(struct mpam_component
>> *comp,
>> +				       struct mpam_msc *msc, bool alloc,
>> +				       gfp_t gfp)
>> +{
>> +	struct mpam_vmsc *vmsc;
>> +
>> +	lockdep_assert_held(&mpam_list_lock);
>> +
>> +	list_for_each_entry(vmsc, &comp->vmsc, comp_list) {
>> +		if (vmsc->msc->id == msc->id)
>> +			return vmsc;
>> +	}
>> +
>> +	if (!alloc)
>> +		return ERR_PTR(-ENOENT);
> 
> It seems like it is always false here.
> If necessary, why not do this at the beginning of the function?

Because the VMSC may exist - in which case the 'get' function should return it
regardless of whether the caller wants to allocate it if its missing.

I'd anticipated callers like resctrl would want to grab components by things like cache-
id, without allocating them by accident. But that coded ended up just searching the lists
instead. I'll rip this out.


Thanks,

James

