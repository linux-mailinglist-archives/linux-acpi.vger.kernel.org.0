Return-Path: <linux-acpi+bounces-16605-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7D8B520F7
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 21:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBB47483FA7
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 19:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75BB12D7D27;
	Wed, 10 Sep 2025 19:29:53 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DAF2D5958;
	Wed, 10 Sep 2025 19:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757532593; cv=none; b=ozsPaSgSBAVpIkhrTWzTID8NNHIwJti3wxrIXDuVEZTkX7wQ0RDZOwWI3oUWz/X6T8FXev+HX+QZdM3PLGFMll8mhxyuO1iCmNPthWBpmWLyNremVGJM+Y7KsTJ3ZNAx9vhL3iChyiFZkoST3fFD196T1HC5mYUnCwPPhJ0/SaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757532593; c=relaxed/simple;
	bh=6iQEXUEKLCsDN0xKTCZuMaCEw2TQNAILeGlJ0Ndprr4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sK5uDFQ5ScGazC/aaPfAJSeXo4bq1ALYOvtT7apyGQw/0L8UxSLBVAHtqr6yOG38dW19ypC7+onmJoqZz8jHipEz7Dx8Qm6mErX5OMws4FiwYagvUJPOSIRk56K6Fv4ws6hWpg7LUMluKSeYP59V0x1aovHlT6D02mCkLVV4/Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11CAA31DB;
	Wed, 10 Sep 2025 12:29:43 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D086B3F694;
	Wed, 10 Sep 2025 12:29:44 -0700 (PDT)
Message-ID: <1a571086-4165-4c94-a834-bd7b92a31b0d@arm.com>
Date: Wed, 10 Sep 2025 20:29:42 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 28/33] arm_mpam: Track bandwidth counter state for
 overflow and power management
To: Fenghua Yu <fenghuay@nvidia.com>, linux-kernel@vger.kernel.org,
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
 Shanker Donthineni <sdonthineni@nvidia.com>, baisheng.gao@unisoc.com,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Rob Herring
 <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
 Rafael Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>
References: <20250822153048.2287-1-james.morse@arm.com>
 <20250822153048.2287-63-james.morse@arm.com>
 <b2fb792f-92ba-4bee-8a2a-e434405653e9@nvidia.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <b2fb792f-92ba-4bee-8a2a-e434405653e9@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Fenghua,

On 28/08/2025 01:58, Fenghua Yu wrote:
> On 8/22/25 08:30, James Morse wrote:
>> Bandwidth counters need to run continuously to correctly reflect the
>> bandwidth.
>>
>> The value read may be lower than the previous value read in the case
>> of overflow and when the hardware is reset due to CPU hotplug.
>>
>> Add struct mbwu_state to track the bandwidth counter to allow overflow
>> and power management to be handled.

>> @@ -2291,11 +2395,35 @@ static void mpam_unregister_irqs(void)
>>     static void __destroy_component_cfg(struct mpam_component *comp)
>>   {
>> +    struct mpam_msc *msc;
>> +    struct mpam_vmsc *vmsc;
>> +    struct mpam_msc_ris *ris;
>> +
>> +    lockdep_assert_held(&mpam_list_lock);
>> +
>>       add_to_garbage(comp->cfg);
>> +    list_for_each_entry(vmsc, &comp->vmsc, comp_list) {
>> +        msc = vmsc->msc;
>> +
>> +        mpam_mon_sel_outer_lock(msc);
>> +        if (mpam_mon_sel_inner_lock(msc)) {
>> +            list_for_each_entry(ris, &vmsc->ris, vmsc_list)
>> +                add_to_garbage(ris->mbwu_state);
>> +            mpam_mon_sel_inner_unlock(msc);
>> +        }
>> +        mpam_mon_sel_outer_lock(msc);
> 
> s/mpam_mon_sel_outer_lock(msc);/mpam_mon_sel_outer_unlock(msc);/
> 
> Or this will hit a dead lock.

Heh, that's a good typo. Thanks!

James

